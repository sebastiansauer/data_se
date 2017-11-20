---
author: Sebastian Sauer
date: '2016-12-21'
title: Some tricks on dplyr::filter
tags:
  - rstats
  - dplyr
slug: dplyr_filter
---


The R package `dplyr` has some attractive features; some say, this packkage revolutionized their workflow. At any rate, I like it a lot, and I think it is very helpful.

In this post, I would like to share some useful (I hope) ideas ("tricks") on `filter`, one function of `dplyr`. This function does what the name suggests: it filters *rows* (ie., observations such as persons). The addressed rows will be kept; the rest of the rows will be dropped. Note that always a ~~data frame~~ tibble is returned.

# Starters example

Load packages:

```r
library(tidyverse)  # get da whole shabeng!
```

```
## Loading tidyverse: ggplot2
## Loading tidyverse: tibble
## Loading tidyverse: tidyr
## Loading tidyverse: readr
## Loading tidyverse: purrr
```

```
## Conflicts with tidy packages ----------------------------------------------
```

```
## filter(): dplyr, stats
## lag():    dplyr, stats
```

```r
# don't forget to have the package(s) installed upfront.
```


An easy usecase would be:


```r
mtcars %>% 
  filter(cyl >= 8)
```

```
##     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## 2  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## 3  16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## 4  17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## 5  15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## 6  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## 7  10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## 8  14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## 9  15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## 10 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## 11 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## 12 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## 13 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## 14 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
```

We see there are 15 cars with 8 cylinders.

Typical comparison operators to filter rows include:

- `==` equality
- `!=` inequality
- `<` or `>` greater than/ smaller than
- `<=` less or equal

Multiple logical comparisons can be combined. Just add 'em up using commas; that amounts to logical `OR` "addition":


```r
mtcars %>% 
  filter(cyl == 8, hp > 250)
```

```
##    mpg cyl disp  hp drat   wt qsec vs am gear carb
## 1 15.8   8  351 264 4.22 3.17 14.5  0  1    5    4
## 2 15.0   8  301 335 3.54 3.57 14.6  0  1    5    8
```

`AND` addition can be achived the standard way


```r
mtcars %>% 
  filter(cyl == 6 & hp < 260)
```

```
##    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 4 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 5 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 6 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 7 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
```



Before we continue, let's transform the rowname (where the cars' names are stored) into a proper column, so that we can address the cars names the usual way:


```r
mtcars <- mtcars %>% 
    rownames_to_column
```



# Pick value from list
One particular helpful way is to say "I want to keep any of the following items". In R, the `%in%` operator comes for help. See:


```r
mtcars %>% 
  filter(cyl %in% c(4, 6))
```

```
##           rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1       Mazda RX4 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2   Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3      Datsun 710 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## 4  Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 5         Valiant 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 6       Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## 7        Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## 8        Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 9       Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 10       Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## 11    Honda Civic 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## 12 Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## 13  Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## 14      Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## 15  Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## 16   Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## 17   Ferrari Dino 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## 18     Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```


# Partial matching
Suppose you would like to filter all Mercs; the Mercs include "Merc 240D", "Merc 280C" and other. So we cannot filter for "Merc" as an exact search string. We need to tell R, "hey if 'Merc' is a part of this string, then filter it, otherwise leave it".

For more flexible string-operations, we can make use of the package `stringr` (again, by Hadley Wickham).


```r
library(stringr)
```



```r
mtcars %>% 
  filter(str_detect(rowname, "Merc"))
```

```
##       rowname  mpg cyl  disp  hp drat   wt qsec vs am gear carb
## 1   Merc 240D 24.4   4 146.7  62 3.69 3.19 20.0  1  0    4    2
## 2    Merc 230 22.8   4 140.8  95 3.92 3.15 22.9  1  0    4    2
## 3    Merc 280 19.2   6 167.6 123 3.92 3.44 18.3  1  0    4    4
## 4   Merc 280C 17.8   6 167.6 123 3.92 3.44 18.9  1  0    4    4
## 5  Merc 450SE 16.4   8 275.8 180 3.07 4.07 17.4  0  0    3    3
## 6  Merc 450SL 17.3   8 275.8 180 3.07 3.73 17.6  0  0    3    3
## 7 Merc 450SLC 15.2   8 275.8 180 3.07 3.78 18.0  0  0    3    3
```


Of course, we now can go wild, making use of the whole string manipulation magic, called `Regex`. This tool is powerful indeed, but it needs some time to get used to it. For example, let's filter all cars where the cars names begins with "L":


```r
mtcars %>% 
  filter(str_detect(rowname, "^L"))
```

```
##               rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1 Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## 2        Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
```

The circonflex means "the string starts with"; in this example "the string starts with 'L'". To get values *ending* with, say, "L", we use `$` in Regex:


```r
mtcars %>% 
  filter(str_detect(rowname, "L$"))
```

```
##          rowname  mpg cyl  disp  hp drat   wt qsec vs am gear carb
## 1     Merc 450SL 17.3   8 275.8 180 3.07 3.73 17.6  0  0    3    3
## 2 Ford Pantera L 15.8   8 351.0 264 4.22 3.17 14.5  0  1    5    4
```


Another usecase could be that we want to pick rows where the names contain digits.



```r
mtcars %>% 
  filter(str_detect(rowname, "\\d"))
```

```
##           rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1       Mazda RX4 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2   Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3      Datsun 710 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## 4  Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 5      Duster 360 14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## 6       Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## 7        Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## 8        Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 9       Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 10     Merc 450SE 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## 11     Merc 450SL 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## 12    Merc 450SLC 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## 13       Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## 14     Camaro Z28 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## 15      Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## 16  Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## 17     Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

In Regex, `\d` means "digit". As the backslash needs to be escaped (by typing an extra backslash), we type two backslashes, and get what we want.

Similarly, if we want all values *except* those with digits, we could say:


```r
mtcars %>% 
  filter(!str_detect(rowname, "\\d"))
```

```
##                rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1    Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## 2              Valiant 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 3   Cadillac Fleetwood 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## 4  Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## 5    Chrysler Imperial 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## 6          Honda Civic 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## 7       Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## 8        Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## 9     Dodge Challenger 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## 10         AMC Javelin 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## 11    Pontiac Firebird 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## 12        Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## 13      Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## 14        Ferrari Dino 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## 15       Maserati Bora 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
```


As `!` is used for a logical `not`, we can invert our expression above (`str_detect) this way. 


Finally, say we want to filter all "Mercs" and all "Toyotas". As there are different Mercs and different Toyotas in the data set, we need to tell R something like "take all Mercs you can find all Toyotas, and leave the rest".

What does *not* work is this:

```r
mtcars %>% 
  filter(rowname %in% c("Merc", "Toyota"))
```

```
##  [1] rowname mpg     cyl     disp    hp      drat    wt      qsec   
##  [9] vs      am      gear    carb   
## <0 rows> (or 0-length row.names)
```

The code above does not work, as the `%in%` operators does not partial matching but expects complete matching.

Again, Regex can help:


```r
mtcars %>% 
  filter(str_detect(rowname, "Merc|Toy"))
```

```
##          rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1      Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## 2       Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## 3       Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 4      Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 5     Merc 450SE 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## 6     Merc 450SL 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## 7    Merc 450SLC 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## 8 Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## 9  Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
```


Note that the `|` (vertical dash) means "or" (in R and in Regex).

The same result could be achived in a more usual R way:


```r
mtcars %>% 
  filter(str_detect(rowname, "Merc") | str_detect(rowname, "Toy"))
```

```
##          rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1      Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## 2       Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## 3       Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 4      Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 5     Merc 450SE 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## 6     Merc 450SL 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## 7    Merc 450SLC 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## 8 Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## 9  Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
```


# Filtering `NA`s

For the sake of illustration, let's introduce some `NA`s to `mtcars`.


```r
mtcars$mpg[sample(32, 3)] <- NA
mtcars$cyl[sample(32, 3)] <- NA
mtcars$hp[sample(32, 3)] <- NA
mtcars$wt[sample(32, 3)] <- NA
```

First, we filter all lines where there are no `NA`s in `mpg`:


```r
mtcars %>% 
  filter(!is.na(mpg))
```

```
##                rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1            Mazda RX4 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2        Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3           Datsun 710 22.8  NA 108.0  93 3.85 2.320 18.61  1  1    4    1
## 4       Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 5    Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## 6              Valiant 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 7           Duster 360 14.3   8 360.0 245 3.21    NA 15.84  0  0    3    4
## 8            Merc 240D 24.4  NA 146.7  62 3.69 3.190 20.00  1  0    4    2
## 9             Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 10           Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 11          Merc 450SE 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## 12          Merc 450SL 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## 13  Cadillac Fleetwood 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## 14 Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## 15   Chrysler Imperial 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## 16            Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## 17      Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## 18       Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## 19    Dodge Challenger 15.5   8 318.0 150 2.76    NA 16.87  0  0    3    2
## 20         AMC Javelin 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## 21          Camaro Z28 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## 22    Pontiac Firebird 19.2  NA 400.0 175 3.08 3.845 17.05  0  0    3    2
## 23           Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## 24       Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## 25        Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## 26      Ford Pantera L 15.8   8 351.0  NA 4.22 3.170 14.50  0  1    5    4
## 27        Ferrari Dino 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## 28       Maserati Bora 15.0   8 301.0  NA 3.54 3.570 14.60  0  1    5    8
## 29          Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

Easy. Next, we filter complete rows. Wait, there's a shortcut for that:

```r
mtcars %>% 
  na.omit %>% 
  nrow
```

```
## [1] 22
```

But, what if we only care about `NA`s at `mpg` and `hp`? Say, we want any row with `NA` in these two columns. Here's a way:





```r
mtcars %>% 
  filter(!is.na(mpg) & !is.na(hp)) 
```

```
##                rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1            Mazda RX4 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2        Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3           Datsun 710 22.8  NA 108.0  93 3.85 2.320 18.61  1  1    4    1
## 4       Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 5    Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## 6              Valiant 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 7           Duster 360 14.3   8 360.0 245 3.21    NA 15.84  0  0    3    4
## 8            Merc 240D 24.4  NA 146.7  62 3.69 3.190 20.00  1  0    4    2
## 9             Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 10           Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 11          Merc 450SE 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## 12          Merc 450SL 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## 13  Cadillac Fleetwood 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## 14 Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## 15   Chrysler Imperial 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## 16            Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## 17      Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## 18       Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## 19    Dodge Challenger 15.5   8 318.0 150 2.76    NA 16.87  0  0    3    2
## 20         AMC Javelin 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## 21          Camaro Z28 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## 22    Pontiac Firebird 19.2  NA 400.0 175 3.08 3.845 17.05  0  0    3    2
## 23           Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## 24       Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## 25        Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## 26        Ferrari Dino 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## 27          Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```


Finally, assume we want to inspect each row where there is at least one `NA` at `mpg` or at `hp`.




```r
mtcars %>% 
  filter((is.na(mpg) | is.na(hp))) 
```

```
##          rowname  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1       Merc 230   NA   4 140.8  NA 3.92 3.150 22.90  1  0    4    2
## 2    Merc 450SLC   NA   8 275.8 180 3.07    NA 18.00  0  0    3    3
## 3    Honda Civic   NA   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## 4 Ford Pantera L 15.8   8 351.0  NA 4.22 3.170 14.50  0  1    5    4
## 5  Maserati Bora 15.0   8 301.0  NA 3.54 3.570 14.60  0  1    5    8
```



Happy filtering!
