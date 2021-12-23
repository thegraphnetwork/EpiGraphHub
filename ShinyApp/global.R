#Install package manager if it is not installed
if(!require('pacman')) install.packages('pacman'); library('pacman') 

library(pacman)

p_load(char=c("lubridate", # for date manipulation
              "MMWRweek", # for epiweek manipulation
              "knitr", # for kniting this markdown
              "sf", "rnaturalearth", # for map creation
              "rnaturalearthdata",
              "shinycssloaders", #for loading animations
              "zoo", # for rolling averages (e.g. 7 day rolling average)
              "ggnewscale", # for calibrating multiple scales
              "ggrepel", # avoiding overlap on geom_text and geom_label aesthetics
              "viridis", # palettes
              "pander", # for generating tables that output to both pdf and docx
              "kableExtra", # for some tables. Only outputs to pdf
              "visdat", # for visualizing data frames
              "janitor", # for some handy cleaning functions not in tidyverse
              "formattable", "flextable", # for pretty tables
              "webshot", "htmltools", "magick", # for taking screenshots of pretty tables
              "see", "htmlwidgets", 
              "treemapify", # for ggplot treemaps
              "grid", "gridExtra", "ggpubr", # for grids
              "png", # for importing PNGs as rasters
              "stringr", # for text manipulation
              "ggspatial", # to add cross, scale-bar and other important annotations in maps
              "raster", # to succesfully import and extract population from the raster file
              "rgdal", # for several spatial functions
              "ggcharts", 
              "RColorBrewer", # for palettes
              "ggforce", # for automatic facetting in facet plots
              "ggridges",
              "tidyr",
              "forcats",
              "dplyr", # for data man
              "shiny",
              "shinyWidgets",
              "shinydashboard",
              "shinythemes",
              "shinycssloaders",
              "tidyverse",
              "leaflet",
              "ggplot2",
              "plotly",
              "reticulate",
              "DT",
              "stringr",
              "stringi",
              "lubridate",
              "yaml",
              "RColorBrewer",
              "aniview"),
       update = FALSE)

df_owid <- read_csv(file = "https://covid.ourworldindata.org/data/owid-covid-data.csv/",
                    col_types = cols( 
                      new_tests = col_double(),
                      total_tests = col_double()
                    )
) %>% 
  filter(continent == "Africa") %>% 
  dplyr::select(iso_code:date, new_cases, new_deaths, new_tests, total_tests, total_vaccinations:new_vaccinations, population, -total_boosters) %>% 
  mutate(
    id = paste0(iso_code, "_", date)
  ) 




#loading dictonary
load("Others/dictionary.Rdata")
colnames(dictionary) <- c("Incorrect", "Correct", "AdminLvl")
assign("dictionary",dictionary,envir = .GlobalEnv)

#loading population data
pop <- raster("Others/gpw_v4_population_count_rev11_2020_15_min.tif")
assign("pop",pop,envir = .GlobalEnv)

options(shiny.maxRequestSize=1000*1024^2)

# loading country info for continental Africa analyses (faux LL)
country_info <- read_csv("Others/country_info_africa.csv", trim_ws = T) %>% 
  mutate(Country = case_when(Country == "CAF" ~ "Central African Republic",
                             Country == "Congo (Rep)" ~ "Republic of Congo",
                             Country == "Cote d'Ivoire" ~ "Côte d'Ivoire", 
                             Country == "DRC" ~ "Democratic Republic of the Congo",
                             Country == "Eq. Guinea" ~ "Equatorial Guinea",
                             Country == "Eswatini" ~ "Swaziland",
                             Country == "Gambia" ~ "The Gambia",
                             Country == "Sao Tome e P" ~ "São Tomé and Principe",
                             TRUE ~ Country),
         Region = if_else(Region == "Easterb Africa", "Eastern Africa", Region))

countries_list <- sort(unique(country_info$Country))

#"All countries",
# contries_list <- c(
#   "Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cameroon", "Cape Verde", "Central African Republic", "Chad", "Comoros", "Congo", "Cote d'Ivoire",
#   "Democratic Republic of Congo", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Sudan", "Swaziland", "Tanzania", "Togo", "Tunisia", "Uganda", "Western Sahara", "Zambia", "Zimbabwe"
# )
# 
# region_list <- c(
#   "Southern Africa", "West Africa", "East Africa" , "North Africa", "Central Africa"
# )

# Load Faux LL data
LL_raw <- read_csv("Others/ConfirmedCases.csv", trim_ws = T, na = c("", " ", "NA")) %>% 
  mutate(Country = as.character(Country)) %>% 
  # renaming mislabelled countries to merge with map polygon later
  mutate(Country = case_when(Country == "CAF" ~ "Central African Republic",
                             Country == "CÃ´te d'Ivoire" ~ "Côte d'Ivoire",
                             Country == "Cote d'Ivoire" ~ "Côte d'Ivoire", 
                             Country == "DRC" ~ "Democratic Republic of the Congo",
                             Country == "Congo (Republic of)" ~ "Republic of Congo",
                             Country == "Eq. Guinea" ~ "Equatorial Guinea",
                             Country == "Eswatini" ~ "Swaziland",
                             Country == "Gambia" ~ "The Gambia",
                             Country == "Sao Tome and Principe" ~ "São Tomé and Principe",
                             Country == "United Republic of Tanzania" ~ "Tanzania",
                             TRUE ~ Country))

# Last date
lastdate <- max(LL_raw$Reporting_Date)

# replace spaces with period in all column names
names(LL_raw) <- str_replace_all(names(LL_raw), " ", ".")

# The slightly cleaned linelist is now stored in the object called "df_LL"
df_LL <- LL_raw %>%
  mutate(Outcome = case_when(Outcome == "dead" ~ "Dead",
                             Outcome == "recovered" ~ "Recovered",
                             TRUE ~ Outcome)) %>%
  # impute dates of death
  mutate(Date.of.Death = case_when(is.na(Outcome) ~ "NA", # if no OUTCOME, Date of Death should be NA
                                   # if dead and no recorded date of death, 
                                   Outcome == "Dead" & is.na(Date.of.Death) ~ 
                                     # plug in their date of discharge, or report date, if missing
                                     ifelse(!is.na(Date.of.Discharge), as.character(Date.of.Discharge), 
                                            as.character(Reporting_Date)),
                                   TRUE ~ as.character(Date.of.Death))) %>%
  # Recode Dates of Discharge as above
  mutate(Date.of.Discharge = case_when(is.na(Outcome) ~ "NA",
                                       Outcome == "Recovered" & is.na(Date.of.Discharge) ~ 
                                         ifelse(!is.na(Date.of.Discharge), as.character(Date.of.Death), 
                                                as.character(Reporting_Date)),
                                       TRUE ~ as.character(Date.of.Discharge))) %>%
  # remove death and recovered dates from individuals neither dead nor recovered
  mutate(Date.of.Death = if_else(Outcome != "Dead", NA_character_, Date.of.Death),
         Date.of.Discharge = if_else(Outcome != "Dead", NA_character_, Date.of.Discharge)) %>%
  # Clip data to last date requested
  filter(Reporting_Date <= lastdate) %>%
  # if death occurred after lastdate, patient is still alive
  mutate(Outcome = if_else(Outcome == "Dead" & Date.of.Death > lastdate, "Alive", Outcome),
         # removing dates of death that occurred after lastdate
         Date.of.Death = if_else(Date.of.Death > lastdate, NA_character_, Date.of.Death),
         Outcome = if_else(Outcome == "Recovered" & Date.of.Discharge > lastdate, "Alive", Outcome),
         Date.of.Discharge = if_else(Date.of.Discharge > lastdate, NA_character_, Date.of.Discharge)) %>%
  # format dates back to dates.
  mutate(Reporting_Date = as.Date(Reporting_Date),
         Date.of.Death = as.Date(Date.of.Death),
         Date.of.Discharge = as.Date(Date.of.Discharge)) %>%
  # replicate rows with multiple recorded NumCases, then change counts to 1
  uncount(NumCases, .remove = FALSE) %>%
  mutate(NumCases = 1)

# Expand dates per country
all_dates <- df_LL %>% 
  # complete to include all dates, even whe case was not recorded
  complete(Reporting_Date = seq.Date(min(Reporting_Date), max(Reporting_Date), by = "day")) %>%
  # expand to include all dates per country 
  tidyr::expand (Reporting_Date, Country) %>% 
  # arrange to make things clearer
  arrange(Country, Reporting_Date) %>% 
  # faux variables for death and discharge; needed to bind with data frames later
  mutate(Date.of.Death = Reporting_Date,
         Date.of.Discharge = Reporting_Date)

# Calculate epicurve for cases
reported_country <- df_LL %>%  
  bind_rows(all_dates) %>%
  dplyr::select(Reporting_Date, Country, NumCases) %>%
  group_by(Country, Reporting_Date) %>%
  summarise(Confirmed_this_day = sum(NumCases, na.rm = TRUE))

# Calculate epicurve for deaths as above
deaths_country <- df_LL %>% 
  bind_rows(all_dates) %>% 
  dplyr::select(Date.of.Death, Country, NumCases) %>%
  group_by(Country, Date.of.Death) %>%
  summarise(Deaths_this_day = sum(NumCases, na.rm = TRUE)) %>% 
  mutate(Reporting_Date = Date.of.Death)

# Calculate epicurve for discharges as above
discharges_country <- df_LL %>% 
  bind_rows(all_dates) %>% 
  dplyr::select(Date.of.Discharge, Country, NumCases) %>%
  group_by(Country, Date.of.Discharge) %>%
  summarise(Discharges_this_day = sum(NumCases, na.rm = TRUE)) %>% 
  mutate(Reporting_Date = Date.of.Discharge)

# Combine into single epicurve
df_country <- inner_join(reported_country, deaths_country,
                         by= c("Reporting_Date", "Country"))  %>% 
  inner_join(discharges_country,
             by= c("Reporting_Date", "Country")) %>% 
  # sort by date within each country 
  arrange(Country, Reporting_Date) %>% 
  # delete useless vars
  dplyr::select(Reporting_Date, Country, Confirmed_this_day, Deaths_this_day, Discharges_this_day) %>% 
  dplyr::rename(Cases_this_day = Confirmed_this_day) %>% 
  # add in EpiWeek 
  mutate(Epiweek = lubridate::isoweek(Reporting_Date)) %>% 
  # Calculate cumulative totals
  group_by(Country) %>% 
  mutate(Cum_cases = cumsum(Cases_this_day),
         Cum_deaths = cumsum(Deaths_this_day),
         Cum_discharges = cumsum(Discharges_this_day),
         Active_cases = Cum_cases - Cum_deaths - Cum_discharges) %>% 
  # remove NA countries (artifact of expansion I think)
  filter(!is.na(Country)) %>% 
  # Calculate crude CFR at each time point
  group_by(Country) %>% 
  mutate(CFR = round(100 * Cum_deaths / Cum_cases, digits = 1)) %>% 
  # Calculate rolling 7 day sums ( past week of cases and deaths)
  mutate(Cases_past_week = rollsum(x = Cases_this_day, k = 7, align = "right",  
                                   fill = na.fill(Cases_this_day, 0)) ,
         Deaths_past_week=rollsum(x = Deaths_this_day, k = 7, align = "right",  
                                  fill = na.fill(Deaths_this_day, 0))) %>% 
  left_join(country_info, by = "Country") %>% 
  mutate(Cases_per_million = round((Cum_cases / Population) * 1e6, digits = 1),
         Deaths_per_million = round((Cum_deaths / Population) * 1e6, digits = 1)) %>% 
  # daily cases and deaths per million
  mutate(Cases_per_million_daily = round((Cases_this_day / Population) * 1e6, digits = 1),
         Deaths_per_million_daily = round((Deaths_this_day / Population) * 1e6, digits = 1)) %>% 
  # daily cases and deaths per million smoothed
  mutate(Cases_per_million_daily_smooth = rollmean(Cases_per_million_daily, k = 7, 
                                                   fill = na.fill(Cases_per_million_daily, "extend")),
         Deaths_per_million_daily_smooth = rollmean(Deaths_per_million_daily, k = 7, 
                                                    fill = na.fill(Deaths_per_million_daily, "extend"))) %>% 
  ungroup() 

nb.cols_1 <- length(unique(df_country$Country))
mycolors_1 <- colorRampPalette(brewer.pal(8, "Set3"))(nb.cols_1)

# regional epicurve (for African regions)
df_region <- df_country %>% 
  dplyr::select(Reporting_Date, Country, Region, Population, 
                Cases_this_day, Deaths_this_day, Discharges_this_day) %>% 
  arrange(Region, Reporting_Date) %>% 
  # sum up cases for all countries in given region for a given day
  group_by(Region, Reporting_Date) %>%
  mutate(Cases_this_day = sum(Cases_this_day),
         Deaths_this_day = sum(Deaths_this_day),
         Discharges_this_day = sum(Discharges_this_day),
         Population = sum(Population),
         Country = NULL) %>% 
  # discard unneeded rows
  slice(1) %>% 
  # calculate cumulatives
  group_by(Region) %>% 
  mutate(Cum_cases = cumsum(Cases_this_day),
         Cum_deaths = cumsum(Deaths_this_day),
         Cum_discharges = cumsum(Discharges_this_day),
         Active_cases = Cum_cases - Cum_deaths - Cum_discharges) %>% 
  # cases and deaths per million
  mutate(Cases_per_million = round((Cum_cases/Population) * 1e6, digits = 1),
         Deaths_per_million = round((Cum_deaths/Population) * 1e6, digits = 1))


##  CREATING TABLES FOR FIGURES AND MAPS AND TABLES 
all_country_tab <- df_country %>% 
  group_by(Country) %>% 
  slice(which.max(Reporting_Date)) %>% 
  dplyr::rename(Cases = Cum_cases, Deaths = Cum_deaths) %>% 
  mutate(`Crude \nCFR (%)` = round(100 * Deaths / Cases, digits = 1)) %>% 
  mutate(`Cases per million` = (Cases / Population) * 1e6,
         `Deaths per million` = (Deaths / Population) * 1e6) %>% 
  dplyr::select(Country, Cases,`Cases per million`, Deaths, `Deaths per million`) %>% 
  arrange(-Cases) %>% 
  left_join(country_info) %>% 
  ungroup()


regional_tab <- df_country %>% 
  dplyr::select(Reporting_Date, Country, Cum_cases, Cum_deaths, Region, Population) %>% 
  group_by(Country) %>% 
  slice(which.max(Reporting_Date)) %>% 
  group_by(Region) %>% 
  mutate(Cum_cases_region = sum(Cum_cases),
         Cum_deaths_region = sum(Cum_deaths),
         Population = sum(Population)) %>% 
  slice(which.max(Reporting_Date)) %>% 
  rename(Cases = Cum_cases_region, Deaths = Cum_deaths_region) %>% 
  mutate(`Crude \nCFR (%)` = round(100 * Deaths / Cases, digits = 1)) %>% 
  mutate(`Cases per million` = (Cases / Population) * 1e6,
         `Deaths per million` = (Deaths / Population) * 1e6) %>% 
  dplyr::select(Region, Cases,`Cases per million`, Deaths, `Deaths per million`) %>% 
  arrange(-Cases) %>% 
  ungroup()


# Import and merging Africa map from natural earth package (including small insular countries)
africa_map <- subset(rnaturalearthdata::countries50,
                     region_un == "Africa" & type == "Sovereign country")

# Extracting centroids
centroids_df <- data.frame(coordinates(africa_map)) %>%
  rename(X = X1,
         Y = X2)

# Inserting centroids into continental map
africa_union <- cbind(africa_map, centroids_df)

# join africa geoms with the COVID info about countries
africa_map <- africa_union %>% 
  st_as_sf() %>% 
  st_set_crs(4326) %>%
  mutate(name_long = case_when(name_long == "Cape Verde" ~ "Cabo Verde",
                               TRUE ~ name_long)) %>%
  rename(Country = name_long) %>%
  left_join(all_country_tab, by = "Country")

# Inserting breaks for choropleth maps

africa_map <- africa_map %>%
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



# Risk map
# defining wihch country to analyze
my_country <- "Burkina Faso"

# Import and merging Africa map from natural earth package (including small insular countries)
# will be used to extract code to automatically import risk mapping files
africa <- subset(rnaturalearthdata::countries50, 
                 region_un == "Africa" & type == "Sovereign country") %>%
  # removing geometries
  as_tibble() %>%
  # selecting only countries and iso_code
  select("admin", "adm0_a3")

# selecting correct iso_code
iso_code_aux <- africa %>%
  filter(admin %in% my_country) %>%
  pull()

####################################
##      importing dictionary      ##
####################################

# importing dictionary of correct/incorrect names 
my_country_dict <- str_replace(str_to_lower(my_country), " ", "_")

dict <- read.csv2(paste0("Others/",my_country,"/dict_", my_country_dict, ".csv"), encoding = "UTF-8") %>%
  setNames(c("incorrect", "correct", "admin_lvl"))

##############################
##      importing gpkg      ##
##############################

# Reading gpkg with region polygons
df_gpkg <- readOGR(paste0("Others/",my_country,"/Burkina_Faso_gadm36_BFA.gpkg"),
                   layer = paste0("gadm36_", iso_code_aux, "_1"), 
                   encoding = "UTF-8", 
                   use_iconv = TRUE) %>%
  st_as_sf() %>%
  mutate(NAME_1 = str_to_title(NAME_1))

##################################################
##      Importing risk mapping result files     ##
##################################################

# importing risk mapping result files: Mortality Risk Index for admin level 1
df_MRI_adm01 <- read.csv(paste0("Others/",my_country,"/BFA_adm01_MRI.csv")) %>%
  mutate(Region = str_to_title(Region),
         Region = stringi::stri_encode(Region, from = "UTF-8", to = "UTF-8")) %>%
  as_tibble()

# importing risk mapping result files: Transmission Risk Index for admin level 1
df_TRI_adm01 <- read.csv(paste0("Others/",my_country,"/BFA_adm01_TRI.csv")) %>%
  mutate(patinfo_resadmin1 = str_to_title(patinfo_resadmin1),
         patinfo_resadmin1 = stringi::stri_encode(patinfo_resadmin1, from = "UTF-8", to = "UTF-8")) %>%
  as_tibble()


############################################################################
##      standardizing the admin lvl 1 names in the risk mapping file      ##
############################################################################

# testing if the resadmin1 names in the risk mapping file are correct or not
TRI_incorrect <- df_TRI_adm01$patinfo_resadmin1 %in% str_to_title(dict$incorrect)[dict$admin_lvl == "risk"]

MRI_incorrect <- df_MRI_adm01$Region %in% str_to_title(dict$incorrect)[dict$admin_lvl == "risk"]

# run to see if there are errors; if you run into errors, dictionary should be manually updated
# df_TRI_adm01$patinfo_resadmin1[TRI_incorrect == "FALSE"]
# df_MRI_adm01$Region[MRI_incorrect == "FALSE"]

# Loop to test individually if each patinfo_resadmin1 entry is correct or not
df_TRI_adm01$resadmin1_correct <- NA_character_
df_MRI_adm01$resadmin1_correct <- NA_character_

for(i in seq_along(df_TRI_adm01$patinfo_resadmin1)){
  if(TRI_incorrect[i] == TRUE) {
    index <- str_to_title(dict$incorrect) %in% df_TRI_adm01$patinfo_resadmin1[i]
    df_TRI_adm01$resadmin1_correct[i] <- dict$correct[dict$admin_lvl == "risk" & index == TRUE]
  }
}

for(i in seq_along(df_MRI_adm01$Region)){
  if(MRI_incorrect[i] == TRUE) {
    index <- str_to_title(dict$incorrect) %in% df_MRI_adm01$Region[i]
    df_MRI_adm01$resadmin1_correct[i] <- dict$correct[dict$admin_lvl == "risk" & index == TRUE]
  }
}

######################################################################
##      Merging my_country daily gpkg with risk mapping results     ##
######################################################################

# a spatial df for the Mortality Risk Index (only for admin lvl 1)
df_risk_MRI_1 <- df_gpkg %>%
  st_as_sf() %>%
  # joining gpkg with MRI results for admin lvl 1
  full_join(df_MRI_adm01, by = c("NAME_1" = "resadmin1_correct"))

# a daily spatial df for the Transmission Risk Index (for admin lvl 1)
df_risk_TRI_1 <- df_gpkg %>%
  st_as_sf() %>%
  # joining gpkg with MRI results for admin lvl 1
  full_join(df_TRI_adm01, by = c("NAME_1" = "resadmin1_correct"))

######################################################################
##      Creating breaks and palletes for risk mapping leaflets      ##
######################################################################

# breaks and palletes for Transmission Risk Indexes
df_risk_TRI_1 <- df_risk_TRI_1 %>%
  mutate(TRI_RIDX_quintile = cut(TRI_RIDX, 
                                 unique(quantile(df_risk_TRI_1$TRI_RIDX, 
                                                 probs = seq(0, 1, length.out = 6), na.rm = TRUE)), 
                                 include.lowest = TRUE),
         TRI_IDX_quintile = cut(TRI_IDX, 
                                unique(quantile(df_risk_TRI_1$TRI_IDX, 
                                                probs = seq(0, 1, length.out = 6), na.rm = TRUE)), 
                                include.lowest = TRUE),
         TRI_IDX2_quintile = cut(TRI_IDX2, 
                                 unique(quantile(df_risk_TRI_1$TRI_IDX2, 
                                                 probs = seq(0, 1, length.out = 6), na.rm = TRUE)), 
                                 include.lowest = TRUE))

# creating palletes for Transmission Risk Indexes
pallete.TRI_RIDX <- colorFactor(palette = "YlOrRd", df_risk_TRI_1$TRI_RIDX_quintile)
pallete.TRI_IDX <- colorFactor(palette = "YlOrRd", df_risk_TRI_1$TRI_IDX_quintile)
pallete.TRI_IDX2 <- colorFactor(palette = "YlOrRd", df_risk_TRI_1$TRI_IDX2_quintile)


# breaks and palletes for Mortality Risk Indexes
df_risk_MRI_1 <- df_risk_MRI_1 %>%
  mutate(MRI_RIDX_quintile = cut(MRI_RIDX, 
                                 unique(quantile(df_risk_MRI_1$MRI_RIDX, 
                                                 probs = seq(0, 1, length.out = 6), na.rm = TRUE)), 
                                 include.lowest = TRUE),
         MRI_RIDX2_quintile = cut(MRI_RIDX2, 
                                  unique(quantile(df_risk_MRI_1$MRI_RIDX2, 
                                                  probs = seq(0, 1, length.out = 6), na.rm = TRUE)), 
                                  include.lowest = TRUE),
         MRI_IDX_quintile = cut(MRI_IDX, 
                                unique(quantile(df_risk_MRI_1$MRI_IDX, 
                                                probs = seq(0, 1, length.out = 6), na.rm = TRUE)), 
                                include.lowest = TRUE))

# creating palletes for Mortality Risk Indexes
pallete.MRI_RIDX <- colorFactor(palette = "YlOrRd", df_risk_MRI_1$MRI_RIDX_quintile)
pallete.MRI_RIDX2 <- colorFactor(palette = "YlOrRd", df_risk_MRI_1$MRI_RIDX2_quintile)
pallete.MRI_IDX <- colorFactor(palette = "YlOrRd", df_risk_MRI_1$MRI_IDX_quintile)

###################################################
##                                               ##
##      SETTING COLOR THEME FOR RColorBrewer     ##
##        NEEDED TO AVOID ERROR IN PLOTLY        ##
##                                               ##
###################################################

# Define the number of colors to prevent error in plots
nb.cols_2 <- length(unique(df_gpkg$NAME_1))
mycolors_2 <- colorRampPalette(brewer.pal(8, "Set3"))(nb.cols_2)




