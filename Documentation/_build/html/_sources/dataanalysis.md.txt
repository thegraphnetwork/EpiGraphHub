# Data Querying, Analysis, and Visualizations

If you have you public key registered with the EpigraphHub server, you can easily connect directly to the database from your programming environment.

First you need to establish an encrypted connection using the following command:

## Direct access to the database

```bash
ssh -f epigraph@epigraphhub.org -L 5432:localhost:5432 -NC
```

This command let's you access the database as if it was a local database.

Below are instructions about how to fetch data for analysis

### Using Python
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

### Using R
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

## Access through the API

In order to access contents  via the Hub's API, it is a bit more involved, and it gives access mostly to metadata instead of raw data.


### Getting the authentication token
you need to authenticate using your user and password you will get a token following this authentication that you can save and use for future requests.

```python
import requests
import json

base_url = 'https://epigraphhub.org/api/v1/'
payload = {'username':'guest', 'password':'guest','provider':'db'}

r = requests.post('https://epigraphhub.org/api/v1/security/login', json=payload)
access_token = r.json()
```

the content of `access_token` will look like this:

```json
{'access_token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2Mzc3NTYzMjksIm5iZiI7MTYzNzc2NjMyOSwianRpIjoiZjEyNGVlMjEtNmUwOS00ZmNmLTgwN2EtOTYzMDYyODQ2ZWQ3IiwiZXhwIjoxNjM3NzU3MjI5LCJpZGVudGl0eSI6MSwiZnJlc2giOnRydWUsInR5cGUiOiJhY2Nlc3MifQ.aObdxq9ECwvgFEz22FRCct2kEv-EgFDf_3XPnaSfx-4'}
```

### Making an authenticated request
With the token, you can prepare an authentication header to use with your requests:

```python
headersAuth = {'Authorization': 'Bearer'+access_token['access_token']}
```

and with that you can finally request some database table:

```python
r2 = requests.get('https://epigraphhub.org/api/v1/database/2/select_star/owid_covid', headers=headersAuth)

r2.json() # This with return you the results
```
