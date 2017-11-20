---
author: Sebastian Sauer
date: '2017-03-27'
title: Rowwise operations in dplyr
tags:
  - rstats
  - tidyverse
slug: rowwise_dplyr
---


R thinks columnwise, not rowwise, at least in standard dataframe operations. A typical *rowwise* operation is to compute row means or row sums, for example to compute person sum scores for psychometric analyses.

One workaround, typical for R, is to use functions such as `apply` (and friends).

However, `dplyr` offers some quite nice alternative:


```r
library(dplyr)

mtcars %>% 
  rowwise() %>% 
  mutate(mymean=mean(c(cyl,mpg))) %>% 
  select(cyl, mpg, mymean)
```

```
## Source: local data frame [32 x 3]
## Groups: <by row>
## 
## # A tibble: 32 × 3
##      cyl   mpg mymean
##    <dbl> <dbl>  <dbl>
## 1      6  21.0  13.50
## 2      6  21.0  13.50
## 3      4  22.8  13.40
## 4      6  21.4  13.70
## 5      8  18.7  13.35
## 6      6  18.1  12.05
## 7      8  14.3  11.15
## 8      4  24.4  14.20
## 9      4  22.8  13.40
## 10     6  19.2  12.60
## # ... with 22 more rows
```

