#!/usr/bin/env python3
"""
Created on Wed Dec 22 15:51:51 2021
@author: eduardoaraujo
"""

import pandas as pd 
import numpy as np 
import copy
from sklearn.model_selection import train_test_split
from ngboost import NGBRegressor
from ngboost.learners import default_tree_learner
from ngboost.distns import  LogNormal
from ngboost.scores import LogScore
from datetime import datetime, timedelta
from get_data import build_lagged_features, compute_clusters, get_combined_data, get_updated_data
from sqlalchemy import create_engine
from loguru import logger

logger.add("/var/log/forecast.log", retention="7 days")

engine = create_engine("postgresql://epigraph:epigraph@localhost:5432/epigraphhub")


def rolling_predictions(target_name, data, ini_date = '2020-03-01',split = 0.75, horizon_forecast = 14, maxlag=15):

    target = data[target_name]

    df_lag = build_lagged_features(copy.deepcopy(data), maxlag=maxlag )
    
    ini_date = max(df_lag.index[0],target.index[0], datetime.strptime(ini_date, "%Y-%m-%d"))

    df_lag = df_lag[ini_date:]
    target = target[ini_date:]
    df_lag = df_lag.dropna()

    # remove the target column and columns related with the day that we want to predict 
    df_lag = df_lag.drop(data.columns, axis = 1)

    # targets 
    targets = {}

    for T in np.arange(1,horizon_forecast+1,1):
        if T == 1:
            targets[T] = target.shift(-(T - 1))
        else:
            targets[T] = target.shift(-(T - 1))[:-(T - 1)]

    X_train, X_test, y_train, y_test = train_test_split(df_lag, target, train_size=split, test_size=1 - split, shuffle=False)

    idx = pd.period_range(start=df_lag.index[0], end=df_lag.index[-1], freq='14D')
    
    idx = idx.to_timestamp()
    
    # predictions 
    preds5 = np.empty((len(idx), horizon_forecast))
    preds50 = np.empty((len(idx), horizon_forecast))
    preds95 = np.empty((len(idx), horizon_forecast))


    for T in range(1, horizon_forecast + 1):

        tgt = targets[T][:len(X_train)]
        
        i = 0
        
        while i < len(tgt):
            if tgt[i] <= 0:
                
                tgt[i] = 0.01
            i = i+1
            
        
        model = NGBRegressor(Base=default_tree_learner, Dist =LogNormal,Score = LogScore,
                             natural_gradient=True,verbose=False, col_sample = 0.9, 
                             n_estimators=300,
        learning_rate=0.1,
        validation_fraction=0.25,
        early_stopping_rounds = 50)
            
        model.fit(X_train, tgt)
        
        pred = model.pred_dist(df_lag.loc[idx])

        pred50 = pred.median()

        pred5, pred95 = pred.interval(alpha = 0.95)

        preds5[:, (T - 1)] = pred5
        preds50[:, (T - 1)] = pred50
        preds95[:, (T - 1)] = pred95


    # transformando preds em um array
    train_size = len(X_train)

    y5 = preds5.flatten()
    y50 = preds50.flatten()
    y95 = preds95.flatten()

    x= pd.period_range(start=df_lag.index[1], end=df_lag.index[-1], freq='D').to_timestamp()
    
    x = np.array(x)
    
    y5 = np.array(y5)
    
    y50 = np.array(y50)
    
    y95 = np.array(y95)
    
    target = targets[1]
    
    train_size = len(X_train)
    
    dif = len(x) - len(y5)
        
    if dif <0:
        y5 = y5[:len(y5) + dif]
        y50 = y50[:len(y50) + dif]
        y95 = y95[:len(y95) + dif]
        
    df_pred = pd.DataFrame()
    df_pred['target'] = target[1:]
    df_pred['date'] = x
    df_pred['lower'] = y5
    df_pred['median'] = y50
    df_pred['upper'] = y95
    df_pred['train_size'] = [train_size]*len(df_pred)
    df_pred['canton'] = [target_name[-2:]]*len(df_pred)
    
    return df_pred

def make_single_prediction(target_curve_name, canton, predictors, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None, updated_data = True):

    '''
    Function to make single prediction 
    
    Important: 
    * By default the function is using the clustering cantons and the data since 2020
    * For the predictor hospCapacity is used as predictor the column ICU_Covid19Patients
    
    params canton: canton of interest 
    params predictors: variables that  will be used in model 
    params vaccine: It determines if the vaccine data from owid will be used or not 
    params smooth: It determines if data will be smoothed or not 
    params ini_date: Determines the beggining of the train dataset
    params title: If none the title will be: Hospitalizations - canton
    params path: If none the plot will be save in the directory: images/hosp_{canton}
    '''

    # compute the clusters 
    clusters, all_regions,fig = compute_clusters('cases', t=0.8, plot = False)

    for cluster in clusters:

        if canton in cluster:

            cluster_canton = cluster


    # getting the data 
    df = get_combined_data(predictors, cluster_canton, vaccine=vaccine, smooth = smooth)
    # filling the nan values with 0
    df = df.fillna(0)
    
    if updated_data: 
        # atualizando a coluna das Hospitalizações com os dados mais atualizados
        df_new = get_updated_data(smooth)
    
        df.loc[df_new.index[0]: df_new.index[-1], 'hosp_GE'] = df_new.hosp_GE

        # utilizando como último data a data dos dados atualizados:
        df = df.loc[:df_new.index[-1]]

    # apply the model 

    target_name = f'{target_curve_name}_{canton}'

    horizon = 14
    maxlag = 14

    # get predictions and forecast 
    #date_predsknn, predsknn, targetknn, train_size, date_forecastknn, forecastknn = rolling_predictions(model_knn, 'knn', target_name, df , ini_date = '2021-01-01',split = 0.75,   horizon_forecast = horizon, maxlag=maxlag,)
    df = rolling_predictions(target_name, df,  ini_date = ini_date,split = 0.75,   horizon_forecast = horizon, maxlag=maxlag)

    #fig = plot_predictions(target_curve_name, canton, target, train_size, x, y5,y50, y95, forecast_dates, forecasts5, forecasts50,forecasts95, title, path)
    return df 

def make_predictions_all_cantons(target_curve_name,  predictors, vaccine = True, smooth= True, ini_date = '2020-03-01', title = None):

    '''
    Function to make prediction for all the cantons
    
    Important: 
    * By default the function is using the clustering cantons and the data since 2020
    * For the predictor hospCapacity is used as predictor the column ICU_Covid19Patients
    
    params target_curve_name: string to indicate the target column of the predictions
    params predictors: variables that  will be used in model 
    params vaccine: It determines if the vaccine data from owid will be used or not 
    params smooth: It determines if data will be smoothed or not 
    params ini_date: Determines the beggining of the train dataset
    
    returns: Dataframe with the predictions for all the cantons
    '''
    
    df_all = pd.DataFrame()

    # compute the clusters 
    clusters, all_regions,fig = compute_clusters('cases', t=0.8, plot = False)

    for cluster in clusters:
        # getting the data 
        df = get_combined_data(predictors, cluster, vaccine=vaccine, smooth = smooth)
        # filling the nan values with 0
        df = df.fillna(0)
    
        for canton in cluster:
            # apply the model 

            target_name = f'{target_curve_name}_{canton}'

            horizon = 14
            maxlag = 14

            # get predictions and forecast 
            
            df_pred = rolling_predictions(target_name, df,  ini_date = ini_date,split = 0.75,   horizon_forecast = horizon, maxlag=maxlag)
            
            df_all = pd.concat([df_all,df_pred])
            
    return df_all

def rolling_forecast(target_name, data, ini_date, horizon_forecast = 14, maxlag=14):
    
    #print(data.index[-1])
    data = data.iloc[:-3]
    
    #print(data.index[-1])
    target = data[target_name]

    df_lag = build_lagged_features(copy.deepcopy(data), maxlag=maxlag )
    
    
    

    ini_date = max(df_lag.index[0],target.index[0], datetime.strptime(ini_date, "%Y-%m-%d"))

    df_lag = df_lag[ini_date:]
    target = target[ini_date:]
    df_lag = df_lag.dropna()

    # remove the target column and columns related with the day that we want to predict 
    df_lag = df_lag.drop(data.columns, axis = 1)

    # targets 
    targets = {}

    for T in np.arange(1,horizon_forecast+1,1):
        if T == 1:
            targets[T] = target.shift(-(T - 1))
        else:
            targets[T] = target.shift(-(T - 1))[:-(T - 1)]
#         print(T, len(df_lag), len(fit_target))
#         print(df_lag.index,fit_target.index)


    # forecast
    forecasts5 = []
    forecasts50 = []
    forecasts95 = []

    for T in range(1, horizon_forecast + 1):
        # training of the model with all the data available
        
        #print(T)
        X_train = df_lag.iloc[:-1]
        tgt = targets[T].iloc[:-1]
        
        i = 0
        
        while i < len(tgt):
            if tgt[i] <= 0:
                
                tgt[i] = 0.01
            i = i+1
            
        
        model = NGBRegressor(Base=default_tree_learner, Dist =LogNormal,Score = LogScore,
                             natural_gradient=True,verbose=False, col_sample = 0.9, 
                             n_estimators=300,
        learning_rate=0.1,
        validation_fraction=0.25,
        early_stopping_rounds = 50)

        model.fit(X_train.iloc[:len(tgt)], tgt)
        
        forecast = model.pred_dist(df_lag.iloc[-1:])

        # make the forecast 
        forecast50 = forecast.median()
        
        forecast5, forecast95 = forecast.interval(alpha = 0.95)
        
        
        forecasts5.append(forecast5)
        forecasts50.append(forecast50)
        forecasts95.append(forecast95)


    # transformando preds em um array

    forecast_dates = []

    last_day = datetime.strftime((df_lag.index)[-1], '%Y-%m-%d')

    a = datetime.strptime(last_day, '%Y-%m-%d')

    for i in np.arange(1, horizon_forecast + 1):

        d_i = datetime.strftime(a+timedelta(days=int(i)),'%Y-%m-%d' ) 

        forecast_dates.append(datetime.strptime(d_i, '%Y-%m-%d'))
    
    
    df_for = pd.DataFrame()

    df_for['date'] = forecast_dates
    df_for['lower'] = np.array(forecasts5)[:,0]
    df_for['median'] = np.array(forecasts50)[:,0]
    df_for['upper'] = np.array(forecasts95)[:,0]
    df_for['canton'] = [target_name[-2:]]*len(df_for)
    
    return df_for

def make_forecast(target_curve_name, canton, predictors, vaccine = True, smooth= True, ini_date = '2020-03-01', title = None, updated_data = True):

    # compute the clusters 
    clusters, all_regions,fig = compute_clusters('cases', t=0.8, plot = False)

    for cluster in clusters:

        if canton in cluster:

            cluster_canton = cluster


    # getting the data 
    df = get_combined_data(predictors, cluster_canton, vaccine=vaccine, smooth = smooth)
    # filling the nan values with 0
    df = df.fillna(0)

    if updated_data:
        # atualizando a coluna das Hospitalizações com os dados mais atualizados
        df_new = get_updated_data(smooth)
    
        df.loc[df_new.index[0]: df_new.index[-1], 'hosp_GE'] = df_new.hosp_GE
    
        # utilizando como último data a data dos dados atualizados:
        df = df.loc[:df_new.index[-1]]


    # apply the model 

    target_name = f'{target_curve_name}_{canton}'

    horizon = 14
    maxlag = 14

    # get predictions and forecast 
    #date_predsknn, predsknn, targetknn, train_size, date_forecastknn, forecastknn = rolling_predictions(model_knn, 'knn', target_name, df , ini_date = '2021-01-01',split = 0.75,   horizon_forecast = horizon, maxlag=maxlag,)
    df_for = rolling_forecast(target_name, df, ini_date = ini_date,  horizon_forecast = horizon, maxlag=maxlag)

    return df_for


def make_forecast(target_curve_name, canton, predictors, vaccine = True, smooth= True, ini_date = '2020-03-01', title = None, updated_data = True):

    # compute the clusters 
    clusters, all_regions,fig = compute_clusters('cases', t=0.8, plot = False)

    for cluster in clusters:

        if canton in cluster:

            cluster_canton = cluster


    # getting the data 
    df = get_combined_data(predictors, cluster_canton, vaccine=vaccine, smooth = smooth)
    # filling the nan values with 0
    df = df.fillna(0)

    if updated_data:
        # atualizando a coluna das Hospitalizações com os dados mais atualizados
        df_new = get_updated_data(smooth)
    
        df.loc[df_new.index[0]: df_new.index[-1], 'hosp_GE'] = df_new.hosp_GE
    
        # utilizando como último data a data dos dados atualizados:
        df = df.loc[:df_new.index[-1]]


    # apply the model 

    target_name = f'{target_curve_name}_{canton}'

    horizon = 14
    maxlag = 14

    # get predictions and forecast 
    #date_predsknn, predsknn, targetknn, train_size, date_forecastknn, forecastknn = rolling_predictions(model_knn, 'knn', target_name, df , ini_date = '2021-01-01',split = 0.75,   horizon_forecast = horizon, maxlag=maxlag,)
    df_for = rolling_forecast(target_name, df, ini_date = ini_date,  horizon_forecast = horizon, maxlag=maxlag)

    return df_for

def make_forecast_all_cantons(target_curve_name, predictors, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None):
    '''
    Function to make the forecast for all the cantons
    
    Important: 
    * By default the function is using the clustering cantons and the data since 2020
    * For the predictor hospCapacity is used as predictor the column ICU_Covid19Patients
    
    params target_curve_name: string to indicate the target column of the predictions
    params predictors: variables that  will be used in model 
    params vaccine: It determines if the vaccine data from owid will be used or not 
    params smooth: It determines if data will be smoothed or not 
    params ini_date: Determines the beggining of the train dataset
    
    returns: Dataframe with the forecast for all the cantons
    '''
    df_all = pd.DataFrame()
    
    # compute the clusters 
    clusters, all_regions,fig = compute_clusters('cases', t=0.8, plot = False)

    for cluster in clusters:

        # getting the data 
        df = get_combined_data(predictors, cluster, vaccine=vaccine, smooth = smooth)
        # filling the nan values with 0
        df = df.fillna(0)
        
        for canton in cluster:

            # apply the model 

            target_name = f'{target_curve_name}_{canton}'

            horizon = 14
            maxlag = 14

            # get predictions and forecast 
            df_for = rolling_forecast(target_name, df, ini_date = ini_date,  horizon_forecast = horizon, maxlag=maxlag)

            df_all= pd.concat([df_all, df_for])
        
    return df_all 

@logger.catch
def save_to_database(df, table_name):
    df.to_sql(table_name, engine, schema= 'switzerland', if_exists = 'replace')

if __name__ == '__main__':
    #target_curve_name = 'hosp'
    canton = 'GE'
    predictors1 = ['cases', 'hosp', 'test']
    predictors2 = ['cases', 'hosp', 'test', 'hospcapacity']

    # compute the predictions in sample and out sample for validation 
    df_val_hosp_up = make_single_prediction('hosp', canton, predictors1, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None, updated_data = True)
    df_val_icu = make_single_prediction('ICU_patients', canton, predictors2, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None, updated_data = False)
    df_val_total = make_single_prediction('total_hosp', canton, predictors2, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None, updated_data = False)
    
    df_val_hosp_cantons = make_predictions_all_cantons('hosp',  predictors1, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None)
    df_val_icu_cantons = make_predictions_all_cantons('ICU_patients',  predictors2, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None)
    df_val_total_cantons = make_predictions_all_cantons('total_hosp',  predictors2, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None)

    logger.info('Generated validation prediction tables')


    # compute the forecast
    df_for_hosp = make_forecast('hosp', canton, predictors1, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None, updated_data = False)
    df_for_icu = make_forecast('ICU_patients', canton, predictors2, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None, updated_data = False)
    df_for_total = make_forecast('total_hosp', canton, predictors2, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None, updated_data = False)
    
    df_for_hosp_cantons = make_forecast_all_cantons('hosp',  predictors1, vaccine = True, smooth= True, ini_date = '2020-03-01', title = None)
    df_for_icu_cantons = make_forecast_all_cantons('ICU_patients',  predictors2, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None)
    df_for_total_cantons = make_forecast_all_cantons('total_hosp',  predictors2, vaccine = True, smooth= True,ini_date = '2020-03-01', title = None)

    df_for_hosp_up = make_forecast('hosp', canton, predictors1, vaccine = True, smooth= True, ini_date = '2020-03-01', title = None,updated_data = True)
    
    logger.info('Finished running forecasts')


    # save the datasets 
    # df_val_hosp_up.to_sql('ml_validation_hosp_up', engine, schema= 'switzerland', if_exists = 'replace')
    save_to_database(df_val_hosp_up, 'ml_validation_hosp_up')
    save_to_database(df_val_icu, 'ml_validation_icu')
    save_to_database(df_val_total, 'ml_validation_total')
    
    
    save_to_database(df_val_hosp_cantons, 'ml_val_hosp_all_cantons')
    save_to_database(df_val_icu_cantons, 'ml_val_icu_all_cantons')
    save_to_database(df_val_total_cantons, 'ml_val_total_all_cantons')
    
    # df_for_hosp.to_sql('ml_forecast_hosp', engine, schema= 'switzerland', if_exists = 'replace') 
    save_to_database(df_for_hosp,'ml_forecast_hosp')
    save_to_database(df_for_hosp_cantons, 'ml_for_hosp_all_cantons')
    # df_for_icu.to_sql('ml_forecast_icu', engine, schema= 'switzerland', if_exists = 'replace') 
    save_to_database(df_for_icu,'ml_forecast_icu')
    save_to_database(df_for_total,'ml_forecast_total')
    save_to_database(df_for_icu_cantons, 'ml_for_icu_all_cantons')
    save_to_database(df_for_total_cantons, 'ml_for_total_all_cantons')
    # df_for_hosp_up.to_sql('ml_forecast_hosp_up', engine, schema= 'switzerland', if_exists = 'replace')
    save_to_database(df_for_hosp_up,'ml_forecast_hosp_up')
    logger.info('Data saved to DB')