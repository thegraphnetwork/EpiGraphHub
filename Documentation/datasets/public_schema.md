
## Public schema

In the `public` schema, we currently have a table with the COVID-19 data made available by the [Our World In Data](https://ourworldindata.org/coronavirus#explore-the-global-situation) project. This table is called `owid_covid`. The meaning of the columns of this table is explained in the `owid_covid_meta` table.

| Table name  | Keys |                                                                                                                     Content                                                                                                                     | Source | 
| :----: | :-----:  |:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:| :----: |
| owid_covid | `date`, `iso_code` |         This dataset contains data regarding COVID-19. This data is available for multiple locations specified in the `iso_code` column by the ISO 3166-1 alpha-3 – three-letter country code.       | [Our World In Data](https://ourworldindata.org/coronavirus#explore-the-global-situation)  |



