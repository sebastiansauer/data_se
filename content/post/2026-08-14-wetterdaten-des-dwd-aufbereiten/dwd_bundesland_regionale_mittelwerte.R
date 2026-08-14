#' Fertige DWD-Bundesland-Zeitreihen laden (keine Stationsaggregation noetig)
#'
#' Der DWD stellt unter regional_averages_DE/ bereits fertige Gebietsmittel
#' pro Bundesland bereit - monatlich fuer Temperatur/Niederschlag/Sonnenschein,
#' jaehrlich fuer Kenntage (FD, SU, TR, Heisse Tage, Eistage, Starkregentage).
#' Deckt ab: urspruengliche Frage (Temperatur/Monat/Bundesland) + Indizes 1,2,4.
#' NICHT abgedeckt: TN10p, TX90p, DTR, CDD, CWD, Rx1day, R95p (siehe zweites Skript).

library(dplyr)
library(readr)
library(tidyr)
library(rvest)
library(stringr)

base_url <- "https://opendata.dwd.de/climate_environment/CDC/regional_averages_DE"

# Hilfsfunktion: alle .txt-Dateilinks eines Verzeichnisses auslesen ----------
list_txt_files <- function(dir_url) {
  page <- read_html(dir_url)
  hrefs <- page |> html_elements("a") |> html_attr("href")
  hrefs[str_ends(hrefs, ".txt")]
}

# Hilfsfunktion: eine DWD-Bundesland-Zeitreihendatei einlesen ---------------
read_regional_file <- function(url) {
  read_delim(
    url,
    delim = ";",
    skip = 1,
    trim_ws = TRUE,
    na = c("", "NA"),
    show_col_types = FALSE
  ) |>
    select(where(~ !all(is.na(.)))) # leere Trailing-Spalte (Endsemikolon) entfernen
}

# 1. Monatswerte: Temperatur -------------------------------------------------
tm_dir <- file.path(base_url, "monthly/air_temperature_mean")
tm_files <- list_txt_files(tm_dir)

temperatur_monat <- map_dfr(
  tm_files,
  ~ read_regional_file(file.path(tm_dir, .x))
)

temperatur_lang <- temperatur_monat |>
  pivot_longer(
    cols = -c(Jahr, Monat),
    names_to = "Bundesland",
    values_to = "Temp_Mittel_C"
  ) |>
  filter(!is.na(Temp_Mittel_C)) |>
  arrange(Bundesland, Jahr, Monat)

write_csv(temperatur_lang, "temperatur_bundesland_monat.csv")

# 2. Monatswerte: Niederschlag (optional, fuer CDD/CWD-Kontext PRCPTOT) ------
rr_dir <- file.path(base_url, "monthly/precipitation")
rr_files <- list_txt_files(rr_dir)

niederschlag_lang <- map_dfr(
  rr_files,
  ~ read_regional_file(file.path(rr_dir, .x))
) |>
  pivot_longer(
    cols = -c(Jahr, Monat),
    names_to = "Bundesland",
    values_to = "Niederschlag_mm"
  ) |>
  filter(!is.na(Niederschlag_mm)) |>
  arrange(Bundesland, Jahr, Monat)

write_csv(niederschlag_lang, "niederschlag_bundesland_monat.csv")

# 3. Jahreswerte: Kenntage (FD, SU, TR, hot_days, ice_days, Starkregentage) --
kenntage_ordner <- c(
  frost_days = "annual/frost_days", # FD
  summer_days = "annual/summer_days", # SU
  tropical_nights = "annual/tropical_nights_tminGE20", # TR
  hot_days = "annual/hot_days",
  ice_days = "annual/ice_days",
  precipGE10mm_days = "annual/precipGE10mm_days",
  precipGE20mm_days = "annual/precipGE20mm_days"
)

kenntage_liste <- imap(kenntage_ordner, function(pfad, label) {
  dir_url <- file.path(base_url, pfad)
  files <- list_txt_files(dir_url)
  if (length(files) == 0) {
    return(NULL)
  }
  df <- read_regional_file(file.path(dir_url, files[1]))
  df |>
    pivot_longer(
      cols = -any_of(c("Jahr", "Monat")),
      names_to = "Bundesland",
      values_to = "Wert"
    ) |>
    filter(!is.na(Wert)) |>
    mutate(Indikator = label)
})

kenntage_lang <- bind_rows(kenntage_liste) |>
  arrange(Indikator, Bundesland, Jahr)

write_csv(kenntage_lang, "klimakenntage_bundesland_jahr.csv")

# 4. Kurzueberblick -----------------------------------------------------------
cat(
  "Temperatur:",
  nrow(temperatur_lang),
  "Zeilen,",
  n_distinct(temperatur_lang$Bundesland),
  "Bundeslaender,",
  "Zeitraum",
  min(temperatur_lang$Jahr),
  "-",
  max(temperatur_lang$Jahr),
  "\n"
)
cat(
  "Kenntage:",
  nrow(kenntage_lang),
  "Zeilen,",
  n_distinct(kenntage_lang$Indikator),
  "Indikatoren\n"
)
