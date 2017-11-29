---
author: Sebastian Sauer
date: '2016-08-30'
title: Plot of mean with exact numbers using ggplot2
tags:
  - rstats
  - plotting
slug: plot_dot_means
---




Often, both in academic research and more business-driven data analysis, we want to compare some (two in many cases) means. We will not discuss here that [friends should not let friends plot barplots](https://www.kickstarter.com/projects/1474588473/barbarplots). Following the advise of [Cleveland's seminal book](https://www.amazon.com/Visualizing-Data-William-S-Cleveland/dp/0963488406) we will plot the means using dots, not bars.

However, at times we do not simply want the diagram, but we (or someone) is interested in the bare, plain, naked, exact numbers too. So we would like to put the numbers right into the diagram. One way to achieve this is the following:


First, let's load some data and some packages (in R):

```r
data(tips, package = "reshape2")  # load some data

library(dplyr)
library(tidyr)
library(ggplot2)
```



Then, summarize the variables (ie., compute means per group). Note that for `ggplot` (and many other graphing systems) it is necessary that the the variable depicted at (say) the X-axis conforms to one column in the data set. Thus, we often have to change the structure of the data set (but here not...).


```r
tips %>% 
  group_by(sex, smoker) %>% 
  summarise(mean_group = mean(tip)) -> tips2
```


OK; now let's plot it with `ggplot2`:


```r
tips2 %>% 
    ggplot(aes(x = smoker, y = mean_group, 
             color = sex, shape = smoker,
             group = sex,
             label = round(mean_group, 2))) + 
  geom_point() +
  geom_line() +
  geom_text(aes(x = smoker, y = mean_group + 0.03))
```

![](/images/2016-08-30-05.png)

The whole syntax can be accessed at [Github](https://gist.github.com/sebastiansauer/f555d57dfc91c1de0be04ac256928b58).





