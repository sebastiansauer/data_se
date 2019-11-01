


install_fom_packages <- function(selection = "standard"){


  # define needed packages:

  pckgs_standard <- c("mosaic", "tidyverse", "sjmisc", "twitteR", "psych",
                      "devtools", "tidytext", "lsr", "sjstats",
                      "gapminder", "rnaturalearth", "corrr", "okcupiddata",
                      "wordcloud", "corrplot", "janitor", "SnowballC",
                      "tinytex", "paramtest", "rnaturalearth", "countrycode",
                      "effsize", "pwr", "rocr")


  pckgs_advanced <- c(pckgs_standard, "ISLR", "caret", "nlme", "lme4")



  # define customized bundle of packages, depending on "selection":

  selection_key <- c("standard", "full")
  selection_value <- list(pckgs_standard, pckgs_advanced)
  names(selection_value) <- selection_key


  if(!selection %in% selection_key)
    error("Error: invalid choice for parameter `selection`")


  # determine the selected bundle of pckgs to be installed:

  selected_bundle <- selection_value[[selection]]



  # install missing packges:

  pckgs_tobeinstalled <- selected_bundle[!(selected_bundle %in% installed.packages()[,"Package"])]
  if(length(pckgs_tobeinstalled)) {
    install.packages(pckgs_tobeinstalled)
    } else {
      cat("No packages were missing. No packages have been installed.\n")}

  if ("tinytex" %in% pckgs_tobeinstalled)
    cat("After installing `tinytex`, don't forget to install tex by using this commend `tinytex::install_tinytex()`.\nCheck out here more details: https://yihui.name/tinytex/ \n")


  cat("Consider updating your packages next by using `update.packagges()`.\n")



}
