---
author: Sebastian Sauer
date: '2016-10-16'
title: Checking for NA with dplyr
tags:
  - rstats
slug: NAs-with-dplyr
---


Often, we want to check for missing values (`NA`s). There are of course many ways to do so. `dplyr` provides a quite nice one.

First, let's load some data:


```r
library(readr)
extra_file <- "https://raw.github.com/sebastiansauer/Daten_Unterricht/master/extra.csv"

extra_df <- read_csv(extra_file)
```

Note that `extra` is a data frame consisting of survey items regarding extraversion and related behavior.

In case the dataframe is quite largish (many columns) it is helpful to have some quick way. Here, we have 25 columns. That is not enormous, but ok, let's stick with that for now.


```r
library(dplyr)

extra_df %>% 
  select_if(function(x) any(is.na(x))) %>% 
  summarise_each(funs(sum(is.na(.)))) -> extra_NA
```

So, what have we done?
The `select_if` part choses any column where `is.na` is true (`TRUE`). Then we take those columns and for each of them, we sum up (`summarise_each`) the number of NAs. Note that each column is summarized to a single value, that's why we use `summarise`. And finally, the resulting data frame (dplyr always aims at giving back a data frame) is stored in a new variable for further processing.


Now, let's see:


```r
# library(pander)  # for printing tables in markdown
library(knitr)

kable(extra_NA)
```



| code| i6| i9| i12| Facebook| Kater| Alter| Geschlecht| extro_one_item| Minuten| Messe| Party| Kunden| Beschreibung| Aussagen| i26| extra_mw|
|----:|--:|--:|---:|--------:|-----:|-----:|----------:|--------------:|-------:|-----:|-----:|------:|------------:|--------:|---:|--------:|
|   82|  1|  1|   1|       73|    12|     3|          3|              4|      37|     4|    16|     49|          117|      121|   3|        3|

