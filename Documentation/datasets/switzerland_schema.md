
## Switzerland COVID-19 data

In the  `switzerland` schema, we have data related to this country. So far, the tables available are related to the COVID-19 and stratified by canton<sup>1</sup>. They were provided by the FOPH<sup>2</sup>. In the table below, we have a brief description of the content of each table. For each of them, we have another table named `{dataset_name}_meta` that contains an explanation of the columns in the dataset.

For example, in the `switzerland` schema, we have a table called `foph_cases_d` that represents the daily records timelines for cases in each canton of Switzerland. The meaning of the columns of this table are explained in the `foph_cases_d_meta` dataset.

> The `georegion` column is a two-letter code representing the cantons of Switzerland. 

| Table name  | Keys | Content | Source | 
| :----: | :-----:  | :--------: | :----: |
| foph_cases_d | `date`, `georegion` | Daily record timelines by georegion for cases. | FOPH<sup>2</sup> |
| foph_casesvaccpersons_d | `date`, `georegion` | Daily record timelines for cases of fully vaccinated persons by vaccine. Data only available for georegion CHFL. This file has been deprecated and will no longer be updated after 11.11.2021. | FOPH<sup>2</sup> |
| foph_covidcertificates_d | `date`, `georegion` | Daily record timelines for cases of fully vaccinated persons by vaccine. Data only available for georegion CHFL. This file has been deprecated and will no longer be updated after 11.11.2021. | FOPH<sup>2</sup> |
| foph_death_d | `date`, `georegion` | Daily record timelines by georegion for deaths. | FOPH<sup>2</sup> |
| foph_deathvaccpersons_d | `date`, `georegion` | Daily record timelines for deaths of fully vaccinated persons by vaccine. Data only available for georegion CHFL. | FOPH<sup>2</sup> |
| foph_hosp_d | `date`, `georegion` | Daily record timelines by georegion for hospitalisations. | FOPH<sup>2</sup> |
| foph_hospcapacity_d | `date`, `georegion` | Daily hospital capacity data timelines by georegion. | FOPH<sup>2</sup> |
| foph_hospcapacitycertstatus_d | `date`, `georegion` | Daily hospital capacity data timelines of certified/ad-hoc status of operational ICU beds by georegion. | FOPH<sup>2</sup> |
| foph_hospvaccpersons_d | `date`, `georegion` | Daily record timelines for hospitalisations of fully vaccinated persons by vaccine. Data only available for georegion CHFL. | FOPH<sup>2</sup> |
| foph_intcases_d | `date`, `georegion` | International daily data (cases). This file has been deprecated and will no longer be updated after 05.04.2022. | FOPH<sup>2</sup> |
| foph_re_d   | `date`, `georegion` |  Reproductive number for the cantons in Switzerland       | FOPH<sup>2</sup> |
| foph_test_d  | `date`, `georegion` | Daily record timelines by georegion for tests (all test types combined). | FOPH<sup>2</sup> |
| foph_testpcrantigen_d  | `datum`, `georegion` | Daily record timelines by georegion and test type (pcr/antigen) for tests. | FOPH<sup>2</sup> |


> **canton<sup>1</sup>** - refers to a political division of Switzerland. 

> **FOPH<sup>2</sup>** - Federal Office of Public Health

