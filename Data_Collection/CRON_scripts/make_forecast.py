#!/usr/bin/env python3
"""
Created on Wed Dec 22 15:51:51 2021

@author: eduardoaraujo
"""

import pandas as pd 
import numpy as np 
import copy
import lightgbm as lgb
from sklearn.model_selection import train_test_split
from datetime import datetime, timedelta
from get_data import *
from sqlalchemy import create_engine
engine = create_engine("postgresql://epigraph:epigraph@localhost:5432/epigraphhub")


def lgbm_model(alpha = 0.5, params=None, **kwargs):
    '''
    Return an LGBM model
    :param kwargs:
    :return: LGBMRegressor model
    '''
    if params is None:
        params = {
            'n_jobs': 8,
            'max_depth': 4,
            'max_bin': 63,
            'num_leaves': 255,
#             'min_data_in_leaf': 1,
            'subsample': 0.9,
            'n_estimators': 200,
            'learning_rate': 0.1,
            'colsample_bytree': 0.9,
            'boosting_type': 'gbdt'
        }

    model = lgb.LGBMRegressor(objective='quantile', alpha = alpha, **params)

    return model 


def rolling_predictions(target_name, data,hosp_as_predict, ini_date = '2020-03-01',split = 0.25, horizon_forecast = 14, maxlag=14):
    '''Train multiple models. One for each prediction delta
    :param df_train: training dataframe 
    :param horizon_forecast: Horizon (maximum forecast range)
    :param maxlag: number of past days to consider
    :param neighbours: knn parameter
    :return: Prediction'''
    
    
    target = data[target_name]
    
    if hosp_as_predict == False: 
        
        for i in data.columns:
            
            if i.startswith('hosp') == True:
                data = data.drop(i, axis = 1)
        
    df_lag = build_lagged_features(copy.deepcopy(data), maxlag=maxlag )
    
    #print(type(df_lag.index[0]))
    #print(target.index[0])
    
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

    
        
    X_train, X_test, y_train, y_test = train_test_split(df_lag, target, train_size=split, test_size=1 - split, shuffle=False)
        
    
    # predictions 
    preds5 = np.empty((len(df_lag), horizon_forecast))
    preds50 = np.empty((len(df_lag), horizon_forecast))
    preds95 = np.empty((len(df_lag), horizon_forecast))
    
    forecasts5 = []
    forecasts50 = []
    forecasts95 = []
    
    for T in range(1, horizon_forecast + 1):
        
        tgt = targets[T][:len(X_train)]
        
        #tgtt = targets[T][len(X_train)]
        model5 = lgbm_model(alpha = 0.025)
        model50 = lgbm_model(alpha = 0.5)
        model95 = lgbm_model(alpha = 0.975)
        
        model5.fit(X_train, tgt)
        model50.fit(X_train, tgt)
        model95.fit(X_train, tgt)
        
        #dump(model, f'saved_models/{estimator}_{target_name}_{T}.joblib')
        
        pred5 = model5.predict(df_lag.iloc[:len(targets[T])])
        pred50 = model50.predict(df_lag.iloc[:len(targets[T])])
        pred95 = model95.predict(df_lag.iloc[:len(targets[T])])

        dif = len(df_lag) - len(pred5)
        if dif > 0:
            pred5 = list(pred5) + ([np.nan] * dif)
            
        dif = len(df_lag) - len(pred50)
        if dif > 0:
            pred50 = list(pred50) + ([np.nan] * dif)
            
        dif = len(df_lag) - len(pred95)
        if dif > 0:
            pred95 = list(pred95) + ([np.nan] * dif)
        
        preds5[:, (T - 1)] = pred5
        preds50[:, (T - 1)] = pred50
        preds95[:, (T - 1)] = pred95
        
        forecast5 = model5.predict(df_lag.iloc[-1:])
        forecast50 = model50.predict(df_lag.iloc[-1:])
        forecast95 = model95.predict(df_lag.iloc[-1:])
        
        forecasts5.append(forecast5)
        forecasts50.append(forecast50)
        forecasts95.append(forecast95)
               
        
    # transformando preds em um array
    train_size = len(X_train)
    point = targets[1].index[train_size]

    pred_window = preds5.shape[1]
    llist = range(len(targets[1].index) - (preds5.shape[1]))

    y5 = []
    y50 = []
    y95 = []
    
    x=[]
    for n in llist:
        x.append(targets[1].index[n + pred_window])
        y5.append(preds5[n][-1])
        y50.append(preds50[n][-1])
        y95.append(preds95[n][-1])
        
    forecast_dates = []

    last_day = datetime.strftime(np.array(x)[-1], '%Y-%m-%d')

    a = datetime.strptime(last_day, '%Y-%m-%d')
    
    for i in np.arange(1, horizon_forecast + 1):

        d_i = datetime.strftime(a+timedelta(days=int(i)),'%Y-%m-%d' ) 

        forecast_dates.append(datetime.strptime(d_i, '%Y-%m-%d'))

    return np.array(x), np.array(y5),np.array(y50), np.array(y95),  targets[1], len(X_train), forecast_dates, np.array(forecasts5)[:,0], np.array(forecasts50)[:,0],np.array(forecasts95)[:,0]

def make_single_prediction(target_curve_name, canton, predictors, vaccine = True, smooth= True, hosp_as_predict = False,ini_date = '2020-03-01', title = None, path = None):
    
    '''
    Function to make single prediction 
    
    Important: 
    * By default the function is using the clustering cantons and the data since 2020
    * For the predictor hospCapacity is used as predictor the column ICU_Covid19Patients
    
    params canton: canton of interest 
    params predictors: variables that  will be used in model 
    params vaccine: It determines if the vaccine data from owid will be used or not 
    params smooth: It determines if data will be smoothed or not 
    params hosp_as_predict: It determines if hosp cruves will be use as predictors or not 
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
    
    # atualizando a coluna das Hospitalizações com os dados mais atualizados
    #df_new = get_updated_data()
    
    #df.loc[df_new.index[0]: df_new.index[-1], 'hosp_GE'] = df_new.hosp_GE
    
    # utilizando como último data a data dos dados atualizados:
    #df = df.loc[:df_new.index[-1]]
   
    # apply the model 
    
    target_name = f'{target_curve_name}_{canton}'

    horizon = 14
    maxlag = 14
    
    # get predictions and forecast 
    #date_predsknn, predsknn, targetknn, train_size, date_forecastknn, forecastknn = rolling_predictions(model_knn, 'knn', target_name, df , ini_date = '2021-01-01',split = 0.75,   horizon_forecast = horizon, maxlag=maxlag,)
    x, y5,y50, y95,  target,train_size, forecast_dates, forecasts5, forecasts50,forecasts95 = rolling_predictions(target_name, df , hosp_as_predict,  ini_date = ini_date,split = 0.75,   horizon_forecast = horizon, maxlag=maxlag)
    
    #fig = plot_predictions(target_curve_name, canton, target, train_size, x, y5,y50, y95, forecast_dates, forecasts5, forecasts50,forecasts95, title, path)
    
    df = pd.DataFrame()
    df['target'] = target[14:]
    df['date'] = x
    df['lower'] = y5
    df['median'] = y50
    df['upper'] = y95
    df['train_size'] = [train_size-14]*len(df)
    return df 

def rolling_forecast(target_name, data, hosp_as_predict, ini_date, horizon_forecast = 14, maxlag=14):
    '''Train multiple models. One for each prediction delta
    :param df_train: training dataframe 
    :param horizon_forecast: Horizon (maximum forecast range)
    :param maxlag: number of past days to consider
    :param neighbours: knn parameter
    :return: Prediction'''
    
    target = data[target_name]
    
    if hosp_as_predict == False: 
        
        for i in data.columns:
            
            if i.startswith('hosp') == True:
                data = data.drop(i, axis = 1)
                
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
        
        model5 = lgbm_model(alpha = 0.025)
        model50 = lgbm_model(alpha = 0.5)
        model95 = lgbm_model(alpha = 0.975)
        
        model5.fit(df_lag.iloc[:len(targets[T])], targets[T])
        model50.fit(df_lag.iloc[:len(targets[T])], targets[T])
        model95.fit(df_lag.iloc[:len(targets[T])], targets[T])
        
        # make the forecast 
        forecast5 = model5.predict(df_lag.iloc[-1:])
        forecast50 = model50.predict(df_lag.iloc[-1:])
        forecast95 = model95.predict(df_lag.iloc[-1:])
        
        
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

    return targets[1], forecast_dates, np.array(forecasts5)[:,0], np.array(forecasts50)[:,0], np.array(forecasts95)[:,0]


def make_forecast(target_curve_name, canton, predictors, vaccine = True, smooth= True, hosp_as_predict = False,ini_date = '2020-03-01', title = None, path = None):
    
    # compute the clusters 
    clusters, all_regions,fig = compute_clusters('cases', t=0.8, plot = False)
    
    for cluster in clusters:
    
        if canton in cluster:

            cluster_canton = cluster
            
    
    # getting the data 
    df = get_combined_data(predictors, cluster_canton, vaccine=vaccine, smooth = smooth)
    # filling the nan values with 0
    df = df.fillna(0)
    
    # atualizando a coluna das Hospitalizações com os dados mais atualizados
    #df_new = get_updated_data()
    
    #df.loc[df_new.index[0]: df_new.index[-1], 'hosp_GE'] = df_new.hosp_GE
    
    # utilizando como último data a data dos dados atualizados:
    #df = df.loc[:df_new.index[-1]]
   

    # apply the model 
    
    target_name = f'{target_curve_name}_{canton}'

    horizon = 14
    maxlag = 14
    
    # get predictions and forecast 
    #date_predsknn, predsknn, targetknn, train_size, date_forecastknn, forecastknn = rolling_predictions(model_knn, 'knn', target_name, df , ini_date = '2021-01-01',split = 0.75,   horizon_forecast = horizon, maxlag=maxlag,)
    ydata, dates_forecast, forecast5, forecast50, forecast95 = rolling_forecast(target_name, df, hosp_as_predict = hosp_as_predict, ini_date = ini_date,  horizon_forecast = horizon, maxlag=maxlag)

    #fig = plot_forecast(target_curve_name, canton, ydata, dates_forecast, forecast5, forecast50, forecast95)

    df = pd.DataFrame()
    
    df['date'] = dates_forecast
    df['lower'] = forecast5
    df['median'] = forecast50
    df['upper'] = forecast95
    return df 


if __name__ == '__main__':
    target_curve_name = 'hosp'
    canton = 'GE'
    predictors = ['cases', 'hosp', 'test', 'hospcapacity']

    # compute the predictions in sample and out sample for validation 
    df_val = make_single_prediction(target_curve_name, canton, predictors, vaccine = True, smooth= True, hosp_as_predict = False,ini_date = '2020-03-01', title = None, path = None)
        
    # compute the forecast
    df_for = make_forecast(target_curve_name, canton, predictors, vaccine = True, smooth= True, hosp_as_predict = False,ini_date = '2020-03-01', title = None, path = None)
        
    # save the datasets 
    df_val.to_sql('ml_validation', engine, schema= 'switzerland', if_exists = 'replace')
    df_for.to_sql('ml_forecast', engine, schema= 'switzerland', if_exists = 'replace')