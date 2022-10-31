"""
The functions in this module allow the user to get the datasets stored in the
epigraphhub database.
The function get_agg_data aggregate the data according to the values of one column,
and the method of aggregation applied.
The function get_georegion_data filter the datasets for a list of
selected regions (in the Switzerland case: cantons).
The function get_cluster_data is focused on being used to apply the forecast models.
This function returns a table where each column is related to a  different table and
region (e.g. the daily number of cases and the daily number of hospitalizations in
Geneva and Fribourg).
Some parts of the code of this function are focused on the swiss case.
So the function isn't fully general.
"""
import pandas as pd
from sqlalchemy import create_engine

from epigraphhub.data.epigraphhub_db import get_data_by_location
from epigraphhub.settings import env

with env.db.credentials[env.db.default_credential] as credential:
    engine_public = create_engine(
        f"postgresql://{credential.username}:"
        f"{credential.password}@{credential.host}:{credential.port}/"
        f"{credential.dbname}"
    )

dict_cols = {
    "foph_cases_d": ["datum", "georegion", "entries"],
    "foph_test_d": ["datum", "georegion", "entries", "entries_pos"],
    "foph_hosp_d": ["datum", "georegion", "entries"],
    "foph_hospcapacity_d": [
        "date",
        "georegion",
        "icu_covid19patients",
        "total_covid19patients",
    ],
    "foph_re_d": ["date", "georegion", "median_r_mean"],
}

georegion_columns = {
    "foph_cases_d": "georegion",
    "foph_test_d": "georegion",
    "foph_hosp_d": "georegion",
    "foph_hospcapacity_d": "georegion",
}

date_columns = {
    "foph_cases_d": "datum",
    "foph_test_d": "datum",
    "foph_hosp_d": "datum",
    "foph_hospcapacity_d": "date",
}

count_columns = {
    "foph_cases_d": ["entries"],
    "foph_test_d": ["entries"],
    "foph_hosp_d": ["entries"],
    "foph_hospcapacity_d": ["icu_covid19patients", "total_covid19patients"],
}

columns_name = {"foph_cases_d": "cases", "foph_test_d": "test", "foph_hosp_d": "hosp"}


def get_cluster_data(
    schema,
    table_name,
    georegion,
    dict_cols=dict_cols,
    date_columns=date_columns,
    georegion_columns=georegion_columns,
    count_columns=count_columns,
    columns_name=columns_name,
    vaccine=True,
    smooth=True,
):

    """
    This function provides a data frame where each column is associated with a table
    and region selected.
    :params schema: string. The schema where the data that you want to get is saved.
    :params table_name: list of strings. In this list should be all the tables that you
                        want get the data.
    :params georegion: list of strings. This list contains all the regions of the country
                        of interest or the string 'All' to return all the regions.
    :params dict_cols: dictionary. In the keys are the table_names and in the values
                      the columns that you want to use from each table
    :params date_columns:dictionary. In the keys are the table_names and in the values
                          the name of the date column of the table to be used as the
                          index.
    :params count_columns: dictionary. In the keys are the table_names and in the values
                        the name of the column which values will be used.
    :params columns_name: dictionary. In the keys ate the table_names and in the values
                        the name that will appear in the column associated with each
                    table in the final data frame that will be returned.
    :params vaccine: boolean. If True the data of total vaccinations per hundred for the
                            country in the schema will be added in the final data frame.
                            This data is from our world in data.
    :params smooth: boolean. If True in the end data frame will be applied a moving
                            average of seven days.
    :return: Dataframe
    """

    df_end = pd.DataFrame()

    for table in table_name:

        df = get_data_by_location(
            schema,
            table,
            georegion,
            dict_cols[table],
            loc_column=georegion_columns[table],
        )
        df.set_index(date_columns[table], inplace=True)
        df.index = pd.to_datetime(df.index)

        for region in df.georegion.unique():

            for count in count_columns[table]:

                if table == "foph_hospcapacity_d":

                    names = {
                        "icu_covid19patients": "icu_patients",
                        "total_covid19patients": "total_hosp",
                    }
                    df_aux1 = df.loc[df.georegion == region].resample("D").mean()

                    df_aux2 = pd.DataFrame()

                    df_aux2[names[count] + "_" + region] = df_aux1[count]
                    df_aux2[f"diff_{names[count]}_{region}"] = df_aux1[count].diff(1)
                    df_aux2[f"diff_2_{names[count]}_{region}"] = df_aux1[count].diff(2)

                    df_end = pd.concat([df_end, df_aux2], axis=1)

                else:
                    df_aux1 = df.loc[df.georegion == region].resample("D").mean()

                    df_aux2 = pd.DataFrame()

                    df_aux2[columns_name[table] + "_" + region] = df_aux1[count]
                    df_aux2[f"diff_{columns_name[table]}_{region}"] = df_aux1[
                        count
                    ].diff(1)
                    df_aux2[f"diff_2_{columns_name[table]}_{region}"] = df_aux1[
                        count
                    ].diff(2)

                    df_end = pd.concat([df_end, df_aux2], axis=1)

    df_end = df_end.resample("D").mean()

    if vaccine == True:
        vac = pd.read_sql_table(
            "owid_covid",
            engine_public,
            schema="public",
            columns=["date", "iso_code", "total_vaccinations_per_hundred"],
        )

        dict_iso_code = {"switzerland": "CHE", "colombia": "COL"}

        vac = vac.loc[vac.iso_code == dict_iso_code[schema]]
        vac.index = pd.to_datetime(vac.date)

        # selecting only the column with vaccinations per hundred
        vac = vac[["total_vaccinations_per_hundred"]]

        vac = vac.fillna(method="ffill")

        df_end["vac_all"] = vac.total_vaccinations_per_hundred

        df_end["vac_all"] = df_end["vac_all"].fillna(method="ffill")

    df_end = df_end.fillna(0)

    if smooth == True:
        df_end = df_end.rolling(window=7).mean()

        df_end = df_end.dropna()

    return df_end