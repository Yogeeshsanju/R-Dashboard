function(input,output,session){
  #Structure
  output$structure <- renderPrint(
    #structure of the data
    my_data %>%
      str()
  )
  #Summary
  output$summary <- renderPrint(
    #Summary of the data
    my_data %>%
      summary()
  )
   # DataTable
  output$dataT <- renderDataTable(
    my_data %>%
      head()
  )
  
  #Histogram
  output$histogram <- renderPlot({
    selected_year <- switch(input$year,
                            "2019" = my_data$X2019...CR,
                            "2020" = my_data$X2020...CR,
                            "2021" = my_data$X2021...CR)
    
    ggplot(my_data, aes(x = selected_year)) +
      geom_histogram(binwidth = (max(selected_year, na.rm = TRUE) - min(selected_year, na.rm = TRUE)) / input$bins,
                     fill = "lightblue", color = "white") +
      labs(title = paste("Histogram for number of Cases in", input$year),
           x = "Count", y = "Frequency") +
      theme_minimal()
  })
  
#Top ten Cities
  output$top_cities_cases <- renderDataTable({
    selected_year <- paste0("X", input$year_1, "...CR")
    top_cities_cases <- my_data %>%
      select(Metropolitan.Cities, {{selected_year}}) %>%
      arrange(desc(get(selected_year))) %>%
      head(10)
    return(top_cities_cases)
  })
  
  output$top_cities_arrested <- renderDataTable({
    selected_year <- paste0("X", input$year_2, "...Persons.Arrested")
    top_cities_arrested <- my_data %>%
      select(Metropolitan.Cities, {{selected_year}}) %>%
      arrange(desc(get(selected_year))) %>%
      head(10)
    return(top_cities_arrested)
  })
  
#trend chart
  output$trend_chart <- renderPlotly({
    selected_city <- input$selected_city
    
    # Filter data for the selected city
    city_data <- my_data %>%
      filter(Metropolitan.Cities == selected_city) %>%
      select("Metropolitan.Cities","X2019...CR","X2020...CR","X2021...CR")  # Assuming columns X2019...CR, X2020...CR, X2021...CR
    
    # Gather the data for plotting
    city_data_long <- gather(city_data, key = "variable", value = "value", -Metropolitan.Cities)
    
    # Filter only the cases registered columns
    city_data_cases <- city_data_long %>%
      filter(grepl("CR", variable))
    
    # Create a trend chart using plot_ly
    plot_ly(city_data_cases, x = ~variable, y = ~value, type = 'scatter', mode = 'lines+markers') %>%
      layout(title = paste("Cases Registered Trend in", selected_city),
             xaxis = list(title = "Year"),
             yaxis = list(title = "Cases Registered"))
  })
  
#ANOVA Tests
  output$anova_result_1 <- renderPrint({
    # Filter data for cases registered columns
    cases_data <- my_data %>%
      select(Metropolitan.Cities, "X2019...CR","X2020...CR","X2021...CR") %>%
      gather(key = "Year", value = "CasesRegistered", -Metropolitan.Cities)
    
    # Perform ANOVA test
    anova_result_1 <- aov(CasesRegistered ~ Year, data = cases_data)
    
    # Print ANOVA summary
    summary(anova_result_1)
  })
  
  output$anova_result_2 <- renderPrint({
    # Filter data for cases registered columns
    cases_data <- my_data %>%
      select(Metropolitan.Cities, "X2019...Persons.Arrested","X2020...Persons.Arrested","X2021...Persons.Arrested") %>%
      gather(key = "Year", value = "CasesRegistered", -Metropolitan.Cities)
    
    # Perform ANOVA test
    anova_result_2 <- aov(CasesRegistered ~ Year, data = cases_data)
    
    # Print ANOVA summary
    summary(anova_result_2)
  })
}