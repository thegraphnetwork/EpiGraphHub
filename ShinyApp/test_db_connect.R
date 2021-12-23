
library(tidyverse)
library(janitor)
library(RPostgreSQL)

# library(vroom)
# library(RSocrata)
# library(glue)
# library(odbc)
# library(DBI)
# library(dbplyr)
# library(here)
# library(dm)


# ------------------------ Create a SSH tunnel to connect to the database ------------------------
# Type the following in your PowerShell
# ssh -f epigraph@epigraphhub.org -L 5432:localhost:5432 -NC


# shiny_hub_db_public_key
# ------------------------ Connecting to the database and transferring data ------------------------

con <- dbConnect(
  RPostgreSQL::PostgreSQL(),
  host = 'localhost',
  port = 5432,
  user = 'epigraph',
  password = 'epigraph',
  dbname = "epigraphhub"
  )


# --- list of available tables
dbListTables(con)

# --- list of variables in available schemas
dbListFields(con, "iso_alpha3_country_codes")
dbListFields(con, "spatial_ref_sys")
dbListFields(con, "CIV_0")
dbListFields(con, "CIV_1")
dbListFields(con, "CIV_2")
dbListFields(con, "CIV_3")
dbListFields(con, "CIV_4")
dbListFields(con, "caso_full")
dbListFields(con, "data_SARI_16_08_21.csv")
dbListFields(con, "casos_positivos_covid")
dbListFields(con, "owid_covid")

# --- reading whole table and saving to local workspace
df <- dbReadTable(con, "owid_covid")

