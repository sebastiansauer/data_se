---
author: Sebastian Sauer
date: '2016-09-29'
title: Using purrr to build a data frame of vectors (eg., from effect size statistics)
tags:
  - rstats
slug: purrr-effsize
---



 I just tried to accomplish the following with R: Compute effect sizes for a variable between two groups. Actually, not one numeric variable but many. And compute not only one measure of effect size but several (d, lower/upper CI, CLES,...). 
 
So how to do that?


First, let's load some data and some (tidyverse and effect size) packages:


```r
knitr::opts_chunk$set(echo = TRUE, cache = FALSE, message = FALSE)
```



```r
library(purrr)  
library(ggplot2)
library(dplyr)
library(broom)
library(tibble)  

library(compute.es)
data(Fair, package = "Ecdat") # extramarital affairs dataset
glimpse(Fair)
```

```
## Observations: 601
## Variables: 9
## $ sex        <fctr> male, female, female, male, male, female, female, ...
## $ age        <dbl> 37, 27, 32, 57, 22, 32, 22, 57, 32, 22, 37, 27, 47,...
## $ ym         <dbl> 10.00, 4.00, 15.00, 15.00, 0.75, 1.50, 0.75, 15.00,...
## $ child      <fctr> no, no, yes, yes, no, no, no, yes, yes, no, yes, y...
## $ religious  <int> 3, 4, 1, 5, 2, 2, 2, 2, 4, 4, 2, 4, 5, 2, 4, 1, 2, ...
## $ education  <dbl> 18, 14, 12, 18, 17, 17, 12, 14, 16, 14, 20, 18, 17,...
## $ occupation <int> 7, 6, 1, 6, 6, 5, 1, 4, 1, 4, 7, 6, 6, 5, 5, 5, 4, ...
## $ rate       <int> 4, 4, 4, 5, 3, 5, 3, 4, 2, 5, 2, 4, 4, 4, 4, 5, 3, ...
## $ nbaffairs  <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
```


Extract the numeric variables:


```r
Fair %>% 
  select_if(is.numeric) %>% names -> Fair_num
Fair_num
```

```
## [1] "age"        "ym"         "religious"  "education"  "occupation"
## [6] "rate"       "nbaffairs"
```


Now suppose we want to compare men and women (people do that all the time). First, we do a t-test for each numeric variable (and save the results):


```r
Fair %>% 
  select(one_of(Fair_num)) %>% 
  map(~t.test(. ~ Fair$sex)) -> Fair_t_test
```

The resulting variable is a list of t-test-results (each a list again). Let's have a look at one of the t-test results:


```r
Fair_t_test[[1]]
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  . by Fair$sex
## t = -4.7285, df = 575.26, p-value = 2.848e-06
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -5.014417 -2.071219
## sample estimates:
## mean in group female   mean in group male 
##             30.80159             34.34441
```

That's the `str`ucture of a t-test result object (one element of Fair_t_test
):

```r
str(Fair_t_test[[1]])
```

```
## List of 9
##  $ statistic  : Named num -4.73
##   ..- attr(*, "names")= chr "t"
##  $ parameter  : Named num 575
##   ..- attr(*, "names")= chr "df"
##  $ p.value    : num 2.85e-06
##  $ conf.int   : atomic [1:2] -5.01 -2.07
##   ..- attr(*, "conf.level")= num 0.95
##  $ estimate   : Named num [1:2] 30.8 34.3
##   ..- attr(*, "names")= chr [1:2] "mean in group female" "mean in group male"
##  $ null.value : Named num 0
##   ..- attr(*, "names")= chr "difference in means"
##  $ alternative: chr "two.sided"
##  $ method     : chr "Welch Two Sample t-test"
##  $ data.name  : chr ". by Fair$sex"
##  - attr(*, "class")= chr "htest"
```

So we see that t-value itself can be accessed with eg., `Fair_t_test[[1]]$statistic`. The t-value is now fed into a function that computes effect sizes.



```r
Fair_t_test %>% 
  map(~tes(.$statistic,
          n.1 = nrow(filter(Fair, sex == "female")),
          n.2 = nrow(filter(Fair, sex == "male")))) -> Fair_effsize
```

```
## Mean Differences ES: 
##  
##  d [ 95 %CI] = -0.39 [ -0.55 , -0.22 ] 
##   var(d) = 0.01 
##   p-value(d) = 0 
##   U3(d) = 34.97 % 
##   CLES(d) = 39.24 % 
##   Cliff's Delta = -0.22 
##  
##  g [ 95 %CI] = -0.39 [ -0.55 , -0.22 ] 
##   var(g) = 0.01 
##   p-value(g) = 0 
##   U3(g) = 34.99 % 
##   CLES(g) = 39.25 % 
##  
##  Correlation ES: 
##  
##  r [ 95 %CI] = 0.19 [ 0.11 , 0.27 ] 
##   var(r) = 0 
##   p-value(r) = 0 
##  
##  z [ 95 %CI] = 0.19 [ 0.11 , 0.27 ] 
##   var(z) = 0 
##   p-value(z) = 0 
##  
##  Odds Ratio ES: 
##  
##  OR [ 95 %CI] = 0.5 [ 0.37 , 0.67 ] 
##   p-value(OR) = 0 
##  
##  Log OR [ 95 %CI] = -0.7 [ -0.99 , -0.41 ] 
##   var(lOR) = 0.02 
##   p-value(Log OR) = 0 
##  
##  Other: 
##  
##  NNT = -11.08 
##  Total N = 601Mean Differences ES: 
##  
##  d [ 95 %CI] = -0.06 [ -0.22 , 0.1 ] 
##   var(d) = 0.01 
##   p-value(d) = 0.46 
##   U3(d) = 47.58 % 
##   CLES(d) = 48.29 % 
##   Cliff's Delta = -0.03 
##  
##  g [ 95 %CI] = -0.06 [ -0.22 , 0.1 ] 
##   var(g) = 0.01 
##   p-value(g) = 0.46 
##   U3(g) = 47.59 % 
##   CLES(g) = 48.29 % 
##  
##  Correlation ES: 
##  
##  r [ 95 %CI] = 0.03 [ -0.05 , 0.11 ] 
##   var(r) = 0 
##   p-value(r) = 0.46 
##  
##  z [ 95 %CI] = 0.03 [ -0.05 , 0.11 ] 
##   var(z) = 0 
##   p-value(z) = 0.46 
##  
##  Odds Ratio ES: 
##  
##  OR [ 95 %CI] = 0.9 [ 0.67 , 1.2 ] 
##   p-value(OR) = 0.46 
##  
##  Log OR [ 95 %CI] = -0.11 [ -0.4 , 0.18 ] 
##   var(lOR) = 0.02 
##   p-value(Log OR) = 0.46 
##  
##  Other: 
##  
##  NNT = -60.47 
##  Total N = 601Mean Differences ES: 
##  
##  d [ 95 %CI] = -0.02 [ -0.18 , 0.15 ] 
##   var(d) = 0.01 
##   p-value(d) = 0.85 
##   U3(d) = 49.39 % 
##   CLES(d) = 49.57 % 
##   Cliff's Delta = -0.01 
##  
##  g [ 95 %CI] = -0.02 [ -0.18 , 0.14 ] 
##   var(g) = 0.01 
##   p-value(g) = 0.85 
##   U3(g) = 49.39 % 
##   CLES(g) = 49.57 % 
##  
##  Correlation ES: 
##  
##  r [ 95 %CI] = 0.01 [ -0.07 , 0.09 ] 
##   var(r) = 0 
##   p-value(r) = 0.85 
##  
##  z [ 95 %CI] = 0.01 [ -0.07 , 0.09 ] 
##   var(z) = 0 
##   p-value(z) = 0.85 
##  
##  Odds Ratio ES: 
##  
##  OR [ 95 %CI] = 0.97 [ 0.73 , 1.3 ] 
##   p-value(OR) = 0.85 
##  
##  Log OR [ 95 %CI] = -0.03 [ -0.32 , 0.26 ] 
##   var(lOR) = 0.02 
##   p-value(Log OR) = 0.85 
##  
##  Other: 
##  
##  NNT = -234.86 
##  Total N = 601Mean Differences ES: 
##  
##  d [ 95 %CI] = -0.86 [ -1.03 , -0.69 ] 
##   var(d) = 0.01 
##   p-value(d) = 0 
##   U3(d) = 19.52 % 
##   CLES(d) = 27.18 % 
##   Cliff's Delta = -0.46 
##  
##  g [ 95 %CI] = -0.86 [ -1.03 , -0.69 ] 
##   var(g) = 0.01 
##   p-value(g) = 0 
##   U3(g) = 19.54 % 
##   CLES(g) = 27.2 % 
##  
##  Correlation ES: 
##  
##  r [ 95 %CI] = 0.39 [ 0.32 , 0.46 ] 
##   var(r) = 0 
##   p-value(r) = 0 
##  
##  z [ 95 %CI] = 0.42 [ 0.34 , 0.5 ] 
##   var(z) = 0 
##   p-value(z) = 0 
##  
##  Odds Ratio ES: 
##  
##  OR [ 95 %CI] = 0.21 [ 0.16 , 0.29 ] 
##   p-value(OR) = 0 
##  
##  Log OR [ 95 %CI] = -1.56 [ -1.86 , -1.25 ] 
##   var(lOR) = 0.02 
##   p-value(Log OR) = 0 
##  
##  Other: 
##  
##  NNT = -6.43 
##  Total N = 601Mean Differences ES: 
##  
##  d [ 95 %CI] = -1.08 [ -1.25 , -0.91 ] 
##   var(d) = 0.01 
##   p-value(d) = 0 
##   U3(d) = 13.95 % 
##   CLES(d) = 22.2 % 
##   Cliff's Delta = -0.56 
##  
##  g [ 95 %CI] = -1.08 [ -1.25 , -0.91 ] 
##   var(g) = 0.01 
##   p-value(g) = 0 
##   U3(g) = 13.98 % 
##   CLES(g) = 22.22 % 
##  
##  Correlation ES: 
##  
##  r [ 95 %CI] = 0.48 [ 0.41 , 0.54 ] 
##   var(r) = 0 
##   p-value(r) = 0 
##  
##  z [ 95 %CI] = 0.52 [ 0.44 , 0.6 ] 
##   var(z) = 0 
##   p-value(z) = 0 
##  
##  Odds Ratio ES: 
##  
##  OR [ 95 %CI] = 0.14 [ 0.1 , 0.19 ] 
##   p-value(OR) = 0 
##  
##  Log OR [ 95 %CI] = -1.96 [ -2.28 , -1.65 ] 
##   var(lOR) = 0.03 
##   p-value(Log OR) = 0 
##  
##  Other: 
##  
##  NNT = -5.79 
##  Total N = 601Mean Differences ES: 
##  
##  d [ 95 %CI] = 0.02 [ -0.15 , 0.18 ] 
##   var(d) = 0.01 
##   p-value(d) = 0.85 
##   U3(d) = 50.6 % 
##   CLES(d) = 50.43 % 
##   Cliff's Delta = 0.01 
##  
##  g [ 95 %CI] = 0.02 [ -0.15 , 0.18 ] 
##   var(g) = 0.01 
##   p-value(g) = 0.85 
##   U3(g) = 50.6 % 
##   CLES(g) = 50.43 % 
##  
##  Correlation ES: 
##  
##  r [ 95 %CI] = 0.01 [ -0.07 , 0.09 ] 
##   var(r) = 0 
##   p-value(r) = 0.85 
##  
##  z [ 95 %CI] = 0.01 [ -0.07 , 0.09 ] 
##   var(z) = 0 
##   p-value(z) = 0.85 
##  
##  Odds Ratio ES: 
##  
##  OR [ 95 %CI] = 1.03 [ 0.77 , 1.37 ] 
##   p-value(OR) = 0.85 
##  
##  Log OR [ 95 %CI] = 0.03 [ -0.26 , 0.32 ] 
##   var(lOR) = 0.02 
##   p-value(Log OR) = 0.85 
##  
##  Other: 
##  
##  NNT = 235.02 
##  Total N = 601Mean Differences ES: 
##  
##  d [ 95 %CI] = -0.02 [ -0.18 , 0.14 ] 
##   var(d) = 0.01 
##   p-value(d) = 0.77 
##   U3(d) = 49.06 % 
##   CLES(d) = 49.34 % 
##   Cliff's Delta = -0.01 
##  
##  g [ 95 %CI] = -0.02 [ -0.18 , 0.14 ] 
##   var(g) = 0.01 
##   p-value(g) = 0.77 
##   U3(g) = 49.07 % 
##   CLES(g) = 49.34 % 
##  
##  Correlation ES: 
##  
##  r [ 95 %CI] = 0.01 [ -0.07 , 0.09 ] 
##   var(r) = 0 
##   p-value(r) = 0.77 
##  
##  z [ 95 %CI] = 0.01 [ -0.07 , 0.09 ] 
##   var(z) = 0 
##   p-value(z) = 0.77 
##  
##  Odds Ratio ES: 
##  
##  OR [ 95 %CI] = 0.96 [ 0.72 , 1.28 ] 
##   p-value(OR) = 0.77 
##  
##  Log OR [ 95 %CI] = -0.04 [ -0.33 , 0.25 ] 
##   var(lOR) = 0.02 
##   p-value(Log OR) = 0.77 
##  
##  Other: 
##  
##  NNT = -153.72 
##  Total N = 601
```

The resulting object (`Fair_effsize`) is a list where each list element is the output of the `tes` function. Let's have a look at one of these list elements:


```r
Fair_effsize[[1]]
```

```
##   N.total n.1 n.2     d var.d   l.d   u.d  U3.d  cl.d cliffs.d pval.d
## t     601 315 286 -0.39  0.01 -0.55 -0.22 34.97 39.24    -0.22      0
##       g var.g   l.g   u.g  U3.g  cl.g pval.g    r var.r  l.r  u.r pval.r
## t -0.39  0.01 -0.55 -0.22 34.99 39.25      0 0.19     0 0.11 0.27      0
##   fisher.z var.z  l.z  u.z  OR l.or u.or pval.or  lOR l.lor u.lor pval.lor
## t     0.19     0 0.11 0.27 0.5 0.37 0.67       0 -0.7 -0.99 -0.41        0
##      NNT
## t -11.08
```

```r
str(Fair_effsize[[1]])
```

```
## 'data.frame':	1 obs. of  36 variables:
##  $ N.total : num 601
##  $ n.1     : num 315
##  $ n.2     : num 286
##  $ d       : num -0.39
##  $ var.d   : num 0.01
##  $ l.d     : num -0.55
##  $ u.d     : num -0.22
##  $ U3.d    : num 35
##  $ cl.d    : num 39.2
##  $ cliffs.d: num -0.22
##  $ pval.d  : num 0
##  $ g       : num -0.39
##  $ var.g   : num 0.01
##  $ l.g     : num -0.55
##  $ u.g     : num -0.22
##  $ U3.g    : num 35
##  $ cl.g    : num 39.2
##  $ pval.g  : num 0
##  $ r       : num 0.19
##  $ var.r   : num 0
##  $ l.r     : num 0.11
##  $ u.r     : num 0.27
##  $ pval.r  : num 0
##  $ fisher.z: num 0.19
##  $ var.z   : num 0
##  $ l.z     : num 0.11
##  $ u.z     : num 0.27
##  $ OR      : num 0.5
##  $ l.or    : num 0.37
##  $ u.or    : num 0.67
##  $ pval.or : num 0
##  $ lOR     : num -0.7
##  $ l.lor   : num -0.99
##  $ u.lor   : num -0.41
##  $ pval.lor: num 0
##  $ NNT     : num -11.1
```

The element itself is a data frame with n=1 and p=36. So we could nicely row-bind these 36 rows into one data frame. How to do that?



```r
Fair_effsize %>% 
  map( ~do.call(rbind, .)) %>% 
  as.data.frame -> Fair_effsize_df

head(Fair_effsize_df)
```

```
##            age     ym religious education occupation   rate nbaffairs
## N.total 601.00 601.00    601.00    601.00     601.00 601.00    601.00
## n.1     315.00 315.00    315.00    315.00     315.00 315.00    315.00
## n.2     286.00 286.00    286.00    286.00     286.00 286.00    286.00
## d        -0.39  -0.06     -0.02     -0.86      -1.08   0.02     -0.02
## var.d     0.01   0.01      0.01      0.01       0.01   0.01      0.01
## l.d      -0.55  -0.22     -0.18     -1.03      -1.25  -0.15     -0.18
```

What we did here is:

1. Take each list element and then... (that was `map`)
2. bind these elements row-wise together, ie,. "underneath" each other (`rbind`). `do.call` is only a helper that allows to hand over to `rbind` a bunch of rows.
3. Then convert this element, still a list, to a data frame (not much changes in effect)


Finally, let's convert the row names to a column:


```r
Fair_effsize_df %>% 
  rownames_to_column -> Fair_effsize_df

head(Fair_effsize_df)
```

```
##   rowname    age     ym religious education occupation   rate nbaffairs
## 1 N.total 601.00 601.00    601.00    601.00     601.00 601.00    601.00
## 2     n.1 315.00 315.00    315.00    315.00     315.00 315.00    315.00
## 3     n.2 286.00 286.00    286.00    286.00     286.00 286.00    286.00
## 4       d  -0.39  -0.06     -0.02     -0.86      -1.08   0.02     -0.02
## 5   var.d   0.01   0.01      0.01      0.01       0.01   0.01      0.01
## 6     l.d  -0.55  -0.22     -0.18     -1.03      -1.25  -0.15     -0.18
```


A bit of a ride, but we got there!

And I am sure, better ways are out there. Let me know!
