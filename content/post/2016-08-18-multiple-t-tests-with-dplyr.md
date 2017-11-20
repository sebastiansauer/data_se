---
author: Sebastian Sauer
date: '2016-08-18'
title: Multiple t-Tests with dplyr
tags:
  - stats
  - rstats
slug: multiple-t-tests-with-dplyr
---



## t-Test on multiple columns
Suppose you have a data set where you want to perform a t-Test on multiple columns with some grouping variable. As an example, say you a data frame where each column depicts the score on some test (1st, 2nd, 3rd assignment...). In each row is a different student. So you glance at the grading list (OMG!) of a teacher!

How to do do that in R? Probably, the most "natural" solution would be some `lapply()` call.

But I like `dplyr` (see [intro here](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)); so, is there some nice way to perform that with `dplyr`? The short answer is: no. `dplyr` basically wants to deliver back a data frame, and the t-test does not output a single value, so you cannot use the t-test (right away) for `dplyr`'s `summarise`. One way out is using list-columns... Let's see.

Load some `dplyr`, `tidyr` and some data:


```r
library(dplyr)
library(tidyr)
data(tips, package = "reshape2")
glimpse(tips)
```

```
## Observations: 244
## Variables: 7
## $ total_bill <dbl> 16.99, 10.34, 21.01, 23.68, 24.59, 25.29, 8.77, 26....
## $ tip        <dbl> 1.01, 1.66, 3.50, 3.31, 3.61, 4.71, 2.00, 3.12, 1.9...
## $ sex        <fctr> Female, Male, Male, Male, Female, Male, Male, Male...
## $ smoker     <fctr> No, No, No, No, No, No, No, No, No, No, No, No, No...
## $ day        <fctr> Sun, Sun, Sun, Sun, Sun, Sun, Sun, Sun, Sun, Sun, ...
## $ time       <fctr> Dinner, Dinner, Dinner, Dinner, Dinner, Dinner, Di...
## $ size       <int> 2, 3, 3, 2, 4, 4, 2, 4, 2, 2, 2, 4, 2, 4, 2, 2, 3, ...
```


Well, it looks crude, but that's a way:


```r
tips %>% 
  select(tip, total_bill, sex) %>% 
  gather(key = variable, value = value, -sex) %>% 
  group_by(sex, variable) %>% 
  summarise(value = list(value)) %>% 
  spread(sex, value) %>% 
  group_by(variable) %>% 
  mutate(p_value = t.test(unlist(Female), unlist(Male))$p.value,
         t_value = t.test(unlist(Female), unlist(Male))$statistic)
```

```
## Source: local data frame [2 x 5]
## Groups: variable [2]
## 
##     variable     Female        Male    p_value   t_value
##        <chr>     <list>      <list>      <dbl>     <dbl>
## 1        tip <dbl [87]> <dbl [157]> 0.13780684 -1.489536
## 2 total_bill <dbl [87]> <dbl [157]> 0.01857339 -2.373398
```


Let's go through this code step by step. First, this bit


```r
tips %>% 
  select(tip, total_bill, sex) %>% head
```

```
##    tip total_bill    sex
## 1 1.01      16.99 Female
## 2 1.66      10.34   Male
## 3 3.50      21.01   Male
## 4 3.31      23.68   Male
## 5 3.61      24.59 Female
## 6 4.71      25.29   Male
```

is used to select the columns we want to perform the t-Test on (here: `tip` and `total_bill`) plus the grouping variable (`sex`).

Then by the next bit

```r
tips %>% 
  select(tip, total_bill, sex) %>% 
  gather(key = variable, value = value, -sex) %>% head
```

```
##      sex variable value
## 1 Female      tip  1.01
## 2   Male      tip  1.66
## 3   Male      tip  3.50
## 4   Male      tip  3.31
## 5 Female      tip  3.61
## 6   Male      tip  4.71
```

we "melt" the data frame down, so that all numeric variables are put in one column (underneath each other).



```r
tips %>% 
  select(tip, total_bill, sex) %>% 
  gather(key = variable, value = value, -sex) %>% 
  group_by(sex, variable) %>% 
  summarise(value = list(value)) 
```

```
## Source: local data frame [4 x 3]
## Groups: sex [?]
## 
##      sex   variable       value
##   <fctr>      <chr>      <list>
## 1 Female        tip  <dbl [87]>
## 2 Female total_bill  <dbl [87]>
## 3   Male        tip <dbl [157]>
## 4   Male total_bill <dbl [157]>
```

Now it get's interesting. We put all the `values` per group (e.g., male-tip or female-total_bill...) in one cell. Yes, that's right. In each cell of column `value` there is now a list (a bunch) of values. That's what is called a "list-column". We will now use this list column for the t-test.



```r
tips %>% 
  select(tip, total_bill, sex) %>% 
  gather(key = variable, value = value, -sex) %>% 
  group_by(sex, variable) %>% 
  summarise(value = list(value)) %>% 
  spread(sex, value) %>% 
  group_by(variable) 
```

```
## Source: local data frame [2 x 3]
## Groups: variable [2]
## 
##     variable     Female        Male
## *      <chr>     <list>      <list>
## 1        tip <dbl [87]> <dbl [157]>
## 2 total_bill <dbl [87]> <dbl [157]>
```

But before we do the t-Test, we "spread" the data frame. That is, we convert from "long" to "wide" format. Next, we group for `variable`. That means in practice, that the following t-test will be applied to each member of this group (ie., each variable, here `tip` and `total_bill`).

And now the t-Test:


```r
tips %>% 
  select(tip, total_bill, sex) %>% 
  gather(key = variable, value = value, -sex) %>% 
  group_by(sex, variable) %>% 
  summarise(value = list(value)) %>% 
  spread(sex, value) %>% 
  group_by(variable) %>% 
  mutate(p_value = t.test(unlist(Female), unlist(Male))$p.value,
         t_value = t.test(unlist(Female), unlist(Male))$statistic)
```

```
## Source: local data frame [2 x 5]
## Groups: variable [2]
## 
##     variable     Female        Male    p_value   t_value
##        <chr>     <list>      <list>      <dbl>     <dbl>
## 1        tip <dbl [87]> <dbl [157]> 0.13780684 -1.489536
## 2 total_bill <dbl [87]> <dbl [157]> 0.01857339 -2.373398
```

That's it.

## You can have it very simple

That was quite cumbersome for something which could have been achieved very simple with


```r
t.test(tip ~ sex, data = tips)$p.value
```

```
## [1] 0.1378068
```

```r
t.test(total_bill ~ sex, data = tips)$p.value
```

```
## [1] 0.01857339
```

So our way (OK, my way) does not seem advisable. However, it may has been instructive for the "thinking" of dplyr.

By the way, another simpler approach with `dplyr` could have been:


```r
tips %>%
    summarise_each(funs(t.test(.[sex == "Female"], .[sex == "Male"])$p.value), vars = total_bill:tip)
```

```
##        vars1     vars2
## 1 0.01857339 0.1378068
```



## Acknowledgment
This post was inspired by [this post](http://stackoverflow.com/questions/32477863/r-run-t-test-on-previous-years-by-group-using-dplyr) on Stack Overflow, and also by [this one](http://stackoverflow.com/questions/26244321/dplyr-summarise-multiple-columns-using-t-test).
