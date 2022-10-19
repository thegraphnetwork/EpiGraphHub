#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 13 13:14:23 2022

@author: nr
"""
import pandas as pd
from airflow.decorators import dag, task
from mpx_dashboard.functions import get_country_pop_egh
from mpx_dashboard import utils
import os
# from typing import Optional#, Union, Any
import logging
import traceback

@dag(
    schedule_interval="@monthly",
    start_date=pd.to_datetime('2022-10-18'),
    catchup=False,
    tags=['POPULATION_DATA'],
)
def population_dag(all_countries: list, folder: str = '',
                   type_: str = 'country', output: str = 'population'):
    """
    Parameters
    ----------
    all_countries : list
        list of all countries.
    folder : str, optional
        Location for output files. The default is ''.
    type_ : str, optional
        the type of location specifications. This is passed down to get_country_pop_egh. Default is 'country'. 
        Options are 'country' (case insensitive) anything containing 'iso3' (case insensitive), 
        otherwise 'location_key' is supposed. For countries, location_key is the iso2 code.
    output : str, optional
        output csv file. The default is population(.csv).
        Works with or without ".csv"

    Returns
    -------
    None
    """

    @task
    def extract_and_load(all_countries: list, folder: str = '',
                         type_: str = 'country', output: str = 'population'):
        """
        Parameters
        ----------
        all_countries : list
            list of all countries.
        folder : str, optional
            Location for output files. The default is ''.
        type_ : str, optional
            the type of location specifications. This is passed down to get_country_pop_egh. Default is 'country'. 
            Options are 'country' (case insensitive) anything containing 'iso3' (case insensitive), 
            otherwise 'location_key' is supposed. For countries, location_key is the iso2 code.
        output : str, optional
            output csv file. The default is population(.csv).
            Works with or without ".csv"

        Returns
        -------
        None
        """
        try:
            population = get_country_pop_egh(all_countries, type_=type_)
            logging.info('Population loaded!')
        except Exception as e:
            tback = traceback.format_exc()
            logging.critical(f'loading raw data failed. Error message and traceback below.\n {e} \n {tback}')
        output = os.path.join(folder, output if output.endswith('.csv') else f'{output}.csv')
        population.to_csv(os.path.join(folder,f'{output}.csv')) 
    
    extract_and_load(all_countries, folder=folder, type_=type_, output=output)
    
dag = population_dag(utils.all_countries, folder='/home/nr/WORK/MPX-dashboard/data')


