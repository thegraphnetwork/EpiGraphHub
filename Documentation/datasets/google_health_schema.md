
## Google COVID-19 data

In the `google_health` schema, we have datasets provided by the **Google COVID-19 Open-Data<sup>1</sup>**. In the table below, we have a brief description of the content of each dataset. For each of them, we have another dataset named `{dataset_name}_meta` that contains an explanation of the columns in the dataset.

For example, in the  `google_health` schema, we have a table called `hospitalizations_d` that contains the information related to patients of COVID-19 and hospitals for the regions in the `location_key`. The meaning of the columns of this dataset are explained in the `hospitalizations_d_meta` table.

> You can find information about the strings used in the `location_key` column of the datasets in the `locality_names_0` dataset.


| Table name  | Keys | Content | Source | 
| :----: | :-----:  | :--------: | :----: |
| covid19_series_by_age_d | `location_key`, `date` | Epidemiology and hospitalizations data stratified by age. | Google COVID-19 Open-Data<sup>1</sup> |
| covid19_series_by_sex_d | `location_key`, `date`  | Epidemiology and hospitalizations data stratified by sex. | Google COVID-19 Open-Data<sup>1</sup> |
| covid19_series_d | `location_key`, `date`  | COVID-19 cases, deaths, recoveries and tests. | Google COVID-19 Open-Data<sup>1</sup> |
| demographics | `location_key`  | Various population statistics. | Google COVID-19 Open-Data<sup>1</sup> |
| economy | `location_key`  | Various economic indicators. | Google COVID-19 Open-Data<sup>1</sup> |
| emergency_declarations_d | `location_key`, `date`  | Government emergency declarations and mitigation policies. | Google COVID-19 Open-Data<sup>1</sup> |
| geography | `location_key`  | Geographical information about the region. | Google COVID-19 Open-Data<sup>1</sup>  |
| government_response_d | `location_key`, `date`  | Government interventions and their relative stringency. | Google COVID-19 Open-Data<sup>1</sup> |
| health | `location_key`  | Health indicators for the region. | Google COVID-19 Open-Data<sup>1</sup> |
| hospitalizations_d | `location_key`, `date`  | Information related to patients of COVID-19 and hospitals. | Google COVID-19 Open-Data<sup>1</sup> |
| locality_names_0 | `location_key` | Various names and codes, useful for joining with other datasets. | Google COVID-19 Open-Data<sup>1</sup> |
| mobility_d | `location_key`, `date`  | Various metrics related to the movement of people.| Google COVID-19 Open-Data<sup>1</sup>|
| search_trends_d | `location_key`, `date`  | Trends in symptom search volumes due to COVID-19. | Google COVID-19 Open-Data<sup>1</sup> |
| vaccinations_access | `location_key`, `date`  | Metrics quantifying access to COVID-19 vaccination sites. | Google COVID-19 Open-Data<sup>1</sup> |
| vaccinations_d | `location_key`, `date`  | Trends in persons vaccinated and population vaccination rate regarding various Covid-19 vaccines.| Google COVID-19 Open-Data<sup>1</sup> |
 | vaccinations_search_d | `location_key`, `date`  | Trends in Google searches for COVID-19 vaccination information.| Google COVID-19 Open-Data<sup>1</sup> |
| weather_d | `location_key`, `date`  | Dated meteorological information for each region. | Google COVID-19 Open-Data<sup>1</sup> |

> **Google COVID-19 Open-Data<sup>1</sup>** - The data was fetched from this repository:  https://github.com/GoogleCloudPlatform/covid-19-open-data



