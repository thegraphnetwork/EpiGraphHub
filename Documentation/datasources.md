# Data Sources and Aquisition 
Epigraphhub database aggregates data from multiple sources which are collect and kept up to date via our data aquisition scripts.

All the data coming from an external source should give origin to on or more tables organized in schemas. For example, maps should be stored in the `map` schema. 

Data can be uploaded manually via the Epigraphhub Superset web interface or programatically, by connecting directly to the database. In order to connect a SSH tunnel must be established using the user `epigraph`

```bash
!ssh -f epigraph@135.181.41.20 -L 5432:localhost:5432 -NC
```

Once the tunnel is established data can be sent to the data base using Pandas:

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgres://epigraph:epigraph@localhost:5432/epigraphhub")
```

Suppose you want to upload a map, in this case you will need Geopandas:

```python
import geopandas as gpd

mymap = gpd.read_file('mymap.shp')
mymap.to_postgis("map.mymap", engine, if_exists='replace')
```

Above, `map` is the schema created to hold all the maps.

## Data sources
The sources below are kept uptodate in the epigraphhub database.

1. Our world in data COVID-19 data
2. [GADM](https://gadm.org) maps.
