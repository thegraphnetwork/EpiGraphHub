#############################################
#
#     Map & Transform Data
#     raw -> clean
#
#     Exemplary Model to Follow
#
#     Country:
#     Columbia 
#
#############################################

# Install pkgs
library(lubridate)
library(stringr)
library(ISOcodes)
# Load utility functions
#source("~/data-cleaning/notebooks/utils/utils.R")


# --------------------------------------
# initialize
clean_columns = list()

# --------------------------------------
# map variables 

clean_columns[['patinfo_ID']] = function(df) as.character(df$id_de_caso)
# Anonymized patient ID, convert to character string (some countries include letters in the ID)
# ** Lots of empty IDs in this column. I'm not sure what these mean

clean_columns[['report_date']] = function(df){
  return(dmy(str_replace(df$fecha_reporte_web, '[0]\\:[0]{2}\\:[0]{2}', "")))
} 
# Date of notification (line), character, YYYY-MM-DD

#clean_columns[['name_first']] = keep_empty
#clean_columns[['name_last']] = keep_empty
# Names, keep empty

clean_columns[['patinfo_ageonset_years']] = function(df) {
  return(as.numeric(df$edad))
}
# Age at intake in years, 0 for infants < 12 months, numeric
# ** Ghana is simply using the ageonset column as an age in years column


#clean_columns[['patinfo_ageonset_months']] = function(df) { 
#  return(format(as.numeric(as.character(df[,'patinfo_ageonset']))))
#}
# Age at intake in months for < 2 years old, 0 for newborns, NA > 23 months (2 years old), numeric
# ** Ghana is simply using the ageonset unit column as an age in months column

clean_columns[['patcourse_status']] =  function(df){
  case_when(
    str_detect(df$recuperado, '[Ff]allecido')~'DEAD',
    str_detect(df$recuperado, 'Activo')~'ALIVE',
    str_detect(df$recuperado, 'Recuperado')~'RECOVERERED',
    TRUE ~ NA_character_
  )
}
# Patient's clinical outcome, ALIVE/DEAD/RECOVERED, factor
# Alive means an ongoing active case; This does not indicate confirmation of case, only patient outcome regardless of classification

clean_columns[['patinfo_sex']] = function(df) return(toupper(df$sexo))
# M/F, factor

clean_columns[['patinfo_resadmin1']] = function(df) return(toupper(df$nombre_departamento))
# Patient residence (province), Standardize names to all uppercase, factor

clean_columns[['patinfo_resadmin2']] = function(df) return(toupper(df$nombre_municipio))
# Patient residence (district), Standardize names to all uppercase, factor

#clean_columns[['patinfo_occus']] = function(df) { 
#  medicalterms <- "medical|health|doctor|physician"
  # any occupations containing medical terms coded as Y
#  cleaned <- ifelse(grepl(medicalterms, df$patinfo_occus, ignore.case = T), "Y", df$patinfo_occus)
  # all other filled-in occupations as N. NAs will remain NAs
#  cleaned <- ifelse(grepl("[A-Za-z]", df$patinfo_occus) & # filled in
#                   !grepl(medicalterms, df$patinfo_occus, ignore.case = T) # but no medical terms
#                    ,"N", cleaned)
#  return(cleaned)
#} 
# Patient occupation is healthcare worker?, Y/N, factor

#clean_columns[['patinfo_occus_specify']] = function(df) return(df$patinfo_occus)
# Patient occupation, character string (factor)

clean_columns[['expo_travel']] =  function(df){return(ifelse(df$tipo_de_contagio == 'Importado', 'Y', 'N'))}
# Patient history of travel?, Y/N, factor

clean_columns[['expo_travel_country']] = function(df){
 return(str_to_upper(countrycode::countrycode(as.character(df$codigo_iso_del_pais), origin = 'genc3n', destination = 'country.name')))
  }
# Country(ies) patient travelled to, character string (comma-separated list)

#clean_columns[['expo_date_departure']] = 
  # Date departed from country visited / Date retuned from country visited, date, YYYY-MM-DD
  #** Ghana has a couple of errors in thic column. And it is only filled in for three rows.
  #** Not worth manipulating. This might change
  
  clean_columns[['pat_symptomatic']] = function(df) { 
    return(ifelse(!is.na(df$fecha_de_inicio_de_sintomas), 'Y', 'N'))
  }
# Does the patient present with current or past history of symptoms?, Y/N, factor
# should be variable 'pat_symptomatic' otherwise, use boolean ifelse (any=1,Y) (all=0,N) (negative & missing data,NA)


clean_columns[['pat_contact']] = function(df){
  return(ifelse(df$tipo_de_contagio =='Relacionado', 'Y', 'N' ))
}
# Has the patient had close contact with a probable or confirmed case?, Y/N, factor
# This is/should be redundant with 'expo_contact_case';
# But it is ambiguous, so prioritize 'expo_contact_case'

clean_columns[['patcourse_dateonset']] = function(df){
  return(dmy(str_replace(df$fecha_de_inicio_de_sintomas, '[0]\\:[0]{2}\\:[0]{2}', "")))
}
# Date of onset of symptoms,  date, YYYY-MM-DD
# NA if no symptoms
# check that this is not identical to other dates (eg, 'report_date')
# ** Ghana has a bunch of different date types in this column. 


#clean_columns[['expo_sourcecaseids']] = function(df) paste(df$expo_ID1, df$expo_ID2,df$expo_ID3,df$expo_ID4,sep=",")
# Confirmed case ID(s) to which patient was exposed, character string (comma-separated list)
# Renamed from WHO template

clean_columns[['patcourse_severity']] = function(df){
 return(case_when(
    str_detect(df$estado,'[Gg]rave')~'SEVERE',
    str_detect(df$estado,'[Ll][Ee][Vv][Ee]')~'MILD',
    str_detect(df$estado, 'Moderado')~'MODERATE',
    TRUE~NA_character_
  ))
}
# COVID19 case severity classification, MILD/MODERATE/SEVERE/CRITICAL, factor
# ** Not available in Ghana file 

#clean_columns[['report_classif']] = function(df) {
#  return ( ifelse(df$Lab_result == "Pending", "RESULTS PENDING",toupper(df$report_classif)))
#}
# COVID19 case classification, SUSPECTED/PROBABLE/CONFIRMED/NOT A CASE/RESULTS PENDING,
# factor

clean_columns[['patcourse_datedeath']] = function(df){
  return(dmy(str_replace(df$fecha_de_muerte, '[0]\\:[0]{2}\\:[0]{2}', "")))}
# Date of Death for deceased patients, date, YYYY-MM-DD, NA if Alive

#clean_columns[['patinfo_resadmin3']] = function(df){return(NA)}
# Place of residence admin level 3 (Health Zone/Town), factor

#clean_columns[['patinfo_resadmin4']] = function(df){return(NA)}
# Place of residence admin level 4 (Village), factor
# ** Keep empty for now, as some addresses are full addresses. Not anonymous. 

#clean_columns[['report_orginst']] = function(df){return(df$report_orginst)}
# Reporting health facility/institution, factor

#clean_columns[['patinfo_idadmin1']] = function(df){return(df$patinfo_idadmin1)}
# Where the case was diagnosed, admin level 1 (Province), factor

#clean_columns[['patinfo_idadmin2']] = function(df){return(df$patinfo_idadmin2)}
# Where the case was diagnosed, admin level 2 (District), factor

#clean_columns[['report_pointofentry']] = yes_no_clean('report_pointofentry')
# Detected at point of entry (eg, border crossing, airport)?, Y/N, factor


#clean_columns[['report_pointofentry_date']] = multiple_date_types('report_pointofentry_date')
# Date detected at point of entry, date, YYYY-MM-DD
# ** Several date formats in the raw df

clean_columns[['consultation_dateHF']] =  function(df){
  return(dmy(str_replace(df$fecha_de_notificacion, '[0]\\:[0]{2}\\:[0]{2}', "")))
}
# Date of first consultation at this Health Facility, date, YYYY-MM-DD
# ** Several date formats in the raw df

#clean_columns[['patcourse_admit']] = yes_no_clean('patcourse_admit')
# Admission to hospital?, Y/N, factor

#clean_columns[['patcourse_presHCF']] = clean_numeric_dates('patcourse_presHCF')

#clean_columns[['patcourse_comp']] = function(df){return(df$patcourse_comp)}
# Other clinical complications, character string (comma-separated list)

#clean_columns[['patsympt_fever']] = function(df){ 
#  cleaned <- yes_no_clean('patsympt_fever')(df)
#  return(cleaned)
#}
  
# History of fever or chills?, Y/N, factor

#clean_columns[['patsympt_sorethroat']] = function(df){ 
#  cleaned <- yes_no_clean('patsympt_sorethroat')(df)
#  cleaned[which(cleaned=="LEKMA")] <- NA #** weird value in Ghana's file
#  return(cleaned)
#}
# History of sore throat?, Y/N, factor

#clean_columns[['patsympt_cough']] = function(df){ 
#  cleaned <- yes_no_clean('patsympt_cough')(df)
#  cleaned[which(cleaned=="LEKMA")] <- NA #** weird value in Ghana's file
#  return(cleaned)
#}
# History of cough?, Y/N, factor
#clean_columns[['patsympt_runnynose']] = function(df){ 
#  cleaned <- yes_no_clean('patsympt_runnynose')(df)
#  cleaned[which(cleaned=="LEKMA")] <- NA #** weird value in Ghana's file
#  return(cleaned)
#}
# History of runny nose?, Y/N, factor

#clean_columns[['patsympt_short']] = function(df){ 
#  cleaned <- yes_no_clean('patsympt_short')(df)
#  cleaned[which(cleaned=="LEKMA")] <- NA #** weird value in Ghana's file
#  return(cleaned)
#}
# History of shortness of breath?, Y/N, factor

#clean_columns[['patsympt_other']] = function(df){
#  cleaned <- yes_no_clean('patsympt_other')(df)
#  cleaned[which(cleaned %in% c("N/A","NA"))] <- NA 
#  return(cleaned)
#}
# Other signs or symptoms, character string (comma-separated list)

#clean_columns[['Comcond_preexist1']] = yes_no_clean('Comcond_preexist1')
# Patient has pre-existing conditions?, Y/N, factor

#clean_columns[['Comcond_preexist']] = function(df){return(df$Comcond_preexist)}
# Patient's pre-existing conditions, character string (comma-separated list)

#clean_columns[['expo_visit_healthcare']] = yes_no_clean('expo_visit_healthcare')
# Has patient visited any healthcare facility in the 14 days prior to symptom onset?, Y/N, factor

#clean_columns[['expo_ari']] = yes_no_clean('expo_ari')
# Has patient had close contact with a person with acute respiratory infection
# in the 14 days prior to symptom onset?, Y/N, factor
# ** Not available in Ghana file

#clean_columns[['expo_aricontsetting']] = function(df){
#  cleaned <- yes_no_clean('expo_aricontsetting')(df)
#  cleaned[which(cleaned == "N")] <- NA #** No is a nonsensical response here
#  return(cleaned)
#}
# Setting where the patient had close contact with a person
# with acute respiratory infection, character string, factor

#clean_columns[['expo_other']] = function(df){return(df$expo_other)}
# Other exposures, character string (comma-separated list)
# ** Empty for the Ghana file

clean_columns[['expo_contact_case']] = function(df){
  return(ifelse(df$tipo_de_contagio =='Relacionado', 'Y', 'N' ))
}
# Has the patient had contact with a probable or confirmed case?, Y/N, factor
# KEEP THIS COLUMN (Redundant with 'pat_contact')

#clean_columns[['expo_ID1']] = function(df){return(df$expo_ID1)}
# ID of confirmed or probable case 1, numeric
# ** Very sparse for Ghana. And inconsistent value types. Probably will be useless

#clean_columns[['expo_ID2']] = function(df){return(df$expo_ID2)}
# ID of confirmed or probable case 2, numeric
# ** Very sparse for Ghana. And inconsistent value types. Probably will be useless

#clean_columns[['expo_ID3']] = function(df){return(df$expo_ID3)}
# ID of confirmed or probable case 3, numeric
# ** Very sparse for Ghana. And inconsistent value types. Probably will be useless

#clean_columns[['expo_ID4']] = function(df){return(df$expo_ID3)}
# ID of confirmed or probable case 4, numeric
# ** Very sparse for Ghana. And inconsistent value types. Probably will be useless

clean_columns[['expo_arisetting']] = function(df){
   return(
     case_when(
       str_detect(df$ubicacion_del_caso,'[Cc][Aa][Ss][Aa]')~'HOME',
       str_detect(df$ubicacion_del_caso,'Hospital')~'HOSPITAL',
       TRUE~NA_character_
       
               )
   )
  } 
# Setting where exposure to confirmed or probable case(s) occurred,
# character string (comma-separated list)
#** this column is a mess in Ghana. This is my attempt to make sense of it

#clean_columns[['Lab_coll']] = yes_no_clean('Lab_coll')
# COVID19 lab sample collected?, Y/N, factor

#clean_columns[['Lab_type']] = function(df){return(toupper(df$Lab_type))}
# COVID19 lab sample type, NASOPHARYNGEAL SWAB/SALIVA/BLOOD/STOOL, factor
# ** Messy in the Ghana file. I am not bothering to recode this. Analysts can decide on recoding conventions

#clean_columns[['Lab_datetaken']] = multiple_date_types('Lab_datetaken')
# Date when COVID19 Lab sample was taken, date, MM/DD/YYYY

#clean_columns[['Lab_performed']] = function(df){return(toupper(df$Lab_performed))}
# What type of lab analysis was performed?, PCR/RDT/ANTIBODY SEROLOGY, factor

#clean_columns[['Lab_result']] = function(df){return(toupper(df$Lab_result))}
# Result of lab analysis performed, POSITIVE/NEGATIVE/INCONCLUSIVE/AWAITING RESULTS, factor

clean_columns[['Lab_resdate']] = function(df){return(dmy(str_replace(df$fecha_de_diagnostico, '[0]\\:[0]{2}\\:[0]{2}', "")))}
# Date when COVID19 Lab result was returned, date, MM/DD/YYYY

#clean_columns[['Lab_other']] = function(df){return(df$Lab_other)}
# Other lab sample(s), character string (comma-separated list)

#clean_columns[['lab_other_samples_result_list']] = function(df){return(df$lab_other_samples_result_list)}
# Other lab sample result(s), character string (comma-separated list)

#clean_columns[['patcourse_datedischarge']] = function(df){return(dmy(str_replace(df$fe, '[0]\\:[0]{2}\\:[0]{2}', "")))}
# Date when patient was discharged (if alive and hospitalized), date, MM/DD/YYYY
# sanity check: be sure all patients with datedischarge are also alive and were hospitalized
