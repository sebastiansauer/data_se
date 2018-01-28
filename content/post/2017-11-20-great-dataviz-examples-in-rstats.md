---
title: Great dataviz examples in rstats
author: Sebastian Sauer
date: '2017-11-20'
slug: great-dataviz-examples-in-rstats
categories:
  - rstats
  - dataviz
tags:
  - plot
  - dataviz
  - rstats
---


Here come some stunning examples of data visualizations, all built with R. R code of each diagram is available at the source. Enjoy! #beautiful.


---

UPDATE: I've included links to the R source!

___




# Plotting geo maps along with subplots in `ggplot2`

I like this one by Ilya Kashnitsky:


<img src="https://ikashnitsky.github.io/images/170522/s-fig-01.png" width = "800">



Similarly, by the same author:

<img src = "https://pbs.twimg.com/media/DDRrLeRWsAACFCh.jpg" width="800">


[Source](https://ikashnitsky.github.io/2017/align-six-maps/?utm_content=bufferc04f2&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer)

Great work, @ikashnitsky!



# Cirlize (Chord) diagrams

Plotting association in a circular form yields aesthetic examples of diagrams, see the following examples


![](http://zuguang.de/circlize/example/bi_directional.small.jpg?149284316731298) ![](http://zuguang.de/circlize/example/genomic_general.small.jpg?1492843167843324) ![](http://zuguang.de/circlize/example/pubmed_24194836.small.jpg?1492843173890760)


Source: This work is from Zuguang Gu; see his package [circlize](https://www.rdocumentation.org/packages/circlize/versions/0.4.1). He is also the author from the corresponding free online [book](http://zuguang.de/circlize_book/book/).


# Grey is your best friend


Providing contect to your data is an important principle in data viz. For example, show the overall data when you focus on a subgroup.

Simon Jackson (@drsimonj) gives a great example:

![](https://svbtleusercontent.com/ofzisqe5egsi2w_retina.png)


[Source](https://drsimonj.svbtle.com/plotting-background-data-for-groups-with-ggplot2?utm_content=buffer2b686&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer)

# Beautitful scatter plots

Again, Simon Jackson does it:

![](https://svbtleusercontent.com/nvvxuthhlzemg_small.png)

[Source](http://drsimonj.svbtle.com/pretty-scatter-plots-with-ggplot2)


# Maps with grid

![](https://www.r-graph-gallery.com/wp-content/uploads/2016/07/178_Map_with_grid_cartography_package.png)

Source: See many more examples of nice diagrams at [The R Graph Gallery](https://www.r-graph-gallery.com/)


# Clean chloropleth map

An example of a clean chloropleth map, again from [The R Graph Gallery](https://www.r-graph-gallery.com/)


![](https://www.r-graph-gallery.com/wp-content/uploads/2016/07/175_Choropleth_map_with_cartography_library_europe.png)

[Source](https://www.r-graph-gallery.com/175-choropleth-map-cartography-pkg/)


For a different choroplatht example using `ggplot` and `geom_sf`, check out [this post](https://data-se.netlify.com/2017/10/10/afd-map/).


# Pirate attack

Pirate plots, by [Nathaniel Philips](http://nathanieldphillips.com/), are available by the R package [yarrr](https://github.com/ndphillips/yarrr).

![](https://camo.githubusercontent.com/390950a591e5ef8bf22b455d587849aaa88cf68f/687474703a2f2f6e617468616e69656c647068696c6c6970732e636f6d2f77702d636f6e74656e742f75706c6f6164732f323031362f31302f7070656c656d656e74732e706e67)

[Source](https://cran.r-project.org/web/packages/yarrr/vignettes/pirateplot.html)

From the documentation on [this page](https://github.com/ndphillips/yarrr):

>   The pirateplot function creates a pirateplot, a transparent (both literally and figuratively) plot for displaying continuous data as a function of 1, 2, or 3 discrete variables. Unlike traditional plots, like barplots and boxplots, the pirateplot shows both raw data (jittered points), descriptive statistics (line and/or bar), and inferential statistics (95% Bayesian Highest Density Intervals or Confidence Intervals), in one plot. While the default plot shows all these elements, the user can easily customize the transparency of each element using additional arguments. See ?pirateplot or https://CRAN.R-project.org/package=yarrr for more details

# Clean R graphs comependium

The [Compendium of Clean Graphs in R](http://shinyapps.org/apps/RGraphCompendium/index.php) presents a gallery of, surprise, clean graphs. The graphs are often "simple" in the sense that they do not convey a hell of a lot information, and graph junk is seriously avoied. Many examples are suitable for academia settings.






# Survey results with Thomas Rahlf's book

This example from Thomas Rahlf's book [Data Design with R](http://www.springer.com/us/book/9783319497501) is nice:

<img src="http://www.datendesign-r.de/dateien/png/balkendiagramme_mehrfach_alle_2.png" width="600">


Again suitable for survey results, but somewhat more advanced:

<img src="http://www.datendesign-r.de/dateien/png/dotcharts_uebereinander.png" width="600">


Unfortunately, the R code from Thomas Rahlf's book is not freely available; however, it is presented in detail in the book.


# Heatmap

By Thomas Rahlf again; there are many examples of heat or tile maps, but this is one is particularly nice - although made with base R, no ggplot.

![](http://www.datendesign-r.de/dateien/png/grafiktabellen_heatmap.png)



# Time series

This one by Thomas Rahlf is nice:

![](http://www.datendesign-r.de/dateien/png/zeitreihen_flaechen_zwischen.png)

Similarly, and "cleaner":

![](http://www.datendesign-r.de/dateien/png/zeitreihen_kurz_tex_unterhalb.png))


# Cab drivers in NYC

Todd Schneider did a great job in [this post](http://toddwschneider.com/posts/analyzing-1-1-billion-nyc-taxi-and-uber-trips-with-a-vengeance/) where he anylzed 1.1 billion cab drives in NYC. Particularly, the visualization of the "cab density" is appealing:

![](http://toddwschneider.com/data/taxi/taxi_pickups_map_hires.png)



[Source](https://github.com/toddwschneider/nyc-taxi-data); in [this file](https://github.com/toddwschneider/nyc-taxi-data/blob/master/analysis/analysis.R) in his Github repo resides most of the R code.


# Enjoy & More

There a many more great data viz examples out there, including those build on R. I find [this curation](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html) quite nice.
