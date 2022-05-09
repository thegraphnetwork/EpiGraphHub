
## Colombian COVID-19 data
This dataset is located in the `colombia` schema.

In the  `colombia` schema, we currently have 3 tables related to this country. So far, the available data are related to the COVID-19 and stratified by departamento<sup>1</sup>. They were provided by the **Instituto Nacional de Salud<sup>2</sup>**. In the table below, we have a brief description of the content of each table. For each of them, we have another table named `{dataset_name}_meta` that contains an explanation of the columns in the table.

For example, in the `colombia` schema, we have a table called `casos_positivos_covid` that represents the daily records timelines for positive cases in each `departamento`<sup>1</sup> of Colombia. The meaning of the columns of this table are explained in the `casos_positivos_covid_meta` table.

| Table name  | Keys |                                                                                                                     Content                                                                                                                     | Source | 
| :----: | :-----:  |:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:| :----: |
| casos_positivos_covid | `fecha_reporte_web` |         This dataset contains the individual data of positive cases in Colombia including informations as sex, age, date of first symptons, date of report, disease severity and date of death of individuals that died of the disease.         | Instituto Nacional de Salud<sup>2</sup>  |
| casos_covid_agg_m  | `fecha_inicio_sintomas` |     This dataset contains the monthly aggregation of the positive cases by the date of first symptoms considering the sex, age group, departamento, and disease severity. This dataset was created using the table `casos_positivos_covid`.     | Epigraphhub<sup>3</sup> |
| casos_covid_agg_m  | `fecha_muerte` | This table contains the monthly aggregation of the positive cases that died, considering the sex, age group, departamento, and disease severity. This table was created using the table `casos_positivos_covid` and the date of death as the index. | Epigraphhub<sup>3</sup> |

> **departamento<sup>1</sup>** - refers to a political division of Colombia. 

> **Instituto Nacional de Salud<sup>2</sup>** - https://www.datos.gov.co/Salud-y-Protecci-n-Social/Casos-positivos-de-COVID-19-en-Colombia/gt2j-8ykr/data 

> **Epigraphhub<sup>3</sup>** - It means that the dataset was created by one of the epigraphhub analysts using another dataset available on the platform. 



