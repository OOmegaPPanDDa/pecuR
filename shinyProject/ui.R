
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)


shinyUI(
  fluidPage(
    # Application title
    titlePanel("Old Faithful Geyser Data"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30),


        numericInput("getmean", "input mean: ", value = 0),
        numericInput("getvar", "input var: ", value = 1),
        numericInput("getn", "input n: ", value = 100),
        
        checkboxGroupInput("Area", label = h2("administrative district"),
                           choices = list("Starbucks"="star","COSMED"="cosmed","MRT"="mrt","POST"='post','CAFE85'='cafe85'),
                           selected = c('star')),
        
        sliderInput("zoom",
                    "zoom size:",
                    min = 1,
                    max = 18,
                    value = 13)
        ),
    
      mainPanel(
        plotOutput('distPlot'),
        plotOutput('randomNumber'),
        leafletOutput("mymap", height='600px'),
        textOutput("mapcheck"),
        tableOutput('store')
        
        )
      )
    )
)