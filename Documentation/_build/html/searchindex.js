Search.setIndex({"docnames": ["charts/bar_charts", "charts/boxplot", "charts/histogram", "charts/index", "charts/line_charts", "charts/map_charts", "charts/pivot_table", "dataanalysis", "datasets/colombia_schema", "datasets/google_health_schema", "datasets/index", "datasets/switzerland_schema", "datasources", "datastorage", "harmonization", "hubapps", "index", "instruction_name_tables", "overview"], "filenames": ["charts/bar_charts.md", "charts/boxplot.md", "charts/histogram.md", "charts/index.rst", "charts/line_charts.md", "charts/map_charts.md", "charts/pivot_table.md", "dataanalysis.md", "datasets/colombia_schema.md", "datasets/google_health_schema.md", "datasets/index.rst", "datasets/switzerland_schema.md", "datasources.md", "datastorage.md", "harmonization.md", "hubapps.md", "index.rst", "instruction_name_tables.md", "overview.md"], "titles": ["Bar Chart", "Boxplot", "Histogram", "Data visualizations", "Time Evolution - Line Chart", "Country map chart", "Pivot table", "Data Querying, Analysis, and Visualizations", "Colombian COVID-19 data", "Google COVID-19 data", "Datasets available on the EpigraphHub platform", "Switzerland COVID-19 data", "Data Sources and Aquisition", "Data Storage", "Data Transformation and Harmonization", "Building Web-apps based on the Hub", "Welcome to EpiGraphHub\u2019s Documentation!", "Database table naming rules", "Overview of the EpiGraphHub Platform"], "terms": {"If": [1, 2, 5, 6, 7, 17], "you": [0, 1, 2, 3, 4, 5, 6, 7, 9, 10, 12, 15, 17], "have": [4, 5, 6, 7, 8, 9, 10, 11, 15, 18], "public": [7, 11, 12, 17, 18], "kei": [1, 7, 8, 9, 11], "regist": 7, "epigraphhub": [3, 8, 12, 15], "server": [7, 15, 16], "can": [0, 1, 2, 3, 4, 5, 7, 9, 10, 12, 15, 17, 18], "easili": [7, 15], "connect": [7, 12, 15], "directli": [4, 7, 12], "from": [1, 4, 6, 7, 9, 10, 12, 17, 18], "your": [0, 1, 2, 4, 5, 7, 16], "program": 7, "environ": 7, "first": [1, 4, 6, 7, 8, 12, 15], "need": [6, 7, 12], "establish": [7, 12], "encrypt": 7, "follow": [0, 1, 4, 5, 6, 7, 17], "command": [7, 15], "ssh": [7, 12, 15], "f": [7, 12], "epigraph": [7, 12], "org": [7, 12, 15], "l": [7, 12], "5432": [7, 12], "localhost": [7, 12, 15], "nc": [7, 12], "thi": [0, 1, 2, 4, 5, 6, 7, 8, 9, 11, 12, 15, 17, 18], "let": [0, 1, 2, 4, 5, 6, 7, 15], "s": [0, 1, 2, 4, 5, 6, 7, 15, 17, 18], "wa": [1, 4, 6, 7, 8, 9, 17], "local": [7, 15, 17], "below": [1, 2, 4, 5, 6, 7, 8, 9, 11, 12, 17, 18], "ar": [1, 4, 5, 7, 8, 9, 11, 12, 15, 17, 18], "instruct": 7, "about": [1, 2, 7, 9, 10], "how": [1, 4, 7], "fetch": [7, 9], "In": [0, 1, 2, 4, 5, 6, 7, 8, 9, 11, 12, 15, 17], "we": [0, 1, 2, 4, 5, 6, 7, 8, 9, 11, 12, 15], "two": [1, 2, 4, 6, 7, 11, 18], "librari": 7, "panda": [7, 12], "sqlalchemi": [7, 12], "import": [7, 12, 15, 17], "pd": [7, 12], "create_engin": [7, 12], "engin": [7, 12, 15], "postgr": [7, 12], "Then": [5, 6, 7, 15], "suppos": [4, 5, 7, 12], "want": [0, 7, 12, 15], "download": 7, "our": [0, 1, 2, 4, 7, 10, 12, 15, 18], "world": [7, 12], "covid": [0, 1, 2, 4, 5, 6, 7, 10, 12, 16], "tabl": [0, 1, 2, 3, 4, 8, 9, 10, 11, 12, 18], "owid": 7, "read_sql_tabl": 7, "owid_covid": 7, "schema": [7, 8, 9, 10, 11, 12, 18], "studio": 7, "consol": 7, "packag": [7, 12], "rpostgresql": [7, 12], "instal": [7, 12], "requir": [7, 12, 15], "load": [7, 12], "postgresql": [7, 10, 12, 18], "driver": [7, 12], "drv": [7, 12], "dbdriver": [7, 12], "creat": [3, 5, 6, 7, 8, 12, 15, 17, 18], "note": [4, 7, 12], "con": [7, 12], "later": [7, 12], "each": [1, 7, 8, 9, 10, 11, 12, 17], "dbconnect": [7, 12], "dbname": [7, 12], "host": [7, 12], "port": [7, 12], "user": [7, 12, 18], "password": [7, 12], "df_owid": 7, "dbgetqueri": 7, "select": [0, 1, 2, 4, 5, 6, 7, 12], "That": [4, 7], "now": [0, 1, 2, 4, 5, 6, 7, 12], "explor": [2, 15, 16, 18], "comput": [1, 6, 7, 15], "wish": 7, "order": [4, 12, 15, 18], "content": [7, 8, 9, 11, 17], "via": [7, 12], "hub": [7, 12, 16], "bit": 7, "more": [6, 7, 12, 15], "involv": 7, "give": [4, 7, 12], "mostli": 7, "metadata": 7, "instead": [7, 17], "raw": 7, "save": [0, 1, 2, 4, 5, 6, 12, 15], "futur": 7, "json": 7, "base_url": 7, "http": [7, 8, 9, 15], "v1": [7, 15], "payload": 7, "usernam": 7, "guest": 7, "provid": [2, 5, 7, 8, 9, 11], "db": 7, "post": 7, "secur": [7, 18], "login": 7, "access_token": 7, "look": [4, 5, 7], "like": [4, 5, 7, 15], "eyj0exaioijkv1qilcjhbgcioijiuzi1nij9": 7, "eyjpyxqioje2mzc3ntyzmjksim5izii7mtyznzc2njmyoswianrpijoizjeyngvlmjetnmuwos00zmnmltgwn2etotyzmdyyodq2zwq3iiwizxhwijoxnjm3nzu3mji5lcjpzgvudgl0esi6mswiznjlc2gionrydwusinr5cguioijhy2nlc3mifq": 7, "aobdxq9ecwvgfez22frcct2kev": 7, "egfdf_3xpnasfx": 7, "4": 7, "With": 7, "prepar": 7, "header": 7, "headersauth": 7, "author": 7, "bearer": 7, "final": [0, 1, 2, 4, 6, 7], "some": [3, 4, 7], "r2": 7, "2": [1, 4, 5, 6, 7, 8, 11], "select_star": 7, "return": [0, 6, 7], "result": [0, 1, 2, 4, 5, 6, 7, 17], "dataset": [0, 1, 2, 4, 5, 6, 8, 12, 16, 17, 18], "locat": 8, "colombia": [1, 2, 8], "current": [4, 7, 8], "3": [8, 12], "relat": [5, 6, 7, 8, 9, 11, 17], "countri": [3, 8, 11, 16, 17], "so": [0, 1, 2, 4, 5, 6, 7, 8, 11], "far": [8, 11], "avail": [1, 4, 7, 8, 11, 12, 15, 16, 17, 18], "stratifi": [8, 9, 11], "departamento": 8, "1": [1, 8, 9, 11], "thei": [8, 11], "were": [1, 8, 11], "instituto": 8, "nacion": 8, "de": 8, "salud": 8, "brief": [8, 9, 11], "descript": [8, 9, 11, 17], "For": [1, 4, 5, 7, 8, 9, 11, 12, 15, 17], "them": [7, 8, 9, 11, 15], "anoth": [6, 8, 9, 11], "name": [1, 4, 5, 7, 8, 9, 11, 12], "table_nam": [8, 9, 11], "_meta": [8, 9, 11], "contain": [8, 9, 11, 17, 18], "an": [0, 4, 5, 8, 9, 11, 12, 15], "explan": [1, 8, 9, 11], "column": [0, 1, 2, 4, 5, 6, 7, 8, 9, 11, 17], "exampl": [3, 4, 6, 7, 8, 9, 11, 12, 16], "call": [7, 8, 9, 11], "positive_cases_covid_d": [0, 1, 2, 6, 8], "repres": [1, 2, 6, 7, 8, 11, 12, 17], "daili": [4, 7, 8, 11, 12, 17], "record": [1, 6, 7, 8, 11], "timelin": [8, 11], "posit": 8, "case": [0, 1, 2, 4, 6, 7, 8, 9, 11, 12, 17], "The": [0, 1, 2, 4, 5, 6, 7, 8, 9, 11, 12, 15, 17, 18], "mean": [1, 6, 8, 9, 11, 17], "explain": [8, 9, 11], "positive_cases_covid_meta": 8, "sourc": [8, 9, 10, 11, 16, 17, 18], "fecha_reporte_web": [1, 8], "individu": [1, 2, 6, 8], "includ": [7, 8, 17], "inform": [1, 2, 6, 7, 8, 9, 15, 17], "sex": [0, 8, 9], "ag": [1, 2, 8, 9], "date": [7, 8, 9, 11, 12, 17], "sympton": 8, "report": 8, "diseas": 8, "sever": [4, 6, 8], "death": [8, 9, 11], "di": [6, 8], "casos_covid_agg_m": 8, "fecha_inicio_sintoma": 8, "monthli": [7, 8, 17], "aggreg": [0, 1, 3, 5, 6, 7, 8, 12], "symptom": [6, 8, 9], "consid": [1, 8], "group": [1, 3, 6, 7, 8, 18], "us": [0, 1, 2, 4, 5, 6, 8, 9, 15, 17, 18], "fecha_muert": 8, "index": [8, 16], "refer": [1, 2, 7, 8, 11, 15, 17], "polit": [8, 11], "divis": [8, 11], "www": 8, "dato": 8, "gov": 8, "co": 8, "y": [4, 7, 8], "protecci": 8, "n": [6, 8], "social": 8, "caso": 8, "positivo": 8, "en": 8, "gt2j": 8, "8ykr": 8, "It": [0, 1, 2, 4, 5, 6, 7, 8, 15, 17, 18], "one": [1, 4, 6, 8, 12, 15, 17], "analyst": [8, 18], "platform": [3, 7, 8, 15], "google_health": 9, "open": [0, 1, 2, 4, 5, 6, 9, 15], "databas": [9, 10, 12, 15, 16], "hospitalizations_d": 9, "patient": [1, 9], "hospit": [9, 11, 17], "region": [1, 9, 12, 17], "location_kei": 9, "hospitalizations_d_meta": 9, "find": [3, 7, 9, 10], "string": [5, 9], "locality_names_0": 9, "covid19_series_by_age_d": 9, "epidemiolog": 9, "covid19_series_by_sex_d": 9, "covid19_series_d": 9, "recoveri": 9, "test": [9, 11, 15, 18], "demograph": 9, "variou": 9, "popul": 9, "statist": [1, 9], "economi": 9, "econom": 9, "indic": [9, 17], "emergency_declarations_d": 9, "govern": 9, "emerg": 9, "declar": 9, "mitig": 9, "polici": 9, "geographi": 9, "geograph": 9, "government_response_d": 9, "intervent": 9, "rel": 9, "stringenc": 9, "health": [7, 9, 11, 17], "code": [5, 9, 11, 12, 15], "join": 9, "other": [1, 7, 9, 17, 18], "mobility_d": 9, "metric": [0, 1, 3, 5, 6, 7, 9], "movement": 9, "peopl": 9, "search_trends_d": 9, "trend": 9, "search": [9, 16], "volum": 9, "due": 9, "vaccinations_access": 9, "quantifi": 9, "access": [9, 12, 16, 18], "vaccin": [9, 11], "site": 9, "vaccinations_d": 9, "person": [9, 11], "rate": 9, "regard": 9, "vaccinations_search_d": 9, "weather_d": 9, "meteorolog": 9, "repositori": [9, 15], "github": [9, 15], "com": 9, "googlecloudplatform": 9, "here": [3, 4, 5, 7, 10, 15, 17], "detail": [10, 15], "document": [10, 15], "been": [10, 11, 18], "alreadi": [7, 10], "onboard": 10, "separ": [4, 10, 17, 18], "kept": [10, 12, 18], "thought": 10, "folder": 10, "collect": 10, "same": [7, 10], "last": [3, 4, 5, 7, 10], "updat": [3, 10, 11, 12, 15, 17, 18], "jun": [3, 10], "13": 10, "2022": [3, 7, 10, 11], "colombian": [10, 16], "19": [0, 1, 2, 6, 7, 10, 12, 16], "data": [2, 4, 5, 10, 15, 16, 17, 18], "googl": [10, 12, 16], "switzerland": [4, 5, 7, 10, 16, 17], "canton": [3, 5, 11], "foph": [7, 11, 17], "foph_cases_d": 11, "foph_cases_d_meta": 11, "georegion": [4, 5, 7, 11], "letter": 11, "foph_casesvaccpersons_d": 11, "fulli": 11, "onli": [1, 4, 5, 7, 11, 18], "chfl": [4, 5, 11], "file": [7, 11, 12], "ha": [5, 7, 11, 12, 18], "deprec": 11, "longer": 11, "after": [0, 1, 2, 7, 11], "11": 11, "2021": 11, "foph_covidcertificates_d": 11, "foph_death_d": 11, "foph_deathvaccpersons_d": 11, "foph_hosp_d": [4, 5, 7, 11], "hospitalis": [4, 5, 7, 11], "foph_hospcapacity_d": 11, "capac": 11, "foph_hospcapacitycertstatus_d": 11, "certifi": 11, "ad": [4, 7, 11, 17], "hoc": 11, "statu": 11, "oper": [1, 6, 7, 11], "icu": 11, "bed": 11, "foph_hospvaccpersons_d": 11, "foph_intcases_d": 11, "intern": [11, 18], "05": 11, "04": 11, "foph_re_d": 11, "reproduct": 11, "number": [0, 2, 4, 5, 6, 7, 11], "foph_test_d": 11, "all": [0, 1, 4, 6, 7, 11, 12, 15, 18], "type": [0, 1, 2, 4, 5, 6, 11, 17], "combin": [6, 7, 11], "foph_testpcrantigen_d": 11, "datum": 11, "pcr": 11, "antigen": 11, "feder": [7, 11, 17], "offic": [7, 11, 17], "multipl": [7, 12], "which": [7, 12, 15, 17, 18], "collectd": 12, "up": [4, 5, 7, 12], "autom": 12, "system": 12, "come": 12, "extern": [12, 18], "should": [0, 1, 4, 5, 7, 12, 15, 17], "origin": 12, "organ": [12, 15], "map": [3, 7, 12, 16, 17], "store": [12, 17], "upload": [12, 17], "superset": [12, 15, 18], "web": [12, 18], "interfac": [12, 15], "programat": 12, "tunnel": [12, 15], "must": [4, 12, 15, 17], "either": [7, 12, 18], "onc": [7, 12, 15], "sent": 12, "base": [1, 4, 7, 12], "geopanda": 12, "gpd": 12, "mymap": 12, "read_fil": 12, "shp": 12, "to_postgi": 12, "if_exist": 12, "replac": 12, "abov": [1, 12, 15, 17], "hold": 12, "complet": 12, "gadm": [12, 17], "check": 12, "script": 12, "To": [0, 1, 2, 4, 5, 6, 7, 12], "csv": [7, 12], "Or": 12, "direct": [12, 16, 18], "shown": [1, 7, 12, 18], "df": 12, "read_csv": 12, "myspreadsheet": 12, "delimit": [12, 17], "to_sql": 12, "read": [12, 18], "dbwritet": 12, "c": 12, "overwrit": 12, "true": [7, 12, 15], "valu": [0, 1, 2, 4, 5, 6, 7, 12, 17], "where": [1, 4, 5, 6, 7, 12], "second": [6, 7, 12], "easi": [12, 15], "wai": [7, 12, 15], "through": [12, 15, 16, 18], "sheet": 12, "permiss": 12, "anyon": 12, "link": [5, 12], "view": 12, "don": [7, 12], "t": [7, 12], "forget": 12, "api": [12, 16], "administr": [12, 17], "level": [4, 7, 12], "chart": [1, 2, 3, 6, 12, 16], "show": [4, 6, 7, 12], "centroid": 12, "guinea": 12, "admin": 12, "possibl": [6, 15], "veri": 15, "simpl": [4, 5, 15, 17], "applic": 15, "simplic": 15, "develop": 15, "own": 15, "reposotori": 15, "under": [5, 7, 15], "graph": [15, 18], "network": [15, 18], "independ": [4, 15, 18], "framework": 15, "written": 15, "configur": [0, 1, 2, 5, 7, 15], "work": [7, 15], "assum": 15, "achiev": 15, "activ": 15, "decrib": 15, "readi": 15, "runa": 15, "help": 15, "deploy": 15, "ci": 15, "cd": 15, "tutori": 15, "go": [0, 1, 2, 4, 5, 7, 15], "step": [7, 15], "further": [7, 15], "than": [6, 7, 15], "interact": [4, 15], "standard": 15, "extra": 15, "abil": 15, "run": [0, 1, 2, 4, 5, 6, 7, 15], "custom": [0, 2, 4, 7, 15, 18], "background": 15, "beyond": 15, "just": [7, 15, 17], "figur": [15, 18], "manipul": 15, "But": [4, 7, 15], "still": [7, 15], "abl": [5, 15], "take": 15, "advantag": 15, "publish": 15, "start": [1, 7, 15], "fastest": 15, "todai": 15, "A": [4, 5, 6, 15, 17], "emb": 15, "would": [4, 15], "line": [0, 3, 5, 7, 15, 16], "st": 15, "my": 15, "compon": 15, "ifram": 15, "9": [1, 15], "standalon": 15, "width": [0, 1, 2, 4, 5, 6, 7, 15], "800": 15, "height": 15, "scroll": [7, 15], "write": [4, 15, 18], "myapp": 15, "py": 15, "see": [1, 4, 6, 7, 15], "browser": 15, "allow": [5, 7, 15, 18], "befor": [15, 17], "much": 15, "its": 15, "top": 15, "perform": 15, "queri": [0, 1, 2, 3, 4, 6, 15, 16], "ani": [7, 15, 18], "visual": [0, 15, 16], "mai": 15, "when": [4, 5, 7, 15, 17], "push": 15, "issu": 15, "descrcib": 15, "why": [4, 15], "label": [1, 4, 7, 15], "request": [4, 15], "One": 15, "respond": 15, "queue": 15, "everi": 15, "time": [0, 1, 2, 3, 6, 15, 16, 18], "main": [15, 18], "branch": 15, "automat": [4, 15], "redeploi": 15, "overview": [5, 16], "structur": [16, 17], "role": 16, "manual": 16, "entri": [4, 5, 7, 16], "transform": 16, "harmon": 16, "storag": 16, "analysi": [16, 17], "build": [7, 16], "app": 16, "gener": [7, 16, 18], "guidelin": 16, "deploi": 16, "modul": 16, "page": [2, 4, 5, 16], "new": [4, 5, 7, 17], "alwai": 17, "lower": [7, 17], "No": [5, 17], "space": 17, "between": [4, 7, 17], "charact": 17, "_": 17, "composit": 17, "singl": 17, "full": [17, 18], "iso": [5, 17], "found": 17, "global": 17, "scale": 17, "belong": 17, "unit": 17, "state": [3, 17], "united_st": 17, "basic": 17, "semant": 17, "word": 17, "0": [7, 17], "d": 17, "w": 17, "m": 17, "option": [1, 5, 6, 7, 17], "suffix": 17, "symbol": [5, 17], "placehold": 17, "insid": 17, "On": [7, 17], "postgi": 17, "gi": 17, "prefix": 17, "fill": [1, 4, 5, 7, 17], "specif": [0, 7, 17, 18], "accord": [7, 17], "nomenclatur": 17, "adopt": 17, "omit": 17, "term": 17, "entir": 17, "e": [4, 7, 17], "g": [4, 7, 17], "whole": [4, 17], "chosen": 17, "frame": 17, "express": 17, "abbrevi": 17, "portion": 17, "period": [17, 18], "weekli": [4, 7, 17], "static": 17, "meta": 17, "geneva_hospitalizations_d": 17, "geneva_hospitalizations_d_meta": 17, "geneva_hospitalizations_forecasts_d_result": 17, "posgi": 17, "geneva": [5, 17], "gis_geneva_new_hospitalizations_d": 17, "explanatori": 17, "least": [4, 17], "list": [4, 7, 17], "enlarg": 17, "exist": 17, "dictionari": 17, "being": 17, "column_nam": 17, "varchar": 17, "128": 17, "text": [7, 17], "numer": [7, 17], "categor": 17, "boolean": [7, 17], "datetim": 17, "etc": 17, "foph_hospitalizations_d": 17, "good": [6, 17], "compos": 18, "integr": 18, "apach": 18, "frontend": 18, "compis": 18, "three": [7, 18], "differ": [4, 6, 7, 18], "priviledg": 18, "exclus": 18, "domain": 18, "project": 18, "privileg": 18, "grant": 18, "per": [4, 5, 18], "basi": 18, "maxim": 18, "made": [4, 7, 18], "partner": 18, "usag": 18, "agreement": 18, "within": 18, "optim": 18, "control": 18, "experiment": 18, "model": 18, "guarante": 18, "persist": 18, "long": 18, "notic": [5, 7, 18], "manag": 18, "purpos": 18, "hubber": 18, "member": 18, "clear": 18, "restrict": 18, "sdfgsfg": [], "evolut": [3, 7, 16], "grain": [1, 3, 7], "swiss": 3, "filter": [0, 1, 2, 3, 6], "finalis": 3, "legend": 3, "ax": 3, "titl": [0, 1, 2, 3, 5, 6], "interest": [1, 4, 5, 7], "over": [1, 2, 4, 5], "year": [1, 2, 4, 7], "previou": [5, 7], "lesson": 7, "back": 4, "click": [0, 1, 2, 4, 5, 6, 7], "button": [0, 1, 2, 4, 5, 6, 7], "upper": [4, 7], "right": [4, 5, 7], "corner": [4, 7], "750px": [0, 1, 2, 4, 5, 6, 7], "do": [0, 1, 2, 4, 5, 6, 7], "thing": 4, "choos": [4, 5, 7], "field": [0, 1, 2, 4, 5, 6, 7], "drop": [4, 7], "down": [4, 7], "again": [4, 5, 7], "section": [0, 1, 4, 5, 6, 7], "sub": 4, "recommend": 4, "tag": 4, "categori": [4, 5, 7], "correspond": [4, 5, 7], "appear": [4, 5, 6, 7], "panel": [0, 2, 4, 5, 6, 7], "classic": 4, "visualis": [0, 1, 2, 4, 6, 7], "chang": [0, 1, 2, 4, 5, 6, 7], "bottom": [4, 5], "pre": 4, "well": 4, "paramet": 4, "mandatori": [1, 4], "color": [0, 3, 4], "red": 4, "annot": 4, "exclam": 4, "mark": 4, "inde": 4, "cannot": 4, "empti": 4, "mani": [4, 7], "displai": [0, 2, 4, 7], "As": [1, 4, 5], "add": [4, 5, 6, 7], "pop": [4, 5], "window": [0, 1, 2, 4, 5, 6, 7], "menu": 4, "set": [1, 2, 4, 5], "sum": [1, 4, 5, 6, 7], "sinc": [4, 5], "week": 4, "dure": [4, 5], "250px": [4, 7], "side": [4, 6, 7], "definit": 4, "unless": 4, "edit": [4, 5], "pencil": 4, "icon": [4, 7], "highlight": [4, 7], "done": [4, 7], "500px": [1, 2, 4, 5, 6, 7], "By": [1, 4, 7], "default": [1, 4, 6, 7], "dai": [1, 4], "get": [1, 2, 4, 5], "smoother": 4, "BY": 4, "press": [4, 7], "great": 4, "also": [0, 1, 4, 6, 7], "ch": [4, 5], "liechtenstein": 4, "togeth": 4, "focu": [4, 7], "out": [4, 5], "NOT": [4, 5, 7], "IN": [4, 5, 7], "tab": [0, 1, 2, 4], "next": [4, 5, 7], "tick": [0, 1, 4], "box": [1, 4, 6, 7], "plot": [0, 1, 2, 4, 7], "hide": 4, "doubl": 4, "associ": [1, 4], "item": [4, 6], "while": [4, 5], "x": [0, 1, 4, 7], "axi": [1, 4], "And": [1, 4, 7], "wave": [4, 7], "There": [5, 7], "divid": 7, "left": 7, "small": 7, "clock": 7, "datasourc": 7, "abc": 7, "fals": 7, "middl": [0, 1, 2, 4, 5, 6, 7], "specifi": [0, 1, 2, 5, 6, 7], "granular": 7, "rang": [1, 2, 3, 7], "defin": [1, 7], "organis": 7, "row": [6, 7], "collaps": 7, "arrow": 7, "closer": 7, "subsect": 7, "potenti": 7, "larg": 7, "seri": [0, 1, 7], "bar": [2, 3, 7, 16], "suit": 7, "best": 7, "most": [1, 7], "popular": 7, "ones": 7, "quarter": 7, "calendar": 7, "advanc": 7, "instanc": [0, 1, 2, 5, 6, 7], "i": 7, "present": [1, 2, 7], "mode": 7, "function": [6, 7], "averag": [1, 7], "without": [1, 7], "appli": [0, 1, 2, 5, 7], "decid": 7, "what": [2, 5, 7], "sai": 7, "sumtot": 7, "retriev": 7, "10k": 7, "export": 7, "featur": 7, "insight": 7, "ascend": 7, "decreas": 7, "asc": 7, "descend": 7, "desc": 7, "keep": [1, 7], "10000": 7, "screen": [0, 7], "third": [1, 7], "equal": [6, 7], "ge": [5, 7], "avoid": [6, 7], "threshold": 7, "bigger": 7, "could": 7, "fr": 7, "invers": 7, "exclud": 7, "insensit": 7, "pattern": 7, "doesn": 7, "differenti": 7, "IS": 7, "null": [6, 7], "non": 7, "cumul": [2, 7], "exce": 7, "100": 7, "clearli": 7, "end": 7, "march": 7, "2020": [5, 7], "impress": 7, "around": 7, "octob": 7, "novemb": 7, "begin": 7, "learn": 7, "across": [1, 5], "month": 5, "3166": 5, "isocod": 5, "did": 5, "polygon": 5, "concaten": 5, "fan": 5, "orang": 5, "linear": 5, "doe": 5, "quit": 5, "nice": 5, "think": 5, "element": 5, "yet": 5, "total": [0, 5, 6], "februari": 5, "correct": 5, "close": 5, "pass": 5, "mous": [1, 2, 5], "count": [0, 2, 6], "uniqu": [0, 1], "sexo": 0, "300px": [0, 1, 2, 6], "config": 0, "improv": 0, "flat": 0, "layout": [0, 1], "scheme": [0, 3], "condit": 0, "summaris": 1, "histogram": [1, 3, 16], "dead": [1, 2], "edad": [1, 2], "unidad_medida": [1, 2], "ensur": [1, 2], "estado": [1, 2, 6], "fallecido": [1, 2, 6], "distribut": [1, 2], "avg": 1, "point": 1, "tempor": 1, "eventu": 1, "practic": 1, "convinc": 1, "yourself": 1, "impact": 1, "prior": 1, "id_de_caso": 1, "id": 1, "consequ": 1, "along": 1, "depart": 1, "departamento_nom": 1, "receiv": 1, "rotat": 1, "customis": 1, "90\u00ba": 1, "imag": [1, 2], "box_x_tick": 1, "png": [1, 2], "hover": [1, 2], "quartil": 1, "observ": 1, "outlier": 1, "pane": 1, "tukei": 1, "min": 1, "max": 1, "5": 1, "iqr": 1, "interquartil": 1, "25": 1, "percentil": [1, 2], "75": 1, "respect": 1, "98": 1, "91": 1, "hist_filter_1": 2, "hist_filter_2": 2, "bin": 2, "NO": 2, "OF": 2, "20": 2, "exact": 2, "14": 3, "boxplot": [3, 16], "pivot": [3, 16], "discret": 6, "ubicacion": 6, "treat": 6, "casa": 6, "home": 6, "leve": 6, "had": 6, "mild": 6, "moderado": 6, "moder": 6, "grave": 6, "v2": 6, "ignor": 6, "vs": 6, "furthermor": 6, "transpos": 6, "put": 6, "dynam": 3, "change_viz_typ": [], "300x": []}, "objects": {}, "objtypes": {}, "objnames": {}, "titleterms": {"data": [3, 7, 8, 9, 11, 12, 13, 14], "queri": [5, 7], "analysi": 7, "visual": [3, 7], "direct": 7, "access": 7, "databas": [7, 17, 18], "us": [7, 12], "python": [7, 12], "r": [7, 12], "through": 7, "api": 7, "get": 7, "authent": 7, "token": 7, "make": 7, "an": 7, "request": 7, "colombian": 8, "covid": [8, 9, 11], "19": [8, 9, 11], "googl": 9, "dataset": [7, 10], "avail": 10, "epigraphhub": [7, 10, 16, 18], "platform": [10, 18], "content": [3, 10, 16], "switzerland": 11, "sourc": 12, "aquisit": 12, "manual": 12, "entri": 12, "spreadsheet": 12, "storag": 13, "transform": 14, "harmon": 14, "build": 15, "web": 15, "app": 15, "base": 15, "hub": 15, "gener": 15, "guidelin": 15, "exampl": [15, 17], "streamlit": 15, "embed": 15, "dashboard": 15, "deploi": 15, "your": 15, "welcom": 16, "s": 16, "document": 16, "indic": 16, "tabl": [6, 7, 16, 17], "name": 17, "rule": 17, "all": 17, "schema": 17, "about": 17, "metadata": 17, "overview": 18, "server": 18, "structur": 18, "privatehub": 18, "sandbox": 18, "role": 18, "line": 4, "chart": [0, 4, 5, 7], "time": [4, 5, 7], "evolut": 4, "creat": 4, "metric": 4, "aggreg": 4, "grain": 4, "group": 4, "swiss": 4, "canton": 4, "state": 4, "filter": [4, 5, 7], "finalis": [4, 5], "legend": 4, "ax": 4, "titl": 4, "explor": 7, "page": 7, "type": 7, "save": 7, "order": 7, "limit": 7, "countri": 5, "map": 5, "color": 5, "scheme": 5, "rang": 5, "dynam": 5, "bar": 0, "boxplot": 1, "histogram": 2, "pivot": 6}, "envversion": {"sphinx.domains.c": 2, "sphinx.domains.changeset": 1, "sphinx.domains.citation": 1, "sphinx.domains.cpp": 6, "sphinx.domains.index": 1, "sphinx.domains.javascript": 2, "sphinx.domains.math": 2, "sphinx.domains.python": 3, "sphinx.domains.rst": 2, "sphinx.domains.std": 2, "sphinx": 56}})