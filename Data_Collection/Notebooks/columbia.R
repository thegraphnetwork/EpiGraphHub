
library(tidyverse)
library(vroom)
library(RSocrata)
library(glue)
library(janitor)
library(odbc)
library(DBI)
library(dbplyr)
library(here)
library(dm)
# Getting and cleaning the data_--------------------------------------------------------------------------------------------------------------------------------------------- 

# loading the scripts
# source(,'generic_run.R')
link <-'https://www.datos.gov.co/api/views/gt2j-8ykr/rows.csv?accessType=DOWNLOAD'

clean <- generic_run(url = link)


#Connecting to the database and transferring data--------------------------------------------------------------------------------------------------------------------------------



con <- dbConnect( RPostgreSQL::PostgreSQL(),
              host = 'localhost',
              port = 5432,
              user = 'epigraph',
              password = 'epigraph',
              dbname = "epigraphhub")



dbListTables(con)

# Getting the Schema 
dbGetQuery(con,"SELECT table_schema, table_name FROM information_schema.tables WHERE table_name = 'casos_positivos_covid'") 


dbRemoveTable(con, 'casos_positivos_covid')


dbWriteTable(con, SQL('columbia.columbia_covid_data'),clean, overwrite = T)

dbDisconnect(con)

#columbia <- tbl(con, in_schema('colombia', 'casos_positivos_covid')) 

#columbia %>% head() %>% show_query()



#dbAppendTable

#copy_to(con, clean, overwrite = T)


#dbDisconnect(con)





















