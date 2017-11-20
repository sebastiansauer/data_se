---
author: Sebastian Sauer
date: '2016-11-30'
title: Pipe the Variance
tags:
  - rstats
  - dplyr
slug: pipe_variance
---




One idea of problem solving is, or should be, I think, that one should tackle problems of high complexity, but not too high. That sounds trivial, cooler tone would be "as hard as possible, as easy as necessary" which is basically the same thing.

In software development including Rstats, a similar principle applies. Sounds theoretical, I admit. So see here some lines of code that has bitten me recently:


```r
obs <-  c(1,2,3)
pred <- c(1,2,4)

monster <- 1 - (sum((obs - pred)^2))/(sum((obs - mean(obs))^2))
monster
```

```
## [1] 0.5
```

The important line is of course


```r
 1 - (sum((obs - pred)^2))/(sum((obs - mean(obs))^2))
```


The bug I incorporated was something like this:



```r
 1 - ((obs - pred)^2)/((obs - mean(obs))^2)
```

Friendly bugs yield a functions that dies trying its job. Nasty bugs silently infuse problems. In this case, not a single number, but a vector of numbers resulted. Once you know it, surely, it is easy. But starring at some 1000 lines of codes can make it more difficult to see...

So, one could argue that the complexity was (too) high... for me, at least. Sigh. To put it differently: Can the code rendered more bug-robust? 

I think the `pipe` ---- `%>%` ---- helps to reduce the complexity. The pipe hacks a big package in tiny pieces, to be dealt with step-by-step, one after each other. And not all in one gobble-dee-gopp.

So, compare the pipe code:


```r
library(dplyr)  # make sure it is installed

obs %>% 
  `-`(pred) %>% 
  `^`(2) %>% 
  sum -> SS_b

obs %>% 
  `-`(mean(obs)) %>% 
  `^`(2) %>% 
  sum -> SS_t
  

R2 <- 1 - (SS_b/SS_t)
R2
```

```
## [1] 0.5
```

In words, what does this code do:

1. Take `obs`, then
2. from that (`obs`) subtract `pred`, then
3. square each number, then
3. sum up the resulting numbers, then
4. save that number as `SS_b`

That's really simple, isn't it!

Similarly procedure for the second bit. `tl;dr`.

Note that the pipe comes from the package `magrittr`, but is included by `dplyr`.

Admittedly, I have allowed one or two intermediate steps which make it easier to follow, too. But that's also a way to reduce unnecessary (I would say) complexity.
