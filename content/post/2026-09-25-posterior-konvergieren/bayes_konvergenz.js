// bayes_konvergenz.js -- D3.js-Skript fuer r2d3
// Wird von bayes_konvergenz.R via r2d3(script = "bayes_konvergenz.js") geladen.
// r2d3 stellt die Variablen `data`, `svg`, `width`, `height`, `options` bereit.

var typen = data.typen;   // Array von {id, label, prior, farbe}, aus dem R-data.frame
var EMAX  = data.emax || 100;
var LR0   = data.lr0 || 1.15;

var margin = (options && options.margin) || { top: 16, right: 20, bottom: 40, left: 46 };

// r2d3 haengt `svg` in einen umgebenden div (container = "div"). Wir setzen
// Steuerelemente als Geschwister-Div davor.
var root = d3.select(svg.node().parentNode);
root.style("font-family", "system-ui, -apple-system, 'Segoe UI', sans-serif");

var controls = root.insert("div", ":first-child")
  .style("display", "flex")
  .style("flex-wrap", "wrap")
  .style("gap", "16px")
  .style("align-items", "flex-end")
  .style("margin-bottom", "10px")
  .style("font-size", "12px");

function controlBlock(labelText) {
  var wrap = controls.append("div").style("flex", "1 1 200px").style("min-width", "160px");
  var label = wrap.append("label")
    .style("display", "block")
    .style("color", "#52514e")
    .style("margin-bottom", "4px")
    .html(labelText);
  return { wrap: wrap, label: label };
}

var eBlock = controlBlock("Anzahl Ereignisse E: <b id='r2d3-eval'>0</b>");
var eSlider = eBlock.wrap.append("input")
  .attr("type", "range").attr("min", 0).attr("max", EMAX).attr("step", 1).attr("value", 0)
  .style("width", "100%");

var lrBlock = controlBlock("Beweiskraft je Ereignis (LR): <b id='r2d3-lrval'>" + LR0.toFixed(2) + "</b>");
var lrSlider = lrBlock.wrap.append("input")
  .attr("type", "range").attr("min", 1).attr("max", 2.5).attr("step", 0.01).attr("value", LR0)
  .style("width", "100%");

var btnWrap = controls.append("div").style("display", "flex").style("gap", "6px");
var playBtn = btnWrap.append("button").text("▶ Abspielen")
  .style("font", "inherit").style("padding", "6px 12px").style("cursor", "pointer");
var resetBtn = btnWrap.append("button").text("Zurücksetzen")
  .style("font", "inherit").style("padding", "6px 12px").style("cursor", "pointer");

var legendDiv = root.append("div")
  .style("display", "flex").style("flex-wrap", "wrap").style("gap", "10px")
  .style("margin-top", "10px").style("font-size", "12px");

var state = { e: 0, lr: LR0, hidden: {}, playing: false, timer: null };

function priorOdds(p) {
  if (p <= 0) return 0;
  if (p >= 1) return Infinity;
  return p / (1 - p);
}
function posterior(prior, lr, e) {
  var odds0 = priorOdds(prior);
  if (odds0 === 0) return 0;
  var odds = odds0 * Math.pow(lr, e);
  return odds / (1 + odds);
}
function curveFor(s, lr) {
  var pts = [];
  for (var e = 0; e <= EMAX; e++) pts.push({ e: e, p: posterior(s.prior, lr, e) });
  return pts;
}

function draw(w, h) {
  svg.selectAll("*").remove();
  var innerW = w - margin.left - margin.right;
  var innerH = h - margin.top - margin.bottom;
  var g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  var x = d3.scaleLinear().domain([0, EMAX]).range([0, innerW]);
  var y = d3.scaleLinear().domain([0, 1]).range([innerH, 0]);

  g.append("g").selectAll("line").data(y.ticks(5)).enter().append("line")
    .attr("x1", 0).attr("x2", innerW)
    .attr("y1", function (d) { return y(d); }).attr("y2", function (d) { return y(d); })
    .attr("stroke", "#e1e0d9");

  g.append("g")
    .attr("transform", "translate(0," + innerH + ")")
    .call(d3.axisBottom(x).ticks(6).tickSizeOuter(0))
    .call(function (sel) { sel.selectAll("text").style("fill", "#898781").style("font-size", "10px"); sel.selectAll("path,line").attr("stroke", "#c3c2b7"); });

  g.append("g")
    .call(d3.axisLeft(y).ticks(5).tickFormat(d3.format(".2f")).tickSizeOuter(0))
    .call(function (sel) { sel.selectAll("text").style("fill", "#898781").style("font-size", "10px"); sel.selectAll("path,line").attr("stroke", "#c3c2b7"); });

  g.append("text").attr("x", innerW / 2).attr("y", innerH + 32).attr("text-anchor", "middle")
    .style("font-size", "11px").style("fill", "#898781").text("Anzahl Ereignisse E");
  g.append("text").attr("transform", "rotate(-90)").attr("x", -innerH / 2).attr("y", -34)
    .attr("text-anchor", "middle").style("font-size", "11px").style("fill", "#898781").text("Pr(H | E)");

  var line = d3.line().x(function (d) { return x(d.e); }).y(function (d) { return y(d.p); });

  var linesG = g.append("g");
  var dotsG = g.append("g");
  var cursor = g.append("line").attr("y1", 0).attr("y2", innerH)
    .attr("stroke", "#898781").attr("stroke-dasharray", "3 3");

  function render() {
    var lr = state.lr;
    var series = typen.map(function (s) { return { s: s, pts: curveFor(s, lr) }; });
    var eIdx = Math.round(state.e);

    var paths = linesG.selectAll("path").data(series, function (d) { return d.s.id; });
    paths.enter().append("path").attr("fill", "none").attr("stroke-width", 2.25)
      .merge(paths)
      .attr("stroke", function (d) { return d.s.farbe; })
      .attr("opacity", function (d) { return state.hidden[d.s.id] ? 0.15 : 1; })
      .attr("d", function (d) { return line(d.pts); });
    paths.exit().remove();

    var visible = series.filter(function (d) { return !state.hidden[d.s.id]; });
    var dots = dotsG.selectAll("circle").data(visible, function (d) { return d.s.id; });
    dots.enter().append("circle").attr("r", 5).attr("stroke", "#fcfcfb").attr("stroke-width", 1.5)
      .merge(dots)
      .attr("fill", function (d) { return d.s.farbe; })
      .attr("cx", x(eIdx)).attr("cy", function (d) { return y(d.pts[eIdx].p); });
    dots.exit().remove();

    cursor.attr("x1", x(eIdx)).attr("x2", x(eIdx));

    var items = legendDiv.selectAll("div.legend-item").data(series, function (d) { return d.s.id; });
    var enter = items.enter().append("div").attr("class", "legend-item")
      .style("display", "flex").style("align-items", "center").style("gap", "6px")
      .style("padding", "4px 8px").style("border-radius", "6px").style("cursor", "pointer")
      .style("color", "#52514e")
      .on("click", function (event, d) { state.hidden[d.s.id] = !state.hidden[d.s.id]; render(); });
    enter.append("span").attr("class", "sw").style("width", "10px").style("height", "10px")
      .style("border-radius", "50%").style("display", "inline-block");
    enter.append("span").attr("class", "lb");
    enter.append("span").attr("class", "vl").style("font-weight", "600").style("color", "#0b0b0b")
      .style("font-variant-numeric", "tabular-nums");

    var merged = enter.merge(items);
    merged.style("opacity", function (d) { return state.hidden[d.s.id] ? 0.35 : 1; });
    merged.select(".sw").style("background", function (d) { return d.s.farbe; });
    merged.select(".lb").text(function (d) { return d.s.label + " (Prior " + d3.format(".3~f")(d.s.prior) + ")"; });
    merged.select(".vl").text(function (d) { return " " + d3.format(".3f")(d.pts[eIdx].p); });
    items.exit().remove();

    root.select("#r2d3-eval").text(eIdx);
    root.select("#r2d3-lrval").text(d3.format(".2f")(lr));
  }

  eSlider.on("input", function () { state.e = +this.value; render(); });
  lrSlider.on("input", function () { state.lr = +this.value; render(); });

  function stopPlaying() {
    state.playing = false;
    playBtn.text("▶ Abspielen");
    if (state.timer) { clearInterval(state.timer); state.timer = null; }
  }
  playBtn.on("click", function () {
    if (state.playing) { stopPlaying(); return; }
    state.playing = true;
    playBtn.text("⏸ Stopp");
    if (state.e >= EMAX) { state.e = 0; eSlider.property("value", 0); }
    state.timer = setInterval(function () {
      state.e += 1;
      if (state.e >= EMAX) {
        state.e = EMAX; eSlider.property("value", EMAX); render(); stopPlaying(); return;
      }
      eSlider.property("value", state.e); render();
    }, 90);
  });
  resetBtn.on("click", function () {
    stopPlaying();
    state.e = 0; state.lr = LR0; state.hidden = {};
    eSlider.property("value", 0); lrSlider.property("value", LR0);
    render();
  });

  render();
}

draw(width, height);

r2d3.onResize(function (newWidth, newHeight) {
  draw(newWidth, newHeight);
});
