---
author: Sebastian Sauer
date: '2016-11-03'
title: How to plot a 'percentage plot' with ggplot2
tags:
  - plotting
  - rstats
slug: percentage_plot_ggplot2_V2
---

At times it is convenient to draw a frequency bar plot; at times we prefer not the bare frequencies but the proportions or the percentages per category. There are lots of ways doing so; let's look at some `ggplot2` ways.

First, let's load some data.


```r
data(tips, package = "reshape2")
```

And the typical libraries.


```r
library(dplyr)
library(ggplot2)
library(tidyr)
library(scales)  # for percentage scales
```


# Way 1


```r
tips %>% 
  count(day) %>% 
  mutate(perc = n / nrow(tips)) -> tips2

ggplot(tips2, aes(x = day, y = perc)) + geom_bar(stat = "identity")
```

![plot of chunk plot1](https://sebastiansauer.github.io/images/2016-11-02-02/plot1-1.png)



# Way 2




```r
ggplot(tips, aes(x = day)) +  
  geom_bar(aes(y = (..count..)/sum(..count..)))
```

![plot of chunk unnamed-chunk-1](https://sebastiansauer.github.io/images/2016-11-02-02/unnamed-chunk-1-1.png)



# Way 3



```r
myplot <- ggplot(tips, aes(day)) + 
          geom_bar(aes(y = (..count..)/sum(..count..))) + 
          scale_y_continuous(labels=scales::percent) +
  ylab("relative frequencies")

myplot
```

![plot of chunk unnamed-chunk-2](https://sebastiansauer.github.io/images/2016-11-02-02/unnamed-chunk-2-1.png)





# Way 4



```r
myplot <- ggplot(tips, aes(day, group = sex)) + 
          geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") + 
          scale_y_continuous(labels=scales::percent) +
          ylab("relative frequencies") +
          facet_grid(~sex)

myplot
```

![plot of chunk unnamed-chunk-3](https://sebastiansauer.github.io/images/2016-11-02-02/unnamed-chunk-3-1.png)



# Way 5

```r
ggplot(tips, aes(x= day,  group=sex)) + 
    geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
    geom_text(aes( label = scales::percent(..prop..),
                   y= ..prop.. ), stat= "count", vjust = -.5) +
    labs(y = "Percent", fill="day") +
    facet_grid(~sex) +
    scale_y_continuous(labels = scales::percent)
```

![plot of chunk unnamed-chunk-4](https://sebastiansauer.github.io/images/2016-11-02-02/unnamed-chunk-4-1.png)

