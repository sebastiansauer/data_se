---
author: Sebastian Sauer
date: '2017-03-08'
title: Convert list to dataframe
tags:
  - rstats
  - tidyverse
slug: convert_list_to_dataframe
---






A handy function to iterate stuff is the function `purrr::map`. It takes a function and applies it to all elements of a given vector. This vector can be a data frame - which is a list, tecnically - or some other sort of of list (normal atomic vectors are fine, too).

However, `purrr::map` is designed to return *lists* (not dataframes). For example, if you apply `mosaic::favstats` to map, you will get some favorite statistics for some variable:


```r
library(mosaic)
library(tidyverse)

data(tips, package = "reshape2")
favstats(tips$tip)
```

```
##  min Q1 median     Q3 max     mean       sd   n missing
##    1  2    2.9 3.5625  10 2.998279 1.383638 244       0
```

Note that `favstats` does *not* accept several columns/variables as parameters;  *one* only at a time is permitted.

Ok, let's apply `favstats` to each numeric column of our dataframe:


```r
tips %>% 
  select_if(is.numeric) %>% 
  map(mosaic::favstats)
```

```
## $total_bill
##   min      Q1 median      Q3   max     mean       sd   n missing
##  3.07 13.3475 17.795 24.1275 50.81 19.78594 8.902412 244       0
## 
## $tip
##  min Q1 median     Q3 max     mean       sd   n missing
##    1  2    2.9 3.5625  10 2.998279 1.383638 244       0
## 
## $size
##  min Q1 median Q3 max     mean        sd   n missing
##    1  2      2  3   6 2.569672 0.9510998 244       0
```

Quite nice, but we are given back a list with several elements; each element is a "row" of our to-be dataframe. How to change this list to a regular dataframe (tibble)?

This trick can be solved by use of some sort of repeated `rbind`. `rbind` binds rows together, hence the name. But `rbinds` does only accept *two* elements as input. Now comes `do.call` to help. Effectiveley, `do.call` does something like: `rbind(my_list[[1]], my_list[[2]], my_list[[2]], ...)` (this is pseudo code).




```r
tips %>% 
  select_if(is.numeric) %>% 
  map(mosaic::favstats) %>% 
  do.call(rbind, .)
```

```
##             min      Q1 median      Q3   max      mean        sd   n
## total_bill 3.07 13.3475 17.795 24.1275 50.81 19.785943 8.9024120 244
## tip        1.00  2.0000  2.900  3.5625 10.00  2.998279 1.3836382 244
## size       1.00  2.0000  2.000  3.0000  6.00  2.569672 0.9510998 244
##            missing
## total_bill       0
## tip              0
## size             0
```


Note the little dot in `rbind`.


Now be happy with the dataframe :-)
