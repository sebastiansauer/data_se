---
author: Sebastian Sauer
date: '2017-10-17'
title: Simple way to separate train and test sample in R
tags:
  - rstats
  - data_science
slug: train-test
---


For statistical modeling, it is typical to separate a train sample from a test sample. The training sample is used to build ("train") the model, whereas the test sample is used to gauge the predictive quality of the model.

There are many ways to split off a test sample from the train sample. One quite simple, tidyverse-oriented way, is the following.


First, load the tidyverse. Next, load some data.


```r
library(tidyverse)
data(Affairs, package = "AER")
```

Then, create an index vector of the length of your train sample, say 80% of the total sample size.



```r
set.seed(42)
index <- sample(1:601, size = trunc(.8 * 601))
```

Put bluntly, we draw 480 (.8*601) cases from the dataset, and note their row numbers.


```r
a_train <- Affairs %>%
  filter(row_number() %in% index)
```

The test set is the complement of the train set, drawn similarly:


```r
a_test <- Affairs %>%
  filter(!(row_number() %in% index))
```
