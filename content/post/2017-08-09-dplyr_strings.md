---
author: Sebastian Sauer
date: '2017-08-09'
title: 'Programming with dplyr: Part 03, working with strings'
tags:
  - tidyeval
  - dplyr
  - programming
  - tidyverse
slug: dplyr_strings
---



# More on programming with dplyr: converting quosures to strings

In [this](https://sebastiansauer.github.io/prop_fav/) post, we have programmed a simple function using dplyr's programming capabilities based on [tidyeval](https://cran.r-project.org/web/packages/rlang/vignettes/tidy-evaluation.html); for more intro to programming with dplyr, see [here](https://cran.r-project.org/web/packages/dplyr/vignettes/programming.html).

In this post, we'll go one step further and programm a function where a quosure will be turned to a string. Why this? Because quite a number of functions out there except strings as input parameters.



# Libraries


```r
library(tidyverse)
library(stringr)
```



# Data example

Say, we have a string where we search for a word stem. However this stem does not appear in its "stem" form, but always with some suffixes. Let our stem be "spd" (the name of the German Social-Democratic party), and (for simplicity), we'll assume two "instances" of "spd" that occurr *with* suffix, ie., "spdbt" and "spdde". (I was just working on a text mining on Tweets of German politiicians, hence the example).


```r
data <- c("spdde", "sdf", "sdf", "fdds", "spdde", "dsf", "spdbt", "df") %>% as_tibble
stem <- "spd"
```


# Task 01: Extract the "spd" stem out of the data

Non-programmatically, ie., interactively, this is quite straight-forward. Some knowledge of Regex is helpful to render the task a bit more general:


```r
data %>% 
  mutate(is_instance = str_detect(string = value, pattern = "spd\\w+"),
         instance = str_match(value, "spd\\w+"))
```

```
## # A tibble: 8 x 3
##   value is_instance instance
##   <chr>       <lgl>    <chr>
## 1 spdde        TRUE    spdde
## 2   sdf       FALSE     <NA>
## 3   sdf       FALSE     <NA>
## 4  fdds       FALSE     <NA>
## 5 spdde        TRUE    spdde
## 6   dsf       FALSE     <NA>
## 7 spdbt        TRUE    spdbt
## 8    df       FALSE     <NA>
```


`\\w` means "find a word-character" (ie., letter or digit), and `+` means that at least 1 hit is expected. `pattern` is the pattern to be looked for and `string` defines the string where to search for the pattern.


# Task 02: Make it a function


Obviously, a function is much more general. Say we have 10 parties we would like to warp through; it becomes tedious to repeat that code many times. We will want a function. How to do that with dplyr?

Let's define a function with input parameters `df` for the name of the dataframe, `col` for the name of the column where the stemming is performend, and `stem`, the term to be stemmed.



```r
stemm_col <- function(df, col, stem){
  
  col <- enquo(col)
  col_name <- quo_name(enquo(col))
  stem_name <- quo_name(enquo(stem))

  df %>% 
    mutate(stemmed = str_extract(string = !!col,
                                pattern = paste0(stem_name,"\\w+"))) -> output
  
  return(output)
}
```

See whether it runs:


```r
stemm_col(df = data, col = value, stem = "spd")
```

```
## # A tibble: 8 x 2
##   value stemmed
##   <chr>   <chr>
## 1 spdde   spdde
## 2   sdf    <NA>
## 3   sdf    <NA>
## 4  fdds    <NA>
## 5 spdde   spdde
## 6   dsf    <NA>
## 7 spdbt   spdbt
## 8    df    <NA>
```


# Bit by bit explanation


- `col <- enquo(col)` -- Take the parameter `col`, and just remember, R, that it is an expression, in this case, the parameter of a function, denoting a column.

- `col_name <- quo_name(enquo(col))`  -- Now turn `col` (an expression) to a string, because the function further down (`str_extract`) expects a string.

- `str_extract(string = !!col,...` -- Hey R, when you extract the strings, you need to know which string to search. OK, take `col` which is an expression, and now evaluate it (indicated by `!!`), in this case, understand that it's a column. Now go get the values.


# Main idea

When working with [NSE](http://adv-r.had.co.nz/Computing-on-the-language.html), it is important to distinguish between expression, strings and evaluation. Using NSE, we can look at the parameters of a function, and grap the parameters before they are evaluated. That's why the parameters need not be well-behaved, importantly, they do not need to have quotation marks, which saves typing for the user. 

From the perspective of the R-interpreter (the machine), the steps of action looks more or less like this:

1. Look at the parameters of the function

2. Save the parameters not as strings, not as variables, but as expressions (via `enquo`)

3. Convert the expression to a string (via `quo_name`) or, eventually,

4. Evaluate it, ie., unquote (let the function to its job) via `!!` (called bang-bang) or via `UQ`.


