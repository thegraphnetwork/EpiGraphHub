## Database table naming rules

Before uploading a new dataset into the database and creating a new table, the following rules should be followed for naming the table:

### All names:
1. Always in lower case; 
2. No space between the characters. Instead of using space, use `_` to separate composite names.
3. Column names should follow the above rules.


### Schema names:

If the table it's single country data use the full ISO country name. This name for each country of the world can be found [here](https://gadm.org/maps.html).

If the data is on a global scale data use the schema: `global`.


### Table names:

Table names should follow this basic structure:

`<locality>_<semantic single word name>_<0|D|W|M>_<optional suffix>`

The symbols <> are just delimiters. On PostGIS tables representing maps, a `gis` prefix should be added. 

The `<locality>` will be filled if the data in the table belongs to a specific administrative region of the country. In this case, you should name the locality according to the nomenclature adopted in [GADM](https://gadm.org/maps.html). You can omit this term if the data refers to the entire region that named the schema, e.g., the whole country.

The `<semantic single word name>` means that the words chosen to represent the data frame must express the content of the table and not be a simple abbreviation of the content. 

The `<0|D|W|M>` portion informs about the periodicity of the update. It should use D for daily, W for weekly, M for monthly, and 0 for static.

The Optional suffixes are: meta for metadata tables and result for analysis results.

Examples:

- `geneva_hospitalizations_D`
- `geneva_caseforecasts_D_result`

### About metadata tables:

The metadata tables should be used to store explanatory information about a table's columns. It should contain at least the columns listed below, but can be enlarged to include other information available on existing data dictionaries for the dataset that is being imported.


```sql
table (
column_name varchar(128),
description text,
type text, # Numeric, categorical, Boolean, date, datetime, etc.
)
```


### Example:

A dataset of hospitalizations from FOPH (Federal Office of Public Health) for Switzerland, which is updated daily, can 
be named as: 

* `schema`: `switzerland`;

* `table name`: `foph_hospitalizations_D`.

It's good to indicate the source of the data in the name. 
