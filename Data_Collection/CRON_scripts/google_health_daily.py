'''
This script was created to update the google health data daily. 
'''

from google_health import load_into_db
from sqlalchemy import create_engine 

dict_tables = {
    'covid19_series_d': 'https://storage.googleapis.com/covid19-open-data/v3/epidemiology.csv', 
    'emergency_declarations_d': 'https://storage.googleapis.com/covid19-open-data/v3/lawatlas-emergency-declarations.csv',
    'hospitalizations_d': 'https://storage.googleapis.com/covid19-open-data/v3/hospitalizations.csv', 
    'mobility_d': 'https://storage.googleapis.com/covid19-open-data/v3/mobility.csv', 
    'search_trends_d': 'https://storage.googleapis.com/covid19-open-data/v3/google-search-trends.csv', 
    'vaccination_search_d': 'https://storage.googleapis.com/covid19-open-data/covid19-vaccination-search-insights/Global_vaccination_search_insights.csv',
    'vaccinations_d': 'https://storage.googleapis.com/covid19-open-data/v3/vaccinations.csv',
    'government_response_d': 'https://storage.googleapis.com/covid19-open-data/v3/oxford-government-response.csv', 
    'weather_d': 'https://storage.googleapis.com/covid19-open-data/v3/weather.csv', 
    'covid19_series_by_age_d': 'https://storage.googleapis.com/covid19-open-data/v3/by-age.csv', 
    'covid19_series_by_sex_d': 'https://storage.googleapis.com/covid19-open-data/v3/by-sex.csv'
    }

engine = create_engine('postgresql://epigraph:epigraph@localhost:5432/epigraphhub', pool_pre_ping=True)

for t,u in dict_tables.items():
    load_into_db(t, u, engine)
