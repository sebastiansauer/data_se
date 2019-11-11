


install_fom_packages <- function(selection = "standard",
                                 show_selection = FALSE,
                                 show_pckgs_to_be_installed = FALSE){


  # define needed packages:

  pckgs_standard <- c("mosaic", "tidyverse")


  pckgs_advanced <- c(pckgs_standard, "ISLR", "caret", "nlme", "lme4",
                      "sjmisc", "twitteR", "psych",
                      "devtools", "tidytext", "lsr", "sjstats",
                      "gapminder", "rnaturalearth", "corrr", "okcupiddata",
                      "wordcloud", "corrplot", "janitor", "SnowballC",
                      "tinytex", "paramtest", "rnaturalearth", "countrycode",
                      "effsize", "pwr", "ROCR", "foreign")



  # define customized bundle of packages, depending on "selection" (as type of dictionnary):

  selection_key <- c("standard", "advanced")
  selection_value <- list(pckgs_standard, pckgs_advanced)
  names(selection_value) <- selection_key


  if(!selection %in% selection_key)
    error("Error: invalid choice for parameter `selection`")

  cat("Selected bundle includes the following packages: \n", selection_value[[selection]],"\n")


  # determine the selected bundle of pckgs to be installed:

  selected_bundle <- selection_value[[selection]]




  # install missing packges:

  pckgs_tobeinstalled <- selected_bundle[!(selected_bundle %in% installed.packages()[,"Package"])]

  cat("The following packages will be installed:\n", pckgs_tobeinstalled, "\n")

  if(length(pckgs_tobeinstalled)) {
    install.packages(pckgs_tobeinstalled)
    } else {
      cat("No packages were missing. No packages have been installed.\n")}

  if ("tinytex" %in% pckgs_tobeinstalled)
    cat("After installing `tinytex`, don't forget to install tex by using this commend `tinytex::install_tinytex()`.\nCheck out here more details: https://yihui.name/tinytex/ \n")


  cat("Consider updating your packages next by using `update.packagges()`.\n")




}
