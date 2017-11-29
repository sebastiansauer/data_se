---
author: Sebastian Sauer
date: '2016-07-04'
title: Long vs. wide format, and gather()
tags:
  - rstats
slug: gather-long-to-wide-format
---

*reading time: 10 min.*

A quite common task in data analysis is to change a dataset from wide to long format.

For example, this is a dataset in wide format:

 
![]( /images/gatherwide.png)

Is is called wide, as, well, it is wide – several columns side by side.

For example, assume, we have measured a number of predictors (here: predictor_1, predictor_2, predictor_3), and an outcome measure (here: outcome). In this case, each variable is dichotomous (either yes or no).

For plotting, eg. using [ggplot2](http://ggplot2.org), we have to convert this format to long format. Long datasets look like this:

![]( /images/gather_long.png)

So, non really surprising, the dataset is now longer than in wide format. Hence the name…

It was converted in a certain way. Look at the two figures (and the color scheme). The 4 columns are now 3: All of the predictors are now paired in two colums: key and value. In the key column we find the names of the former columns as entries; in the value column we find the entries of those columns as entries (check the colors).

We easily see that the variable outcome was not paired. Before and after the convertion, it happily resides in its own, whole column. We often want a non-paired column, as we need it for eg., facetting.

Let’s visualize this transformation. First, we look at the transformation of the values:

![](/images/gather_values.png)

Second, let’s look at the transformation of the keys (column headers), and the outcome variable, which will not be paires (remains in its own, complete, tidy column):

![](/images/gather_keys.png)

 

So let’s see the `tidyr` and `dplyr` code:


```r
library(dplyr)
library(tidyr)
library(ggplot2)

data(Wage, package = "ISLR")

Wage %>%
  mutate(wage_f = ntile(wage, 2)) %>%  # bin it
  mutate(wage_f = factor(wage_f, labels = c("low_wage","high_wage"))) %>%
  select(health, race, wage_f) %>%
  gather(key = predictor, value = pred_value, -wage_f) %>%
  ggplot(aes(x = pred_value, fill = predictor)) + geom_bar() + facet_wrap(~wage_f) +
  coord_flip()
```

```
## Warning: attributes are not identical across measure variables; they will
## be dropped
```

![]( /images/gather1.png)



The plot itself is not particular useful as it is, but at times you will want such a type of plot. And many R functions built on the long format.
