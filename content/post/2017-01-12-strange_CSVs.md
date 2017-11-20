---
author: Sebastian Sauer
date: '2017-01-12'
title: How to import a strange CSV
tags:
  - rstats
  - tutorial
slug: strange_CSVs
---




A typical task in data analysis is to import CSV-formatted data. CSV is nothing more than a text file with data in rectangular form; rows stand for observations (eg., persons), and columns represent variables (such as `age`). Columns are separed by a "separator", often a comma. Hence the name "CSV" - "comma separeted values". Note however that the separator can in principle anything you like (eg., ";" or tabulator or " ").

An easy example for importing a CSV is this


```r
d <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/MASS/birthwt.csv")
head(d)
```

```
##    X low age lwt race smoke ptl ht ui ftv  bwt
## 1 85   0  19 182    2     0   0  0  1   0 2523
## 2 86   0  33 155    3     0   0  0  0   3 2551
## 3 87   0  20 105    1     1   0  0  0   1 2557
## 4 88   0  21 108    1     1   0  0  1   2 2594
## 5 89   0  18 107    1     1   0  0  1   0 2600
## 6 91   0  21 124    3     0   0  0  0   0 2622
```

It comes in handy that `read.csv` is able to address websites out of the box!


Now at times it happens that the CSV is somehow strange. Consider this example:


```r
dd <- read.csv("http://www.stat.ufl.edu/~winner/data/slash_survsex.dat")
head(dd)
```

```
##         X1.......1.......1
## 1        1       1       1
## 2        1       1       1
## 3        1       1       1
## 4        1       1       1
## 5        1       1       1
## 6        1       1       1
```

Hm, how many columns do we have?


```r
ncol(dd)
```

```
## [1] 1
```

One only. Something got lost in translation. We would expect three columns. Now what?

To be honest, I am not really sure what the problem exactly consists of. But that does not stop from finding a solution.

The little at `X1......1...` appear to indicate blanks (spaces). So let's try to use a blank as the column separator.


```r
dd <- read.csv("http://www.stat.ufl.edu/~winner/data/slash_survsex.dat", 
              sep = " ")
ncol(dd)
```

```
## [1] 22
```


Yosh! 22 columns, that's too much of something good... Hm, let's look at the dataframe.


```r
head(dd)
```

```
##    X X.1 X.2 X.3 X.4 X.5 X.6 X1 X.7 X.8 X.9 X.10 X.11 X.12 X1.1 X.13 X.14
## 1 NA  NA  NA  NA  NA  NA  NA  1  NA  NA  NA   NA   NA   NA    1   NA   NA
## 2 NA  NA  NA  NA  NA  NA  NA  1  NA  NA  NA   NA   NA   NA    1   NA   NA
## 3 NA  NA  NA  NA  NA  NA  NA  1  NA  NA  NA   NA   NA   NA    1   NA   NA
## 4 NA  NA  NA  NA  NA  NA  NA  1  NA  NA  NA   NA   NA   NA    1   NA   NA
## 5 NA  NA  NA  NA  NA  NA  NA  1  NA  NA  NA   NA   NA   NA    1   NA   NA
## 6 NA  NA  NA  NA  NA  NA  NA  1  NA  NA  NA   NA   NA   NA    1   NA   NA
##   X.15 X.16 X.17 X.18 X1.2
## 1   NA   NA   NA   NA    1
## 2   NA   NA   NA   NA    1
## 3   NA   NA   NA   NA    1
## 4   NA   NA   NA   NA    1
## 5   NA   NA   NA   NA    1
## 6   NA   NA   NA   NA    1
```

It appears that `X1`,  `X1.1`, and `X1.2` are the only columns which are of interest (all others only consist of `NA`s). So let's select those columns and discard the rest.


```r
library(dplyr)
dd <- select(dd, X1, X1.1, X1.2)
```

Worked!

Finally, let's change the column names to our desire.


```r
dd <- rename(dd, V1 = X1,V2 = X1.1, V3 = X1.2)
```



