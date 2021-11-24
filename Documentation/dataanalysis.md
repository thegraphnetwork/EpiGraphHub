# Data Querying, Analysis, and Visualizations

If you have you public key registered with the EpigraphHub server, you can easily connect directly to the database from your programming environment.

First you need to establish an encrypted connection using the following command:

```bash
ssh -f epigraph@epigraphhub.org -L 5432:localhost:5432 -NC
```

This command let's you access the database as if it was a local database.

Below are instructions about how to fetch data for analysis

## Python
In a Python environment we will use two libraries: [Pandas](https://pandas.pydata.org) and SQLAlchemy.

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgres://epigraph:epigraph@localhost:5432/epigraphhub")
```

Then suppose you want to download the "Our World in Data" covid table:

```python
owid = pd.read_sql_table('owid_covid', engine, schema='public')
```

## R
In R-studio or the R console, we will need the following packages: `RPostgreSQL`.

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

Then to fetch the "Our World in Data" covid table:

```R
# query the data from postgreSQL 
df_owid <- dbGetQuery(con, "SELECT * from public.owid_covid")
```

That's it! you can now explore the data on your local computer as you wish.