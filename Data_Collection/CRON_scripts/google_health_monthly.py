"""
This script was created to update the google health data that aren't
updated daily by Google.
"""

from google_health import load_into_db
from sqlalchemy import create_engine
from data_types import dtype_monthly

import config

dict_tables = {
    "locality_names_0": "https://storage.googleapis.com/covid19-open-data/v3/index.csv",
    "demographics": "https://storage.googleapis.com/covid19-open-data/v3/demographics.csv",
    "economy": "https://storage.googleapis.com/covid19-open-data/v3/economy.csv",
    "geography": "https://storage.googleapis.com/covid19-open-data/v3/geography.csv",
    "health": "https://storage.googleapis.com/covid19-open-data/v3/health.csv",
    "vaccination_access": "https://storage.googleapis.com/covid19-open-data/covid19-vaccination-access/facility-boundary-us-all.csv",
}

engine = create_engine(config.DB_URI, pool_pre_ping=True)

for t, u in dict_tables.items():
    print(t)
    load_into_db(t, u, dtype_monthly[t], engine)
