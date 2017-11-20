---
author: Sebastian Sauer
date: '2017-06-28'
title: A second look to grouping with dplyr
tags:
  - rstats
  - tidyverse
  - dplyr
  - programming
slug: second_look_group_by
---




~~The~~ one basic idea of dplyr is that each function should focus on one job. That's why there are no functions such as `compute_sumamries_by_group_with_robust_variants(df)`. Rather, summarising and grouping are seen as different jobs which should be accomplished by different functions. And, in turn, that's why `group_by`, the grouping function of dplyr, is of considerable importance: this function should do the grouping for each operation whatsoever. 


Let's load all tidyverse libraries in one go:

```r
library(tidyverse)
```


On the first glimpse, simply enough, this code


```r
my_data %>% 
  group_by(grouping_var) %>% 
  summarise(n_per_group = (n(var_to_be_counted_per_group)))
```

more or less can be read in plain English. So, simple. As a popular example, consider the dataset `mtcars`:


```r
mtcars %>% 
  group_by(cyl) %>% 
  summarise(n_per_group = n())
```

```
## # A tibble: 3 x 2
##     cyl n_per_group
##   <dbl>       <int>
## 1     4          11
## 2     6           7
## 3     8          14
```

`n` simply counts the rows of a (grouped) dataframe. As all rows must, per definition, have the same number of rows, it does not matter which particular column we are looking at. Hence, no column is specified for `n()`.

Somewhat slightly more complicated, say we want to count the number of cars grouped by (number of) cylinder and by (type of) transmission. In dplyr, we just add an additional grouping variable:


```r
mtcars %>% 
  group_by(cyl, am) %>%  # 'am' added as second grouping variable
  summarise(n_per_group = n())
```

```
## # A tibble: 6 x 3
## # Groups:   cyl [?]
##     cyl    am n_per_group
##   <dbl> <dbl>       <int>
## 1     4     0           3
## 2     4     1           8
## 3     6     0           4
## 4     6     1           3
## 5     8     0          12
## 6     8     1           2
```

Note that dplyr now tells us about groups: `# Groups:   cyl [?]`. That output tells us that `cyl` is the grouping variable. The question mark just means that the number of groups is unkown right now; it will only be computed when the next line is executed.

Note also that *one*  grouping variable is indicated. But wait! We had indicated two grouping variables, right? What happened is that by each run of `summarise` one grouping variable is removed. So if we had two grouping variables before we ran `summarise` we are left with one grouping variabl after the call of `summarise`. I assume this behavior was implemented because you can 'roll up' up a data frame: Get the counts for each cell for the two grouping variables, then sum up the levels of one variables, then sum up again to double check the total sum. See:



```r
mtcars %>% 
  group_by(cyl, am) %>%  
  summarise(n_per_group = n()) %>% 
  summarise(n_per_group = n())
```

```
## # A tibble: 3 x 2
##     cyl n_per_group
##   <dbl>       <int>
## 1     4           2
## 2     6           2
## 3     8           2
```

This output tells us that there are 2 lines for each group of cyl (am == 1 and am == 0). Maybe more useful:


```r
mtcars %>% 
  group_by(cyl, am) %>%  
  summarise(n_per_group = n()) %>% 
  summarise(n_per_group = sum(n_per_group))
```

```
## # A tibble: 3 x 2
##     cyl n_per_group
##   <dbl>       <int>
## 1     4          11
## 2     6           7
## 3     8          14
```

What happens if the 'peel off' the last last layer and sum up the remaining rows?


```r
mtcars %>% 
  group_by(cyl, am) %>%  
  summarise(n_per_group = n()) %>% 
  summarise(n_per_group = sum(n_per_group)) %>% 
  summarise(n_per_group = sum(n_per_group))
```

```
## # A tibble: 1 x 1
##   n_per_group
##         <int>
## 1          32
```

We get the overall number of rows of the whole dataset.

>   Each summarise peels off one layer of grouping.


