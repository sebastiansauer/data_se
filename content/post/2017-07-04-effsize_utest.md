---
author: Sebastian Sauer
date: '2017-07-04'
title: 'Effect sizes for the Mann-Whitney U Test: an intuition'
tags:
  - stats
  - intuition
  - rstats
slug: effsize_utest
---




The Mann-Whitney U-Test is a test with a wide applicability, wider than the t-Test. Why that? Because the U-Test is applicable for ordinal data, and it can be argued that confining the metric level of a psychological variable to ordinal niveau is a reasonable bet. Second, it is robust, more robust than the t-test, because it only considers ranks, not raw values. In addition, [some say](https://en.wikipedia.org/wiki/Mann%E2%80%93Whitney_U_test#cite_note-Lehmann_1999-13) that the efficiency of the U-Test is very close to the t-Test (.95). In sum: use the U-Test.

# Idea of the U-Test

How is the test computed? In essence, that's easy: 

1. Count the number of pairwise comparisons in your sample. Say you have  two groups, with n1=5 and n2=4. Thus there are 20 comparisons in total.
2. Now count the frequency group 1 "wins" a comparison (count 0.5 for ties). The resulting statistic can be called U.

How to achieve that in R? Try this code. Say we have two groups of runners (100m), and we record their running time (in seconds):


```r
g1 <- c(9.9, 10.3, 11.5, 12.1, 23.3)
g2 <- c(13.2, 14.5, 15.2, 16.6)
```

Now let's see all possible comparisons:


```r
comp <- expand.grid(g1, g2)
names(comp) <- c("g1", "g2")
head(comp)
```

```
##     g1   g2
## 1  9.9 13.2
## 2 10.3 13.2
## 3 11.5 13.2
## 4 12.1 13.2
## 5 23.3 13.2
## 6  9.9 14.5
```

How man comparisons do we have?


```r
nrow(comp)
```

```
## [1] 20
```



And now count how often members of g1 outperform members of g2, ie., we count the proportion of $$g1_i > g2_j$$ for all $$i,j$$.

I need the pipe for that...


```r
library(tidyverse)
```



```r
comp %>% 
  mutate(g1fasterg2 = g1 < g2) %>% 
  summarise(sum_g1fasterg2 = sum(g1fasterg2))
```

```
##   sum_g1fasterg2
## 1             16
```

So we now have the sum of "wins"; getting the proportion is easy, just divide by the number of comparisons.


# Computing U the standard way

Let's compare that to the more "traditional" way of computing U.

U is given by 

$$U1 =\sum{g1} - \sum{min1}$$

where $$U1$$ means the U statistic for g1, and $$min1$$ is the *minimal possible* rank sum in g1. What's the smallest possible rank sum if there are 2 observations in a group? 3. Because 1+2=3. If there are 5 runners in a group? 15. Because 1+2+3+4+5=15. So, in our case for g1, 15 is the minimal possible rank sum in g1. Now we now that if we get a rank sum of 15 that's as possible as it can be.

Let's compute the rank sums for each group.

First, build a dataframe:


```r
df <- data.frame(
  runtime = c(g1, g2),
  groups = c(rep("g1", 5), rep("g2",4))
  )
```

Now transform the run time to ranks.


```r
df %>% 
  mutate(ranks = min_rank(runtime)) -> df
```

Note that we are not considering ties here for the sake of simplicity.

Now compute the sum of `ranks` grouped by `groups`.


```r
df %>% 
  group_by(groups) %>% 
  summarise(ranks_sum = sum(ranks))
```

```
## # A tibble: 2 x 2
##   groups ranks_sum
##   <fctr>     <int>
## 1     g1        19
## 2     g2        26
```

Applying the formula above we see that the rank sum for g1 is 19, subtracting the min rank of 15, we get a value of 4. This number is equivalent to saying that out of 20 comparisons, g1 lost 4 (and won 16). U is obviously synonymous to saying "how many comparisons were lost".

For g2, similarly: 26 - 10 = 16, so 16 (out of 20) comparisons were *lost*.

Now, the *proportion* of won (or lost) comparisons is of course more telling than the absolute value, seen from a practical point of view. This amounts to saying that the proportion of won/lost comparisons is some kind of *effect size*. See details for this idea in the paper of [Kerby](http://journals.sagepub.com/doi/pdf/10.2466/11.IT.3.1) (Kerby, D. S. (2014). The Simple Difference Formula: An Approach to Teaching Nonparametric Correlation. *Comprehensive Psychology, 3*, 11.IT.3.1. http://doi.org/10.2466/11.IT.3.1), and the 1992 paper of 
[McGraw and Wong](http://core.ecu.edu/psyc/wuenschk/docs30/CL.pdf) (McGraw, K. O., & Wong, S. P. (1992). A common language effect size statistic. *Psychological Bulletin, 111*(2), 361–365. http://doi.org/10.1037/0033-2909.111.2.361). That's were the ideas presented here stem from (as far as I am involved).


>   The proportion of favorable comparisons can be gauged a "common language effect size" (CLES).

In our example, the effect size (CLES) would amount to 16/20 = 80% (.8). For the sake of a memorable example, let's say that g1 are "doped runners" and g2 are "normal runners".

It's quite straight forward to say "doped runners outperform normal runners in 80 of 100 cases".

As an effect size for non-parametric two-group comparison scenarios are quite often neglected in standard text books, I think it is helpful to ponder the CLES idea presented by Kerby, and put forward earlier by McGraw and Wong.



