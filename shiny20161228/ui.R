library(shiny)
library(leaflet)
library(ggvis)
source("readdata.R")

vars <- colnames(houseprice)

navbarPage(
  "house price",
  
  tabPanel(
    "New GDP Test",
    fluidPage(
      h2('GPD Page'),
      fluidRow(
        column(
          3,
          wellPanel(
            h4("Filter"),
            sliderInput("totalC", "The first year’s total energy consumption divided by the second year’s total energy consumption, times 100.", min = 2010, max = 2014, value = 2010, step = 1),
            sliderInput("totalP", "The first year’s total energy production divided by the second year’s total energy production, times 100", min = 2010, max = 2014, value = 2010, step = 1)
          )

        ),
        
        column(
          9,
          plotOutput("gdpPlot")
        )
      )
    )
  ),
  
  tabPanel(
    "New Movie Test",
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
          ggvisOutput("plot1"),
          wellPanel(
            span("Number of movies selected:",
            textOutput("n_movies"))
          )
        )
      )
    )
  ),
           
  tabPanel("Interactive map",
    leafletOutput("myMap", width="100%", height="1000"),
    absolutePanel(fixed = TRUE, draggable = TRUE, 
                  top = 200, left = 20, right = "auto", 
                  bottom = "auto", width = 330, height = "auto",
                  h2("Feature Selects"),
                  selectInput("feature", "Features", vars[3:7]),
                  sliderInput("bins", "",
                              min = 0, max = 100, value = 25),
                  plotOutput("histCentile", height = 200)
    )
  ),
  
  tabPanel("K means",
    selectInput("featureX", "x Features", vars[3:7]),
    selectInput("featureY", "Y Features", vars[3:7]),
    sliderInput("clusters", "",
               min = 1, max = 10, value = 5),
    plotOutput("kmeans")
  ),
  tabPanel("render table",
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