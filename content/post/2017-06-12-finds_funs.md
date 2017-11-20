---
author: Sebastian Sauer
date: '2017-06-12'
title: Identifying the package of a function
tags:
  - rstats
slug: finds_funs
---


# tl;dr
Suppose you want to know which package(s) a given R function belongs to, say `filter`. Here come `find_funs`to help you:

```r
find_funs("filter")
```

```
## # A tibble: 4 x 3
##   package_name builtin_pckage loaded
##          <chr>          <lgl>  <lgl>
## 1         base           TRUE   TRUE
## 2        dplyr          FALSE   TRUE
## 3       plotly          FALSE  FALSE
## 4        stats           TRUE   TRUE
```

This function will search all *installed* packages for this function name. It will return all the package names that match the function name (ie., packages which include a function by the respective name). In addition, the function raises a flag as to whether the packages is a standard (built-in) packge and whether the package is currently loaded/attached.


For convenience this function can be sourced like this:

```
source("https://sebastiansauer.github.io/Rcode/find_funs.R")
```


# Usecase
Sometimes it is helpful to know in which R package a function 'resides'. For example, `ggplot` comes from the package `ggplot2`, and `select` is a function that can be located in the package `dplyr` (among other packages). Especially if a function has a common name name clases are bound to be experienced. For a example, I was bitten by `filter` a couple of times - not reckognizing that the function `filter` that was applied did not come from `dplyr` as intended but from some other package.

Additionally, sometimes we have in mind 'oh I should make use of this function `filter` here', but cannot remember which package should be loaded for that function.

A number of ways exist to address this question. Our convenience function here takes the name of the function for which we search its residential package as its input (that's the only parameter). The function will then return the one more packgages in which the function was found. In addition, it returns for each package found whether that package comes with standard R (is 'built-in'). That information can be useful to know whether someone needs to install a package in order to use some function. The function also returns whether the function is currently loaded.



# Code



```r
find_funs <- function(f) {
  # Returns dataframe with two columns:
    # `package_name`: packages(s) which the function is part of (chr)
    # `builtin_package`:  whether the package comes with standard R (a 'builtin'  package)

  # Arguments:
    # f: name of function for which the package(s) are to be identified.


  if ("tidyverse" %in% rownames(installed.packages()) == FALSE) {
    cat("tidyverse is needed for this fuction. Please install. Stopping")
    stop()}

  suppressMessages(library(tidyverse))


  # search for help in list of installed packages
  help_installed <- help.search(paste0("^",f,"$"), agrep = FALSE)

  # extract package name from help file
  pckg_hits <- help_installed$matches[,"Package"]

  if (length(pckg_hits) == 0) pckg_hits <- "No_results_found"


  # get list of built-in packages

  pckgs <- installed.packages()  %>% as_tibble
  pckgs %>%
    dplyr::filter(Priority %in% c("base","recommended")) %>%
    dplyr::select(Package) %>%
    distinct -> builtin_pckgs_df

  # check for each element of 'pckg hit' whether its built-in and loaded (via match). Then print results.

  results <- data_frame(
    package_name = pckg_hits,
    builtin_pckage = match(pckg_hits, builtin_pckgs_df$Package, nomatch = 0) > 0,
    loaded = match(paste("package:",pckg_hits, sep = ""), search(), nomatch = 0) > 0
  )

  return(results)

}
```


# Example


```r
find_funs("filter")
```

```
## # A tibble: 4 x 3
##   package_name builtin_pckage loaded
##          <chr>          <lgl>  <lgl>
## 1         base           TRUE   TRUE
## 2        dplyr          FALSE   TRUE
## 3       plotly          FALSE  FALSE
## 4        stats           TRUE   TRUE
```


# Convenience access

For convenience this function can be sourced like this:


```r
source("https://sebastiansauer.github.io/Rcode/find_funs.R")
```


# Notes

`tidyverse` needs to installed to run this code. `tidyverse` is loaded quietly. The function will return an empty dataframe if no target package is found.


# Acknowledgements

This function was inspired by code from [Ben Bolker's](https://stackoverflow.com/questions/10553755/name-of-a-package-for-a-given-function-in-r) post on SO.
