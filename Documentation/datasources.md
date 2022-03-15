# Data Sources and Aquisition 
Epigraphhub database aggregates data from multiple sources which are collect and kept up to date via our data aquisition scripts.

All the data coming from an external source should give origin to on or more tables organized in schemas. For example, maps should be stored in the `map` schema. 

## Manual data entry

Data can be uploaded manually via the Epigraphhub Superset web interface or programatically, by connecting directly to the database. In order to connect a SSH tunnel must be established using the user `epigraph`

```bash
ssh -f epigraph@epigraphhub.org -L 5432:localhost:5432 -NC
```

Now we can use either Python or R to upload the data. 

### Using Python

Once the tunnel is established data can be sent to the data base using Pandas:

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql://epigraph:epigraph@localhost:5432/epigraphhub")
```

Suppose you want to upload a map, in this case you will need Geopandas:

```python
import geopandas as gpd

mymap = gpd.read_file('mymap.shp')
mymap.to_postgis("public.mymap", engine, if_exists='replace')
```

Above, `public` is the schema holding all the maps. 

For a more complete example for loading all the GADM maps, check this [script](../Data_Collection/load_gpkg_maps.py).

To Import CSVs you can use the web interface. Or the direct database connection as shown above  

```python
import pandas as pd
df = pd.read_csv('myspreadsheet.csv', delimiter=',')
df.to_sql('myspreadsheet', engine, if_exists='replace')
```

### Using R
Once the tunnel is established data can be sent to the data base using the package: `RPostgreSQL`

```R
# install.packages("RPostgreSQL")
require("RPostgreSQL")

# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")
# creates a connection to the postgres database
# note that "con" will be used later in each connection to the database
con <- dbConnect(drv, 
                dbname = "epigraphhub",
                host = "localhost", 
                port = 5432,
                user = "epigraph", 
                password = 'epigraph')
```

To Import CSVs you can use the web interface. Or the direct database connection as shown above using the code below:

```R
require("RPostgreSQL")
data <- read.csv('myspreadsheet.csv')
dbWriteTable(con, c('public', 'myspreadsheet'), data, overwrite = TRUE)
```

The first value in `c('public', 'myspreadsheet')` represents the **schema** where the table will be saved, and the second the table name.

### Spreadsheets
To import spreadsheets one easy way is through Google sheets. You need to give the spreadsheet you want to read from Epigraphhub, permission to anyone that has the link to view the file.

![sheets](../Documentation/gsheets.png)

Don't forget to select the `Google sheets` first.

## Data sources
The sources below are kept up-to-date in the epigraphhub database.

1. **Our World In Data COVID-19 data.** This dataset is updated daily on the the database and is accessible via the [EpiGraphHub API](https://epigraphhub.org/swagger/v1).
2. [GADM](https://gadm.org) maps. All GADM maps with all available administrative levels are available in the Hub database. [This chart](http://epigraphhub.org/r/14), for example shows the centroids of Guinea' admin 3 regions.
