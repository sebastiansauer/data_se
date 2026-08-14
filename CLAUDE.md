# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository overview

This is Sebastian Sauer's Hugo-based data science blog (`data_se`), authored with R Markdown via **blogdown**. Posts live as paired `.Rmd`/`.html` (or plain `.md`) files under `content/post/`; the `.Rmd` is the source, the `.html`/`.md` is the rendered/knitted output that Hugo actually serves. `ignoreFiles` in `config.toml` excludes `.Rmd`, `.Rmarkdown`, and knit-cache artifacts from the Hugo build itself.

## Commands

Rendering posts (R/blogdown, run from an R session):

```r
source("build-site-trying.R")
# or individually:
blogdown::hugo_build()   # build without re-knitting Rmd files
blogdown::serve_site()   # local live-reload server
blogdown::build_site()   # full build, re-knits changed Rmd files
blogdown::stop_server()
```

Hugo build directly (used in CI, no R/knitting involved):

```bash
hugo --minify --gc
```

There is no test suite, linter, or package manifest in this repo.

## Architecture

- **Content**: `content/post/*.Rmd` are the editable sources; knitting an `.Rmd` produces the matching `.html` (or `.md`) file next to it, which Hugo renders. Edit the `.Rmd`, not the generated `.html`/`.md`, then re-knit.
- **Theme**: active theme is `hugo-lithium-theme` (set via `theme` in `config.toml`); `themes/` also contains several unused alternate themes left over from earlier experiments.
- **Config**: `config.toml` holds site params, menu, permalink pattern (`/:year/:month/:day/:slug/`), and `baseurl` (`https://sebastiansauer.github.io/data_se/` — a GitHub Pages project site, so all internal links must respect the `/data_se/` subpath).
- **Deployment**: `.github/workflows/deploy.yml` builds with `hugo --minify --gc` on every push to `master` and publishes `./public` to the `gh-pages` branch via `peaceiris/actions-gh-pages`. No R/knitr step runs in CI — `.Rmd` files must already be knitted to `.html`/`.md` and committed before pushing.
