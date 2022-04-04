#Install package manager if it is not installed

library(pacman)
library(MMWRweek) # for epiweek manipulation
library(sf) 
library(rnaturalearth) # for map creation
library(rnaturalearthdata)
library(janitor) # for some handy cleaning functions not in tidyverse
library(htmltools)
library(htmlwidgets) 
library(stringr) # for text manipulation
library(raster) # to succesfully import and extract population from the raster file
library(rgdal) # for several spatial functions
library(ggcharts) 
library(RColorBrewer) # for palettes
library(forcats)
library(dplyr) # for data man
library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(shinythemes)
library(shinycssloaders)
library(leaflet)
library(ggplot2)

library(reticulate)
library(DT)
library(stringr)
library(stringi)
library(lubridate)
library(data.table)
library(aniview)

library(tidyverse)
library(plotly)
library(zoo) # for rolling averages (e.g. 7 day rolling average)


owid_latest <- read_csv(file = "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/latest/owid-covid-latest.csv",
                        col_types = cols( 
                          new_tests = col_double(),
                          total_tests = col_double()
                        )
) %>% 
  filter(continent == "Africa") %>% 
  dplyr::select(iso_code:population) %>% 
  select(-contains("smooth")) %>% 
  rename(date = last_updated_date) %>% 
  rename(Country = location,
         Population = population) %>% 
  mutate(
    id = paste0(iso_code, "_", date),
    Region = case_when(
      Country %in% c("Burundi", "Cameroon", "Central African Republic", "Chad", "Republic of Congo", "Democratic Republic of the Congo", "Equatorial Guinea", "Gabon", "São Tomé and Principe") ~ "Central Africa",
      Country %in% c("Comoros", "Eritrea", "Ethiopia", "Kenya", "Madagascar", "Mauritius", "Rwanda", "Seychelles", "South Sudan", "Tanzania", "Uganda") ~ "Eastern Africa",
      Country %in% c("Algeria") ~ "Northern Africa",
      Country %in% c("Angola", "Botswana", "Swaziland", "Lesotho", "Malawi", "Mozambique", "Namibia", "South Africa", "Zambia", "Zimbabwe") ~ "Southern Africa",
      Country %in% c("Benin", "Burkina Faso", "Cabo Verde", "Côte d'Ivoire", "The Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Niger", "Nigeria", "Senegal", "Sierra Leone", "Togo") ~ "Western Africa"
    ),
    Epiweek = lubridate::isoweek(date)
  ) %>% 
  group_by(Country, Epiweek) %>% 
  mutate(
    weekly_new_cases = sum(new_cases, na.rm = T),
    weekly_new_deaths = sum(new_deaths, na.rm = T)
  ) %>% 
  ungroup() %>% 
  relocate(Epiweek, .after = "date") %>%
  relocate(weekly_new_cases, .after = "new_cases") %>%
  relocate(weekly_new_deaths, .after = "new_deaths")

owid_countries <- read_csv(file = "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv",
                           col_types = cols( 
                             new_tests = col_double(),
                             total_tests = col_double()
                           )
) %>% 
  filter(continent == "Africa") %>% 
  dplyr::select(iso_code:population) %>% 
  select(-contains("smooth")) %>% 
  rename(Country = location,
         Population = population) %>% 
  mutate(
    id = paste0(iso_code, "_", date),
    Region = case_when(
      Country %in% c("Burundi", "Cameroon", "Central African Republic", "Chad", "Republic of Congo", "Democratic Republic of the Congo", "Equatorial Guinea", "Gabon", "São Tomé and Principe") ~ "Central Africa",
      Country %in% c("Comoros", "Eritrea", "Ethiopia", "Kenya", "Madagascar", "Mauritius", "Rwanda", "Seychelles", "South Sudan", "Tanzania", "Uganda") ~ "Eastern Africa",
      Country %in% c("Algeria") ~ "Northern Africa",
      Country %in% c("Angola", "Botswana", "Swaziland", "Lesotho", "Malawi", "Mozambique", "Namibia", "South Africa", "Zambia", "Zimbabwe") ~ "Southern Africa",
      Country %in% c("Benin", "Burkina Faso", "Cabo Verde", "Côte d'Ivoire", "The Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Niger", "Nigeria", "Senegal", "Sierra Leone", "Togo") ~ "Western Africa"
    ),
    Epiweek = lubridate::isoweek(date)
  ) %>% 
  group_by(Country, Epiweek) %>% 
  mutate(
    weekly_new_cases = sum(new_cases, na.rm = T),
    weekly_new_deaths = sum(new_deaths, na.rm = T)
  ) %>% 
  ungroup() %>% 
  relocate(Epiweek, .after = "date") %>%
  relocate(weekly_new_cases, .after = "new_cases") %>%
  relocate(weekly_new_deaths, .after = "new_deaths")

# loading country info for continental Africa analyses (faux LL)
countries_list <- sort(unique(owid_countries$Country))
regions_list <- sort(unique(owid_countries$Region))
min_date <- min(owid_countries$date, na.rm = T)
max_date <- max(owid_latest$date, na.rm = T)
