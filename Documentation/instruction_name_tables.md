## Database table naming rules

Before uploading a new dataset into the database and creating a new table, the following rules should be followed for naming the table:

### All names (schema name, table name, and column names)
1. Always in lower case; 
2. No space between the characters. Instead of using space, use `_` to separate composite names.
3. Column names should follow the above rules.

### Schema names

If the table is related to a single country data, use the full ISO country name. The name for each country can be found [here](https://gadm.org/maps.html).

If the data is on a global scale data use the schema: `global`.

#### Example: 

For a table that belongs to the United States data, for the schema, should be used the name: `united_states`.


### Table names

Table names should follow this basic structure:

`<locality>_<semantic single word name>_<0|d|w|m>_<optional suffix>`

The symbols `<>` are just delimiters for the placeholder, it means that one of the values inside should be used.

On PostGIS tables, when representing maps, a `gis` prefix should be added. 

The `<locality>` will be filled if the data in the table belongs to a specific administrative region of the country. In this case, you should name the locality according to the nomenclature adopted in [GADM](https://gadm.org/maps.html). You can omit this term if the data refers to the entire region that named the schema, e.g., the whole country.

The `<semantic single word name>` means that the words chosen to represent the data frame must express the content of the table and not be a simple abbreviation of the content. 

The `<0|d|w|m>` portion informs about the periodicity of the update. It should use `d` for daily, `w` for weekly, `m` for monthly, and 0 for static.

The `<optional suffixes>` are: `meta` for metadata tables and `result` for analysis results.

Examples:

- `geneva_hospitalizations_d`
- `geneva_hospitalizations_d_meta`
- `geneva_hospitalizations_forecasts_d_result`

For a PosGIS table representing a map for Geneva, if the map represent new hospitalizations, for example, and is updated daily you can use the name: 
`gis_geneva_new_hospitalizations_d` 


### About metadata tables

The metadata tables should be used to store explanatory information about a table's columns. It should contain at least the columns listed below, but can be enlarged to include other information available on existing data dictionaries for the dataset that is being imported.


```sql
table (
column_name varchar(128),
description text,
type text, # Numeric, categorical, Boolean, date, datetime, etc.
)
```


#### Example:

A dataset of hospitalizations from FOPH (Federal Office of Public Health) for Switzerland, which is updated daily, can 
be named as: 

* `schema`: `switzerland`;

* `table name`: `foph_hospitalizations_d`.

It's good to indicate the source of the data in the name. In this case the source was indicated by the `foph`. 
