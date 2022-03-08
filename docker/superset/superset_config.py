import os

from celery.schedules import crontab
from cachelib.redis import RedisCache

# Superset specific config
ROW_LIMIT = 5000

SIP_15_ENABLED = True

APP_NAME = "EpiGraphHub"

MAPBOX_API_KEY = os.getenv("MAPBOX_API_KEY")

# Specify the App icon
APP_ICON = "/static/assets/images/epigraphhub.png"
APP_ICON_WIDTH = 126

# Specify where clicking the logo would take the user
# e.g. setting it to '/' would take the user to '/superset/welcome/'
LOGO_TARGET_PATH = '/welcome'

# Specify tooltip that should appear when hovering over the App Icon/Logo
LOGO_TOOLTIP = "EpiGraphHub"

PUBLIC_ROLE_LIKE = "Gamma"

# Redis caching
REDIS_PORT = os.getenv("REDIS_PORT")
REDIS_URI = f'redis://localhost:{REDIS_PORT}/0'

RESULTS_BACKEND = RedisCache(
    host='localhost',
    port=REDIS_PORT,
    key_prefix='superset_results'
)


DATA_CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 60 * 60 * 24, # 1 day default (in secs)
    'CACHE_KEY_PREFIX': 'superset_results',
    'CACHE_REDIS_URL': REDIS_URI,
}

CELERYBEAT_SCHEDULE = {
    'cache-warmup-hourly': {
        'task': 'cache-warmup',
        'schedule': crontab(minute=0, hour='*'),  # hourly
        'kwargs': {
            'strategy_name': 'top_n_dashboards',
            'top_n': 5,
            'since': '7 days ago',
        },
    },
}

class CeleryConfig:
    BROKER_URL = REDIS_URI
    CELERY_IMPORTS = (
        'superset.sql_lab',
        'superset.tasks',
    )
    CELERY_RESULT_BACKEND = REDIS_URI
    CELERYD_LOG_LEVEL = 'DEBUG'
    CELERYD_PREFETCH_MULTIPLIER = 10
    CELERY_ACKS_LATE = True
    CELERY_ANNOTATIONS = {
        'sql_lab.get_sql_results': {
            'rate_limit': '100/s',
        },
        'email_reports.send': {
            'rate_limit': '1/s',
            'time_limit': 120,
            'soft_time_limit': 150,
            'ignore_result': True,
        },
    }
    CELERYBEAT_SCHEDULE = {
        'email_reports.schedule_hourly': {
            'task': 'email_reports.schedule_hourly',
            'schedule': crontab(minute=1, hour='*'),
        },
    }

CELERY_CONFIG = CeleryConfig
SQLALCHEMY_DATABASE_URI = "sqlite:////opt/data/superset/superset.db"
