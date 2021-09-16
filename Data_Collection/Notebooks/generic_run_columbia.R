#############################################
#
#   IGH WHO Africa COVID-19 Assistance Working Group
#
#   Data Cleaning (Pre-analysis) Script
#
#   Generic cleaning code
#
#############################################
# if creating new map, set country:




cleaning_run = function(url) {
  # This function runs all the necessary cleaning code
  # for a given country (parameter) 
  #############################################
  # Load Libraries ############################
  #############################################
  library(vroom)
  library(readxl)
  library(DescTools)
  library(here)
  library(glue)
  library(janitor)
  library(tidyverse)
  library(here)
  
  # -----------------------------------------------------------------------------
  # Define the country-specific mappings and transformations
  # This is the only country-specific code and is loaded from a separate file
  
  # Get the xlsx params
  #source(here("notebooks/utils", "xlsx_params.R"))
  
  #############################################
  # Load Raw Data, Convert to CSV #############
  #############################################
  
  # Read excel file and use parameters according to countries
  # path <- "~/data-cleaning/data/"
  # params = get_excel_params(country)
  # raw.xl.file <- paste(path,country,"/",country,params[3],sep="")
  # raw <- read_excel(raw.xl.file,sheet=as.numeric(params[1]),skip=as.numeric(params[2]))
  
  # # When we are ready to load files from master with dates attached
  #params = get_excel_params(country)
  #path.name <- paste("./data-cleaning/data/",country,"/",sep="")
  #latest.report.date<-max(as.Date(gsub(params[3],"",gsub(paste(country,"_",sep=""),"",list.files(path.name))),"%Y_%m_%d"),na.rm=T)
  #(latest_report_date <- gsub("-","_",as.character(latest.report.date)))
  #raw.xl.file.name<-paste(path.name,country,"_",latest_report_date,params[3],sep="")
  #if(is.na(params[4])==TRUE){raw <- read_excel(raw.xl.file.name,sheet=as.numeric(params[1]),skip=as.numeric(params[2]))}
  #if(is.na(params[4])==FALSE){raw <- read_excel(raw.xl.file.name,sheet=as.numeric(params[1]),skip=as.numeric(params[2]),col_types = params[4])}
  
  # Load files with dates on the file name 
  
  
  raw <-vroom(url)
  raw <- raw %>% clean_names()
  raw <- as.data.frame(raw)
  
  # CHANGE TIBBLE TO DATA FRAME! PHEW!
  
  
  
  
  # clean up raw xlxs column names 
  colnames(raw) = colnames(raw)
  
  
  
  
  #############################################
  # Clean Data ################################
  #############################################
  # Map raw data columns to clean data columns, format data
  
  # -------------
  # Load raw data if not already loaded
  # raw <- read.csv(XXXX.csv, check.names=F)
  
  # ---------------------------
  # Set-up the target dataframe
  
  # Define column names for the cleaned dataframe
  cols <- c('patinfo_ID', 'report_date', 'name_first', 'name_last', 'patinfo_ageonset_years', 'patinfo_ageonset_months', 'patcourse_status', 'patinfo_sex', 'patinfo_resadmin1'
            , 'patinfo_resadmin2', 'patinfo_occus','patinfo_occus_specify', 'expo_travel', 'expo_travel_country', 'expo_date_departure', 'pat_symptomatic', 'pat_contact'
            , 'patcourse_dateonset', 'expo_sourcecaseids', 'patcourse_severity', 'report_classif', 'patcourse_datedeath', 'patinfo_resadmin3', 'patinfo_resadmin4'
            , 'report_orginst', 'patinfo_idadmin1', 'report_idadmin2', 'report_pointofentry', 'report_pointofentry_date', 'consultation_dateHF'
            , 'patcourse_admit', 'patcourse_presHCF', 'patcourse_comp', 'patsympt_fever', 'patsympt_sorethroat', 'patsympt_cough', 'patsympt_runnynose'
            , 'patsympt_short', 'patsympt_other', 'Comcond_preexist1', 'Comcond_preexist', 'expo_visit_healthcare', 'expo_ari','expo_aricontsetting'
            , 'expo_other', 'expo_contact_case', 'expo_ID1', 'expo_ID2', 'expo_ID3', 'expo_ID4', 'expo_arisetting'
            , 'Lab_coll', 'Lab_type', 'Lab_datetaken', 'Lab_performed', 'Lab_result', 'Lab_resdate', 'Lab_other', 'Lab_otherres', 'patcourse_datedischarge')
  
  # Generate a dataframe with the necessary columns
  clean <- data.frame(matrix(ncol = length(cols), nrow = nrow(raw)), row.names=NULL, check.names=F)
  colnames(clean)<-cols
  
  # -----------------------------------------------------------------------------
  # Define the country-specific mappings and transformations
  # This is the only country-specific code and is loaded from a separate file
  
  source(here("Data_Collection/Notebooks", "map_columbia.R" ))
  
  
  # --------------------------------------
  # Apply the mappings and transformations
  
  # Apply mappings and transformations
  for(column in names(clean_columns)){
    print(paste("Filling column",column))
    clean[,column]=clean_columns[[column]](raw)
  }
  
  # clean <- map_df(clean_columns, ~clean[,.x]= clean_columns[[.x]](raw))
  
  return(clean)
  
}
