library(shiny)

shinyServer(function(input, output, session) {
  
  # Selecting country
  output$select_country <- renderUI({
    selectInput("selected_country",
                label = "Select a country:",
                choices = c("Senegal", "Burkina Faso"), #countries_list,
                selected = "Senegal") #countries_list[1]
  })
  
  output$select_region <- renderUI({
    selectInput("selected_region",
                label = "Select a region:",
                choices = c("Central Africa", "Eastern Africa",  "Northern Africa", "Southern Africa", "Western Africa"),
                selected = "Central Africa")
  })
  
  output$select_date <- renderUI({
    dateRangeInput("selected_dates", "Date range:",
                   start  = min(df_country$Reporting_Date),
                   end    = max(df_country$Reporting_Date),
                   min    = min(df_country$Reporting_Date),
                   max    = max(df_country$Reporting_Date),
                   format = "dd/mm/yy",
                   separator = " - ")
  })
  
  observeEvent(input$selected_country,{
    
    output$country_chosen <- renderText({
      paste0("<b>Country: </b>", input$selected_country)
    })
    
    country_selected <- reactive({
      df_country %>% 
        filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
        filter(Country == input$selected_country)
       })
    
    date_reactive <- reactive({
      country_selected() %>% 
        arrange(desc(Reporting_Date)) %>% 
        distinct(Country, .keep_all = T) %>% 
        dplyr::select(Reporting_Date) %>% 
        table() %>% 
        names()
    })
    
    output$last_update <- renderText({
      paste0(
        "<b>Last update: </b>",
        substr(date_reactive(),9,10),"/",
        substr(date_reactive(),6,7),"/",
        substr(date_reactive(),1,4)
      )
    })
    
    output$confirmedCases <- renderText({
      prettyNum(
        country_selected() %>% 
          #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
          arrange(desc(Reporting_Date)) %>% 
          distinct(Country, .keep_all = T) %>% 
          dplyr::select(Cum_cases),
        decimal.mark = ",", big.mark = ".")
    })
    
    output$newCases <- renderText({
      paste0(prettyNum(
        country_selected() %>% 
          #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
          filter(Epiweek == max(Epiweek)) %>% 
          group_by(Epiweek) %>% 
          mutate(NewCases = sum(Cases_this_day ,na.rm = T)) %>% 
          ungroup() %>% 
          distinct(Epiweek,.keep_all = T) %>% 
          dplyr::select(NewCases),
        decimal.mark = ",", big.mark = ".")," cases this week")
    })
    
    output$Deaths <- renderText({
      prettyNum(
        country_selected() %>% 
          #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
          arrange(desc(Reporting_Date)) %>% 
          distinct(Country, .keep_all = T) %>% 
          dplyr::select(Cum_deaths),
        decimal.mark = ",", big.mark = ".")
    })
    
    output$newDeaths <- renderText({
      paste0(prettyNum(
        country_selected() %>% 
          #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
          filter(Epiweek == max(Epiweek)) %>% 
          group_by(Epiweek) %>% 
          mutate(NewDeaths = sum(Deaths_this_day ,na.rm = T)) %>% 
          ungroup() %>% 
          distinct(Epiweek,.keep_all = T) %>% 
          dplyr::select(NewDeaths),
        decimal.mark = ",", big.mark = ".")," deaths this week")
    })
    
    output$CasesPerMillion <- renderText({
      prettyNum(
        country_selected() %>% 
          #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
          filter(Epiweek == max(Epiweek)) %>% 
          distinct(Epiweek,.keep_all = T) %>% 
          dplyr::select(Cases_per_million),
        decimal.mark = ",", big.mark = ".")
    })
    
    output$DeathsPerMillion <- renderText({
      paste0(prettyNum(
        country_selected() %>% 
          #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
          filter(Epiweek == max(Epiweek)) %>% 
          distinct(Epiweek,.keep_all = T) %>% 
          dplyr::select(Deaths_per_million),
        decimal.mark = ",", big.mark = ".")," deaths per million")
    })
    
    growth_rate_tab <- reactive({
      country_selected() %>% 
        #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
        dplyr::select(Reporting_Date, Cases_past_week, Epiweek) %>% 
        group_by(Epiweek) %>% 
        # take the last day of each epiweek
        slice(which.max(Reporting_Date)) %>% 
        ungroup() %>% 
        # Cases in the past week vs cases two weeks ago
        mutate(diff_cases = Cases_past_week - lag(Cases_past_week,1), 
               week_growth = diff_cases/lag(Cases_past_week,1),
               week_growth_perc = 100 * week_growth, 
               # formula to convert weekly_growth to daily_growth equivalent
               growth = (((1 + week_growth) ^ (1/7)) - 1), 
               growth_perc = 100 * growth)
    })
    
    # plot
    output$ts_growth_rate_tab <- renderPlotly({
      plot_ly(growth_rate_tab(), x = ~Reporting_Date) %>%
        # ribbons are polygons in the background
        add_ribbons(x = ~Reporting_Date, ymin = 0, 
                    # ymax needs to remove Inf or otherwise plotly will explode to a large ymax
                    ymax = max(growth_rate_tab()$week_growth_perc[growth_rate_tab()$week_growth_perc != Inf], 
                               na.rm = TRUE),
                    color = I("red"), # red for increase in growth rate
                    opacity = 0.5,
                    hoverinfo = "none", # removes the hovering text (it is not needed in here)
                    showlegend = FALSE, # to remove the unneeded trace info 
                    line = list(color = "rgba(0, 0, 0, 0)")) %>% # red for increase in growth rate
        add_ribbons(x = ~Reporting_Date, ymax = 0, 
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
                  text = ~paste0("<b>Date of reporting: </b>", Reporting_Date,
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
    
    epi_curve_ll <- reactive({
      country_selected() %>% 
        #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
        dplyr::select(Reporting_Date, Cases_this_day, Deaths_this_day) %>% 
        mutate(seven_day_case_avg = rollmean(x = Cases_this_day, k = 7, align = "right",  
                                             fill = na.fill(Cases_this_day, 0)),
               fourteen_day_case_avg = rollmean(x = Cases_this_day, k = 14, align = "right",  
                                                fill = na.fill(Cases_this_day, 0)),
               seven_day_death_avg = rollmean(x = Deaths_this_day, k = 7, align = "right",  
                                              fill = na.fill(Deaths_this_day, 0)),
               fourteen_day_death_avg = rollmean(x = Deaths_this_day, k = 14, align = "right",  
                                                 fill = na.fill(Deaths_this_day, 0)))
    })
    
    output$ts_epi_curve_ll_confirmed <- renderPlotly({
      epi_curve_ll() %>%
        plot_ly(x = ~Reporting_Date) %>%
        add_bars(y = ~Cases_this_day, 
                 colors = mycolors_1,
                 name = "Cases this day", 
                 hoverinfo = "text+x",
                 text = ~paste0("<b>Confirmed cases in ", input$selected_country, ": </b>", Cases_this_day)) %>%
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
        plot_ly(x = ~Reporting_Date) %>%
        add_bars(y = ~Deaths_this_day, 
                 colors = mycolors_1,
                 name = "Cases this day", 
                 hoverinfo = "text+x",
                 text = ~paste0("<b>Deaths in ", input$selected_country, ": </b>", Deaths_this_day)) %>%
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
    
    df_age_sex <- reactive({
      df_LL %>% 
        filter(Country == input$selected_country) %>%
        # filtering out individuals with missing sex or age
        # creating age categories
        mutate(age_group = cut(as.numeric(Age), 
                               breaks = c(0, 5, 9, 19, 29, 39, 49, 59, 69, 79, Inf),
                               labels = c("< 5", "5-9", "10-19", "20-29", "30-39", "40-49",
                                          "50-59", "60-69", "70-79", "> 80"), 
                               right = TRUE)) %>% 
        # for each age group and sex, sum the number of cases and the number of deaths
        filter(!is.na(age_group)) %>%
        filter(!is.na(Sex)) %>%
        group_by(age_group, Sex) %>%
        summarise(
          confirmed = sum(FinalEpiClassification == "Confirmed", na.rm = TRUE),
          deaths = sum(FinalOutcome == "Dead", na.rm = TRUE)
        ) %>%
        ungroup()
    })
    
    
    # long format for the stacked bar chart
    df_age_sex_long <-  reactive({
      df_age_sex() %>% 
        # subtract out deaths from reported count to get CASES ALONE 
        # needed since we're going to build a STACKED bar chart.
        mutate(
          `Confirmed cases` = confirmed - deaths,
          Deaths = deaths,
          Sex = recode_factor(Sex,
                              "M" = "Male",
                              "F" = "Female")) %>% 
        pivot_longer(names_to = "classification", cols = c(
          `Confirmed cases`, 
          Deaths)) %>% 
        mutate(classification = fct_relevel(classification, c( 
          "Confirmed cases", 
          "Deaths")),
          # in order for the pyramid to be correctly displayed, one of the groups should be negative
          # we will hack the axis later to make it the absolute number
          value = ifelse(Sex == "Female", value * (-1), value),
          # value to be passed to hoverinfo in plotly
          text_value = paste0("<b>", classification, ": </b>", abs(value)),
          # creating a variable with the absolute number of reported cases
          color_info = paste0(Sex, " ", classification),
          color_info = fct_relevel(color_info, c("Female Confirmed cases", "Female Deaths",
                                                 "Male Confirmed cases","Male Deaths")),
          # calculating CFR
          CFR_confirmed = round(deaths / confirmed * 100, 2))
    })
    
    # age-sex pyramid plot of confirmed cases
    output$piramid_age_sex <- renderPlotly({
      df_age_sex_long() %>%
        plot_ly(x = ~value, # inverting x axis
                y = ~age_group, # inverting x axis
                color = ~color_info,
                colors = c("Female Confirmed cases" = "#66C2A5",
                           "Female Deaths" = "red",
                           "Male Confirmed cases" = "#8DA0CB",
                           "Male Deaths" = "red"),
                customdata = ~text_value,
                hoverinfo = "text",
                text = ~paste0("<b>Sex: </b>", Sex,
                               "<br><b>Age group: </b>", age_group,
                               "<br>", text_value,
                               "<br><b>CFR (based on confirmed cases): </b>", CFR_confirmed, "%")) %>%
        # changing orientations to horizontal
        add_bars(orientation = "h") %>%
        layout(bargap = 0.1,
               # needed to make bars correctly placed
               barmode = "relative",
               title = paste0("Age-sex distribution of all COVID-19 confirmed cases in "),
               yaxis = list(title = "Age group"),
               xaxis = list(title = "COVID-19 confirmed cases and deaths")
               # legend = list(orientation = "h",   # show entries horizontally
               #               xanchor = "center",  # use center of legend as anchor
               #               x = 0.5)
        )
    })
    
  })
  
  # Cases per Million map
  output$map_cases_per_million <- renderLeaflet({
    africa_map %>% 
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
                colors =  RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
                labels = c("No cases", "[0 - 10]", "[10 - 100]", 
                           "[100 - 500]", "[500 - 1000]", "[1000 - 5000]", 
                           "[5000 - 10000]", "[10000 - 100000]", "Higher than 100,000"))
  })
  
  # Deaths per Million map
  output$map_deaths_per_million <- renderLeaflet({
    africa_map %>% 
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
                colors =  RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
                labels = c("No deaths", "[0,1 - 1]", "[1 - 5]",
                           "[5 - 10]", "[10 - 50]", "[50 - 100]", 
                           "[100 - 500]", "[500 - 1,000]", "Higher than 1,000"))
  })
  
  # Cumulative cases map
  output$map_cumulative_cases <- renderLeaflet({
    africa_map %>% 
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
                colors =  RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
                labels = c("No cases", "[1 - 1,000]", "[1,001 - 5,000]",
                           "[5,001 - 10,000]", "[10,001 - 50,000]", "[50,001 - 100,000]", 
                           "[100,001 - 500,000]", "[500,001 - 1,000,000]", "Higher than 1,000,000"))
  })
  
  # Cumulative deaths map
  output$map_cumulative_deaths <- renderLeaflet({
    africa_map %>% 
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
                colors =  RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
                labels = c("No deaths", "[1 - 100]", "[101 - 500]", "[501 - 1000]", 
                           "[1,001 - 5,000]", "[5,001 - 10,000]", "[10,001 - 50,000]", 
                           "[50,001 - 100,000]", "Higher than 100,000"))
  })
  
  # Risk maps
  
  # Mortality Risk Index (raw and not including distance from medical facility)
  output$map_mri_lvl1_1 <- renderLeaflet({
    df_risk_MRI_1 %>%
      leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.75,
                  fillColor = ~pallete.MRI_RIDX(MRI_RIDX_quintile),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>Country: </b>", NAME_0,
                                  "<br><b>Department: </b>", NAME_1,
                                  "<br><b>Mortality Risk Index (raw and not including<br> distance from medical facility): </b>", round(MRI_RIDX, 2))) %>%  
      addLegend("bottomright", 
                pal = pallete.MRI_RIDX,
                values = ~MRI_RIDX_quintile,
                title = ~paste0("Mortality Risk Index <br> (raw and not including<br> distance from medical facility)"),
                opacity = 1)
  })
  
  # Mortality Risk Index (raw and including distance from medical facility)
  output$map_mri_lvl1_2 <- renderLeaflet({
    df_risk_MRI_1 %>%
      leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.75,
                  fillColor = ~pallete.MRI_RIDX2(MRI_RIDX2_quintile),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>Country: </b>", NAME_0,
                                  "<br><b>Department: </b>", NAME_1,
                                  "<br><b>Mortality Risk Index (raw and including<br> distance from medical facility): </b>", round(MRI_RIDX2, 2))) %>%  
      addLegend("bottomright", 
                pal = pallete.MRI_RIDX2,
                values = ~MRI_RIDX2_quintile,
                title = ~paste0("Mortality Risk Index <br> (raw and including<br> distance from medical facility)"),
                opacity = 1)
  })
  
  # Normalized Mortality Risk Index
  output$map_mri_lvl1_3 <- renderLeaflet({
    df_risk_MRI_1 %>%
      leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.75,
                  fillColor = ~pallete.MRI_IDX(MRI_IDX_quintile),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>Country: </b>", NAME_0,
                                  "<br><b>Department: </b>", NAME_1,
                                  "<br><b>Mortality Risk Index (standardized and including<br> distance from medical facility): </b>",
                                  round(MRI_IDX, 2))) %>%  
      addLegend("bottomright", 
                pal = pallete.MRI_IDX,
                values = ~MRI_IDX_quintile,
                title = ~paste0("Mortality Risk Index <br> (standardized and including<br> distance from medical facility)"),
                opacity = 1)
  })
  
  # Risk Index (raw and not including distance from medical facility)
  output$bar_mri_lvl1_1 <- renderPlotly({
    df_risk_MRI_1 %>% 
      plot_ly(x = ~reorder(NAME_1, -MRI_RIDX)) %>%
      add_bars(y = ~MRI_RIDX, 
               color = ~NAME_1,
               colors = mycolors_2,
               hoverinfo = "text+x", 
               # presenting reported cases info
               text = ~paste0("<b>Region: </b>", NAME_1,
                              "<br><b>Mortality Risk Index (raw): </b>", round(MRI_RIDX, 2))) %>%
      layout(hovermode = "unified x",
             yaxis = list(title = "Mortality Risk Index"))
  })
  
  # Risk Index (raw and including distance from medical facility)
  output$bar_mri_lvl1_2 <- renderPlotly({
    df_risk_MRI_1 %>% 
      plot_ly(x = ~reorder(NAME_1, -MRI_RIDX2)) %>%
      add_bars(y = ~MRI_RIDX2, 
               color = ~NAME_1,
               colors = mycolors_2,
               hoverinfo = "text+x", 
               # presenting reported cases info
               text = ~paste0("<b>Region: </b>", NAME_1,
                              "<br><b>Mortality Risk Index</b>(raw and including distance from medical facility): </b>", 
                              round(MRI_RIDX2, 2))) %>%
      layout(hovermode = "unified x",
             yaxis = list(title = "Mortality Risk Index"))
  })
  
  # Standardized Risk Index
  output$bar_mri_lvl1_3 <- renderPlotly({
    df_risk_MRI_1 %>% 
      plot_ly(x = ~reorder(NAME_1, -MRI_IDX)) %>%
      add_bars(y = ~MRI_IDX, 
               color = ~NAME_1,
               colors = mycolors_2,
               hoverinfo = "text+x", 
               # presenting reported cases info
               text = ~paste0("<b>Region: </b>", NAME_1,
                              "<br><b>Mortality Risk Index<br>(standardized and including distance from medical facility): </b>", 
                              round(MRI_IDX, 2))) %>%
      layout(hovermode = "unified x",
             yaxis = list(title = "Mortality Risk Index"))
  })
  
  # Transmission Risk Index (raw and not including distance from medical facility)
  output$map_tri_lvl1_1 <- renderLeaflet({
    # Transmission Risk Index (raw)
    df_risk_TRI_1 %>%
      # filtering for the last date (could be replaced by a slider in shiny)
      filter(report_date == max(report_date, na.rm = TRUE)) %>%
      leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron, group = "Map") %>%
      addProviderTiles(providers$HERE.satelliteDay, group = "Satellite") %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.75,
                  fillColor = ~pallete.TRI_RIDX(TRI_RIDX_quintile),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>Country: </b>", NAME_0,
                                  "<br><b>Department: </b>", NAME_1,
                                  "<br><b>Transmission Risk Index (raw): </b>", round(TRI_RIDX, 2))) %>%  
      addLayersControl(
        baseGroups = c("Map", "Satellite"),
        options = layersControlOptions(collapsed = TRUE)
      ) %>%  
      addLegend("bottomright", 
                pal = pallete.TRI_RIDX,
                values = ~TRI_RIDX_quintile,
                title = ~paste0("Transmission Risk Index<br>(raw)"),
                opacity = 1)
  })
  
  
  
  # Transmission Risk Index (raw and including distance from medical facility)
  output$map_tri_lvl1_2 <- renderLeaflet({
    # Transmission Risk Index Normalized between 0 and 100 by the maximum raw value for each day)
    df_risk_TRI_1 %>%
      # filtering for the last date (could be replaced by a slider in shiny)
      filter(report_date == max(report_date, na.rm = TRUE)) %>%
      leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron, group = "Map") %>%
      addProviderTiles(providers$HERE.satelliteDay, group = "Satellite") %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.75,
                  fillColor = ~pallete.TRI_IDX(TRI_IDX_quintile),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>Country: </b>", NAME_0,
                                  "<br><b>Department: </b>", NAME_1,
                                  "<br><b>Transmission Risk Index (standardized by day): </b>", round(TRI_IDX, 2))) %>%  
      addLayersControl(
        baseGroups = c("Map", "Satellite"),
        options = layersControlOptions(collapsed = TRUE)
      ) %>%  
      addLegend("bottomright", 
                pal = pallete.TRI_IDX,
                values = ~TRI_IDX_quintile,
                title = ~paste0("Transmission Risk Index (standardized by day)"),
                opacity = 1)
  })
  
  # Normalized Transmission Risk Index
  output$map_tri_lvl1_3 <- renderLeaflet({
    # Transmission Risk Index Normalized between 0 and 100 by the maximum raw value for each day
    # but exluding outliers)
    df_risk_TRI_1 %>%
      # filtering for the last date (could be replaced by a slider in shiny)
      filter(report_date == max(report_date, na.rm = TRUE)) %>%
      leaflet(options = leafletOptions(minZoom = 7, maxZoom = 7)) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron, group = "Map") %>%
      addProviderTiles(providers$HERE.satelliteDay, group = "Satellite") %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.75,
                  fillColor = ~pallete.TRI_IDX2(TRI_IDX2_quintile),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  popup = ~paste0("<b>Country: </b>", NAME_0,
                                  "<br><b>Department: </b>", NAME_1,
                                  "<br><b>Transmission Risk Index (standardized by day and without outliers): </b>",
                                  round(TRI_IDX2, 2))) %>%  
      addLayersControl(
        baseGroups = c("Map", "Satellite"),
        options = layersControlOptions(collapsed = TRUE)
      ) %>%  
      addLegend("bottomright", 
                pal = pallete.TRI_IDX2,
                values = ~TRI_IDX2_quintile,
                title = ~paste0("Transmission Risk Index<br>(standardized by day and<br>without outliers)"),
                opacity = 1)
  })
  
  # Risk Index (raw and not including distance from medical facility)
  output$bar_tri_lvl1_1 <- renderPlotly({
    # interactive time series plot: Transmission Risk Index (raw)
    df_risk_TRI_1 %>% 
      plot_ly(x = ~report_date) %>%
      add_lines(y = ~TRI_RIDX, 
                color = ~NAME_1,
                colors = mycolors_2,
                hoverinfo = "text+x", 
                # presenting reported cases info
                text = ~paste0("<b>Region: </b>", NAME_1,
                               "<br><b>Transmission Risk Index (raw): </b>", round(TRI_RIDX, 2))) %>%
      layout(hovermode = "unified x",
             yaxis = list(title = "Transmission Risk Index"),
             xaxis = list(title = "Date of Reporting",
                          type = "date",
                          tickformat = "%b %d (%a)",
                          rangeslider = list(type = "date")
             )
      )
  })
  
  # Risk Index (raw and including distance from medical facility)
  output$bar_tri_lvl1_2 <- renderPlotly({
    # interactive time series plot: Transmission Risk Index (standardized by day)
    df_risk_TRI_1 %>% 
      plot_ly(x = ~report_date) %>%
      add_lines(y = ~TRI_IDX, 
                color = ~NAME_1,
                colors = mycolors_2,
                hoverinfo = "text+x", 
                # presenting reported cases info
                text = ~paste0("<b>Region: </b>", NAME_1,
                               "<br><b>Transmission Risk Index (standardized by day): </b>", round(TRI_IDX, 2))) %>%
      layout(hovermode = "unified x",
             yaxis = list(title = "Transmission Risk Index"),
             xaxis = list(title = "Date of Reporting",
                          type = "date",
                          tickformat = "%b %d (%a)",
                          rangeslider = list(type = "date")
             )
      )
  })
  
  # Standardized Risk Index
  output$bar_tri_lvl1_3 <- renderPlotly({
    # interactive time series plot: Transmission Risk Index (standardized by day)
    df_risk_TRI_1 %>% 
      plot_ly(x = ~report_date) %>%
      add_lines(y = ~TRI_IDX2, 
                color = ~NAME_1,
                colors = mycolors_2,
                hoverinfo = "text+x", 
                # presenting reported cases info
                text = ~paste0("<b>Region: </b>", NAME_1,
                               "<br><b>Transmission Risk Index <br> (standardized by day and without outliers): </b>", round(TRI_IDX2, 2))) %>%
      layout(hovermode = "unified x",
             yaxis = list(title = "Transmission Risk Index"),
             xaxis = list(title = "Date of Reporting",
                          type = "date",
                          tickformat = "%b %d (%a)",
                          rangeslider = list(type = "date")
             )
      )
  })
  
  
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
  
  
  df_regional_comparison <- reactive({
    df_country %>% 
      filter(Region == input$selected_region) %>% 
      #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
      dplyr::select(Reporting_Date, Cases_per_million, Deaths_per_million, Country) %>%
      group_by(Country) 
  })
  
  output$ts_df_regional_comparison <- renderPlotly({
    plot_ly(df_regional_comparison(), x = ~Reporting_Date, y = ~Cases_per_million, 
            color = ~Country, type = "scatter", mode = "lines",
            hoverinfo = "text", visible = TRUE,
            text = ~paste("<b>Country: </b>", Country, 
                          "<br><b>Date: </b>", Reporting_Date,
                          "<br><b>Confirmed cases per million: </b>", round(Cases_per_million, 2))) %>%
      add_trace(y = ~Deaths_per_million, color = ~Country, type = "scatter", mode = "lines",
                hoverinfo = "text", visible = FALSE,
                text = ~paste("<b>Country: </b>", Country, 
                              "<br><b>Date: </b>", Reporting_Date,
                              "<br><b>Deaths cases per million: </b>", round(Deaths_per_million, 2))) %>%
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
  
  output$table_all_contries <- DT::renderDT(
    df_country %>% 
      #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
      group_by(Country) %>% 
      slice(which.max(Reporting_Date)) %>% 
      dplyr::rename(Cases = Cum_cases, Deaths = Cum_deaths) %>% 
      mutate(
        `Crude \nCFR (%)` = round(100 * Deaths / Cases, digits = 1),
        `Cases per million` = round((Cases / Population) * 1e6, 2),
        `Deaths per million` = round((Deaths / Population) * 1e6, 2)
      ) %>% 
      dplyr::select(Country, Cases,`Cases per million`, Deaths, `Deaths per million`) %>% 
      arrange(-Cases) %>% 
      left_join(country_info) %>% 
      ungroup(),
    options = list(pageLength = 10, language = list(search = 'Search:'),
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': '#24ccff', 'color': '#000000'});",
                     "}")
    )
  )
  
  output$table_all_regions <- DT::renderDT(
    df_country %>% 
      #filter(Reporting_Date >= input$selected_dates[1] & Reporting_Date <= input$selected_dates[2]) %>% 
      dplyr::select(Reporting_Date, Country, Cum_cases, Cum_deaths, Region, Population) %>% 
      group_by(Country) %>% 
      slice(which.max(Reporting_Date)) %>% 
      group_by(Region) %>% 
      mutate(Cum_cases_region = sum(Cum_cases),
             Cum_deaths_region = sum(Cum_deaths),
             Population = sum(Population)) %>% 
      slice(which.max(Reporting_Date)) %>% 
      rename(Cases = Cum_cases_region, Deaths = Cum_deaths_region) %>% 
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
      df_daily_national <- df_daily_national%>% 
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
  
})
