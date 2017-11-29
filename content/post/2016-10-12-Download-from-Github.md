---
author: Sebastian Sauer
date: '2016-10-12'
title: How to read Github files into R easily
tags:
  - rstats
slug: Download-from-Github
---

## Downloading a folder (repository) from Github as a whole
The most direct way to get data from Github to your computer/ into R, is to download the repository. That is, click the big green button:


<img src="https://sebastiansauer.github.io/images/2016-10-12/repo_example.png" width="700">


___


The big, green button saying "Clone or download", click it and choose "download zip".

![](/images/2016-10-12/download_repo.png)

Of course, for those using [Git](https://www.google.de/webhp?sourceid=chrome-instant&rlz=1C5CHFA_enDE701DE701&ion=1&espv=2&ie=UTF-8#q=git) and [Github](https://github.com/), it would be appropriate to clone the repository. And, although appearing more advanced, cloning has the definitive advantage that you'll enjoy the whole of the Github features. In fact, the whole purpose of Github is to provide a history of the file(s), so the purpose is not really served if one just downloads the most recent snapshot. But anyhow, that depends on you own will.

Note that "repository" can be thought of as "folder" or "project".

Once downloaded, you **need** to [unzip](https://en.wikipedia.org/wiki/Zip_(file_format)) the folder. Unzipping means to "extract" or "unpack" the file/folder. On many machines, this can be accomplished by right clicking the icon and choosing something like "extract here".

Once extracted, just navigate to the folder and open whatever file you are inclined to.

## Downloading individual files from Github

In case you do not want to download the whole repository, individual files can be downloaded and parsed to R quite easily:


```r
library(readr)  # for read_csv
library(knitr)  # for kable
myfile <- "https://raw.github.com/sebastiansauer/Daten_Unterricht/master/Affairs.csv"

Affairs <- read_csv(myfile)
```

```
## Warning: Missing column names filled in: 'X1' [1]
```

```
## Parsed with column specification:
## cols(
##   X1 = col_integer(),
##   affairs = col_integer(),
##   gender = col_character(),
##   age = col_double(),
##   yearsmarried = col_double(),
##   children = col_character(),
##   religiousness = col_integer(),
##   education = col_integer(),
##   occupation = col_integer(),
##   rating = col_integer()
## )
```

```r
kable(head(Affairs))
```



| X1| affairs|gender | age| yearsmarried|children | religiousness| education| occupation| rating|
|--:|-------:|:------|---:|------------:|:--------|-------------:|---------:|----------:|------:|
|  1|       0|male   |  37|        10.00|no       |             3|        18|          7|      4|
|  2|       0|female |  27|         4.00|no       |             4|        14|          6|      4|
|  3|       0|female |  32|        15.00|yes      |             1|        12|          1|      4|
|  4|       0|male   |  57|        15.00|yes      |             5|        18|          6|      5|
|  5|       0|male   |  22|         0.75|no       |             2|        17|          6|      3|
|  6|       0|female |  32|         1.50|no       |             2|        17|          5|      5|


Let's quickly deconstruct the url above from Github. In general, we need to write:


`https://raw.github.com/user/repository/branch/file.name`.

In many cases, the branch will be "master". You can easily find out about that one the page of the repo you wanna download:

![](/images/2016-10-12/branch.png)



I've noticed that unzipping a repository from Github (and downloading a zip file) can cause confusion, so it might be easier to provide a code bit as shown above.

BTW: `read.csv` should work equally.
