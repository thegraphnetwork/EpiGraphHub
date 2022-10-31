#!/usr/bin/env python3
"""
The functions in this module allow the application of the
ngboost regressor model for time series of new, total and total ICU hospitlaizations of COVID-19 in switzerland.
The result of these functions are shown in the dashboard: https://epigraphhub.org/covidch/
"""
import pandas as pd
from ngboost.distns import LogNormal
from ngboost.learners import default_tree_learner
from ngboost.scores import LogScore

from epigraphhub.analysis.clustering import compute_clusters
from epigraphhub.analysis.forecast_models.ngboost_models import NGBModel
from preprocess_data import get_cluster_data, get_data_by_location

params_model = {
    "Base": default_tree_learner,
    "Dist": LogNormal,
    "Score": LogScore,
    "natural_gradient": True,
    "verbose": False,
    "col_sample": 0.9,
    "n_estimators": 100,
    "learning_rate": 0.05,
}


def get_clusters_swiss(t=0.3, end_date=None):
    """
    Params to get the list of clusters computed by the compute_cluster function.

    Parameters
    ----------
    t : float, optional
        Thereshold used in the clusterization., by default 0.3
    end_date : string | None, optional
        Indicates the last day used to compute the cluster, by default None

    Returns
    -------
    array
        Array with the clusters computed.
    """    
    
    df = get_data_by_location(
        "switzerland",
        "foph_cases_d",
        "All",
        ["datum", '"georegion"', "entries"],
        "georegion",
    )

    df.set_index("datum", inplace=True)
    df.index = pd.to_datetime(df.index)

    if end_date != None:
        df = df.loc[:end_date]

    clusters = compute_clusters(
        df,
        ["georegion", "entries"],
        t=t,
        drop_values=["CH", "FL", "CHFL"],
        plot=False,
        smooth=True,
    )[1]

    return clusters

def remove_zeros(tgt):
    """
    Function to remove the zeros of the target curve. It needs to be done to us be able
    to use the LogNormal dist.

    Parameters
    ----------
    tgt : array

    Returns
    -------
    array
        
    """    

    tgt[tgt == 0] = 0.01

    return tgt

def train_eval_all_cantons(
    target_curve_name,
    predictors,
    vaccine=True,
    smooth=True,
    ini_date="2020-03-01",
    end_train_date=None,
    end_date=None,
    ratio=0.75,
    ratio_val=0.15,
    early_stop=5,
    parameters_model=params_model,
    predict_n=14,
    look_back=14,
):
    """
    Function to train and evaluate the model for all cantons.
    
    Parameters
    ----------
    target_curve_name : string
        name of the target curve.
    predictors : list of strings
        variables that  will be used in model.
    vaccine : bool, optional
         It determines if the vaccine data from owid will be used or not, by default True
    smooth : bool, optional
        It determines if data will be smoothed (7 day moving average) or not, by default True
    ini_date : str, optional
        Determines the beggining of the train dataset, by default "2020-03-01"
    end_train_date : str, optional
         Determines the beggining of end of train dataset. If end_train_date
                           is not None, then ratio isn't used., by default None
    end_date : str, optional
        Determines the end of the dataset used in validation., by default None
    ratio : float, optional
        Determines which percentage of the data will be used to train the model, by default 0.75
    ratio_val : float, optional
       Determines which percentage of the train data will be used as validation data, by default 0.15
    early_stop : int, optional
         This parameter will finish the model's training after {early_stop}
                    iterations without improving the model in the validation data, by default 5
    parameters_model : dict, optional
         dict with the params that will be used in the ngboost
                             regressor model, by default params_model
    predict_n : int, optional
         Number of days that will be predicted, by default 14
    look_back : int, optional
        Number of the last days that will be used to forecast the next days, by default 14

    Returns
    -------
    Dataframe.
    """ 


    df_all = pd.DataFrame()

    clusters = get_clusters_swiss(t=0.6)

    for cluster in clusters:

        df = get_cluster_data(
            "switzerland", predictors, list(cluster), vaccine=vaccine, smooth=smooth
        )

        df = df.fillna(0)

        for canton in cluster:

            target_name = f"{target_curve_name}_{canton}"

            df_c = df.copy()

            df_c[target_name] = remove_zeros(df_c[target_name].values)

            ngb_m = NGBModel(
                look_back=look_back,
                predict_n=predict_n,
                validation_split=ratio_val,
                early_stop=early_stop,
                params_model=parameters_model,
            )

            if any(df_c[target_name] > 1):

                df_pred = ngb_m.train_eval(
                    target_name,
                    df_c,
                    ini_date=ini_date,
                    end_train_date=end_train_date,
                    end_date=end_date,
                    ratio=ratio,
                    save=False,
                )

                df_pred["canton"] = canton

            else:
                df_pred = pd.DataFrame()
                df_pred["target"] = df[target_name]
                df_pred["date"] = 0
                df_pred["lower"] = 0
                df_pred["median"] = 0
                df_pred["upper"] = 0
                df_pred["canton"] = canton

            df_all = pd.concat([df_all, df_pred])

    return df_all


def train_all_cantons(
    target_curve_name,
    predictors,
    vaccine=True,
    smooth=True,
    ini_date="2020-03-01",
    end_date=None,
    parameters_model=params_model,
    ratio_val=0.15,
    early_stop=10,
    predict_n=14,
    look_back=14,
    path=None,
):

    """
    Function to train the model with all the data available for all the cantons
    
    Parameters
    ----------
    target_curve_name : string
        name of the target curve.
    predictors : list of strings
        variables that  will be used in model.
    vaccine : bool, optional
         It determines if the vaccine data from owid will be used or not, by default True
    smooth : bool, optional
        It determines if data will be smoothed (7 day moving average) or not, by default True
    ini_date : str, optional
        Determines the beggining of the train dataset, by default "2020-03-01"
    end_date : str, optional
        Determines the end of the dataset used in training, by default None
    parameters_model : dict, optional
         dict with the params that will be used in the ngboost
                             regressor model, by default params_model
    ratio_val : float, optional
       Determines which percentage of the train data will be used as validation data, by default 0.15
    early_stop : int, optional
         This parameter will finish the model's training after {early_stop}
                    iterations without improving the model in the validation data, by default 5
    predict_n : int, optional
         Number of days that will be predicted, by default 14
    look_back : int, optional
        Number of the last days that will be used to forecast the next days, by default 14
    path: string
        path to save the trained models. 

    Returns
    -------
    None
    """ 

    clusters = get_clusters_swiss(t=0.6)

    for cluster in clusters:

        df = get_cluster_data(
            "switzerland", predictors, list(cluster), vaccine=vaccine, smooth=smooth
        )

        df = df.fillna(0)

        for canton in cluster:

            df_c = df.copy()

            target_name = f"{target_curve_name}_{canton}"

            df_c[target_name] = remove_zeros(df_c[target_name].values)

            ngb_m = NGBModel(
                look_back=look_back,
                predict_n=predict_n,
                validation_split=ratio_val,
                early_stop=early_stop,
                params_model=parameters_model,
            )

            if any(df_c[target_name] > 1):
                ngb_m.train(
                    target_name,
                    df_c,
                    ini_date=ini_date,
                    path=path,
                    end_date=end_date,
                    save=True,
                    name=f"ngboost_{target_name}",
                )

    return


def forecast_all_cantons(
    target_curve_name,
    predictors,
    vaccine=True,
    smooth=True,
    predict_n=14,
    look_back=14,
    path="../opt/models/saved_models/ml"):
    """
    Function to load the trained values and make the forecast for all the cantons. 
    
    Parameters
    ----------
    target_curve_name : string
        name of the target curve.
    predictors : list of strings
        variables that  will be used in model.
    vaccine : bool, optional
         It determines if the vaccine data from owid will be used or not, by default True
    smooth : bool, optional
        It determines if data will be smoothed (7 day moving average) or not, by default True
    predict_n : int, optional
         Number of days that will be predicted, by default 14
    look_back : int, optional
        Number of the last days that will be used to forecast the next days, by default 14
     path: string
        path to load the trained models. 

    Returns
    -------
    Dataframe.
    """ 
    
    df_all = pd.DataFrame()

    clusters = get_clusters_swiss(t=0.6)

    for cluster in clusters:

        df = get_cluster_data(
            "switzerland", predictors, list(cluster), vaccine=vaccine, smooth=smooth
        )

        df = df.fillna(0)

        for canton in cluster:

            target_name = f"{target_curve_name}_{canton}"

            ngb_m = NGBModel(
                look_back=look_back,
                predict_n=predict_n,
                validation_split=0.15,
                early_stop=10,
            )

            df[target_name] = remove_zeros(df[target_name].values)

            if any(df[target_name] > 1):
                df_for = ngb_m.forecast(df, path=path, name=f"ngboost_{target_name}")

                df_for["canton"] = canton

                df_all = pd.concat([df_all, df_for])

    return df_all


def save_to_database(df, table_name, engine):
    """
    Save the results in the database

    Parameters
    ----------
    df : dataframe
    table_name : str
        name of the table
    engine :
        sqlalchemy connection 
    """    
    df.to_sql(table_name, engine, schema="switzerland", if_exists="replace")


