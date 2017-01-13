library(shiny)
library(leaflet)
library(dplyr)
library(datasets)
library(ggvis)
library(RSQLite)
library(shinythemes)
library(googleVis)
library(ggplot2)


source("readdata.R")

navbarPage(theme = shinytheme("flatly"),
  "Pecu R Class:  B02705027 陳信豪",
  
  tabPanel(
    'Store Map',
    fluidPage(
      # Application title
      titlePanel("Taipei Store Data"),
      
      sidebarLayout(
        sidebarPanel(
          
          checkboxGroupInput("Area", label = h2("administrative district"),
                             choices = list("Starbucks"="star","COSMED"="cosmed","MRT"="mrt","POST"='post','CAFE8MRT'='cafe8mrt'),
                             selected = c('star')),
          
          sliderInput("zoom",
                      "zoom size:",
                      min = 1,
                      max = 18,
                      value = 13)
        ),
        
        mainPanel(
          navbarPage('Store Info',
            tabPanel( 'map_part',
                      textOutput("mapcheck"),
                      HTML('<br><hr><br>'),
                      leafletOutput("mymap", height='600px')),
            tabPanel( 'table_part',
                      htmlOutput('store'))
          )
          
          
          
        )
      )
    )
    
  ),
  
  tabPanel(
    "GDP",
    fluidPage(
      h2('GPD Page'),
      fluidRow(
        column(
          3,
          wellPanel(
            h4("Filter"),
            sliderInput("totalC", "Total energy consumption in billion BTU in given year.", min = 2010, max = 2014, value = 2010, step = 1),
            sliderInput("totalP", "Total energy production in billion BTU in given year.", min = 2010, max = 2014, value = 2010, step = 1),
            sliderInput("totalE", "Total Energy expenditures in million USD in given year.", min = 2010, max = 2014, value = 2010, step = 1)
          )

        ),
        
        column(
          9,
          HTML('<center>'),
          HTML('<br><hr><br>'),
          HTML("<font size='5' color='coral'>ggplot2 Method</font>"),
          HTML('<br>'),
          plotOutput("gdpPlot"),
          HTML('<br><hr><br>'),
          HTML("<font size='5' color='coral'>googleVis Method</font>"),
          HTML('<br>'),
          htmlOutput("gdpPlotGvis"),
          HTML('</center>')
        )
      )
    )
  ),
  
  tabPanel(
    'Basic Practice',
    fluidPage(
      # Application title
      titlePanel("Hist and Plot"),
      
      fluidRow(
        column(3,
               wellPanel(
                 'Basic_hist',
                  sliderInput(
                    "bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30
                    )
                 )
               ),
        
        column(9,
               plotOutput('distPlot')
               )
      ),
      
      fluidRow(
        column(3,
               wellPanel(
                  'Basic_scatter_plot',
                  numericInput("getmean", "input mean: ", value = 0),
                  numericInput("getvar", "input var: ", value = 1),
                  numericInput("getn", "input n: ", value = 100)
               )
              ),
        
        column(9,
               plotOutput('randomNumber')
               )
      )
    )
  ),
  
  tabPanel(
    "Movie",
    fluidPage(
      h2('Movie Page'),
      fluidRow(
        column(
          3,
          wellPanel(
            h4("Filter"),
            sliderInput("reviews", "Minimum number of reviews on Rotten Tomatoes",10, 300, 80, step = 10),
            sliderInput("year", "Year released", 1940, 2014, value = c(1970, 2014)),
            sliderInput("oscars", "Minimum number of Oscar wins (all categories)", 0, 4, 0, step = 1),
            sliderInput("boxoffice", "Dollars at Box Office (millions)", 0, 800, c(0, 800), step = 1),
            selectInput("genre", "Genre (a movie can have multiple genres)",
              c("All", "Action", "Adventure", "Animation", "Biography", "Comedy",
              "Crime", "Documentary", "Drama", "Family", "Fantasy", "History",
              "Horror", "Music", "Musical", "Mystery", "Romance", "Sci-Fi",
              "Short", "Sport", "Thriller", "War", "Western")
            ),
            textInput("director", "Director name contains (e.g., Miyazaki)"),
            textInput("cast", "Cast names contains (e.g. Tom Hanks)")
          ),
          wellPanel(
            selectInput("xvar", "X-axis variable", axis_vars, selected = "Meter"),
            selectInput("yvar", "Y-axis variable", axis_vars, selected = "Reviews"),
            tags$small(paste0(
                   "Note: The Tomato Meter is the proportion of positive reviews",
                   " (as judged by the Rotten Tomatoes staff), and the Numeric rating is",
                   " a normalized 1-10 score of those reviews which have star ratings",
                   " (for example, 3 out of 4 stars)."
                 ))
          )
        ),
      
        column(
          9,
          ggvisOutput("plotMovie"),
          wellPanel(
            span("Number of movies selected:",
            textOutput("n_movies"))
          )
        )
      )
    )
  ),
           
  tabPanel("House Price 1 - Interactive Map",
    leafletOutput("houseMap", width="100%", height="1000"),
    absolutePanel(fixed = TRUE, draggable = TRUE, 
                  top = 200, left = 20, right = "auto", 
                  bottom = "auto", width = 330, height = "auto",
                  h2("Feature Selects"),
                  selectInput("feature", "Features", vars[3:7]),
                  sliderInput("house_bins", "",
                              min = 0, max = 100, value = 25),
                  plotOutput("histCentile", height = 200)
    )
  ),
  
  tabPanel("House Price 2 - K Means",
    selectInput("featureX", "x Features", vars[3:7]),
    selectInput("featureY", "Y Features", vars[3:7]),
    sliderInput("clusters", "",
               min = 1, max = 10, value = 5),
    plotOutput("kmeans")
  ),
  tabPanel("House Price 3 - Render Table",
    fluidPage(
     fluidRow(
       column(12,
              h2("Shiny Table Demo"),
              fluidRow(
                column(4,
                       h3("Inputs"),
                       hr(),
                       fluidRow(
                         column(6, selectInput("dataset", "Data:", 
                                               c("rock", "pressure", "cars", "mock"))),
                         column(6,numericInput("obs", "Rows:", 6))
                       ),
                       br(),
                       fluidRow(
                         column(6, checkboxGroupInput("format", "Options:",
                                                      c("striped", "bordered", "hover"))),
                         column(6, radioButtons("spacing", "Spacing:",
                                                c("xs", "s", "m", "l"), "s"))
                       ),
                       br(),
                       fluidRow(
                         column(6, selectInput("width", "Width:",
                                               c("auto", "100%", "75%",
                                                 "300", "300px", "10cm"), "auto")),
                         column(6, uiOutput("pre_align"))
                       ),
                       br(),
                       fluidRow(
                         column(6, radioButtons("rownames", "Include rownames:",
                                                c("T", "F"), "F", inline=TRUE)),
                         column(6, radioButtons("colnames", "Include colnames:",
                                                c("T", "F"), "T", inline=TRUE))
                       ),
                       br(),
                       fluidRow(
                         column(6, selectInput("digits", "Number of decimal places:",
                                               c("NULL", "3", "2", "0", "-2", "-3"))),
                         column(6, selectInput("na", "String for missing values:",
                                               c("NA", "missing", "-99"), "NA"))
                       )
                ),
                column(7, offset=1,
                       h3("Table and Code"),
                       br(),
                       tableOutput("view"),
                       br(),
                       h4("Corresponding R code:"),
                       htmlOutput("code")
                )
              )
       )
     )
    )           
  )
)