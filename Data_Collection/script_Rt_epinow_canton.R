### Reading packages ------------------------------

library(pacman)

p_load(char = c("tidyverse",
                "RPostgreSQL",
                "dotenv",
                "EpiNow2",
                "EpiEstim",
                "lubridate",
                "readxl",
                "janitor",
                "linelist"))


# Create a SSH tunnel to connect to the database ------------------------
# Type the following in your PowerShell
# ssh -f epigraph@epigraphhub.org -L 5432:localhost:5432 -NC


### Connecting to the database and transferring data ------------------------
load_dot_env(file = ".env")

con <- dbConnect(
  PostgreSQL(),
  host = Sys.getenv("POSTGRES_HOST"),
  port = Sys.getenv("POSTGRES_PORT"),
  user = Sys.getenv("POSTGRES_USER"),
  password = Sys.getenv("POSTGRES_PASSWORD"),
  dbname = Sys.getenv("POSTGRES_DB")
  )


### Querying FOPH cases database ------------------------------
df <- dbGetQuery(con, "SELECT datum, \"geoRegion\", entries FROM switzerland.foph_cases") %>% 
  # changing variable class to 'date'
  mutate(datum = as.Date(datum)) %>% 
  as_tibble()


### Important definitions ------------------------------

# Defining canton of interest
# unique(df$geoRegion) # chose between one canton for individual analysis

# my_canton <- "CH"


# Defining period of interest (default to last 14 days of data)
interval <- 14


### Rt estimate ------------------------------

# Various delay/lag distributions as per the Covid-19 examples in the EpiNow2 documentation.
reporting_delay <- estimate_delay(rlnorm(1000,  log(3), 1),
                                  max_value = 15, bootstraps = 1)

# Generation and incubation periods taken from literature
generation_time <- get_generation_time(disease = "SARS-CoV-2", source = "ganyani")

incubation_period <- get_incubation_period(disease = "SARS-CoV-2", source = "lauer")

# Period of analysis
my_period <- max(df$datum) - interval

# Subsetting linelist to my_canton for individual analysis
# reported_cases <- df %>% 
#   filter(geoRegion == my_canton,
#          datum >= my_period) %>% 
#   group_by(datum) %>% 
#   summarise(entries = sum(entries, na.rm = TRUE)) %>% 
#   rename(date = datum,
#          confirm = entries)

# For regional analysis, data must be aggregated by day and canton
reported_regional_cases <- df %>% 
  filter(datum >= my_period) %>% 
  group_by(datum, geoRegion) %>% 
  summarise(entries = sum(entries, na.rm = TRUE)) %>% 
  rename(date = datum,
         confirm = entries,
         region = geoRegion)


### Running model for selected canton (it may take a while) ------------------------------
# estimates <- epinow(reported_cases = reported_cases, 
#                     generation_time = generation_time,
#                     delays = delay_opts(incubation_period, reporting_delay),
#                     horizon = 7,
#                     rt = rt_opts(prior = list(mean = 2, sd = 0.2)),
#                     verbose = TRUE)


### Running regional model for all cantons (it may take a while) ------------------------------
estimates_regional <- regional_epinow(reported_cases = reported_regional_cases, 
                                      generation_time = generation_time,
                                      delays = delay_opts(incubation_period, reporting_delay),
                                      horizon = 7,
                                      rt = rt_opts(prior = list(mean = 2, sd = 0.2)),
                                      verbose = TRUE)

# initial time: 14:17:07
# end time: 14:28:38
# ymd_hms("2022-02-04 14:28:38 -03") - ymd_hms("2022-02-04 14:17:07 -03")
# Time difference of 11.51667 mins

### Summary of estimates for each canton ------------------------------
# regional_summary <- estimates_regional$summary$summarised_results$table %>% 
#   as.data.frame()

### Exporting tables to database ------------------------------

# Exporting Rt
regional_rt <- estimates_regional$summary$summarised_measures$rt %>% 
  as.data.frame()

dbWriteTable(con, c(schema = 'switzerland', table = 'epinow_rt'), value = regional_rt, overwrite = TRUE)

# Exporting Growth Rate
regional_growth_rate <- estimates_regional$summary$summarised_measures$growth_rate %>% 
  as.data.frame()

dbWriteTable(con, c(schema = 'switzerland', table = 'epinow_growth_rate'), value = regional_growth_rate, overwrite = TRUE)

# Exporting Cases by Infection Date
regional_cases_infection <- estimates_regional$summary$summarised_measures$cases_by_infection %>% 
  as.data.frame()

dbWriteTable(con, c(schema = 'switzerland', table = 'epinow_cases_infection'), value = regional_cases_infection, overwrite = TRUE)

# Exporting Cases by Reporting Date
regional_cases_report <- estimates_regional$summary$summarised_measures$cases_by_report %>% 
  as.data.frame()

dbWriteTable(con, c(schema = 'switzerland', table = 'epinow_cases_report'), value = regional_cases_report, overwrite = TRUE)

