---
author: Sebastian Sauer
date: '2017-08-31'
title: Comparing the pipe with base methods
tags:
  - rstats
  - tidyverse
slug: some-pipes
---




Some say, the pipe (#tidyverse) makes analyses in R easier. I agree. This post demonstrates some examples.


Let's take the `mtcars` dataset as an example.


```r
data(mtcars)
?mtcars
```


Say, we would like to compute the correlation between gasoline consumption (`mpg`) and horsepower (`hp`).

## Base approach 1


```r
cor(mtcars[, c("mpg", "hp")])
```

```
##            mpg         hp
## mpg  1.0000000 -0.7761684
## hp  -0.7761684  1.0000000
```

We use the `[`-operator (function) to select the columns; note that `df[, c(col1, col2)]` sees dataframes as matrices, and spits out a dataframe, not a vector:


```r
class(mtcars[, c("mpg", "hp")])
```

```
## [1] "data.frame"
```

That's ok, because `cor` expects a matrix or a dataframe as input. Alternatively, we can understand dataframes as lists as in the following example.

## Base approach 2


```r
cor.test(x = mtcars[["mpg"]], y = mtcars[["hp"]])
```

```
##
## 	Pearson's product-moment correlation
##
## data:  mtcars[["mpg"]] and mtcars[["hp"]]
## t = -6.7424, df = 30, p-value = 1.788e-07
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.8852686 -0.5860994
## sample estimates:
##        cor
## -0.7761684
```

the `[[`-operator extracts a column from a list (a dataframe is technically a list), and extracts it as a vector. This is useful as some functions, such as `cor.test` don't digest dataframes, but want vectors as input (here x, y).


## Pipe approach 1

We will use `dplyr` for demonstrating the pipe approach.


```r
library(dplyr)

mtcars %>%
  select(mpg, hp) %>%
  cor
```

```
##            mpg         hp
## mpg  1.0000000 -0.7761684
## hp  -0.7761684  1.0000000
```


If you are not acquainted with dplyr, the `%>%` operator can be translated as `then do`. More specifically, the result of the the lefthand side (lhs) is transferred as input to the righthand side (rhs).

Easy, right?


## Pipe approach 2

We will need `broom` here, a package that renders some R output into a nice (ie, tidy) dataframe. For example, `cor.test` does not spit a nice dataframe when left in the wild. Applying `tidy()` from `broom` on the output, we will get a nice dataframe:


```r
library(broom)

cor.test(x = mtcars[["mpg"]], y = mtcars[["hp"]]) %>% tidy
```

```
##     estimate statistic      p.value parameter   conf.low  conf.high
## 1 -0.7761684 -6.742389 1.787835e-07        30 -0.8852686 -0.5860994
##                                 method alternative
## 1 Pearson's product-moment correlation   two.sided
```

```r
# same:
tidy(cor.test(x = mtcars[["mpg"]], y = mtcars[["hp"]]))
```

```
##     estimate statistic      p.value parameter   conf.low  conf.high
## 1 -0.7761684 -6.742389 1.787835e-07        30 -0.8852686 -0.5860994
##                                 method alternative
## 1 Pearson's product-moment correlation   two.sided
```

This code can be made simpler using dplyr:



```r
mtcars %>%
  do(tidy(cor.test(.$mpg, .$hp)))
```

```
##     estimate statistic      p.value parameter   conf.low  conf.high
## 1 -0.7761684 -6.742389 1.787835e-07        30 -0.8852686 -0.5860994
##                                 method alternative
## 1 Pearson's product-moment correlation   two.sided
```

The function `do` from `dplyr` runs any function, provided it spits a dataframe. That's why we first apply `tidy` from `broom`, and run `do` afterwards.

The `.` dot refers to the dataframe as handed over from the last step. We need this piece because `cor.test` does not know any variable by the name `mpg` (unless you have attached `mtcars` beforehands).

This code produces the same result:


```r
mtcars %>%
  do(cor.test(.$mpg, .$hp) %>% tidy) %>%
  knitr::kable()
```



|   estimate| statistic| p.value| parameter|   conf.low|  conf.high|method                               |alternative |
|----------:|---------:|-------:|---------:|----------:|----------:|:------------------------------------|:-----------|
| -0.7761684| -6.742388|   2e-07|        30| -0.8852686| -0.5860994|Pearson's product-moment correlation |two.sided   |


## Pipe appraoch 3

The package `magrittr` provides some pipe variants, most importantly perhaps the "exposition pipe", `%$%`:


```r
mtcars %$%
  cor.test(mpg, hp) %>%
  tidy
```

```
##     estimate statistic      p.value parameter   conf.low  conf.high
## 1 -0.7761684 -6.742389 1.787835e-07        30 -0.8852686 -0.5860994
##                                 method alternative
## 1 Pearson's product-moment correlation   two.sided
```

Why is it useful? Let's spell out the code above in more detail.

- Line 1: "Hey R, pick up `mtcars` but do not simply pass over this dataframe, but pull out each column and pass those columns over"  
- Line 2: "Run the function `cor.test` with `hp` and `mpg`" and then ...  
- Line 3: "Tidy the result up. Not necessary here but quite nice".  


Remember that `cor.test` does *not* accept a dataframe as input. It expects two vectors. That's why we need to transform the dataframe `mtcars` to a bundle of vectors (ie., the columns).


## Recap

In sum, I think the pipe makes life easier. Of course, one needs to get used to it. But after a while, it's much simpler than working with deeply nested `[` brackets.

Enjoy the pipe!
