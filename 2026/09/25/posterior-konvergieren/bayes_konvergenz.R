## Bayes-Konvergenz: interaktives Diagramm mit R + D3.js (r2d3)
##
## Zeigt, wie fuenf Beobachter mit unterschiedlichen Priors Pr(H) unter
## wiederholten, fuer H sprechenden Ereignissen E konvergieren.
##
## Update-Regel (Odds-Form):
##   Odds(H | E) = Odds(H) * LR^E
##   Pr(H | E)   = Odds / (1 + Odds)
##
## Ein Prior von exakt 0 ("Ausschliesser") bleibt fuer immer bei 0 -- das ist
## Cromwells Regel, keine Naeherung.
##
## Benoetigt: install.packages(c("r2d3", "htmlwidgets"))

library(r2d3)

typen <- data.frame(
  id     = c("ausschliesser", "kritiker", "skeptiker", "unentschieden", "zustimmer"),
  label  = c("Ausschließer", "Kritiker", "Skeptiker", "Unentschiedene", "Zustimmer"),
  prior  = c(0, 0.10, 0.001, 0.50, 0.90),
  farbe  = c("#2a78d6", "#eb6834", "#1baf7a", "#eda100", "#e87ba4"),
  stringsAsFactors = FALSE
)

# an d3.js uebergebene Daten: Typen + Default-Parameter
d3_data <- list(
  typen = typen,
  emax  = 100,
  lr0   = 1.15
)

widget <- r2d3(
  data = d3_data,
  script = "bayes_konvergenz.js",
  container = "div",
  d3_version = "6",
  options = list(margin = list(top = 16, right = 20, bottom = 40, left = 46))
)

widget

# Als eigenstaendige HTML-Datei speichern (zum Teilen, ohne R):
# htmlwidgets::saveWidget(widget, "bayes_konvergenz_standalone.html", selfcontained = TRUE)
