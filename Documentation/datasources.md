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
