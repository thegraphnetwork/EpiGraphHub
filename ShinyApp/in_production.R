arq_data1 <- reactiveValues(data = NULL)
observeEvent(input$file_data1,{
  showNotification("Importing file.",duration = 3,type = "message")
  dat <- data.table::fread(input$file_data1$datapath,stringsAsFactors = F,
                           header = T,
                           sep = ";")
  if(ncol(dat)<=2){
    dat <- data.table::fread(input$file_data1$datapath,stringsAsFactors = F,
                             header = T,
                             sep = ",")  
  }
  
  if ("patinfo_ID" %in% names(dat) &
      "patinfo_resadmin1" %in% names(dat) &
      "patcourse_status" %in% names(dat)){
    
    # Data wagling
    arq_data1$data <- dat %>% 
      # removing additional information-less rows in the df
      filter(!is.na(report_date)) %>%
      # Transforming all dates properly
      mutate(report_date = as.Date(report_date),
             consultation_dateHF = as.Date(consultation_dateHF),
             Lab_datetaken = as.Date(Lab_datetaken),
             Lab_resdate = as.Date(Lab_resdate),
             patcourse_dateonset = as.Date(patcourse_dateonset),
             patcourse_datedeath = as.Date(patcourse_datedeath),
             patcourse_datedischarge = as.Date(patcourse_datedischarge),
             # logical variable = was case reported or no (necessary because of the missing dates that will be inserted)
             # we use report_date; if there isnt a date, the case cannot be counted
             # Note that reported cases are those that are in the linelist
             # Confirmed cases will be added later
             is_reported = case_when(!is.na(report_date) ~ 1,
                                     TRUE ~ 0),
             # Creating age_group variable
             age_group = cut(as.integer(patinfo_ageonset_years), 
                             breaks = c(-Inf, 50, Inf), labels = c("less than 50 y.o.","50+ y.o.")),
             # impute missing report_dates with date of consult, date lab taken, onset date, 
             # death date or discharge date or lab result dats in that order
             report_date = if_else(is.na(report_date), consultation_dateHF, report_date),
             report_date = if_else(is.na(report_date), Lab_datetaken, report_date),
             report_date = if_else(is.na(report_date), patcourse_dateonset, report_date),
             report_date = if_else(is.na(report_date), patcourse_datedeath, report_date),
             report_date = if_else(is.na(report_date), patcourse_datedischarge, report_date),
             report_date = if_else(is.na(report_date), Lab_resdate, report_date)) %>%
      # if report date is still NA, drop from analysis.
      filter(!is.na(report_date))
    
    assign("data1", arq_data1$data, envir = .GlobalEnv)
    
    output$arq_data1_imported = DT::renderDT(
      arq_data1$data,
      options = list(scrollX = TRUE, pageLength = 5, language = list(search = 'Search:'),
                     initComplete = JS(
                       "function(settings, json) {",
                       "$(this.api().table().header()).css({'background-color': '#24ccff', 'color': '#000000'});",
                       "}")
      )
    )
    aux_data1=matrix(sapply(unlist(arq_data1$data), nchar),byrow = F,nrow = dim(arq_data1$data)[1])
    aux_data1B=data.frame(names(arq_data1$data),as.vector(sapply(arq_data1$data, typeof)),
                          as.vector(apply(aux_data1,2,function(x){sum(x==0,na.rm = T)})),
                          apply(aux_data1,2,function(x){sum(is.na(x)==TRUE,na.rm = T)}),
                          row.names = NULL)
    
    output$var_data1 = DT::renderDT(
      aux_data1B,
      options = list(scrollX = TRUE, pageLength = 5, language = list(search = 'Search:'),
                     initComplete = JS(
                       "function(settings, json) {",
                       "$(this.api().table().header()).css({'background-color': '#24ccff', 'color': '#000000'});",
                       "}")
      ),
      rownames= FALSE,
      colnames=c("Variable","Type","Empty values","Missing data")
    )
    assign("aux_data1B",aux_data1B,envir = .GlobalEnv)
    
    #selecionar camps da variavel data1
    arq_data1_names <- names(arq_data1$data)
    cb_options_data1 <- list()
    cb_options_data1[arq_data1_names] <- arq_data1_names
    updateSelectInput(session, "arq_data1_xaxis",
                      label = "X-Axis",
                      choices = cb_options_data1,
                      selected = "")
    updateSelectInput(session, "arq_data1_yaxis",
                      label = "Y-Axis",
                      choices = cb_options_data1,
                      selected = "")
    
    # patinfo_resadmin1
    # testing if the names in the cleanCSV are correct or not
    test_incorrect_1 <- arq_data1$data$patinfo_resadmin1 %in% c(dictionary %>% filter(AdminLvl == "1") %>% 
                                                                  dplyr::select(Correct))
    # Loop to test individually if each patinfo_resadmin1 entry is correct or not
    if(any(test_incorrect_1==TRUE)){
      for(i in seq_along(arq_data1$data$patinfo_resadmin1)){
        if(test_incorrect[i] == FALSE) {
          index <- dictionary$Incorrect %in% arq_data1$data$patinfo_resadmin1[i]
          arq_data1$data$resadmin1_correct[i] <- dictionary$Correct[index == TRUE]
        }
        arq_data1$data$resadmin1_correct <- ifelse(is.na(arq_data1$data$resadmin1_correct), "No Info", arq_data1$data$resadmin1_correct)
      }
    }else{
      arq_data1$data$resadmin1_correct <- arq_data1$data$patinfo_resadmin1
      arq_data1$data$resadmin1_correct <- ifelse(is.na(arq_data1$data$resadmin1_correct), "No Info", arq_data1$data$resadmin1_correct)
    }
    
    # patinfo_resadmin2
    # testing if the names in the cleanCSV are correct or not
    test_incorrect_2 <- arq_data1$data$patinfo_resadmin2 %in% c(dictionary %>% filter(AdminLvl == "2") %>% 
                                                                  dplyr::select(Correct))
    # Loop to test individually if each patinfo_resadmin1 entry is correct or not
    if(any(test_incorrect_2==TRUE)){
      for(i in seq_along(arq_data1$data$patinfo_resadmin2)){
        if(test_incorrect[i] == FALSE) {
          index <- dictionary$Incorrect %in% arq_data1$data$patinfo_resadmin2[i]
          arq_data1$data$resadmin2_correct[i] <- dictionary$Correct[index == TRUE]
        }
        arq_data1$data$resadmin2_correct <- ifelse(is.na(arq_data1$data$resadmin2_correct), "No Info", arq_data1$data$resadmin2_correct)
        
      }
    }else{
      arq_data1$data$resadmin2_correct <- arq_data1$data$patinfo_resadmin2
      arq_data1$data$resadmin2_correct <- ifelse(is.na(arq_data1$data$resadmin2_correct), "No Info", arq_data1$data$resadmin2_correct)
    }
    
    
    # Expanding df with missing report dates for all regions
    df_expanded <- arq_data1$data %>% 
      # complete to include all dates, even when case was not recorded 
      complete(report_date = seq.Date(min(report_date, na.rm = TRUE), 
                                      max(report_date, na.rm = TRUE), by = "day")) %>%
      # expand to include all dates in all regions
      expand(resadmin1_correct, report_date) %>%
      filter(!is.na(report_date))
    
    # Joining with df
    arq_data1$data<- arq_data1$data%>% 
      right_join(df_expanded) %>%
      # creating an epiweek variable 
      mutate(epiweek = MMWRweek(report_date)$MMWRweek)
    
  }else{
    sendSweetAlert(
      session = session,
      title = "Error!",
      text = "You should import a file that have at least those columns:\n
                patinfo_ID, patinfo_resadmin1, patcourse_status",
      type = "error"
    )
  }
})

#arq_data2 <- reactiveValues(data = NULL)
observeEvent(input$file_data2,{
  showNotification("Importing GPKG file.",duration = 3,type = "message")
  layers <- st_layers(input$file_data2$datapath)
  layer_name <- layers$name[which(layers$features==max(layers$features))]
  df_gpkg <- rgdal::readOGR(input$file_data2$datapath,encoding = "UTF-8",
                            layer = layer_name)
  
  df_gpkg$NAME_1 <- gsub("Ã©","é",df_gpkg$NAME_1)
  assign("df_gpkg", df_gpkg, envir = .GlobalEnv)
  
  #Reprojecting gpkg to wgs84
  df_gpkg <- spTransform(df_gpkg, crs(pop))
  
  # Extracting centroids
  centroids_df <- data.frame(coordinates(df_gpkg)) %>%
    rename(X = X1,
           Y = X2)
  
  # Inserting centroids into gpkg
  df_gpkg <- cbind(df_gpkg, centroids_df)
  
  # Creating a spatialDF of centroids to extract raster values
  centroids <- SpatialPointsDataFrame(coords = centroids_df,
                                      data = data.frame(df_gpkg, centroids_df),
                                      proj4string = crs(df_gpkg))
  
  # Extract all pop values in each polygons (should take a while)
  pop_vals <- raster::extract(pop, df_gpkg)
  
  # Mean population for each polygon
  pop_mean <- unlist(lapply(pop_vals, function(x) if (!is.null(x)) mean(x, na.rm=TRUE) else NA ))
  
  # Sum population for each polygon
  pop_sum <- unlist(lapply(pop_vals, function(x) if (!is.null(x)) sum(x, na.rm=TRUE) else NA ))
  
  # Creating a data.frame with results
  pop_data <- data.frame(NAME_1 = df_gpkg$NAME_1,
                         pop_mean = pop_mean,
                         pop_sum = pop_sum)
  assign("pop_data", pop_data, envir = .GlobalEnv)
})

output$combine_data <- renderUI({
  actionButton("combine_data_button", label = "Combine data",
               style="color: #000000; background-color: #fff; border-color: #24ccff")
})


# Data tab
observeEvent(input$combine_data_button, {
  if(exists("data1") & exists("df_gpkg") & exists("country_info")){
    showNotification("Combining both .csv and .gpkg files.",duration = 5,type = "message")
    
    # Creating new object with country linelist
    df2 <- arq_data1$data
    
    # Calculate daily reported cases
    reported_region <- df2 %>%
      # summarise the number of reported each day in each region
      group_by(resadmin1_correct, report_date) %>%
      summarise(reported_this_day = sum(is_reported, na.rm = T))
    
    # Calculate daily confirmed cases
    confirmed_region <-  df2 %>%
      # summarise the number of confirmed cases each day in each region
      group_by(resadmin1_correct, report_date) %>%
      summarise(confirmed_this_day = sum(is_reported[report_classif == "CONFIRMED"], na.rm = T))
    
    # Calculate daily deaths
    deaths_region <- df2 %>%
      # summarise the number of deaths each day in each region
      group_by(resadmin1_correct, report_date) %>%
      summarise(deaths_this_day = sum(is_reported[patcourse_status == "DEAD"], na.rm = T))
    
    # Calculate daily discharges as above
    discharges_region <- df2 %>%
      # summarise the number of deaths each day in each region
      group_by(resadmin1_correct, report_date) %>%
      summarise(discharges_this_day = sum(is_reported[!is.na(patcourse_datedischarge)], na.rm = T))
    
    # Combine reported cases, confirmed cases, deaths and discharges into a single df
    df_daily <- inner_join(reported_region, confirmed_region,
                           by= c("report_date", "resadmin1_correct"))  %>%
      right_join(deaths_region,
                 by= c("report_date", "resadmin1_correct")) %>%
      left_join(discharges_region,
                by= c("report_date", "resadmin1_correct")) %>%
      # sort by date within each region
      arrange(resadmin1_correct, report_date) %>%
      # delete useless vars
      dplyr::select(report_date, resadmin1_correct, reported_this_day,
                    confirmed_this_day, deaths_this_day, discharges_this_day) %>%
      # arranging by regions and report dates (cumsum seems to work only when arranging or grouping;
      # in this case, it only worked correctly when arranging)
      arrange(resadmin1_correct, report_date) %>%
      # Calculating cumulative totals
      mutate(epiweek = MMWRweek(report_date)$MMWRweek,
             cum_reported = cumsum(reported_this_day),
             cum_confirmed = cumsum(confirmed_this_day),
             cum_deaths = cumsum(deaths_this_day),
             cum_discharges = cumsum(discharges_this_day)) %>%
      # removing NA regions and dates (artifacts that may have been up to this step)
      filter(!is.na(resadmin1_correct) | is.na(report_date)) %>%
      group_by(resadmin1_correct) %>%
      # calculating crude case fatality rate at each time point
      mutate(CFR = round(100 * cum_deaths/cum_confirmed, digits = 2)) %>%
      # inserting population data
      left_join(pop_data, by = c("resadmin1_correct" = "NAME_1")) %>%
      # calculating incidence and mortality rates per 100,000 for maps
      mutate(incidence_reported = cum_reported / pop_sum * 100000,
             incidence_confirmed = cum_confirmed / pop_sum * 100000,
             mortality = cum_deaths / pop_sum * 100000) %>%
      # calculating log of each variable
      mutate(reported_log = log10(reported_this_day + 1),
             confirmed_log = log10(confirmed_this_day + 1),
             deaths_log = log10(deaths_this_day + 1),
             discharges_log = log10(discharges_this_day + 1),
             cum_reported_log = log10(cum_reported + 1),
             cum_confirmed_log = log10(cum_confirmed + 1),
             cum_deaths_log = log10(cum_deaths + 1),
             cum_discharges_log = log10(cum_discharges + 1),
             incidence_reported_log = log10(incidence_reported + 1),
             incidence_confirmed_log = log10(incidence_confirmed + 1),
             mortality_log = log10(mortality + 1)) %>%
      # calculating number and log of cases, deaths and discharges in the past week
      mutate(reported_past_7 = rollsum(x = reported_this_day, k = 7, align = "right",
                                       fill = na.fill(reported_this_day, 0)),
             confirmed_past_7 = rollsum(x = confirmed_this_day, k = 7, align = "right",
                                        fill = na.fill(confirmed_this_day, 0)),
             deaths_past_7 = rollsum(x = deaths_this_day, k = 7, align = "right",
                                     fill = na.fill(deaths_this_day, 0)),
             discharges_past_7 = rollsum(x = discharges_this_day, k = 7, align = "right",
                                         fill = na.fill(discharges_this_day, 0)),
             reported_past_7_log = log10(reported_past_7 + 1),
             confirmed_past_7_log = log10(confirmed_past_7 + 1),
             deaths_past_7_log = log10(deaths_past_7 + 1),
             discharges_past_7_log = log10(discharges_past_7 + 1)) %>%
      # calculating number and log of cases, deaths and discharges in the past two weeks
      mutate(reported_past_14 = rollsum(x = reported_this_day, k = 14, align = "right",
                                        fill = na.fill(reported_this_day, 0)),
             confirmed_past_14 = rollsum(x = confirmed_this_day, k = 14, align = "right",
                                         fill = na.fill(confirmed_this_day, 0)),
             deaths_past_14 = rollsum(x = deaths_this_day, k = 14, align = "right",
                                      fill = na.fill(deaths_this_day, 0)),
             discharges_past_14 = rollsum(x = discharges_this_day, k = 14, align = "right",
                                          fill = na.fill(discharges_this_day, 0)),
             reported_past_14_log = log10(reported_past_14 + 1),
             confirmed_past_14_log = log10(confirmed_past_14 + 1),
             deaths_past_14_log = log10(deaths_past_14 + 1),
             discharges_past_14_log = log10(discharges_past_14 + 1)) %>%
      # calculating number and log of cases, deaths and discharges in the 14 day of the previous two weeks
      mutate(reported_prev_14 = lag(n = 14, reported_past_14),
             confirmed_prev_14 = lag(n = 14, confirmed_past_14),
             deaths_prev_14 = lag(n = 14, deaths_past_14),
             discharges_prev_14 = lag(n = 14, discharges_past_14),
             reported_prev_14_log = log10(reported_prev_14 + 1),
             confirmed_prev_14_log = log10(confirmed_prev_14 + 1),
             deaths_prev_14_log = log10(deaths_prev_14 + 1),
             discharges_prev_14_log = log10(discharges_prev_14 + 1)) %>%
      # calculating trend and log cases, deaths and discharges in the past week
      mutate(reported_trend = rollmean(x = reported_this_day, k = 7, align = "right",
                                       fill = na.fill(reported_this_day, NA)),
             confirmed_trend = rollmean(x = confirmed_this_day, k = 7, align = "right",
                                        fill = na.fill(confirmed_this_day, NA)),
             deaths_trend =rollmean(x = deaths_this_day, k = 7, align = "right",
                                    fill = na.fill(deaths_this_day, NA)),
             discharges_trend =rollmean(x = discharges_this_day, k = 7, align = "right",
                                        fill = na.fill(discharges_this_day, NA)),
             reported_trend_log = log10(reported_trend + 1),
             confirmed_trend_log = log10(confirmed_trend + 1),
             deaths_trend_log = log10(deaths_trend + 1),
             discharges_trend_log = log10(discharges_trend + 1))
    
    # Combine into national plot
    df_daily_national <- df_daily %>%
      dplyr::select(report_date, resadmin1_correct, reported_this_day, confirmed_this_day,
                    deaths_this_day, discharges_this_day) %>%
      # pulling values from dplyr::selected columns
      pivot_wider(id_cols = report_date, names_from = resadmin1_correct,
                  values_from = c(reported_this_day, confirmed_this_day,
                                  deaths_this_day, discharges_this_day))
    assign("df_daily_national",df_daily_national, envir = .GlobalEnv)
    # identifying which columns pertain to cases, deaths and discharges
    # there should be a more elegant way to do this.
    reported_cols <- which(!is.na(str_extract(names(df_daily_national), pattern = "reported")))
    confirmed_cols <- which(!is.na(str_extract(names(df_daily_national), pattern = "confirmed")))
    deaths_cols <- which(!is.na(str_extract(names(df_daily_national), pattern = "deaths")))
    discharges_cols <- which(!is.na(str_extract(names(df_daily_national), pattern = "discharges")))
    
    # sum across rows to generate national values
    df_daily_national <- df_daily_national %>% 
      mutate(reported_this_day = rowSums(.[reported_cols],na.rm = T),
             confirmed_this_day = rowSums(.[confirmed_cols],na.rm = T),
             deaths_this_day = rowSums(.[deaths_cols],na.rm = T),
             discharges_this_day = rowSums(.[discharges_cols],na.rm = T)) %>% 
      dplyr::select(report_date, reported_this_day, confirmed_this_day, 
                    deaths_this_day, discharges_this_day) %>% 
      # creating a cumulative sum, 7- and 14-day average of cases, deaths and discharges
      mutate(epiweek = MMWRweek(report_date)$MMWRweek,
             cum_reported = cumsum(reported_this_day),
             cum_confirmed = cumsum(confirmed_this_day),
             cum_deaths = cumsum(deaths_this_day),
             cum_discharges = cumsum(discharges_this_day),
             reported_7day_avg = rollmean(x = reported_this_day, k = 7, align = "right",  
                                          fill = na.fill(reported_this_day, "extend")),
             confirmed_7day_avg = rollmean(x = confirmed_this_day, k = 7, align = "right",  
                                           fill = na.fill(confirmed_this_day, "extend")),
             deaths_7day_avg = rollmean(x = deaths_this_day, k = 7, align = "right",  
                                        fill = na.fill(deaths_this_day, "extend")),
             discharges_7day_avg = rollmean(x = discharges_this_day, k = 7, align = "right",  
                                            fill = na.fill(discharges_this_day, "extend")),
             reported_14day_avg = rollmean(x = reported_this_day, k = 14, align = "right",  
                                           fill = na.fill(reported_this_day, "extend")),
             confirmed_14day_avg = rollmean(x = confirmed_this_day, k = 14, align = "right",  
                                            fill = na.fill(confirmed_this_day, "extend")),
             deaths_14day_avg = rollmean(x = deaths_this_day, k = 14, align = "right",  
                                         fill = na.fill(deaths_this_day, "extend")),
             discharges_14day_avg = rollmean(x = discharges_this_day, k = 14, align = "right",  
                                             fill = na.fill(discharges_this_day, "extend"))) 
    
    count_of_cases_reported <- max(df_daily_national$cum_reported, na.rm = T)
    count_of_cases_confirmed <- max(df_daily_national$cum_confirmed, na.rm = T)
    count_of_deaths <- max(df_daily_national$cum_deaths, na.rm = T)
    count_of_discharges <- max(df_daily_national$cum_discharges, na.rm = T)
    
    current_crude_CFR <-  round(100 * max(df_daily_national$cum_deaths, na.rm = T) / 
                                  max(df_daily_national$cum_confirmed, na.rm = T), 2)
    
    # Similar to daily df, but grouped by epiweek
    df_ew <- df_daily %>%
      group_by(resadmin1_correct, epiweek) %>%
      summarise(reported_this_week = sum(reported_this_day),
                confirmed_this_week = sum(confirmed_this_day),
                deaths_this_week = sum(deaths_this_day),
                discharges_this_week = sum(discharges_this_day)) %>%
      mutate(cum_reported = cumsum(reported_this_week),
             cum_confirmed = cumsum(confirmed_this_week),
             cum_deaths = cumsum(deaths_this_week),
             cum_discharges = cumsum(discharges_this_week)) %>%
      group_by(resadmin1_correct) %>%
      # Calculate crude CFR at each time point
      mutate(CFR = round(100 * cum_deaths/cum_confirmed, digits = 2)) %>% 
      left_join(pop_data, by = c("resadmin1_correct" = "NAME_1")) %>%
      # calculating incidence and mortality rates per 100,000 for maps
      mutate(incidence_reported = cum_reported / pop_sum * 100000,
             incidence_confirmed = cum_confirmed / pop_sum * 100000,
             mortality = cum_deaths / pop_sum * 100000) %>%
      # calculating log of each variable
      mutate(reported_log = log10(reported_this_week + 1),
             confirmed_log = log10(confirmed_this_week + 1),
             deaths_log = log10(deaths_this_week + 1),
             discharges_log = log10(discharges_this_week + 1),
             cum_reported_log = log10(cum_reported + 1),
             cum_confirmed_log = log10(cum_confirmed + 1),
             cum_deaths_log = log10(cum_deaths + 1),
             cum_discharges_log = log10(cum_discharges + 1),
             incidence_reported_log = log10(incidence_reported + 1),
             incidence_confirmed_log = log10(incidence_confirmed + 1),
             mortality_log = log10(mortality + 1)) %>%
      # calculating trend and log cases, deaths and discharges in the past week
      mutate(reported_trend = rollmean(x = reported_this_week, k = 7, align = "right",  
                                       fill = na.fill(reported_this_week, NA)),
             confirmed_trend = rollmean(x = confirmed_this_week, k = 7, align = "right",  
                                        fill = na.fill(confirmed_this_week, NA)),
             deaths_trend =rollmean(x = deaths_this_week, k = 7, align = "right",  
                                    fill = na.fill(deaths_this_week, NA)),
             discharges_trend =rollmean(x = discharges_this_week, k = 7, align = "right",  
                                        fill = na.fill(discharges_this_week, NA)),
             reported_trend_log = log10(reported_trend + 1),
             confirmed_trend_log = log10(confirmed_trend + 1),
             deaths_trend_log = log10(deaths_trend + 1),
             discharges_trend_log = log10(discharges_trend + 1))
    
    df_gpkg_daily <- df_gpkg %>%
      # converting to sf, easier to make maps
      st_as_sf() %>%
      # joining daily df with gpkg
      full_join(df_daily, by = c("NAME_1" = "resadmin1_correct")) %>%
      # this part of the code is aimed to fill the regions without cases with data
      # this way plotting the maps wont show holes
      # replacing NA with zeros in all epidemiological variables 
      mutate_at(vars(reported_this_day:discharges_trend_log), ~replace_na(., 0)) %>%
      # inserting the max report_date in the regions with missing data
      mutate(report_date = if_else(is.na(report_date), max(na.omit(report_date)), report_date))
    
    # Merging country daily EW and gpkg
    df_gpkg_ew <- df_gpkg %>%
      st_as_sf() %>%
      full_join(df_ew, by = c("NAME_1" = "resadmin1_correct")) %>%
      # this part of the code is aimed to fill the regions without cases with data
      # this way plotting the maps wont show holes
      # replacing NA with zeros in all epidemiological variables 
      mutate_at(vars(reported_this_week:discharges_trend_log), ~replace_na(., 0)) %>%
      # inserting the max epiweek in the regions with missing data
      mutate(epiweek = if_else(is.na(epiweek), max(na.omit(epiweek)), epiweek))
  }else{
    showModal(modalDialog(
      title = "Info",
      "Please, in order to get all charts updated, it is required to upload the country data file in .csv and its correspondent .gpkg file.",
      easyClose = TRUE,
      footer = NULL
    ))
  }
  
})


output$clean_data <- renderUI({
  if(!is.null(arq_data1$data)){
    actionButton("clean_data_button", label = "Clean data",
                 style="color: #000000; background-color: #fff; border-color: #24ccff")
  }
})

observeEvent(input$clean_data_button,{
  showNotification("Data is being cleaning.",duration = 5,type = "message")
})

observeEvent(input$HelpBox_data1,{
  showModal(modalDialog(
    title = "Info",
    "Please, in order to get all charts updated, it is required to upload the country data file in .csv and its correspondent .gpkg file.",
    easyClose = TRUE,
    footer = NULL
  ))
})

observeEvent(input$HelpBox_gpkg,{
  showModal(modalDialog(
    title = "Info",
    "Please, in order to get all charts updated, it is required to upload the country data file in .csv and its correspondent .gpkg file.",
    easyClose = TRUE,
    footer = NULL
  ))
})

output$downloadReport <- downloadHandler(
  filename = function(){
    if(input$selected_pdf_file=="Senegal"){
      "Senegal_Covid_Report.pdf"
    }else{
      "BurkinaFaso_Covid_Report.pdf"
    }
  },
  content = function(file) {
    if(input$selected_pdf_file=="Senegal"){
      file.copy('Others/Senegal.pdf', file)
    }else{
      file.copy('Others/BurkinaFaso.pdf', file)
    }
  }
)

output$select_pdf_file <- renderUI({
  selectInput("selected_pdf_file","",
              choices = list("Senegal", "Burkina Faso"))
})
