---
author: Sebastian Sauer
date: '2017-10-30'
title: Data, machine-friendly, of the 2017 German federal elections
tags:
  - data
  - rstats
  - politics
slug: de-elec-data
---



On September 2017, the 19. German Bundestag has been elected. As of this writing, the parties are still busy sorting out whether they want to part of the government, with whom, and maybe whether they even want to form a government at all. This post is about providing the data in machine friendly form, and in English language.

All data presented in this post regarding this (and previous) elections are published by the Bundeswahlleiter. The data may be used without restriction as long as it is credited duely.

Let me be clear that the all data presented here were drawn from this source. So, for each dataset the copyright notice is:


---

The raw data is published by the Bundeswahlleiter 2017
(c) Der Bundeswahlleiter, Wiesbaden 2017
https://www.bundeswahlleiter.de/info/impressum.html


---

The contribution by me is only to render the data more machine friendly, as the presented CSVs have multiple header lines, German Umlaute, non-UTF8 coding, and some other minor hickups.

Of course, data itself has not been touched by me; I hae only changed some wordings and the structure of the dataset in order to render analysis more comfortable. Analysts can easily access the raw data and check the correctness.



Setup:


```r
library(tidyverse)
```


# Package `prada` contains the data

Maybe the easiest way is to use my package `prada`, which can be downloaded/installed from Github:

Install the package once:


```r
devtools::install_github("sebastiansauer/prada")
```


```r
library(prada)
```


There you will find the relevant data.


## Parties running the election

- `parties_de` - a dataframe of the 43 parties than ran for the election



```r
data(parties_de)
glimpse(parties_de)
#> Observations: 43
#> Variables: 2
#> $ party_short <chr> "CDU", "SPD", "Linke", "Gruene", "CSU", "FDP", "Af...
#> $ party_long  <chr> "Christlich Demokratische Union Deutschlands", "So...
```


- `elec_results` - a dataframe of the results (first/second) votes of the parties plus some more data


```r
data(elec_results)
head(elec_results)
#> # A tibble: 6 x 191
#>   district_nr                     district_name parent_district_nr
#>         <int>                             <chr>              <int>
#> 1           1             Flensburg – Schleswig                  1
#> 2           2 Nordfriesland – Dithmarschen Nord                  1
#> 3           3      Steinburg – Dithmarschen Süd                  1
#> 4           4             Rendsburg-Eckernförde                  1
#> 5           5                              Kiel                  1
#> 6           6                 Plön – Neumünster                  1
#> # ... with 188 more variables: registered_voters_1 <int>,
#> #   registered_voters_2 <int>, registered_voters_3 <int>,
#> #   registered_voters_4 <int>, votes_1 <dbl>, votes_2 <int>,
#> #   votes_3 <dbl>, votes_4 <int>, votes_unvalid_1 <int>,
#> #   votes_unvalid_2 <int>, votes_unvalid_3 <dbl>, votes_unvalid_4 <int>,
#> #   votes_valid_1 <int>, votes_valid_2 <int>, votes_valid_3 <int>,
#> #   votes_valid_4 <int>, CDU_1 <int>, CDU_2 <chr>, CDU_3 <int>,
#> #   CDU_4 <dbl>, SPD_1 <int>, SPD_2 <int>, SPD_3 <int>, SPD_4 <int>,
#> #   Linke_1 <int>, Linke_2 <int>, Linke_3 <int>, Linke_4 <int>,
#> #   Gruene_1 <int>, Gruene_2 <int>, Gruene_3 <dbl>, Gruene_4 <dbl>,
#> #   CSU_1 <int>, CSU_2 <int>, CSU_3 <int>, CSU_4 <int>, FDP_1 <int>,
#> #   FDP_2 <int>, FDP_3 <int>, FDP_4 <int>, AfD_1 <int>, AfD_2 <int>,
#> #   AfD_3 <dbl>, AfD_4 <dbl>, Piraten_1 <int>, Piraten_2 <int>,
#> #   Piraten_3 <int>, Piraten_4 <dbl>, NPD_1 <int>, NPD_2 <int>,
#> #   NPD_3 <int>, NPD_4 <int>, FW_1 <int>, FW_2 <int>, FW_3 <int>,
#> #   FW_4 <int>, Mensch_1 <int>, Mensch_2 <int>, Mensch_3 <int>,
#> #   Mensch_4 <dbl>, ÖDP_1 <dbl>, ÖDP_2 <int>, ÖDP_3 <int>, ÖDP_4 <int>,
#> #   Arbeit_1 <int>, Arbeit_2 <int>, Arbeit_3 <int>, Arbeit_4 <int>,
#> #   Bayern_1 <int>, Bayern_2 <int>, Bayern_3 <int>, Bayern_4 <int>,
#> #   Volk_1 <int>, Volk_2 <int>, Volk_3 <int>, Volk_4 <int>,
#> #   Vernunft_1 <int>, Vernunft_2 <int>, Vernunft_3 <int>,
#> #   Vernunft_4 <int>, MLPD_1 <int>, MLPD_2 <int>, MLPD_3 <int>,
#> #   MLPD_4 <int>, Soli_1 <int>, Soli_2 <int>, Soli_3 <int>, Soli_4 <int>,
#> #   Sozialist_1 <int>, Sozialist_2 <chr>, Sozialist_3 <int>,
#> #   Sozialist_4 <int>, Rechte_1 <int>, Rechte_2 <chr>, Rechte_3 <int>,
#> #   Rechte_4 <int>, ADD_1 <chr>, ADD_2 <chr>, ADD_3 <int>, ADD_4 <chr>,
#> #   ...
```

Note that this data set is structured as follows: For each column AFTER 'parent_district_nr', ie., from column 4 onward, 4 columns build one bundle. In each bundle, column 1 refers to the Erststimme in the present election; column 2 to the Erststimme in the previous election. Column 3 refers to the Zweitstimme of the present election, and column 4 to the Zweitstimme of the previous election. For example, 'CDU_3' refers to the number of Zweitstimmen in the present (2017) elections.

That is:

- "`_1`" - first vote in present election
- "`_2`" - first vote in previous election
- "`_3`" - second vote in present election
- "`_4`" - second vote in previous election


Please also check the package documentation for additional information.


## Geometric shapes of the electoroal districts (Wahlkreise)

- `wahlkreise_shp` - a dataframe with ID of the Wahlkreise (electoral districts) plus their geometric shape for plotting



```r
data(wahlkreise_shp)
glimpse(wahlkreise_shp)
#> Observations: 299
#> Variables: 5
#> $ WKR_NR    <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1...
#> $ LAND_NR   <fctr> 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 13, 13,...
#> $ LAND_NAME <fctr> Schleswig-Holstein, Schleswig-Holstein, Schleswig-H...
#> $ WKR_NAME  <fctr> Flensburg – Schleswig, Nordfriesland – Dithmarschen...
#> $ geometry  <S3: sfc_MULTIPOLYGON> [543474.9, 547528.6, 547598.2, 5479...
```

See [this post](https://sebastiansauer.github.io/afd-map/) for a usecase of the shapefile data.


## Socioeconomic data of Germany

- `socec` - a dataframe with socio economic information (eg., unemployment rate) for each wahlkreis.


```r
data(socec)
head(socec)
#> # A tibble: 6 x 51
#>                   V1    V2                                V3    V4     V5
#>                <chr> <int>                             <chr> <int>  <dbl>
#> 1 Schleswig-Holstein     1             Flensburg – Schleswig   130 2128.1
#> 2 Schleswig-Holstein     2 Nordfriesland – Dithmarschen Nord   197 2777.0
#> 3 Schleswig-Holstein     3      Steinburg – Dithmarschen Süd   178 2000.5
#> 4 Schleswig-Holstein     4             Rendsburg-Eckernförde   163 2164.8
#> 5 Schleswig-Holstein     5                              Kiel     3  143.0
#> 6 Schleswig-Holstein     6                 Plön – Neumünster    92 1302.0
#> # ... with 46 more variables: V6 <dbl>, V7 <dbl>, V8 <dbl>, V9 <dbl>,
#> #   V10 <dbl>, V11 <dbl>, V12 <dbl>, V13 <dbl>, V14 <dbl>, V15 <dbl>,
#> #   V16 <dbl>, V17 <dbl>, V18 <dbl>, V19 <dbl>, V20 <dbl>, V21 <dbl>,
#> #   V22 <dbl>, V23 <dbl>, V24 <dbl>, V25 <dbl>, V26 <int>, V27 <int>,
#> #   V28 <dbl>, V29 <chr>, V30 <dbl>, V31 <dbl>, V32 <dbl>, V33 <dbl>,
#> #   V34 <dbl>, V35 <dbl>, V36 <dbl>, V37 <dbl>, V38 <dbl>, V39 <chr>,
#> #   V40 <chr>, V41 <chr>, V42 <chr>, V43 <dbl>, V44 <dbl>, V45 <dbl>,
#> #   V46 <dbl>, V47 <dbl>, V48 <dbl>, V49 <dbl>, V50 <dbl>, V51 <dbl>
```

The names of the indicators can be accessed via the dictionary `socec_dict` or via the documentation of `socec`. In addition, of course, the Bundeswahlleiter provides this information.


```r
data(socec_dict)
glimpse(socec_dict)
```


# Use case




You can use the data eg., for determining association of right-wing (AfD) results with unemployment rate per electoral district - see [here](https://sebastiansauer.github.io/afd-map-foreigners/) for an example.


Of course those data can easily be saved as csv:


```r
write_csv(elec_results, path = "elec_results.csv")
write_csv(socec, path = "socec.csv")
write_csv(parties_de, path = "parties_de.csv")
write_csv(wahlkreise_shp, path = "wahlkreise_shp.csv")
```

Watch our for `wahlkreise_shp` though as it contains a list column.


# Data at osf.io


The [Open Science Framework](https://osf.io) is a great place to store data openly. You can easily access the data from that source, too. Look at [this repository](https://osf.io/2yhr9/).

Data are provided in csv and RData form.


# Concluding


It was quite fun to me to play around with the data, and I think quite some valuable insights can be inferred. Of course, electoral data has a unique value as it features the most important action of a democracy.
