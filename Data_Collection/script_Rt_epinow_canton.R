### Reading packages ------------------------------

library(pacman)

p_load(char = c("tidyverse",
                "RPostgreSQL",
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
con <- dbConnect(
  PostgreSQL(),
  host = 'localhost',
  port = 5432,
  user = 'epigraph',
  password = 'epigraph',
  dbname = "epigraphhub"
  )


### Querying FOPH cases database ------------------------------
df <- dbGetQuery(con, "SELECT datum, \"geoRegion\", entries FROM switzerland.foph_cases")

df <- df %>% 
  mutate(datum = as.Date(datum)) %>% 
  as_tibble()


### Important definitions ------------------------------

# Defining canton of interest
unique(df$geoRegion)

my_canton <- "CH"


# Defining period of interest (default to last 4 weeks of data)
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

# Subsetting linelist to my_canton
reported_cases <- df %>% 
  filter(geoRegion == my_canton,
         datum >= my_period) %>% 
  group_by(datum) %>% 
  summarise(entries = sum(entries, na.rm = TRUE)) %>% 
  complete(datum = seq.Date(my_period, max(df$datum), by = "day")) %>% 
  select(datum, entries) %>% 
  rename(date = datum,
         confirm = entries)


### Running model (it may take a while) ------------------------------
estimates <- epinow(reported_cases = reported_cases, 
                    generation_time = generation_time,
                    delays = delay_opts(incubation_period, reporting_delay),
                    horizon = 7,
                    rt = rt_opts(prior = list(mean = 2, sd = 0.2)),
                    stan = stan_opts(samples = 2000, warmup = 250, chains = 4, cores = 8),
                    verbose = TRUE)


### Summary of estimates ------------------------------
summary(estimates)

summary(estimates, type = "parameters", params = "R")


### Plotting model output ------------------------------

# Reported cases
plot(estimates$plots$reports) +
  ggtitle(label = my_canton,
          subtitle = paste0("Estimates using data from the last ", interval, " days", "\n",
                            estimates$summary$measure[1], ": ", estimates$summary$estimate[1], "\n",
                            estimates$summary$measure[2], ": ", estimates$summary$estimate[2]))

# Rt
plot(estimates$plots$R) +
  ggtitle(label = my_canton,
          subtitle = paste0("Estimates using data from the last ", interval, " days", "\n",
                            estimates$summary$measure[2], ": ", estimates$summary$estimate[2], "\n",
                            estimates$summary$measure[3], ": ", estimates$summary$estimate[3]))



# Next: compare to FOPH estimates?

df_rt <- dbGetQuery(con, "SELECT date, \"geoRegion\", \"median_R_mean\" 
                    FROM switzerland.foph_re 
                    WHERE \"geoRegion\" = 'CH' AND date >= '2021-12-13' 
                    ORDER BY date ASC") 

df_rt %>% 
  left_join(summary(estimates, type = "parameters", params = "R") %>% 
              as_tibble() %>% 
              select(date, type, median))

