---
author: Sebastian Sauer
date: '2016-10-15'
title: Multiple ways to subsetting data frames in R
tags:
  - rstats
slug: indexing-in-R
---

Subsetting a data frame is an essential and frequently performed task. Here, some basic ideas are presented.

Get some data first.

```r
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

```r
mtcars <- head(mtcars)  # for shorter output
mtcars
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```


## One: Addressing dataframe as list (vector, 1-dim structure)
Data frames can be understood/addressed as lists, ie., as some type of vectors. Vectors have one dimension. Thus, we can access/subset with one index only (one dimension). For example `mtcars[1]` selects the first element (ie., column) of `mtcars`.


```r
mtcars[1]
```

```
##                    mpg
## Mazda RX4         21.0
## Mazda RX4 Wag     21.0
## Datsun 710        22.8
## Hornet 4 Drive    21.4
## Hornet Sportabout 18.7
## Valiant           18.1
```

```r
mtcars["mpg"]
```

```
##                    mpg
## Mazda RX4         21.0
## Mazda RX4 Wag     21.0
## Datsun 710        22.8
## Hornet 4 Drive    21.4
## Hornet Sportabout 18.7
## Valiant           18.1
```

```r
mtcars[c("mpg", "cyl")]  
```

```
##                    mpg cyl
## Mazda RX4         21.0   6
## Mazda RX4 Wag     21.0   6
## Datsun 710        22.8   4
## Hornet 4 Drive    21.4   6
## Hornet Sportabout 18.7   8
## Valiant           18.1   6
```

```r
mtcars[1:3]
```

```
##                    mpg cyl disp
## Mazda RX4         21.0   6  160
## Mazda RX4 Wag     21.0   6  160
## Datsun 710        22.8   4  108
## Hornet 4 Drive    21.4   6  258
## Hornet Sportabout 18.7   8  360
## Valiant           18.1   6  225
```

Note that data frames are vectors (lists) technically, where the vectors are the columns and the columns possess names. Thus we can address the columns by their names. Of course, we can select (address/index/subset) more than one element (column) using the `c()` function.

Besides names, we can address the elements by their number: type a positive integer to subset the respective element. `c` can be used here too.

Note that the `:` (colon) operator is a short hand for `c(from_this_column_to_that column)`.


Similarly to addressing the names of the data frames using brackets `[]`, we can use the Dollar `$` operator:


```r
mtcars$mpg
```

```
## [1] 21.0 21.0 22.8 21.4 18.7 18.1
```

Whatever comes after the `$` is understood by R as the name (without quotation marks) of the column within that data frame. `$` is a shorthand for `[[]]` (but not exactly the same; see [here](http://adv-r.had.co.nz/Subsetting.html) for an excellent overview).


## Two: Addressing dataframe as a matrix (2-dim-structure, 2-dim-matrix)

As data frames can also be addressed as rectangular, two-dimensional matrices, we may subset specific elements using a x-y-coordinate scheme where in R matrices the row is addressed first, and the column second, eg., `mtcars(1,2)` would be *first* line of *second* column.


```r
mtcars[1,1]
```

```
## [1] 21
```

```r
mtcars[1, c(1,2)]
```

```
##           mpg cyl
## Mazda RX4  21   6
```

```r
mtcars[1, 1:3]
```

```
##           mpg cyl disp
## Mazda RX4  21   6  160
```

```r
mtcars[1, c(1:3)]
```

```
##           mpg cyl disp
## Mazda RX4  21   6  160
```

```r
mtcars[, c(1:3)]
```

```
##                    mpg cyl disp
## Mazda RX4         21.0   6  160
## Mazda RX4 Wag     21.0   6  160
## Datsun 710        22.8   4  108
## Hornet 4 Drive    21.4   6  258
## Hornet Sportabout 18.7   8  360
## Valiant           18.1   6  225
```

```r
mtcars[1, "mpg"]
```

```
## [1] 21
```

```r
mtcars[1, c("mpg", "cyl")]  
```

```
##           mpg cyl
## Mazda RX4  21   6
```


Again, the `c()` operator may be used to group several rows or columns. Columns may again addressed by their names (row names are  unusual). The `:` colon operator is allowed, too.

## Three: Logical subsetting in dataframes

```r
mtcars[c(T, T, F, F, F, F, F, F, F, F, T)]
```

```
##                    mpg cyl carb
## Mazda RX4         21.0   6    4
## Mazda RX4 Wag     21.0   6    4
## Datsun 710        22.8   4    1
## Hornet 4 Drive    21.4   6    1
## Hornet Sportabout 18.7   8    2
## Valiant           18.1   6    1
```

```r
mtcars[c(T, T, F)]
```

```
##                    mpg cyl  hp drat  qsec vs gear carb
## Mazda RX4         21.0   6 110 3.90 16.46  0    4    4
## Mazda RX4 Wag     21.0   6 110 3.90 17.02  0    4    4
## Datsun 710        22.8   4  93 3.85 18.61  1    4    1
## Hornet 4 Drive    21.4   6 110 3.08 19.44  1    3    1
## Hornet Sportabout 18.7   8 175 3.15 17.02  0    3    2
## Valiant           18.1   6 105 2.76 20.22  1    3    1
```

In the first example above, the columns #1, #2, #and #11 are selected, because their position is indexed as `TRUE` (or `T`).

Note that if you supply less elements than the length of the objects (eg., here 11 columns/elements), R will recycle your elements until the full length of the element is met (here: TTF-TTF-TTF-TT).

Again, the data frame can be addressed either as a list (1-dim), or as a 2-dim matrix. See here for an example using logical indexing and addressing the data frame as a 2-dim matrix:


```r
mtcars[c(T, T, F), c(T, T, F)]
```

```
##                    mpg cyl  hp drat  qsec vs gear carb
## Mazda RX4         21.0   6 110 3.90 16.46  0    4    4
## Mazda RX4 Wag     21.0   6 110 3.90 17.02  0    4    4
## Hornet 4 Drive    21.4   6 110 3.08 19.44  1    3    1
## Hornet Sportabout 18.7   8 175 3.15 17.02  0    3    2
```


Actually, the logical subsetting is quite powerful. We can use a predicate function, ie., a function delivering a logial state (`TRUE` or `FALSE`) within the subsetting:


```r
mtcars[mtcars$cyl == 6, c(1,2)]
```

```
##                 mpg cyl
## Mazda RX4      21.0   6
## Mazda RX4 Wag  21.0   6
## Hornet 4 Drive 21.4   6
## Valiant        18.1   6
```

Here, we declared that we only want *rows* for which the following condition is `TRUE`: `mtcars$cyl == 6`. (And only cols 1 and 2.)



## Final words

Subsetting in R is an essential task. It is also not so easy, as many slightly different variants exist. Here, only some ideas were presented. A much broader are excellently presented by Hadley Wickham [here](http://adv-r.had.co.nz/Subsetting.html).

Besides that subsettting using base R should be well understood, it may be more comfortable to use functions such as `select` from `dplyr`.





