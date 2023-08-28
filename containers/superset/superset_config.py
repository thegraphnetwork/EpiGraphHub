import os

from cachelib.redis import RedisCache
from celery.schedules import crontab

# Superset specific config
SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY", "\2\1thisismyscretkey\1\2\e\y\y\h")

# note: configure talisman for improving security
TALISMAN_ENABLED = None
TALISMAN_CONFIG = {}

SESSION_COOKIE_SAMESITE = "Lax"
# Flask-WTF flag for CSRF
WTF_CSRF_ENABLED = os.getenv("ENV") == "prod"
# Add endpoints that need to be exempt from CSRF protection
WTF_CSRF_EXEMPT_LIST = []
# A CSRF token that expires in 1 year
WTF_CSRF_TIME_LIMIT = 60 * 60 * 24 * 365

FEATURE_FLAGS = {
    "CLIENT_CACHE": False,
    "ENABLE_EXPLORE_JSON_CSRF_PROTECTION": False,
    "PRESTO_EXPAND_DATA": False,
}

ROW_LIMIT = 5000

SIP_15_ENABLED = True

APP_NAME = "EpiGraphHub"

MAPBOX_API_KEY = os.getenv("MAPBOX_API_KEY")

# Specify the App icon
APP_ICON = "/static/assets/images/epigraphhub.png"
APP_ICON_WIDTH = 126
FAVICONS = [{"href": "/static/assets/images/favicon.png"}]

# Specify where clicking the logo would take the user
# e.g. setting it to '/' would take the user to '/superset/welcome/'
LOGO_TARGET_PATH = "/"

# Specify tooltip that should appear when hovering over the App Icon/Logo
LOGO_TOOLTIP = "EpiGraphHub"

PUBLIC_ROLE_LIKE = "Gamma"

SUPERSET_HOME = os.getenv("SUPERSET_HOME")

# Redis caching
REDIS_HOST = os.getenv("REDIS_HOST")
REDIS_PORT = os.getenv("REDIS_PORT")
REDIS_PASSWORD = os.getenv("REDIS_PASSWORD")
REDIS_CELERY_DB = os.getenv("REDIS_CELERY_DB", "0")
REDIS_RESULTS_DB = os.getenv("REDIS_RESULTS_DB", "1")
# RESULTS_BACKEND = FileSystemCache(f"{SUPERSET_HOME}/sqllab")

REDIS_CACHE_PREFIX = "superset_results"

RESULTS_BACKEND = RedisCache(
    host=REDIS_HOST,
    port=REDIS_PORT,
    # password=REDIS_PASSWORD,
    key_prefix=REDIS_CACHE_PREFIX,
)


class CeleryConfig:
    BROKER_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_CELERY_DB}"
    CELERY_IMPORTS = ("superset.sql_lab", "superset.tasks")
    CELERY_RESULT_BACKEND = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_RESULTS_DB}"
    CELERYD_LOG_LEVEL = "DEBUG"
    CELERYD_PREFETCH_MULTIPLIER = 1
    CELERY_ACKS_LATE = False

    CELERY_ANNOTATIONS = {
        "sql_lab.get_sql_results": {
            "rate_limit": "100/s",
        },
        "email_reports.send": {
            "rate_limit": "1/s",
            "time_limit": 120,
            "soft_time_limit": 150,
            "ignore_result": True,
        },
    }
    CELERYBEAT_SCHEDULE = {
        "email_reports.schedule_hourly": {
            "task": "email_reports.schedule_hourly",
            "schedule": crontab(minute=1, hour="*"),
        },
        "cache-warmup-hourly": {
            "task": "cache-warmup",
            "schedule": crontab(minute=0, hour="*"),  # hourly
            "kwargs": {
                "strategy_name": "top_n_dashboards",
                "top_n": 5,
                "since": "7 days ago",
            },
        },
    }


CELERY_CONFIG = CeleryConfig

DB_HOST = os.getenv("POSTGRES_HOST")
DB_PORT = os.getenv("POSTGRES_PORT")
DB_USER = os.getenv("SUPERSET_DB_USER")
DB_PASS = os.getenv("SUPERSET_DB_PASSWORD")
DB_DATABASE = os.getenv("SUPERSET_DB_DATABASE")
SQLALCHEMY_DATABASE_URI = (
    f"postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_DATABASE}"
)


# ---------------------------------------------------
# Babel config for translations
# ---------------------------------------------------
# Setup default language
BABEL_DEFAULT_LOCALE = "en"
# Your application default translation path
BABEL_DEFAULT_FOLDER = "superset/translations"
# The allowed translation for you app
LANGUAGES = {
    "en": {"flag": "us", "name": "English"},
    "es": {"flag": "es", "name": "Spanish"},
    "it": {"flag": "it", "name": "Italian"},
    "fr": {"flag": "fr", "name": "French"},
    "zh": {"flag": "cn", "name": "Chinese"},
    "ja": {"flag": "jp", "name": "Japanese"},
    "de": {"flag": "de", "name": "German"},
    "pt": {"flag": "pt", "name": "Portuguese"},
    "pt_BR": {"flag": "br", "name": "Brazilian Portuguese"},
    # "ru": {"flag": "ru", "name": "Russian"},
    "ko": {"flag": "kr", "name": "Korean"},
    # "sk": {"flag": "sk", "name": "Slovak"},
    # "sl": {"flag": "si", "name": "Slovenian"},
    "nl": {"flag": "nl", "name": "Dutch"},
}

# EMAIL

MAIL_SERVER = os.getenv("SUPERSET_MAIL_SERVER")
MAIL_USE_TLS = os.getenv("SUPERSET_MAIL_USE_TLS").lower() in ["true", "1"]
MAIL_PORT = int(os.getenv("SUPERSET_MAIL_PORT"))
MAIL_USERNAME = os.getenv("SUPERSET_MAIL_USERNAME")
MAIL_PASSWORD = os.getenv("SUPERSET_MAIL_PASSWORD")
MAIL_DEFAULT_SENDER = os.getenv("SUPERSET_MAIL_DEFAULT_SENDER")

# REGISTRATION

AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Data_scientist"

# RECAPTCHA
RECAPTCHA_USE_SSL = False
RECAPTCHA_PUBLIC_KEY = os.getenv("RECAPTCHA_PUBLIC_KEY")
RECAPTCHA_PRIVATE_KEY = os.getenv("RECAPTCHA_PRIVATE_KEY")
RECAPTCHA_OPTIONS = {"theme": "white"}
