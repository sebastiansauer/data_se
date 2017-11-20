---
author: Sebastian Sauer
date: '2016-11-13'
title: New bar stacking with ggplot 2.2.0
tags:
  - rstats
  - plotting
slug: improved_bar_stacking_ggplot2_220
---




Recently, `ggplot2` 2.2.0 was released. Among other news, stacking bar plot was improved. Here is a short demonstration.

Load libraries

```r
library(tidyverse)
library(htmlTable)
```

... and load data:



```r
data <- read.csv("https://osf.io/meyhp/?action=download")
```

DOI for this piece of data is 10.17605/OSF.IO/4KGZH.

The data consists of results of a survey on extraversion and associated behavior.

Say, we would like to visualize the responsed to the extraversion items (there are 10 of them).

So, let's see. First, compute summary of the responses.


```r
data %>% 
  select(i01:i10) %>% 
  gather %>% 
  dplyr::count(key, value) %>% 
  ungroup -> data2
  
htmlTable(head(data2))
```

<table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>key</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>value</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>n</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>39</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>230</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'>4</td>
<td style='text-align: center;'>223</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'></td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>6</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>i02</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>1</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>176</td>
</tr>
</tbody>
</table>


Ok, so now let's plot.


```r
ggplot(data2) +
  geom_col(aes(x = key, fill = value, y = n))
```

![plot of chunk unnamed-chunk-4](https://sebastiansauer.github.io/images/2016-11-13-03/unnamed-chunk-4-1.png)


Note that `geom_col` is short-hand vor `geom_bar(stat = "identity")`.

Of interest, "negative" stacking is now possible. 


```r
data %>% 
  select(i01:i10) %>% 
  gather %>% 
  na.omit %>% 
  count(key, value) %>% 
  ungroup %>% 
  group_by(key) %>% 
  mutate(rel_n = round(n - mean(n), 2)) %>% 
  ungroup -> data3



htmlTable(head(data3))
```

<table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>key</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>value</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>n</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>rel_n</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>7</td>
<td style='text-align: center;'>-117.75</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>39</td>
<td style='text-align: center;'>-85.75</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>230</td>
<td style='text-align: center;'>105.25</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>i01</td>
<td style='text-align: center;'>4</td>
<td style='text-align: center;'>223</td>
<td style='text-align: center;'>98.25</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>i02</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>176</td>
<td style='text-align: center;'>51.5</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>6</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>i02</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>2</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>224</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>99.5</td>
</tr>
</tbody>
</table>



```r
ggplot(data3) +
  geom_col(aes(x = key, fill = value, y = rel_n))
```

![plot of chunk unnamed-chunk-6](https://sebastiansauer.github.io/images/2016-11-13-03/unnamed-chunk-6-1.png)

Hm, at it comes to the color, we need to change to discrete colors. It appears that the color scheme is not able (out of the box) to adapt to this "negative stacking".

So:


```r
ggplot(data3) +
  geom_col(aes(x = key, fill = factor(value), y = rel_n))
```

![plot of chunk unnamed-chunk-7](https://sebastiansauer.github.io/images/2016-11-13-03/unnamed-chunk-7-1.png)




```r
sessionInfo()
```

```
## R version 3.3.2 (2016-10-31)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: macOS Sierra 10.12.1
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] purrr_0.2.2.9000 readr_1.0.0      tibble_1.2       tidyverse_1.0.0 
## [5] knitr_1.15       htmlTable_1.7    ggplot2_2.2.0    tidyr_0.6.0     
## [9] dplyr_0.5.0     
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.7         magrittr_1.5        munsell_0.4.3      
##  [4] colorspace_1.3-0    R6_2.2.0            highr_0.6          
##  [7] stringr_1.1.0       plyr_1.8.4          tools_3.3.2        
## [10] grid_3.3.2          gtable_0.2.0        DBI_0.5-1          
## [13] htmltools_0.3.5     yaml_2.1.13         lazyeval_0.2.0.9000
## [16] assertthat_0.1      digest_0.6.10       rprojroot_1.1      
## [19] rsconnect_0.5       evaluate_0.10       rmarkdown_1.1.9016 
## [22] labeling_0.3        stringi_1.1.2       scales_0.4.1       
## [25] backports_1.0.4
```

