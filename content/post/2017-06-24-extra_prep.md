---
author: Sebastian Sauer
date: '2017-06-24'
title: Preparation of extraversion survey data
tags:
  - rstats
  - psychometrics
  - survey
slug: extra_prep
---




For teaching purposes and out of curiosity towards some psychometric questions, I have run a survey on extraversion [here](https://docs.google.com/forms/d/e/1FAIpQLSfD4wQuhDV_edx1WBfN3Qos7XqoVbe41VpiKLRKtGLeuUD09Q/viewform?usp=sf_link). The dataset has been published at [OSF](https://osf.io/4kgzh/) (DOI 10.17605/OSF.IO/4KGZH). The survey is base on a google form, which in turn saves the data in Google spreadsheet. Before the data can be analyzed, some preparation and makeup is in place. This posts shows some general makeup, typical for survey data.



# Download the data and load packages

Download the data from source (Google spreadsheets); the package `gsheet` provides an easy interface for that purpose.


```r
library(gsheet)
extra_raw <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1Ln8_0xSJ5teHY2QkwGaYxDLxpcdjOsQ0gIAEZ5az5BY/edit#gid=305064170")
```

```
## Warning: Missing column names filled in: 'X23' [23]
```


```r
library(tidyverse)  # data judo
library(purrr)  # map
library(lsr)  # aad
library(modeest)  # mlv
#devtools::install_github("sebastiansauer/prada")
library(prada)
```



# Prepare variable names

First, save item names in a separate object for later retrieval and for documentation.


```r
extra_names <- names(extra_raw) 
head(extra_names)
```

```
## [1] "Zeitstempel"                                                                                                                                                                                       
## [2] "Bitte geben Sie Ihren dreistellen anonymen Code ein (1.: Anfangsbuchstabe des Vornamens Ihres Vaters; 2.: Anfangsbuchstabe des Mädchennamens Ihrer Mutter; 3: Anfangsbuchstabe Ihres Geburstsorts)"
## [3] "Ich bin gerne mit anderen Menschen zusammen."                                                                                                                                                      
## [4] "Ich bin ein Einzelgänger. (-)"                                                                                                                                                                     
## [5] "Ich bin in vielen Vereinen aktiv."                                                                                                                                                                 
## [6] "Ich bin ein gesprächiger und kommunikativer Mensch."
```


Next, replace the lengthy col names by 'i' followed by a number:


```r
extra <- extra_raw
names(extra) <- c("timestamp", "code", paste0("i",1:26))
```



Then we rename some of the variables with new names.



```r
extra <-
  extra %>%
  rename(n_facebook_friends = i11,
         n_hangover = i12,
         age = i13,
         sex = i14,
         extra_single_item = i15,
         time_conversation = i16,
         presentation = i17,
         n_party = i18,
         clients = i19,
         extra_vignette = i20,
         extra_vignette2 = i22,
         major = i23,
         smoker = i24,
         sleep_week = i25,
         sleep_wend = i26)
```


# Add leading zero to items

It is more helpful for sorting purposes for variable names with numbers to have the same format, ie., the same number of leadings zero. So not this "i1, i2", but this "i01, i02" (if the number of items is not greater than 99).

To get the same amount of leading zeros we can use:


```r
i <- 1:10
item_names <- paste0("i", formatC(i, width = 2, flag = "0"))

colnames(extra)[3:12] <- item_names
```



# Parse numbers from chr columns 

Some columns actually assess a number but the field in the survey form was liberally open to characters. So we have to convert the character to numbers, or, more precisely, suck out the numbers from the character variables.


```r
extra$n_hangover <- parse_number(extra$n_hangover)
```

```
## Warning in rbind(names(probs), probs_f): number of columns of result is not
## a multiple of vector length (arg 1)
```

```
## Warning: 2 parsing failures.
## row # A tibble: 2 x 4 col     row   col expected actual expected   <int> <int>    <chr>  <chr> actual 1   132    NA a number Keinen row 2   425    NA a number      .
```

```r
extra$n_facebook_friends <- parse_number(extra$n_facebook_friends)
extra$time_conversation <- parse_number(extra$time_conversation)
```

```
## Warning in rbind(names(probs), probs_f): number of columns of result is not
## a multiple of vector length (arg 1)
```

```
## Warning: 2 parsing failures.
## row # A tibble: 2 x 4 col     row   col expected      actual expected   <int> <int>    <chr>       <chr> actual 1   153    NA a number       Opfer row 2   633    NA a number Eine Minute
```

```r
extra$n_party <- parse_number(extra$n_party)
```

```
## Warning: 1 parsing failure.
## row # A tibble: 1 x 4 col     row   col expected actual expected   <int> <int>    <chr>  <chr> actual 1   270    NA a number      u
```

The parsing left the dataframe with some rather ugly attributes, albeit with interesting informations. After checking them, however, I feel inclined to delete them.


```r
attributes(extra$n_hangover) <- NULL
attributes(extra$time_conversation) <- NULL
attributes(extra$n_party) <- NULL
attributes(extra$sleep_wend) <- NULL
attr(extra, "spec") <- NULL
```



# Recode items 1: Reverse order

Some extraversion items (variables i2, i6) need to be recoded, ie., reversed. 



```r
extra %>% 
  mutate(i02 = 5-i02,
            i06 = 5-i06) %>% 
  rename(i02r = i02,
         i06r = i06) -> extra
```


# Recode items 2: Convert labels to numbers

Typically, items answers are anchored with labels such as "do not agree" till "fully agree" or similar. However, sometimes it is convenient to have such labels in a number format. Let's convert such items labels to numbers.


```r
extra %>% 
  mutate(clients_freq = case_when(
    clients ==  "im Schnitt 1 Mal pro Quartal (oder weniger)" ~ "1",
    clients == "im Schnitt 1 Mal pro Monat" ~ "2",
    clients == "im Schnitt 1 Mal pro Woche" ~ "3",
    clients == "im Schnitt 1 Mal pro Tag" ~ "4",
    clients == "im Schnitt mehrfach pro Tag" ~"5",
    TRUE ~ "NA")) %>% 
  mutate(clients_freq = parse_number(clients_freq)) -> extra
```



# Compute summaries (extraversion score)

Let's compute the mean but also the median and mode for each *person* (ie., row) with regard to the 10 extraversion items.

For that, we'll use a helper function to compute the mode (most frequent value).


```r
most <- function(x){
  if (!(is.numeric(x))) {
    out <- NA
    return(out)
  }
  x <- stats::na.omit(x)
  t <- base::table(x)
  m <- base::max(t)
  out <- base::as.numeric(base::names(t)[t==m])
  if (base::length(out) > 1) out <- out[1]
  if (base::length(out) == 0) out <- NA
  base::return(out)
}
```




```r
extra %>% 
  rowwise %>% 
  summarise(extra_mean = mean(c(i01, i02r, i03, i04, i05, i06r, i07, i08, i09, i10), na.rm = TRUE),
            extra_md = median(c(i01, i02r, i03, i04, i05, i06r, i07, i08, i09, i10), na.rm = TRUE),
            extra_aad = aad(c(i01, i02r, i03, i04, i05, i06r, i07, i08, i09, i10), na.rm = TRUE),
            extra_mode = most(c(i01, i02r, i03, i04, i05, i06r, i07, i08, i09, i10)),
            extra_iqr = IQR(c(i01, i02r, i03, i04, i05, i06r, i07, i08, i09, i10))) -> extra_scores
```

```
## Warning in base::max(t): no non-missing arguments to max; returning -Inf

## Warning in base::max(t): no non-missing arguments to max; returning -Inf

## Warning in base::max(t): no non-missing arguments to max; returning -Inf

## Warning in base::max(t): no non-missing arguments to max; returning -Inf
```

This approach works but it's a lot of duplicated typing. Rather give `summarise` an unquoted expression:

First, we define an expression; that's to say we want R to *quote*, rather than to evaluation the expression. This can be achieved using `quo`:


```r
extra_items <- quo(c(i01, i02r, i03, i04, i05, i06r, i07, i08, i09, i10))
```

Then we hand over the *un*quoted expression (defined by `quote`) to mean Unquoting now (dplyr >= .7) works by usig the `!!` operator.


```r
extra %>% 
  rowwise %>% 
  summarise(extra_mean = mean(!!extra_items),
            extra_md = median(!!extra_items),
            extra_aad = lsr::aad(!!extra_items),
            extra_mode = most(!!extra_items),
            extra_iqr = IQR(!!extra_items)) -> extra_scores
```

```
## Warning in base::max(t): no non-missing arguments to max; returning -Inf

## Warning in base::max(t): no non-missing arguments to max; returning -Inf

## Warning in base::max(t): no non-missing arguments to max; returning -Inf

## Warning in base::max(t): no non-missing arguments to max; returning -Inf
```

```r
extra_scores %>% head
```

```
## # A tibble: 6 x 5
##   extra_mean extra_md extra_aad extra_mode extra_iqr
##        <dbl>    <dbl>     <dbl>      <dbl>     <dbl>
## 1        2.9      3.0      0.56          3      0.00
## 2        2.1      2.0      0.54          2      0.75
## 3        2.6      3.0      1.08          1      2.50
## 4        2.9      3.0      0.36          3      0.00
## 5        3.2      3.5      0.80          4      1.00
## 6        2.8      3.0      0.68          3      0.75
```

Neat! Now let's bind that to the main df.



```r
extra %>% 
  bind_cols(extra_scores) -> extra
```

Done! Enyoj the freshly juiced data frame :sunglasses:


