---
  title: "Hands-on data exploration using R <br/> - a tidyverse approach"
subtitle: "An introduction to modern data analysis"
author: "Sebastian Sauer"
date: "22018016/11/21 (Last update: `r Sys.Date()`)"
output:
  xaringan::moon_reader:
  css: ["default", "default-fonts", "hygge"]
#css: [default, metropolis, metropolis-fonts]
lib_dir: libs
nature:
  highlightStyle: github
highlightLines: true
countIncrementalSlides: false
editor_options: 
  chunk_output_type: console
---
  
  ```{r setup-knitr, include=FALSE}
options(htmltools.dir.version = FALSE)


knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  message = FALSE,
  warning = FALSE,
  cache = TRUE,
  echo = FALSE,
  out.width = "70%",
  fig.align = 'center',
  fig.width = 6,
  fig.asp =  .618,
  fig.show = "hold",
  size = "tiny"
)


options(max.print = 20,
        dplyr.print_max = 10,
        dplyr.print_min = 3)
```


