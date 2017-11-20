---
author: Sebastian Sauer
date: '2017-09-05'
title: Replacing dplyr::do by purrr:map. Some considerations
tags:
  - rstats
  - tidyverse
slug: purrr-map-no-do
---




Hadley Wickham has announced to depreceate `dplyr::do` in favor of `purrr:map`. In a recent post, I have made use of `do`, so some commentators informed me about that. In this post, I will show use cases of `map`, specifically as a replacement of `do`. `map` is for lists; read more about lists [here](http://r4ds.had.co.nz/lists.html).


```r
library(tidyverse)
library(broom)
```

We will use `mtcars` as a sample dataframe (boring, I know, but convenient).



```r
data(mtcars)
```

# `Cor` is a function that takes a dataframe as its input

As in the last post, assume we would like to conduct a correlation test. First, let's start simple using `cor`.



```r
mtcars %>% 
  select_if(is.numeric) %>% 
  select(1:3) %>%   # to make it smaller
  cor
#>             mpg        cyl       disp
#> mpg   1.0000000 -0.8521620 -0.8475514
#> cyl  -0.8521620  1.0000000  0.9020329
#> disp -0.8475514  0.9020329  1.0000000
```

Here's no need for `purrr:map`. `map` is essentially a looping device, taking a list as input. However, `cor` does not takes lists as input. It takes a whole dataframe (consisting of many lists). That's even more practical than a looping function such as `map`.

# `cor.test` via `do` and via `map`

Now let's see where `map` makes sense. Consider `cor.test` from the last post. `cor.test` does not accept a dataframe as input, hence the `dplyr` logic does not apply well. Instead we have to build a workaround using `do`:



```r
mtcars %>% 
  do(cor.test(.$hp, .$cyl) %>% tidy)
#>    estimate statistic      p.value parameter  conf.low conf.high
#> 1 0.8324475  8.228604 3.477861e-09        30 0.6816016 0.9154223
#>                                 method alternative
#> 1 Pearson's product-moment correlation   two.sided
```

Here we apply the function `cor.test` to two columns. Applying functions to columns (ie., lists) works smoothly with `map` and friends:


```r
mtcars %>% 
  select(hp) %>%  # take out this line for iteration/loop
  map(~cor.test(.x, mtcars$cyl) %>% tidy)
#> $hp
#>    estimate statistic      p.value parameter  conf.low conf.high
#> 1 0.8324475  8.228604 3.477861e-09        30 0.6816016 0.9154223
#>                                 method alternative
#> 1 Pearson's product-moment correlation   two.sided
```

# `map` applies a function to a list element

So, what does `map` do? It applies a function `.fun` over all elements of a list `.list`:

`map(.list, .fun)`


`.list` must either be a list or a simple vector. `mapp` is convenient for iteration as a replacement of "for-loops":



```r
mtcars %>% 
  select(hp, cyl, mpg) %>%  # only three for the sake of demonstration
  map(~cor.test(.x, mtcars$cyl) %>% tidy)
#> $hp
#>    estimate statistic      p.value parameter  conf.low conf.high
#> 1 0.8324475  8.228604 3.477861e-09        30 0.6816016 0.9154223
#>                                 method alternative
#> 1 Pearson's product-moment correlation   two.sided
#> 
#> $cyl
#>   estimate statistic p.value parameter conf.low conf.high
#> 1        1       Inf       0        30        1         1
#>                                 method alternative
#> 1 Pearson's product-moment correlation   two.sided
#> 
#> $mpg
#>    estimate statistic      p.value parameter   conf.low  conf.high
#> 1 -0.852162 -8.919699 6.112687e-10        30 -0.9257694 -0.7163171
#>                                 method alternative
#> 1 Pearson's product-moment correlation   two.sided
```

BTW, it would be nice to combine the tidy output elements (`$hp`, `$cyl`, `$mpg`) to a dataframe:


```r
mtcars %>% 
  select(hp, cyl, mpg) %>%  # only three for the sake of demonstration
  map_df(~cor.test(.x, mtcars$cyl) %>% tidy)
#>     estimate statistic      p.value parameter   conf.low  conf.high
#> 1  0.8324475  8.228604 3.477861e-09        30  0.6816016  0.9154223
#> 2  1.0000000       Inf 0.000000e+00        30  1.0000000  1.0000000
#> 3 -0.8521620 -8.919699 6.112687e-10        30 -0.9257694 -0.7163171
#>                                 method alternative
#> 1 Pearson's product-moment correlation   two.sided
#> 2 Pearson's product-moment correlation   two.sided
#> 3 Pearson's product-moment correlation   two.sided
```

`map_df` maps the function (that's what comes after "~") to each list (ie., column) of `mtcars`. If possible, the resulting elements will be row-binded to a dataframe. To make the output of `cor.test` nice (ie., tidy) we again use `tidy`.



# Extract elements from a list using `map`

Say, we are only interest in the p-value (OMG). How to extract each of the 3 p-values in our example?


```r
mtcars %>% 
  select(hp, cyl, mpg) %>%  # only three for the sake of demonstration
  map(~cor.test(.x, mtcars$cyl) %>% tidy) %>% 
  map("p.value")
#> $hp
#> [1] 3.477861e-09
#> 
#> $cyl
#> [1] 0
#> 
#> $mpg
#> [1] 6.112687e-10
```

To extract several elements, say the p-value and r, we can use the `[` operator:


```r
mtcars %>% 
  select(hp, cyl, mpg) %>%  # only three for the sake of demonstration
  map(~cor.test(.x, mtcars$cyl) %>% tidy) %>% 
  map(`[`, c("p.value", "statistic"))
#> $hp
#>        p.value statistic
#> 1 3.477861e-09  8.228604
#> 
#> $cyl
#>   p.value statistic
#> 1       0       Inf
#> 
#> $mpg
#>        p.value statistic
#> 1 6.112687e-10 -8.919699
```

`[` is some kind of "extractor" function; it extracts elements, and returns a list or data frame:


```r
mtcars["hp"] %>% head
#>                    hp
#> Mazda RX4         110
#> Mazda RX4 Wag     110
#> Datsun 710         93
#> Hornet 4 Drive    110
#> Hornet Sportabout 175
#> Valiant           105
mtcars["hp"] %>% head %>% str
#> 'data.frame':	6 obs. of  1 variable:
#>  $ hp: num  110 110 93 110 175 105

x <- list(1, 2, 3)
x[1]
#> [[1]]
#> [1] 1
```


Maybe more convenient, there is a function called `magrittr:extractor`. It's a wrapper aroung `[`:


```r
library(magrittr)
mtcars %>% 
  select(hp, cyl, mpg) %>%  # only three for the sake of demonstration
  map(~cor.test(.x, mtcars$cyl) %>% tidy) %>% 
  map_df(extract, c("p.value", "statistic"))
#>        p.value statistic
#> 1 3.477861e-09  8.228604
#> 2 0.000000e+00       Inf
#> 3 6.112687e-10 -8.919699
```
