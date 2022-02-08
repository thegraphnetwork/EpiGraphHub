require("tidyverse")
require("shiny")
require("shinyWidgets")
require("shinydashboard")
require("shinythemes")
require("shinycssloaders")
require("leaflet")
require("ggplot2")
require("plotly")
require("lubridate")
require("MMWRweek")
require("sf") 
require("zoo")
require("janitor")
require("rgdal")
require("DT")
require("RColorBrewer")
require("htmlwidgets")
# require("rnaturalearthdata")
require("aniview")
require("promises")
require("future")
require("DBI")
require("RPostgreSQL")
require("sys")

load("www/data/afro_subregions.Rdata")
load("www/data/africa_map.Rdata")


regions_list <- c("Middle Africa", "Eastern Africa", "Western Africa", "Southern Africa", "Northern Africa")

#https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv
# OWID


df_daily <- read_csv(
  file = "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv",
       col_types = cols(
         new_tests = col_double(),
         total_tests = col_double()
       )
) %>%
  filter(continent == "Africa") %>%
  # dplyr::select(iso_code:date, new_cases, new_deaths, new_tests, total_tests, total_vaccinations:new_vaccinations, population, -total_boosters) %>%
  mutate(
    id = paste0(iso_code, "_", date)
  ) %>%
  dplyr::select(-continent) %>%
  dplyr::select(-contains("smooth"))


# expanded dates
## completing dataset with missing dates
min_date <- min(ymd(df_daily$date), na.rm = T)-1
max_date <- max(ymd(df_daily$date), na.rm = T)
all_dates = ymd(seq.Date(min_date, max_date, by = "day"))
all_countries <- unique(df_daily$iso_code)
all_locations <- df_daily %>% 
  dplyr::select(iso_code, location, population, population_density, median_age) %>% 
  distinct(iso_code, .keep_all = T)

dates_expanded <- expand.grid(all_countries, all_dates) %>% 
  rename(iso_code = Var1, date = Var2) %>% 
  arrange(iso_code, date) %>% 
  mutate(
    id = paste0(iso_code, "_", date)
  ) %>% 
  dplyr::select(date, iso_code, id) %>% 
  left_join(all_locations, by = "iso_code")

df_daily <- dates_expanded %>% 
  left_join(df_daily %>% dplyr::select(-c(iso_code, location, date, population, population_density, median_age)), by = "id") %>% 
  replace(is.na(.), 0) %>% 
  mutate(
    epiweek = isoweek(date),
    year = isoyear(date),
    epiweek = paste0(year, "-Wk", epiweek)
  ) %>% 
  left_join(
    afro_subregions, by = "location"
  )

countries_list <- df_daily %>% 
  dplyr::select(location) %>% 
  distinct() %>% 
  pull %>% 
  sort()

rm(min_date, max_date, all_dates, all_countries, dates_expanded)

# integrating OWID data
epi_table <- df_daily %>% 
  dplyr::select(
    -c(
      icu_patients:hosp_patients_per_million,
      aged_65_older:excess_mortality_cumulative_per_million
    )
  ) %>% 
  group_by(location, epiweek) %>% 
  mutate(
    id = paste0(iso_code, "_", epiweek),
    start_on = min(date),
    # Cases
    total_cases = sum(total_cases, na.rm = T),
    new_cases = sum(new_cases, na.rm = T),
    total_cases_per_million = total_cases/population * 10^6,
    total_new_cases_per_million = new_cases/population * 10^6,
    
    # Deaths
    total_deaths = sum(total_deaths, na.rm = T),
    new_deaths = sum(new_deaths, na.rm = T),
    total_deaths_per_million = total_deaths/population * 10^6,
    total_new_deaths_per_million = new_deaths/population * 10^6,
    
    # Tests
    total_tests = sum(total_tests, na.rm = T),
    new_tests = sum(new_tests, na.rm = T),
    total_tests_per_ten_thousand = total_tests/population * 10^4,
    new_tests_per_ten_thousand = new_tests/population * 10^4,
    
    # Vaccine
    total_vaccinations = sum(total_vaccinations, na.rm = T),
    people_vaccinated = sum(people_vaccinated, na.rm = T),
    people_fully_vaccinated = sum(people_fully_vaccinated, na.rm = T),
    total_boosters = sum(total_boosters, na.rm = T),
    new_vaccinations = sum(new_vaccinations, na.rm = T),
    total_vaccinations_per_hundred = total_vaccinations/population * 10^6,
    people_vaccinated_per_hundred = people_vaccinated/population * 10^6,
    people_fully_vaccinated_per_hundred = people_fully_vaccinated/population * 10^6,
    total_boosters_per_hundred = total_boosters/population * 10^6,
    
    # Others metrics
    reproduction_rate = mean(reproduction_rate),
    positive_rate = mean(positive_rate),
    stringency_index = mean(stringency_index)
  ) %>% 
  ungroup() %>% 
  arrange(location, epiweek) %>% 
  distinct(id, .keep_all = T) %>% 
  dplyr::select(-c(id, date))

# defining moving average window (increase jumps by every 7 days to make plots smoother)
mov_avg_plot <- 7 # we are using a 7-day window for plots
mov_avg_tab <- 28 # we are using a 28-day window for table 3

# daily interactive plots
df_daily_plots <- df_daily %>% 
  arrange(date) %>% 
  group_by(location) %>% 
  mutate(
    # Incidences
    incidence = round(new_cases / population * 1e6, 2),
    mortality = round(new_deaths / population * 1e6, 2),
    tests_incidence = round(new_tests / population * 1e4, 2),
    people_fully_vaccinated = ifelse(people_fully_vaccinated < 0, 0, people_fully_vaccinated),
    vaccines_incidence = round(people_fully_vaccinated / population * 100, 2),
    # Xday_avg
    new_cases_Xday_avg = rollapply(new_cases, width = mov_avg_plot, FUN = mean, 
       align = "right", partial = TRUE, fill = 0),
    new_deaths_Xday_avg = rollapply(new_deaths, width = mov_avg_plot, FUN = mean, 
        align = "right", partial = TRUE, fill = 0),
    new_tests_Xday_avg = rollapply(new_tests, width = mov_avg_plot, FUN = mean, 
       align = "right", partial = TRUE, fill = 0),
    people_fully_vaccinated_Xday_avg = rollapply(people_fully_vaccinated, width = mov_avg_plot, FUN = mean, 
          align = "right", partial = TRUE, fill = 0),
    # Incidences Xday_avg
    incidence_Xday_avg = rollapply(incidence, width = mov_avg_plot, FUN = mean, 
       align = "right", partial = TRUE, fill = 0),
    mortality_Xday_avg = rollapply(mortality, width = mov_avg_plot, FUN = mean, 
       align = "right", partial = TRUE, fill = 0),
    tests_incidence_Xday_avg = rollapply(tests_incidence, width = mov_avg_plot, FUN = mean, 
             align = "right", partial = TRUE, fill = 0),
    vaccines_incidence_Xday_avg = rollapply(vaccines_incidence, width = mov_avg_plot, FUN = mean, 
  align = "right", partial = TRUE, fill = 0)
  ) %>% 
  # calculating growth rates
  mutate(
    cases_past_Xdays = rollapply(new_cases, width = mov_avg_tab, FUN = sum, 
     align = "right", partial = TRUE, fill = 0),
    deaths_past_Xdays = rollapply(new_deaths, width = mov_avg_tab, FUN = sum, 
      align = "right", partial = TRUE, fill = 0),
    tests_past_Xdays = rollapply(new_tests, width = mov_avg_tab, FUN = sum, 
     align = "right", partial = TRUE, fill = 0),
    vaccines_past_Xdays = rollapply(people_fully_vaccinated, width = mov_avg_tab, FUN = sum, 
        align = "right", partial = TRUE, fill = 0),
    diff_cases = cases_past_Xdays - lag(cases_past_Xdays, 1), 
    diff_deaths = deaths_past_Xdays - lag(deaths_past_Xdays, 1), 
    diff_tests = tests_past_Xdays - lag(tests_past_Xdays, 1),
    diff_vaccines = vaccines_past_Xdays - lag(vaccines_past_Xdays, 1), 
    across(starts_with("diff_"), ~ replace_na(., 0)),
    cases_growth_Xd = round(diff_cases / lag(cases_past_Xdays, 1) * 100, 2),
    deaths_growth_Xd = round(diff_deaths / lag(deaths_past_Xdays, 1) * 100, 2),
    tests_growth_Xd = round(diff_tests / lag(tests_past_Xdays, 1) * 100, 2),
    vaccines_growth_Xd = round(diff_vaccines / lag(vaccines_past_Xdays, 1) * 100, 2),
    across(ends_with("_growth_Xd"), ~ replace_na(., 0))) %>% 
  select(-c(cases_past_Xdays:diff_vaccines)) %>% 
  ungroup()

df_weekly_plots <- epi_table %>% 
  arrange(start_on) %>% 
  # calculating cumulative indicators and moving averages
  group_by(location) %>% 
  mutate(
    incidence = round(new_cases / population * 1e6, 2),
    mortality = round(new_deaths / population * 1e6, 2),
    tests_incidence = round(new_tests / population * 1e4, 2),
    people_fully_vaccinated = ifelse(people_fully_vaccinated < 0, 0, people_fully_vaccinated),
    vaccines_incidence = round(people_fully_vaccinated / population * 100, 2),
    incidence_Xday_avg = rollapply(new_cases, width = 4, FUN = mean, 
       align = "right", partial = TRUE, fill = 0),
    mortality_Xday_avg = rollapply(new_deaths, width = 4, FUN = mean, 
       align = "right", partial = TRUE, fill = 0),
    new_tests_Xday_avg = rollapply(new_tests, width = mov_avg_plot, FUN = mean, 
       align = "right", partial = TRUE, fill = 0),
    people_fully_vaccinated_Xday_avg = rollapply(people_fully_vaccinated, width = mov_avg_plot, FUN = mean, 
          align = "right", partial = TRUE, fill = 0),
    incidence_per_million_Xday_avg = rollapply(new_cases_per_million, width = 4, FUN = mean, 
     align = "right", partial = TRUE, fill = 0),
    mortality_per_million_Xday_avg = rollapply(new_deaths_per_million, width = 4, FUN = mean, 
     align = "right", partial = TRUE, fill = 0),
    tests_incidence_per_ten_thousand_Xday_avg = rollapply(new_tests_per_ten_thousand, width = 4, FUN = mean, 
  align = "right", partial = TRUE, fill = 0),
    vaccines_incidence_per_hundred_Xday_avg = rollapply(people_fully_vaccinated_per_hundred, width = 4, FUN = mean, 
align = "right", partial = TRUE, fill = 0),
    epiweek = factor(epiweek, levels = unique(epiweek))
  ) %>% 
  ungroup() %>% 
  arrange(start_on)

nb.cols_1 <- length(countries_list)
mycolors_1 <- colorRampPalette(brewer.pal(8, "Set3"))(nb.cols_1)

# Maps
all_country_tab <- df_daily %>% 
  group_by(location) %>% 
  slice(which.max(date)) %>% 
  dplyr::rename(Cases = total_cases, Deaths = total_deaths) %>% 
  mutate(`Crude \nCFR (%)` = round(100 * Deaths / Cases, digits = 1)) %>% 
  mutate(`Cases per million` = (Cases / population) * 1e6,
         `Deaths per million` = (Deaths / population) * 1e6) %>% 
  dplyr::select(location, Cases,`Cases per million`, Deaths, `Deaths per million`) %>% 
  arrange(-Cases) %>% 
  ungroup() 

# Import and merging Africa map from natural earth package (including small insular countries)
# africa_map <- subset(rnaturalearthdata::countries50,
#        region_un == "Africa" & type == "Sovereign country")

# save(africa_map, file = "www/Others/africa_map.R")
# load("www/Others/africa_map.R")

# Extracting centroids
centroids_df <- data.frame(coordinates(africa_map)) %>%
  rename(X = X1,
         Y = X2)

# Inserting centroids into continental map
africa_union <- cbind(africa_map, centroids_df)

# join africa geoms with the COVID info about countries
africa_map_final <- africa_union %>% 
  st_as_sf() %>% 
  st_set_crs(4326) %>%
  mutate(name_long = case_when(name_long == "Cape Verde" ~ "Cabo Verde",
   TRUE ~ name_long)) %>%
  rename(location = name_long) %>%
  left_join(all_country_tab, by = "location")

# Inserting breaks for choropleth maps

africa_map_final <- africa_map_final %>%
  mutate(
    
    #Total cases
    cases.cat = cut(Cases, 
      breaks = c(-1, 0, 1000, 5000, 10000, 50000, 100000, 500000, 1000000, Inf),
      labels = c("No cases", "[1 - 1,000]", "[1,001 - 5,000]",
   "[5,001 - 10,000]", "[10,001 - 50,000]", "[50,001 - 100,000]", 
   "[100,001 - 500,000]", "[500,001 - 1,000,000]", "Higher than 1,000,000"), 
      right = T),
    cases.color = case_when(
      cases.cat == "No cases" ~ "#ffffff", cases.cat == "[1 - 1,000]" ~ "#FFEDA0", cases.cat == "[1,001 - 5,000]" ~ "#FED976", 
      cases.cat == "[5,001 - 10,000]" ~ "#FEB24C", cases.cat == "[10,001 - 50,000]" ~ "#FD8D3C", cases.cat == "[50,001 - 100,000]" ~ "#FC4E2A", 
      cases.cat == "[100,001 - 500,000]" ~ "#E31A1C", cases.cat == "[500,001 - 1,000,000]" ~ "#BD0026", cases.cat == "Higher than 1,000,000" ~ "#800026"
    ),
    
    #Total deaths
    deaths.cat = cut(Deaths, 
       breaks = c(-1, 0, 100, 500, 1000, 5000, 10000, 50000, 100000, Inf),
       labels = c("No deaths", "[1 - 100]", "[101 - 500]", "[501 - 1000]", 
    "[1,001 - 5,000]", "[5,001 - 10,000]", "[10,001 - 50,000]", 
    "[50,001 - 100,000]", "Higher than 100,000"), 
       right = T),
    deaths.color = case_when(
      deaths.cat == "No deaths" ~ "#ffffff", deaths.cat == "[1 - 100]" ~ "#FFEDA0", deaths.cat == "[101-500]" ~ "#FED976",
      deaths.cat == "[501 - 1000]" ~ "#FEB24C", deaths.cat == "[1.001 - 5.000]" ~ "#FD8D3C", deaths.cat == "[5.001 - 10.000]" ~ "#FC4E2A",
      deaths.cat == "[10.001 - 50.000]" ~ "#E31A1C", deaths.cat == "[50.001 - 100.000]" ~ "#BD0026", deaths.cat == "Higher than 100,000" ~ "#800026"
    ),
    
    #Cases per million
    cases.rate.cat = cut(`Cases per million`, 
           breaks = c(-1, 0, 10, 100, 500, 1000, 5000, 10000, 100000, Inf),
           labels = c("No cases", "[0 - 10]", "[10 - 100]", 
        "[100 - 500]", "[500 - 1000]", "[1000 - 5000]", 
        "[5000 - 10000]", "[10000 - 100000]", "Higher than 100,000"), 
           right = T),
    cases.rate.color = case_when(
      cases.rate.cat == "No cases" ~ "#ffffff", cases.rate.cat == "[0 - 10]" ~ "#FFEDA0", cases.rate.cat == "[10 - 100]" ~ "#FED976",
      cases.rate.cat == "[100 - 500]" ~ "#FEB24C", cases.rate.cat == "[500 - 1000]" ~ "#FD8D3C", cases.rate.cat == "[1000 - 5000]" ~ "#FC4E2A",
      cases.rate.cat == "[5000 - 10000]" ~ "#E31A1C", cases.rate.cat == "[10000 - 100000]" ~ "#BD0026", cases.rate.cat == "Higher than 100,000" ~ "#800026"
    ),
    
    #Deaths per million
    deaths.rate.cat = cut(`Deaths per million`, 
            breaks = c(-1, 0, 1, 5, 10, 50, 100, 500, 1000, Inf),
            labels = c("No deaths", "[0,1 - 1]", "[1 - 5]",
         "[5 - 10]", "[10 - 50]", "[50 - 100]", 
         "[100 - 500]", "[500 - 1000]", "Higher than 1,000"), 
            right = T),
    deaths.rate.color = case_when(
      deaths.rate.cat == "No deaths" ~ "#ffffff", deaths.rate.cat == "[0,1 - 1]" ~ "#FFEDA0", deaths.rate.cat == "[1 - 5]" ~ "#FED976", 
      deaths.rate.cat == "[5 - 10]" ~ "#FEB24C", deaths.rate.cat == "[10 - 50]" ~ "#FD8D3C", deaths.rate.cat == "[50 - 100]" ~ "#FC4E2A",
      deaths.rate.cat == "[100 - 500]" ~ "#E31A1C", deaths.rate.cat == "[500 - 1000]" ~ "#BD0026", deaths.rate.cat == "Higher than 1,000" ~ "#800026"
    )
    
  )

