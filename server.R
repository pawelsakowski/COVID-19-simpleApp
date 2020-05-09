source("dataPrep.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$coronaPlot <- renderPlot({

        data %>%
            select(date, starts_with("num")) %>%
            group_by(date) %>%
            summarize_all(list(sum = sum), na.rm = TRUE) %>%
            mutate(diff_cnfd_rcvd = num_confirmed_sum - num_recovered_sum) %>%
            gather(key = key, value = value, -date) %>%
            ggplot(aes(date, value, col = key)) +
            geom_point() + 
            geom_line() +
            theme_bw() +
            labs(title = "Coronavirus COVID-19 Global Cases",
                 subtitle = "a simple app for DSwR Postgraduate Studies at University of Warsaw",
                 caption = "data source: https://github.com/CSSEGISandData/COVID-19")
        

    })

    output$coronaPlot2 <- renderPlot({
      
      data2 %>%
        filter(Country_Region %in% input$countryChoice) %>%
        mutate(diff_cnfd_rcvd = num_confirmed_sum - num_recovered_sum) %>%
        gather(key = key, value = value, -date, -Country_Region) %>%
        ggplot(aes(date, value, col = key)) +
        geom_point() + 
        geom_line() +
        theme_bw() +
        labs(title = "Coronavirus COVID-19 - Cases by country",
             subtitle = "a simple app for DSwR Postgraduate Studies at University of Warsaw",
             caption = "data source: https://github.com/CSSEGISandData/COVID-19")
      
      
    })
    
})
