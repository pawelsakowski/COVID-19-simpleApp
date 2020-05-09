#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("COVID-19 analysis"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("countryChoice",
                        label = "select country",
                        c("China", "US", "United Kingdom", "Italy", "Spain", "Poland"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("coronaPlot"),
            plotOutput("coronaPlot2")
        )
    )
))
