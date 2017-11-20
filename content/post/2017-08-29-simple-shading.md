---
author: Sebastian Sauer
date: '2017-08-29'
title: Shading normal curve made easy
slug: simple-shading
---





Shading values/areas under the normal curve is a quite frequent taks in eg educational contexts. Thanks to Hadley in [this post](
https://github.com/tidyverse/ggplot2/issues/1528), I found this easy solution.



```r
library(ggplot2)
```

``````

```r
ggplot(NULL, aes(c(-3,3))) +
  geom_area(stat = "function", fun = dnorm, fill = "#00998a", xlim = c(-3, 0)) +
  geom_area(stat = "function", fun = dnorm, fill = "grey80", xlim = c(0, 3))
```

![plot of chunk unnamed-chunk-1]({{ site.url }}/images/2017-08-29/unnamed-chunk-1-1.png)

Simple, right?


Some minor beautification:


```r
 ggplot(NULL, aes(c(-3,3))) +
  geom_area(stat = "function", fun = dnorm, fill = "#00998a", xlim = c(-3, 1)) +
  geom_area(stat = "function", fun = dnorm, fill = "grey80", xlim = c(1, 3)) +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = 1)
```

![plot of chunk unnamed-chunk-2]({{ site.url }}/images/2017-08-29/unnamed-chunk-2-1.png)



And some other quantiles:



```r
ggplot(NULL, aes(c(-3,3))) +
  geom_area(stat = "function", fun = dnorm, fill = "#00998a", xlim = c(-3, 1.65)) +
  geom_area(stat = "function", fun = dnorm, fill = "grey80", xlim = c(1.65, 3)) +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = 1.65)
```

![plot of chunk unnamed-chunk-3]({{ site.url }}/images/2017-08-29/unnamed-chunk-3-1.png)

```r
ggplot(NULL, aes(c(-3,3))) +
  geom_area(stat = "function", fun = dnorm, fill = "#00998a", xlim = c(-3, 2)) +
  geom_area(stat = "function", fun = dnorm, fill = "grey80", xlim = c(2, 3)) +
  labs(x = "z", y = "") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(breaks = 2)
```

![plot of chunk unnamed-chunk-3]({{ site.url }}/images/2017-08-29/unnamed-chunk-3-2.png)
