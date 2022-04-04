shinyServer(function(input, output, session) {
  
  df_country_server <- reactive(
    df_country
  )
  
  africa_map_server <- reactive(
    africa_map
  )
  
  df_risk_MRI_1_server <- reactive(
    df_risk_MRI_1
  )
  
  df_risk_TRI_1_server <- reactive(
    df_risk_TRI_1
  )

  # Selecting country
  output$select_country <- renderUI({
    selectInput("selected_country",
                label = "Select a country:",
                choices = countries_list, #countries_list,
                selected = countries_list[1]) #countries_list[1]
  })
  
  output$select_region <- renderUI({
    selectInput("selected_region",
                label = "Select a region:",
                choices = regions_list,
                selected = regions_list[1])
  })
  
  output$select_date <- renderUI({
    dateRangeInput("selected_dates", "Date range:",
                   start  = min_date,
                   end    = max_date,
                   min    = min_date,
                   max    = max_date,
                   format = "dd/mm/yy",
                   separator = " - ")
  })
  
  observeEvent(input$selected_country,{
    
    output$country_chosen <- renderText({
      paste0("<b>Country: </b>", input$selected_country)
    })
    
    # country_selected <- owid_countries %>% 
    #   filter(Country == "Senegal")
    
    country_selected <- reactive({
      df_country_server() %>% 
        filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
        filter(Country == input$selected_country)
    })
    
    date_reactive <- reactive({
      country_selected() %>% 
        arrange(desc(date)) %>% 
        distinct(Country, .keep_all = T) %>% 
        dplyr::select(date) %>% 
        pull
    })
    
    output$last_update <- renderText({
      paste0(
        "<b>Last update: </b>",
        substr(date_reactive(),9,10),"/",
        substr(date_reactive(),6,7),"/",
        substr(date_reactive(),1,4)
      )
    })
    names(country_selected)
    output$confirmedCases <- renderText({
      prettyNum(
        country_selected() %>% 
          #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
          filter(date == max_date) %>% 
          distinct(Country, .keep_all = T) %>% 
          dplyr::select(total_cases) %>% 
          pull,
        decimal.mark = ",", big.mark = ".")
    })
    
    output$new_cases <- renderText({
      paste0(prettyNum(
        country_selected() %>% 
          #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
          filter(date == max_date) %>% 
          dplyr::select(new_cases) %>% 
          pull,
        decimal.mark = ",", big.mark = ".")," cases this week")
    })
    
    output$Deaths <- renderText({
      prettyNum(
        country_selected() %>% 
          #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
          filter(date == max_date) %>% 
          distinct(Country, .keep_all = T) %>% 
          dplyr::select(total_deaths) %>% 
          pull,
        decimal.mark = ",", big.mark = ".")
    })
    
    output$newDeaths <- renderText({
      paste0(prettyNum(
        country_selected() %>% 
          #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
          filter(date == max_date) %>%
          dplyr::select(new_deaths) %>% 
          pull,
        decimal.mark = ",", big.mark = ".")," deaths this week")
    })
    
    output$CasesPerMillion <- renderText({
      prettyNum(
        country_selected() %>% 
          #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
          filter(date == max_date) %>%
          dplyr::select(total_cases_per_million) %>% 
          pull,
        decimal.mark = ",", big.mark = ".")
    })
    
    output$DeathsPerMillion <- renderText({
      paste0(prettyNum(
        country_selected() %>% 
          #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
          filter(date == max_date) %>%
          dplyr::select(total_deaths_per_million) %>% 
          pull,
        decimal.mark = ",", big.mark = ".")," deaths per million")
    })
    
    growth_rate_tab <- reactive({
      country_selected() %>% 
        #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
        dplyr::select(date, Epiweek, weekly_new_cases) %>% 
        distinct(Epiweek, .keep_all = T) %>% 
        # Cases in the past week vs cases two weeks ago
        mutate(diff_cases = weekly_new_cases - lag(weekly_new_cases,1), 
               week_growth = diff_cases/lag(weekly_new_cases,1),
               week_growth_perc = 100 * week_growth, 
               # formula to convert weekly_growth to daily_growth equivalent
               growth = (((1 + week_growth) ^ (1/7)) - 1), 
               growth_perc = 100 * growth) %>% 
        slice(-1)
    })
    
    # plot
    output$ts_growth_rate_tab <- renderPlotly({
      plot_ly(growth_rate_tab(), x = ~date) %>%
        # ribbons are polygons in the background
        add_ribbons(x = ~date, ymin = 0, 
                    # ymax needs to remove Inf or otherwise plotly will explode to a large ymax
                    ymax = max(growth_rate_tab()$week_growth_perc[growth_rate_tab()$week_growth_perc != Inf], 
                               na.rm = TRUE),
                    color = I("red"), # red for increase in growth rate
                    opacity = 0.5,
                    hoverinfo = "none", # removes the hovering text (it is not needed in here)
                    showlegend = FALSE, # to remove the unneeded trace info 
                    line = list(color = "rgba(0, 0, 0, 0)")) %>% # red for increase in growth rate
        add_ribbons(x = ~date, ymax = 0, 
                    ymin = min(growth_rate_tab()$week_growth_perc[growth_rate_tab()$week_growth_perc != Inf], 
                               na.rm = TRUE),
                    color = I("green"), # green for decrease in growth rate
                    opacity = 0.5,
                    hoverinfo = "none", 
                    showlegend = FALSE, 
                    line = list(color = "rgba(0, 0, 0, 0)")) %>% # green for decrease in growth rate
        add_trace(y = ~week_growth_perc, 
                  name = "Weekly growth rate", 
                  type = "scatter", # configuring trace as scatterplot
                  mode = "markers+lines", # lines + points
                  color = I("black"),
                  hoverinfo = "text+x",
                  text = ~paste0("<b>Date of reporting: </b>", date,
                                 "<br><b>Epidemiological week: </b>", Epiweek,
                                 "<br><b>Weekly growth rate: </b>", paste0(round(week_growth_perc, 2), "%"))) %>%
        layout(
          title = paste0("<br>Week-on-week growth rate of new COVID-19 cases in ", input$selected_country),
          yaxis = list(
            title = "Average daily growth rate (%)<br>each week"),
          xaxis = list(
            title = "Date of Reporting",
            type = "date",
            tickformat = "%b<br>%d (%a)",
            rangeslider = list(type = "date")
          )
        )
    })
    
    output$table_all_contries <- DT::renderDT(
      country_selected() %>% 
        arrange(desc(date)) %>% 
        distinct(Epiweek, .keep_all = T) %>% 
        #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
        dplyr::rename(
          Cases = total_cases,
          Deaths = total_deaths,
          `Cases per million` = total_cases_per_million,
          `Deaths per million` = total_deaths_per_million
          ) %>% 
        mutate(
          `Crude \nCFR (%)` = round(100 * Deaths / Cases, digits = 1)
        ) %>% 
        dplyr::select(Country, Cases,`Cases per million`, Deaths, `Deaths per million`) %>% 
        arrange(-Cases) %>% 
        ungroup(),
      options = list(pageLength = 10, language = list(search = 'Search:'),
                     initComplete = JS(
                       "function(settings, json) {",
                       "$(this.api().table().header()).css({'background-color': '#24ccff', 'color': '#000000'});",
                       "}")
      )
    )
    
    epi_curve_ll <- reactive({
      country_selected() %>% 
        #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
        dplyr::select(date, new_cases, new_deaths) %>% 
        mutate(seven_day_case_avg = rollmean(x = new_cases, k = 7, align = "right",  
                                             fill = na.fill(new_cases, 0)),
               fourteen_day_case_avg = rollmean(x = new_cases, k = 14, align = "right",  
                                                fill = na.fill(new_cases, 0)),
               seven_day_death_avg = rollmean(x = new_deaths, k = 7, align = "right",  
                                              fill = na.fill(new_deaths, 0)),
               fourteen_day_death_avg = rollmean(x = new_deaths, k = 14, align = "right",  
                                                 fill = na.fill(new_deaths, 0)))
    })
    
    output$ts_epi_curve_ll_confirmed <- renderPlotly({
      epi_curve_ll() %>%
        plot_ly(x = ~date) %>%
        add_bars(y = ~new_cases, 
                 # colors = ~mycolors,
                 name = "Cases this day", 
                 hoverinfo = "text+x",
                 text = ~paste0("<b>Confirmed cases in ", input$selected_country, ": </b>", total_cases)) %>%
        add_trace(y = ~seven_day_case_avg, 
                  name = "7-day rolling avg. cases", 
                  type = "scatter", 
                  mode = "lines", 
                  line = list(color = "black", dash = "dash"),
                  hoverinfo = "text+x",
                  text = ~paste("<b>7-day rolling avg.: </b>", round(seven_day_case_avg, 2))) %>%
        add_trace(y = ~fourteen_day_case_avg, 
                  name = "14-day rolling avg. cases", 
                  type = "scatter",
                  mode = "lines", 
                  line = list(color = "black", dash = "dot"),
                  hoverinfo = "text+x",
                  text = ~paste0("<b>14-day rolling avg.: </b>", round(fourteen_day_case_avg, 2))) %>%
        layout(hovermode = "x unified",
               title = paste0("Daily COVID-19 confirmed cases in ", input$selected_country),
               yaxis = list(title = "Absolute number of COVID-19 confirmed cases"),
               xaxis = list(title = "Date of Reporting",
                            type = "date",
                            tickformat = "%b %d (%a)",
                            rangeslider = list(type = "date"))
        )
    })
    
    output$ts_epi_curve_ll_deaths<- renderPlotly({
      epi_curve_ll() %>%
        plot_ly(x = ~date) %>%
        add_bars(y = ~new_deaths, 
                 # colors = ~mycolors,
                 name = "Cases this day", 
                 hoverinfo = "text+x",
                 text = ~paste0("<b>Deaths in ", input$selected_country, ": </b>", new_deaths)) %>%
        add_trace(y = ~seven_day_death_avg, 
                  name = "7-day rolling avg. cases", 
                  type = "scatter", 
                  mode = "lines", 
                  line = list(color = "black", dash = "dash"),
                  hoverinfo = "text+x",
                  text = ~paste("<b>7-day rolling avg.: </b>", round(seven_day_death_avg, 2))) %>%
        add_trace(y = ~fourteen_day_death_avg, 
                  name = "14-day rolling avg. cases", 
                  type = "scatter", 
                  mode = "lines", 
                  line = list(color = "black", dash = "dot"),
                  hoverinfo = "text+x",
                  text = ~paste0("<b>14-day rolling avg.: </b>", round(fourteen_day_death_avg, 2))) %>%
        layout(hovermode = "x unified",
               title = paste0("Daily COVID-19 deaths in ", input$selected_country),
               yaxis = list(title = "Absolute number of COVID-19 deaths"),
               xaxis = list(title = "Date of Reporting",
                            type = "date",
                            tickformat = "%b %d (%a)",
                            rangeslider = list(type = "date"))
        )
    })
    
   
  # Cases per Million map
  output$map_total_cases_per_million <- renderLeaflet({
    africa_map_server() %>% 
      leaflet(options = leafletOptions(minZoom = 3, maxZoom = 3)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 1,
                  fillColor = ~cases.rate.color, fill = ~cases.rate.color,
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>", "Country: ", "</b>", name, "<br>",
                                  "<b>", "Region: ", "</b>", Region, "<br>",
                                  "<b>", "Cases: ", "</b>", format(Cases,
                                                                   decimal.mark = ".",
                                                                   big.mark = ","), "<br>",
                                  "<b>", "Deaths: ", "</b>", format(Deaths,
                                                                    decimal.mark = ".",
                                                                    big.mark = ","), "<br>",
                                  "<b>", "Cases per million: ", "</b>", format(round(`Cases per million`, 2),
                                                                               decimal.mark = ".",
                                                                               big.mark = ","), "<br>",
                                  "<b>", "Deaths per million: ", "</b>", format(round(`Deaths per million`, 2), 
                                                                                decimal.mark = ".", 
                                                                                big.mark = ","), "<br>"),
                  group = "Cases per Million") %>%
      addEasyButton(easyButton(position = "topleft",
                               icon    = "glyphicon glyphicon-globe", title = "Reset zoom",
                               onClick = JS("function(btn, map){ map.setView([2, 10], 3); }"))) %>%
      addEasyButton(easyButton(position = "topleft",
                               icon    = "glyphicon glyphicon-map-marker", title = "Find-me",
                               onClick = JS("function(btn, map){ map.locate({setView: true, maxZoom: 6}); }"))) %>%
      addLegend("bottomright", title= "Cases per million", opacity = 0.92, group = "Cases per Million",
                colors =  c("#ffffff", RColorBrewer::brewer.pal(n = 8, name = "YlOrRd")),
                labels = c("No cases", "[0 - 10]", "[10 - 100]", 
                           "[100 - 500]", "[500 - 1000]", "[1000 - 5000]", 
                           "[5000 - 10000]", "[10000 - 100000]", "Higher than 100,000"))
  })
  
  # Deaths per Million map
  output$map_total_deaths_per_million <- renderLeaflet({
    africa_map_server() %>% 
      leaflet(options = leafletOptions(minZoom = 3, maxZoom = 3)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 1,
                  fillColor = ~deaths.rate.color, fill = ~deaths.rate.color,
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>", "Country: ", "</b>", name, "<br>",
                                  "<b>", "Region: ", "</b>", Region, "<br>",
                                  "<b>", "Cases: ", "</b>", format(Cases,
                                                                   decimal.mark = ".",
                                                                   big.mark = ","), "<br>",
                                  "<b>", "Deaths: ", "</b>", format(Deaths,
                                                                    decimal.mark = ".",
                                                                    big.mark = ","), "<br>",
                                  "<b>", "Cases per million: ", "</b>", format(round(`Cases per million`, 2),
                                                                               decimal.mark = ".",
                                                                               big.mark = ","), "<br>",
                                  "<b>", "Deaths per million: ", "</b>", format(round(`Deaths per million`, 2), 
                                                                                decimal.mark = ".", 
                                                                                big.mark = ","), "<br>"),
                  group = "Deaths per Million") %>%
      addEasyButton(easyButton(position = "topleft",
                               icon    = "glyphicon glyphicon-globe", title = "Reset zoom",
                               onClick = JS("function(btn, map){ map.setView([2, 10], 3); }"))) %>%
      addEasyButton(easyButton(position = "topleft",
                               icon    = "glyphicon glyphicon-map-marker", title = "Find-me",
                               onClick = JS("function(btn, map){ map.locate({setView: true, maxZoom: 6}); }"))) %>%
      addLegend("bottomright", title= "Deaths per million", opacity = 0.92, group = "Deaths per Million",
                colors =  c("#ffffff", RColorBrewer::brewer.pal(n = 8, name = "YlOrRd")),
                labels = c("No deaths", "[0,1 - 1]", "[1 - 5]",
                           "[5 - 10]", "[10 - 50]", "[50 - 100]", 
                           "[100 - 500]", "[500 - 1,000]", "Higher than 1,000"))
  })
  
  # Cumulative cases map
  output$map_cumulative_cases <- renderLeaflet({
    africa_map_server() %>% 
      leaflet(options = leafletOptions(minZoom = 3, maxZoom = 3)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 1,
                  fillColor = ~cases.color, fill = ~cases.color,
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>", "Country: ", "</b>", name, "<br>",
                                  "<b>", "Region: ", "</b>", Region, "<br>",
                                  "<b>", "Cases: ", "</b>", format(Cases,
                                                                   decimal.mark = ".",
                                                                   big.mark = ","), "<br>",
                                  "<b>", "Deaths: ", "</b>", format(Deaths,
                                                                    decimal.mark = ".",
                                                                    big.mark = ","), "<br>",
                                  "<b>", "Cases per million: ", "</b>", format(round(`Cases per million`, 2),
                                                                               decimal.mark = ".",
                                                                               big.mark = ","), "<br>",
                                  "<b>", "Deaths per million: ", "</b>", format(round(`Deaths per million`, 2), 
                                                                                decimal.mark = ".", 
                                                                                big.mark = ","), "<br>"),
                  group = "Cumulative Cases") %>%
      addEasyButton(easyButton(position = "topleft",
                               icon    = "glyphicon glyphicon-globe", title = "Reset zoom",
                               onClick = JS("function(btn, map){ map.setView([2, 10], 3); }"))) %>%
      addEasyButton(easyButton(position = "topleft",
                               icon    = "glyphicon glyphicon-map-marker", title = "Find-me",
                               onClick = JS("function(btn, map){ map.locate({setView: true, maxZoom: 6}); }"))) %>%
      addLegend("bottomright", title= "Cumulative cases", opacity = 0.92, group = "Cumulative Cases",
                colors =  c("#ffffff", RColorBrewer::brewer.pal(n = 8, name = "YlOrRd")),
                labels = c("No cases", "[1 - 1,000]", "[1,001 - 5,000]",
                           "[5,001 - 10,000]", "[10,001 - 50,000]", "[50,001 - 100,000]", 
                           "[100,001 - 500,000]", "[500,001 - 1,000,000]", "Higher than 1,000,000"))
  })
  
  # Cumulative deaths map
  output$map_cumulative_deaths <- renderLeaflet({
    africa_map_server() %>% 
      leaflet(options = leafletOptions(minZoom = 3, maxZoom = 3)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 1,
                  fillColor = ~deaths.color, fill = ~deaths.color,
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>", "Country: ", "</b>", name, "<br>",
                                  "<b>", "Region: ", "</b>", Region, "<br>",
                                  "<b>", "Cases: ", "</b>", format(Cases,
                                                                   decimal.mark = ".",
                                                                   big.mark = ","), "<br>",
                                  "<b>", "Deaths: ", "</b>", format(Deaths,
                                                                    decimal.mark = ".",
                                                                    big.mark = ","), "<br>",
                                  "<b>", "Cases per million: ", "</b>", format(round(`Cases per million`, 2),
                                                                               decimal.mark = ".",
                                                                               big.mark = ","), "<br>",
                                  "<b>", "Deaths per million: ", "</b>", format(round(`Deaths per million`, 2), 
                                                                                decimal.mark = ".", 
                                                                                big.mark = ","), "<br>"),
                  group = "Cumulative Deaths") %>%
      addEasyButton(easyButton(position = "topleft",
                               icon    = "glyphicon glyphicon-globe", title = "Reset zoom",
                               onClick = JS("function(btn, map){ map.setView([2, 10], 3); }"))) %>%
      addEasyButton(easyButton(position = "topleft",
                               icon    = "glyphicon glyphicon-map-marker", title = "Find-me",
                               onClick = JS("function(btn, map){ map.locate({setView: true, maxZoom: 6}); }"))) %>%
      addLegend("bottomright", title= "Cumulative deaths", opacity = 0.92, group = "Cumulative Deaths",
                colors =  c("#ffffff", RColorBrewer::brewer.pal(n = 8, name = "YlOrRd")),
                labels = c("No deaths", "[1 - 100]", "[101 - 500]", "[501 - 1000]", 
                           "[1,001 - 5,000]", "[5,001 - 10,000]", "[10,001 - 50,000]", 
                           "[50,001 - 100,000]", "Higher than 100,000"))
  })
  
  # Risk maps
  
  # # Mortality Risk Index (raw and not including distance from medical facility)
  # output$map_mri_lvl1_1 <- renderLeaflet({
  #   df_risk_MRI_1_server() %>%
  #     leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
  #     addTiles() %>%
  #     addProviderTiles(providers$CartoDB.Positron) %>%
  #     addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
  #                 opacity = 1.0, fillOpacity = 0.75,
  #                 fillColor = ~pallete.MRI_RIDX(MRI_RIDX_quintile),
  #                 highlightOptions = highlightOptions(color = "white", weight = 2,
  #                                                     bringToFront = TRUE),
  #                 popup = ~paste0("<b>Country: </b>", NAME_0,
  #                                 "<br><b>Department: </b>", NAME_1,
  #                                 "<br><b>Mortality Risk Index (raw and not including<br> distance from medical facility): </b>", round(MRI_RIDX, 2))) %>%  
  #     addLegend("bottomright", 
  #               pal = pallete.MRI_RIDX,
  #               values = ~MRI_RIDX_quintile,
  #               title = ~paste0("Mortality Risk Index <br> (raw and not including<br> distance from medical facility)"),
  #               opacity = 1)
  # })
  # 
  # # Mortality Risk Index (raw and including distance from medical facility)
  # output$map_mri_lvl1_2 <- renderLeaflet({
  #   df_risk_MRI_1_server() %>%
  #     leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
  #     addTiles() %>%
  #     addProviderTiles(providers$CartoDB.Positron) %>%
  #     addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
  #                 opacity = 1.0, fillOpacity = 0.75,
  #                 fillColor = ~pallete.MRI_RIDX2(MRI_RIDX2_quintile),
  #                 highlightOptions = highlightOptions(color = "white", weight = 2,
  #                                                     bringToFront = TRUE),
  #                 popup = ~paste0("<b>Country: </b>", NAME_0,
  #                                 "<br><b>Department: </b>", NAME_1,
  #                                 "<br><b>Mortality Risk Index (raw and including<br> distance from medical facility): </b>", round(MRI_RIDX2, 2))) %>%  
  #     addLegend("bottomright", 
  #               pal = pallete.MRI_RIDX2,
  #               values = ~MRI_RIDX2_quintile,
  #               title = ~paste0("Mortality Risk Index <br> (raw and including<br> distance from medical facility)"),
  #               opacity = 1)
  # })
  # 
  # # Normalized Mortality Risk Index
  # output$map_mri_lvl1_3 <- renderLeaflet({
  #   df_risk_MRI_1_server() %>%
  #     leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
  #     addTiles() %>%
  #     addProviderTiles(providers$CartoDB.Positron) %>%
  #     addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
  #                 opacity = 1.0, fillOpacity = 0.75,
  #                 fillColor = ~pallete.MRI_IDX(MRI_IDX_quintile),
  #                 highlightOptions = highlightOptions(color = "white", weight = 2,
  #                                                     bringToFront = TRUE),
  #                 popup = ~paste0("<b>Country: </b>", NAME_0,
  #                                 "<br><b>Department: </b>", NAME_1,
  #                                 "<br><b>Mortality Risk Index (standardized and including<br> distance from medical facility): </b>",
  #                                 round(MRI_IDX, 2))) %>%  
  #     addLegend("bottomright", 
  #               pal = pallete.MRI_IDX,
  #               values = ~MRI_IDX_quintile,
  #               title = ~paste0("Mortality Risk Index <br> (standardized and including<br> distance from medical facility)"),
  #               opacity = 1)
  # })
  # 
  # # Risk Index (raw and not including distance from medical facility)
  # output$bar_mri_lvl1_1 <- renderPlotly({
  #   df_risk_MRI_1_server() %>% 
  #     plot_ly(x = ~reorder(NAME_1, -MRI_RIDX)) %>%
  #     add_bars(y = ~MRI_RIDX, 
  #              color = ~NAME_1,
  #              colors = ~mycolors,
  #              hoverinfo = "text+x", 
  #              # presenting reported cases info
  #              text = ~paste0("<b>Region: </b>", NAME_1,
  #                             "<br><b>Mortality Risk Index (raw): </b>", round(MRI_RIDX, 2))) %>%
  #     layout(hovermode = "unified x",
  #            yaxis = list(title = "Mortality Risk Index"))
  # })
  # 
  # # Risk Index (raw and including distance from medical facility)
  # output$bar_mri_lvl1_2 <- renderPlotly({
  #   df_risk_MRI_1_server() %>% 
  #     plot_ly(x = ~reorder(NAME_1, -MRI_RIDX2)) %>%
  #     add_bars(y = ~MRI_RIDX2, 
  #              color = ~NAME_1,
  #              colors = ~mycolors,
  #              hoverinfo = "text+x", 
  #              # presenting reported cases info
  #              text = ~paste0("<b>Region: </b>", NAME_1,
  #                             "<br><b>Mortality Risk Index</b>(raw and including distance from medical facility): </b>", 
  #                             round(MRI_RIDX2, 2))) %>%
  #     layout(hovermode = "unified x",
  #            yaxis = list(title = "Mortality Risk Index"))
  # })
  # 
  # # Standardized Risk Index
  # output$bar_mri_lvl1_3 <- renderPlotly({
  #   df_risk_MRI_1_server() %>% 
  #     plot_ly(x = ~reorder(NAME_1, -MRI_IDX)) %>%
  #     add_bars(y = ~MRI_IDX, 
  #              color = ~NAME_1,
  #              colors = ~mycolors,
  #              hoverinfo = "text+x", 
  #              # presenting reported cases info
  #              text = ~paste0("<b>Region: </b>", NAME_1,
  #                             "<br><b>Mortality Risk Index<br>(standardized and including distance from medical facility): </b>", 
  #                             round(MRI_IDX, 2))) %>%
  #     layout(hovermode = "unified x",
  #            yaxis = list(title = "Mortality Risk Index"))
  # })
  # 
  # # Transmission Risk Index (raw and not including distance from medical facility)
  # output$map_tri_lvl1_1 <- renderLeaflet({
  #   # Transmission Risk Index (raw)
  #   df_risk_TRI_1_server() %>%
  #     # filtering for the last date (could be replaced by a slider in shiny)
  #     filter(report_date == max(report_date, na.rm = TRUE)) %>%
  #     leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
  #     addTiles() %>%
  #     addProviderTiles(providers$CartoDB.Positron, group = "Map") %>%
  #     addProviderTiles(providers$HERE.satelliteDay, group = "Satellite") %>%
  #     addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
  #                 opacity = 1.0, fillOpacity = 0.75,
  #                 fillColor = ~pallete.TRI_RIDX(TRI_RIDX_quintile),
  #                 highlightOptions = highlightOptions(color = "white", weight = 2,
  #                                                     bringToFront = TRUE),
  #                 popup = ~paste0("<b>Country: </b>", NAME_0,
  #                                 "<br><b>Department: </b>", NAME_1,
  #                                 "<br><b>Transmission Risk Index (raw): </b>", round(TRI_RIDX, 2))) %>%  
  #     addLayersControl(
  #       baseGroups = c("Map", "Satellite"),
  #       options = layersControlOptions(collapsed = TRUE)
  #     ) %>%  
  #     addLegend("bottomright", 
  #               pal = pallete.TRI_RIDX,
  #               values = ~TRI_RIDX_quintile,
  #               title = ~paste0("Transmission Risk Index<br>(raw)"),
  #               opacity = 1)
  # })
  # 
  # 
  # 
  # # Transmission Risk Index (raw and including distance from medical facility)
  # output$map_tri_lvl1_2 <- renderLeaflet({
  #   # Transmission Risk Index Normalized between 0 and 100 by the maximum raw value for each day)
  #   df_risk_TRI_1_server() %>%
  #     # filtering for the last date (could be replaced by a slider in shiny)
  #     filter(report_date == max(report_date, na.rm = TRUE)) %>%
  #     leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
  #     addTiles() %>%
  #     addProviderTiles(providers$CartoDB.Positron, group = "Map") %>%
  #     addProviderTiles(providers$HERE.satelliteDay, group = "Satellite") %>%
  #     addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
  #                 opacity = 1.0, fillOpacity = 0.75,
  #                 fillColor = ~pallete.TRI_IDX(TRI_IDX_quintile),
  #                 highlightOptions = highlightOptions(color = "white", weight = 2,
  #                                                     bringToFront = TRUE),
  #                 popup = ~paste0("<b>Country: </b>", NAME_0,
  #                                 "<br><b>Department: </b>", NAME_1,
  #                                 "<br><b>Transmission Risk Index (standardized by day): </b>", round(TRI_IDX, 2))) %>%  
  #     addLayersControl(
  #       baseGroups = c("Map", "Satellite"),
  #       options = layersControlOptions(collapsed = TRUE)
  #     ) %>%  
  #     addLegend("bottomright", 
  #               pal = pallete.TRI_IDX,
  #               values = ~TRI_IDX_quintile,
  #               title = ~paste0("Transmission Risk Index (standardized by day)"),
  #               opacity = 1)
  # })
  # 
  # # Normalized Transmission Risk Index
  # output$map_tri_lvl1_3 <- renderLeaflet({
  #   # Transmission Risk Index Normalized between 0 and 100 by the maximum raw value for each day
  #   # but exluding outliers)
  #   df_risk_TRI_1_server() %>%
  #     # filtering for the last date (could be replaced by a slider in shiny)
  #     filter(report_date == max(report_date, na.rm = TRUE)) %>%
  #     leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
  #     addTiles() %>%
  #     addProviderTiles(providers$CartoDB.Positron, group = "Map") %>%
  #     addProviderTiles(providers$HERE.satelliteDay, group = "Satellite") %>%
  #     addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
  #                 opacity = 1.0, fillOpacity = 0.75,
  #                 fillColor = ~pallete.TRI_IDX2(TRI_IDX2_quintile),
  #                 highlightOptions = highlightOptions(color = "white", weight = 2,
  #                                                     bringToFront = TRUE),
  #                 popup = ~paste0("<b>Country: </b>", NAME_0,
  #                                 "<br><b>Department: </b>", NAME_1,
  #                                 "<br><b>Transmission Risk Index (standardized by day and without outliers): </b>",
  #                                 round(TRI_IDX2, 2))) %>%  
  #     addLayersControl(
  #       baseGroups = c("Map", "Satellite"),
  #       options = layersControlOptions(collapsed = TRUE)
  #     ) %>%  
  #     addLegend("bottomright", 
  #               pal = pallete.TRI_IDX2,
  #               values = ~TRI_IDX2_quintile,
  #               title = ~paste0("Transmission Risk Index<br>(standardized by day and<br>without outliers)"),
  #               opacity = 1)
  # })
  # 
  # # Risk Index (raw and not including distance from medical facility)
  # output$bar_tri_lvl1_1 <- renderPlotly({
  #   # interactive time series plot: Transmission Risk Index (raw)
  #   df_risk_TRI_1_server() %>% 
  #     plot_ly(x = ~report_date) %>%
  #     add_lines(y = ~TRI_RIDX, 
  #               color = ~NAME_1,
  #               colors = ~mycolors,
  #               hoverinfo = "text+x", 
  #               # presenting reported cases info
  #               text = ~paste0("<b>Region: </b>", NAME_1,
  #                              "<br><b>Transmission Risk Index (raw): </b>", round(TRI_RIDX, 2))) %>%
  #     layout(hovermode = "unified x",
  #            yaxis = list(title = "Transmission Risk Index"),
  #            xaxis = list(title = "Date of Reporting",
  #                         type = "date",
  #                         tickformat = "%b %d (%a)",
  #                         rangeslider = list(type = "date")
  #            )
  #     )
  # })
  # 
  # # Risk Index (raw and including distance from medical facility)
  # output$bar_tri_lvl1_2 <- renderPlotly({
  #   # interactive time series plot: Transmission Risk Index (standardized by day)
  #   df_risk_TRI_1_server() %>% 
  #     plot_ly(x = ~report_date) %>%
  #     add_lines(y = ~TRI_IDX, 
  #               color = ~NAME_1,
  #               colors = ~mycolors,
  #               hoverinfo = "text+x", 
  #               # presenting reported cases info
  #               text = ~paste0("<b>Region: </b>", NAME_1,
  #                              "<br><b>Transmission Risk Index (standardized by day): </b>", round(TRI_IDX, 2))) %>%
  #     layout(hovermode = "unified x",
  #            yaxis = list(title = "Transmission Risk Index"),
  #            xaxis = list(title = "Date of Reporting",
  #                         type = "date",
  #                         tickformat = "%b %d (%a)",
  #                         rangeslider = list(type = "date")
  #            )
  #     )
  # })
  # 
  # # Standardized Risk Index
  # output$bar_tri_lvl1_3 <- renderPlotly({
  #   # interactive time series plot: Transmission Risk Index (standardized by day)
  #   df_risk_TRI_1_server() %>% 
  #     plot_ly(x = ~report_date) %>%
  #     add_lines(y = ~TRI_IDX2, 
  #               color = ~NAME_1,
  #               colors = ~mycolors,
  #               hoverinfo = "text+x", 
  #               # presenting reported cases info
  #               text = ~paste0("<b>Region: </b>", NAME_1,
  #                              "<br><b>Transmission Risk Index <br> (standardized by day and without outliers): </b>", round(TRI_IDX2, 2))) %>%
  #     layout(hovermode = "unified x",
  #            yaxis = list(title = "Transmission Risk Index"),
  #            xaxis = list(title = "Date of Reporting",
  #                         type = "date",
  #                         tickformat = "%b %d (%a)",
  #                         rangeslider = list(type = "date")
  #            )
  #     )
  # })
  
  observeEvent(input$selected_region,{
    
    df_regional_comparison <- reactive({
      df_country_server() %>% 
        filter(Region %in% input$selected_region) %>% 
        # filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>%
        dplyr::select(date, total_cases_per_million, total_deaths_per_million, Country)
    })
    
    output$ts_df_regional_comparison <- renderPlotly({
      plot_ly(df_regional_comparison(), x = ~date, y = ~total_cases_per_million, 
              color = ~Country, 
              type = "scatter", mode = "lines",
              hoverinfo = "text", visible = TRUE,
              text = ~paste("<b>Country: </b>", Country, 
                            "<br><b>Date: </b>", date,
                            "<br><b>Confirmed cases per million: </b>", round(total_cases_per_million, 2))) %>%
        add_trace(y = ~total_deaths_per_million, color = ~Country, type = "scatter", mode = "lines",
                  hoverinfo = "text", visible = FALSE,
                  text = ~paste("<b>Country: </b>", Country, 
                                "<br><b>Date: </b>", date,
                                "<br><b>Deaths cases per million: </b>", round(total_deaths_per_million, 2))) %>%
        layout(updatemenus = list(
          list(
            y = 0,
            buttons = list(
              list(method = "restyle",
                   args = list("visible", list(TRUE, FALSE)),
                   label = "Cases per million"),
              list(method = "restyle",
                   args = list("visible", list(FALSE, TRUE)),
                   label = "Deaths per million")))),
          title = paste("Cumulative cases and deaths per million for countries in", input$selected_region),
          yaxis = list(
            title = "Cases/Deaths per million"),
          xaxis = list(
            title = "Date of Reporting",
            type = "date",
            tickformat = "%b<br>%d (%a)",
            rangeslider = list(type = "date")
          )
        )
    })
    
    output$table_all_regions <- DT::renderDT(
      df_country_server() %>% 
        #filter(date >= input$selected_dates[1] & date <= input$selected_dates[2]) %>% 
        dplyr::select(date, Country, total_cases, total_deaths, Region, Population) %>% 
        group_by(Country) %>% 
        slice(which.max(date)) %>% 
        group_by(Region) %>% 
        mutate(total_cases_region = sum(total_cases),
               total_deaths_region = sum(total_deaths),
               Population = sum(Population)) %>% 
        slice(which.max(date)) %>% 
        rename(Cases = total_cases_region, Deaths = total_deaths_region) %>% 
        mutate(
          `Crude \nCFR (%)` = round(100 * Deaths / Cases, digits = 1),
          `Cases per million` = round((Cases / Population) * 1e6, 2),
          `Deaths per million` = round((Deaths / Population) * 1e6, 2)
        ) %>% 
        dplyr::select(Region, Cases,`Cases per million`, Deaths, `Deaths per million`) %>% 
        arrange(-Cases) %>% 
        ungroup(),
      options = list(pageLength = 5, language = list(search = 'Search:'),
                     initComplete = JS(
                       "function(settings, json) {",
                       "$(this.api().table().header()).css({'background-color': '#24ccff', 'color': '#000000'});",
                       "}")
      )
    )
    
  })
  
})
