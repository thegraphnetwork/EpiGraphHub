from sqlalchemy import text
import logging as logger
import pytest

from epigraphhub.connection import get_engine
from epigraphhub.settings import env


public_tables = [
    "owid_covid",
    # 'iso_alpha3_country_codes',
]

colombia_tables = [
    "positive_cases_covid_d",
    # 'casos_positivos_covid',
]

switzerland_tables = [
    # 'foph_cases',
    # 'foph_casesvaccpersons',
    # 'foph_covidcertificates',
    # 'foph_death',
    # 'foph_deathvaccpersons',
    # 'foph_hosp',
    # 'foph_hospcapacity',
    # 'foph_hospvaccpersons',
    # 'foph_intcases',
    # 'foph_re',
    # 'foph_test',
    # 'foph_testpcrantigen',
    # 'foph_virusvariantswgs',
    "foph_casesvaccpersons_d",
    "foph_cases_d",
    "foph_hosp_d",
    "foph_hospvaccpersons_d",
    "foph_death_d",
    "foph_deathvaccpersons_d",
    "foph_test_d",
    "foph_testpcrantigen_d",
    "foph_hospcapacity_d",
    "foph_hospcapacitycertstatus_d",
    "foph_re_d",
    "foph_intcases_d",
    "foph_virusvariantswgs_d",
    "foph_covidcertificates_d",
    # df_val_hosp_cantons
    # janne_scenario_1
    # janne_scenario_2
    # janne_scenario_3
    # janne_scenario_4
    # ml_for_icu_all_cantons
    # ml_for_hosp_all_cantons
    # ml_forecast_hosp_up
    # ml_for_total_all_cantons
    # ml_forecast
    # ml_forecast_hosp
    # ml_forecast_icu_up
    # ml_forecast_icu
    # ml_forecast_total
    # ml_val_hosp_all_cantons
    # ml_val_icu_all_cantons
    # ml_val_total_all_cantons
    # ml_validation
    # ml_validation_hosp_up
    # ml_validation_icu
    # ml_validation_icu_up
    # ml_validation_total
    # phosp_post
    # prev_post
    # existance
]


def _return_true_if_table_exists(schema, table) -> bool:
    engine = get_engine(credential_name=env.db.default_credential)
    try:
        with engine.connect().execution_options(autocommit=True) as conn:
            result = conn.execute(
                text(
                    f"""
                    SELECT EXISTS (
                        SELECT FROM 
                            pg_tables
                        WHERE 
                            schemaname = '{schema}' AND 
                            tablename  = '{table}'
                        );
            """
                )
            )
            for row in result:
                return row["exists"]

    except Exception as e:
        logger.error(f"Could not access {table} table\n{e}")
        raise (e)


def _check_schema_integrity(schema, tables_list):
    for table in tables_list:
        return _return_true_if_table_exists(schema, table)


def test_tables_in_public_schema():
    assert _check_schema_integrity(schema="public", tables_list=public_tables)


def test_tables_in_colombia_schema():
    assert _check_schema_integrity(schema="colombia", tables_list=colombia_tables)


def test_tables_in_switzerland_schema():
    assert _check_schema_integrity(schema="switzerland", tables_list=switzerland_tables)
