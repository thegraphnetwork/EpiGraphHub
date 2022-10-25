#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 13 13:14:23 2022

@author: nr
"""
import pandas as pd
from airflow.decorators import dag, task
from mpx_dashboard.functions import load_cases, group_and_aggr#, add_to_parquet, cached_read_csv, cached_read_parquet
from mpx_dashboard import csv_specs
import os
# from typing import Optional#, Union, Any
import logging
import traceback

@dag(
    schedule_interval='@daily',
    start_date=pd.to_datetime('2022-10-18'),
    catchup=False,
    tags=['MPX_ETL'],
)
def etl_mpx(rawfile: str, folder: str = '',
            load_cases_kwargs: dict = {},
            to_parquet_kwargs: dict = {},
            read_parquet_kwargs: dict = {},
            conf_aggr: dict = {}, sus_aggr: dict = {}):
    """
    1. Loads disaggregated data (1 line for case), from a csv file. Column data types are handled
    2. Saves a copy of the data in parquet file. 
    3. Aggregates data based on values in a columns and a date column. 
        Default is to group by country and date (confirmation for confirmed cases, death date for death)
        We obtain the number of reported entries (cases, deaths, etc... ) for each day for every country.
    4. Writes aggregated data as parquet file
    Parameters
    ----------
    rawfile : str
        file with disaggregated data (one case per line).
    folder : str, optional
        Location for output files. The default is ''.
    load_cases_kwargs : dict, optional
        dictionary of kwargs for load_cases. The default is {}.
    to_parquet_kwargs : dict, optional
        dictionary of kwargs for to_parquet. The default is {}.
    read_parquet_kwargs : dict, optional
        dictionary of kwargs for read_parquet. The default is {}.
    conf_aggr : dict, optional
        acts as group_and_aggr(raw_data, **conf_aggr). 
        Default is:
            {'cases': dict(column=csv_specs.countrycol, date_col=csv_specs.confdatecol,
                            dropna=True, entrytype='cases', dropzeros=True),
             'deaths' : dict(column=csv_specs.countrycol, date_col=csv_specs.deathdatecol,
                             dropna=True, entrytype='deaths', dropzeros=True)}
    sus_aggr : dict, optional
        analogous to conf_aggr but acts on suspected entries. Default is:
            {'sus_cases' : dict(column=csv_specs.countrycol, date_col=csv_specs.entrydatecol,
                            dropna=True, entrytype='cases', dropzeros=True),
            'sus_deaths' : dict(column=csv_specs.countrycol,
                                             date_col=csv_specs.deathdatecol, 
                                             dropna=True, entrytype='deaths', dropzeros=True)}
        

    Raises
    ------
    ValueError
        No data to aggregate if rawfile results empty or not available.
    
    Note
    ----
    Do not use the same keys conf_aggr and sus_aggr, otherwise your files for suspected entries will overwrite those with confirmed ones

    Returns
    -------
    None

    """

    @task
    def extract(rawfile: str, folder, load_cases_kwargs: dict = {},
                to_parquet_kwargs: dict = {}):
        """
        Note
        ----
        Loads the csv file with load_cases. 
        Column data types can be provided as input or deduced based on csv_specs.
        
        Parameters
        ----------
        rawfile : str
            file with disaggregated data (one case per line).
        folder : str, optional
            Location for output files. The default is ''.
        load_cases_kwargs : dict, optional
            dictionary of kwargs for load_cases. The default is {}.
        to_parquet_kwargs : dict, optional
            dictionary of kwargs for to_parquet. The default is {}.

        Returns
        -------
        path : str
            The path where rawfile has been copied in a parquet format

        """
        try:
            raw_data = load_cases(rawfile, **load_cases_kwargs)
            logging.info('raw data loaded')
        except Exception as e:
            tback = traceback.format_exc()
            logging.critical(f'loading raw data failed. Error message and traceback below.\n {e} \n {tback}')
        date = pd.to_datetime('today').strftime('%d_%m_%Y')
        path = os.path.join(folder, f'{date}.parquet')
        raw_data.to_parquet(path, **to_parquet_kwargs)
        logging.info(f'raw data saved in {path}')
        return path

    @task
    def transform_and_load(path: str, folder: str, read_parquet_kwargs: dict = {},
                           conf_aggr: dict = {}, sus_aggr: dict = {}):
        """
        Aggregates the data and saves it as parquet files.
        The dictionaries conf_aggr and sus_aggr control what files are obtain and how the data is aggregated.
        
        Parameters
        ----------
        path : str
            location of the raw_data parquet file (obtained from extract).
        folder : str
            Location for output files.
        read_parquet_kwargs : dict, optional
            dictionary of kwargs for read_parquet. The default is {}.
        conf_aggr : dict, optional
            acts as group_and_aggr(raw_data, **conf_aggr). 
            Default is:
                {'cases': dict(column=csv_specs.countrycol, date_col=csv_specs.confdatecol,
                                dropna=True, entrytype='cases', dropzeros=True),
                 'deaths' : dict(column=csv_specs.countrycol, date_col=csv_specs.deathdatecol,
                                 dropna=True, entrytype='deaths', dropzeros=True)}
        sus_aggr : dict, optional
            analogous to conf_aggr but acts on suspected entries. Default is:
                {'sus_cases' : dict(column=csv_specs.countrycol, date_col=csv_specs.entrydatecol,
                                dropna=True, entrytype='cases', dropzeros=True),
                'sus_deaths' : dict(column=csv_specs.countrycol,
                                                 date_col=csv_specs.deathdatecol, 
                                                 dropna=True, entrytype='deaths', dropzeros=True)}
        Note
        ----
        Do not use the same keys conf_aggr and sus_aggr, otherwise your files for suspected entries will overwrite those with confirmed ones
        Returns
        -------
        None
        """
        raw_data = pd.read_parquet(path, **read_parquet_kwargs)
        sus = raw_data[raw_data[csv_specs.statuscol] == csv_specs.statusvals['suspected']]
        if not len(raw_data):
            raise ValueError('No data to aggregate')
        if not conf_aggr:
            conf_aggr['cases'] = dict(column=csv_specs.countrycol, date_col=csv_specs.confdatecol,
                            dropna=True, entrytype='cases', dropzeros=True)
            conf_aggr['deaths'] = dict(column=csv_specs.countrycol, date_col=csv_specs.deathdatecol,
                            dropna=True, entrytype='deaths', dropzeros=True)
        if not sus_aggr:
            sus_aggr['sus_cases'] = dict(column=csv_specs.countrycol, date_col=csv_specs.entrydatecol,
                            dropna=True, entrytype='cases', dropzeros=True)
            sus_aggr['sus_deaths'] =  dict(column=csv_specs.countrycol,
                                             date_col=csv_specs.deathdatecol, # NB. there are some deaths with no deathdate. 
                                             # right now they are being excluded. We could plot them with the date of entry or of last modification
                                             dropna=True, entrytype='deaths', dropzeros=True)
        d_aggr = {}
        for k, v in conf_aggr.items():
            d_aggr[k] = group_and_aggr(raw_data, **v)
            logging.info(f'aggregated {k}')
        for k, v in sus_aggr.items():
            d_aggr[k] = group_and_aggr(sus, **v)
            logging.info(f'aggregated {k}')
        
        for k, v in d_aggr.items():
            outpath = os.path.join(folder, f'{k}.parquet')
            v.to_parquet(outpath)
            logging.info(f'Written aggregated parquet file {outpath}')

    transform_and_load(extract(rawfile, folder,
                               load_cases_kwargs=load_cases_kwargs,
                               to_parquet_kwargs=to_parquet_kwargs),
                       folder,
                       read_parquet_kwargs=read_parquet_kwargs,
                       conf_aggr=conf_aggr,
                       sus_aggr=sus_aggr)

cols_needed = [csv_specs.countrycol, csv_specs.confdatecol, csv_specs.deathdatecol, csv_specs.entrydatecol, csv_specs.statuscol]
dag = etl_mpx('https://raw.githubusercontent.com/globaldothealth/monkeypox/main/latest_deprecated.csv',
              folder=os.getenv('DATA_FOLDER'),
              read_parquet_kwargs={'columns': cols_needed})


