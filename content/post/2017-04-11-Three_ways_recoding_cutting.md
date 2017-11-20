---
author: Sebastian Sauer
date: '2017-04-11'
title: Three ways to dichotomize a variable
tags: rstats
slug: Three_ways_recoding_cutting
---



Dichotomizing is also called dummy coding. It means: Take a variable with multiple different values (>2), and transform it so that the output variable has 2 different values.

Note that this "thing" can be understood as consisting of two different aspects: Recoding and cutting. Recoding means that value "a" becomes values "b" etc. Cutting means that a "rope" of numbers is cut into several shorter "ropes" (that's why it is called cutting).

Several ways of achieving this exist in R. Here we discuss three.


First, let's load some data.


```r
library(AER)
data(Affairs)
```


We will define a new variable, called "halodrie". A "halodrie" is someone who likes having affairs (German parlance). The variable should have 2 values, ie., "yes" and "no".

# Using {car}


```r
library(car)

Affairs$halodrie <- car::recode(Affairs$affairs, "0 = 'no'; 1:12 = 'yes'")

head(Affairs$halodrie)
```

```
## [1] "no" "no" "no" "no" "no" "no"
```

```r
table(Affairs$halodrie)
```

```
## 
##  no yes 
## 451 150
```

A comfortable feature of this function is that it allows using the colon operator. Note that the whole recode-thing (all values to be recoded) is to be put into quotation marks.

# Using {dplyr}


```r
library(dplyr)

Affairs$halodrie <- 
  dplyr::recode(Affairs$affairs, `0` = "no", .default = "yes")

Affairs$halodrie %>% head
```

```
## [1] "no" "no" "no" "no" "no" "no"
```

```r
table(Affairs$halodrie)
```

```
## 
##  no yes 
## 451 150
```


This function does not allow the colon operator. I assume the reason that the author (Hadley Wickham) argues that a given function should only be capable of one thing. Here, the function reassigns a value of a variable, not (much) more, not less. 


# Using `base::cut`


```r
Affairs$halodrie <- cut(Affairs$affairs, breaks = c(-Inf, 0, +Inf), labels = c("no", "yes"))

table(Affairs$halodrie)
```

```
## 
##  no yes 
## 451 150
```

Of note, when a continuous variable is "cut", one must specify the minimum and the maximum value (or arbitrarly small or large values) as cutting points. So cutting in two halfs, is *not one* cutting point for `cut`, but three (always add two cutting points: one being the smallest value in the sample [or smaller, even `-Inf`, the other one being the largest value in the sample [or even `Inf`]).

# Summary

For beginners, I would recommend `car::recode`. It provides both recoding and cutting in one function, and hence may be easier to apply at start. It also offers quite some flexibility. Assume you are interested in marriages ranging from 5 to 15 years:


```r
Affairs$years5_15 <- car::recode(Affairs$yearsmarried, "0:4 =  'no'; 5:15 = 'yes'; else = 'no'")

head(Affairs$years5_15)
```

```
## [1] "yes" "no"  "yes" "yes" "no"  "no"
```

```r
table(Affairs$years5_15)
```

```
## 
##  no yes 
## 245 356
```

