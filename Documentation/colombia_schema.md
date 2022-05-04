
## schema = colombia

In the schema `colombia` we have datasets related to this country. Up to now, the datasets available are related to the COVID-19 and stratified by departamento<sup>1</sup>. They were provided by the **Instituto Nacional de Salud**. In the table below, we have a brief description of the content of each dataset. For each of them, we have another dataset named `{dataset_name}_meta` that contains an explanation of the columns in the dataset.

For example, in the schema `colombia` we have a dataset called `casos_positivos_covid` that represents the daily records timelines for positive cases in each `departamento`<sup>1</sup> of Colombia. The meaning of the columns of this dataset are explained in the `casos_positivos_covid_meta` dataset.

**departamento<sup>1</sup>** - refers to a political division of Colombia.

**ATTENTION:**

* `fecha_reporte_web`: Date load web;

* `fecha_de_notificaci_n`: Date of notification;

* `fecha_inicio_sintomas`: Date of first symptons;

* `fecha_muerte`: Date of death. 


| Table name  | Keys | Content | Source | 
| :----: | :-----:  | :--------: | :----: |
| casos_positivos_covid | `fecha_reporte_web` | This dataset contains the individual data of positive cases in Colombia including informations as sex, age, date of first symptons, date of report, disease severity and date of death of individuals that died of the disease. | Instituto Nacional de Salud |
| casos_covid_agg_m  | `fecha_inicio_sintomas` | This dataset contains the monthly aggregation of the positive cases by the date of first symptoms considering the sex, age group, departamento, and disease severity. This dataset was created using the dataset `casos_positivos_covid`. | Epigraphhub<sup>2</sup> |
| casos_covid_agg_m  | `fecha_muerte` | This dataset contains the monthly aggregation of the positive cases that died, considering the sex, age group, departamento, and disease severity. This dataset was created using the dataset `casos_positivos_covid` and the date of death as the index. | Epigraphhub<sup>2</sup> |

Epigraphhub<sup>2</sup> - It means that the dataset was created by one of the epigraphhub analysts using another dataset available on the platform. 



