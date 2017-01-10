library(shiny)
library(shinythemes)
library(dplyr)
library(ggmap)
#library(leaflet)
source('readdata.R')



navbarPage("Disaster Info",
           theme = shinytheme("flatly"),
           
           tabPanel("typhoon",
                    titlePanel("Typhoon"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("typhoon", "颱風:",
                                    c("薇帕颱風 (Wipha)" = "01_Wipha",
                                      "夏浪颱風 (Halong)" = "02_Halong",
                                      "卡玫基颱風 (Kalmaegi)" = "06_Kalmaegi",
                                      "雷馬遜颱風 (Rammasun Manila)" = "08_Rammasun_Manila"
                                    )),
                        
                        uiOutput("date_ui_typhoon"),
                        
                        sliderInput("zoom_Ty",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5)
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          tabPanel("地圖",
                                   plotOutput("map_typhoon")
                                   #leafletOutput("leaf_typhoon")
                                  ),
                          tabPanel("統計圖表",
                                   plotOutput("hist_typhoon")
                                   ),
                          tabPanel("災難介紹",
                                   imageOutput("intro_typhoon")
                                   )
                        )
                      )
                    )       
           ),
           
           tabPanel("earthquakes",
                    titlePanel("Earthquakes"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("earthquake", "地震:",
                                    c("保和地震 (Bohol)" = "12_Bohol",
                                      "伊基克地震 (Iquique)" = "13_Iquique",
                                      "南納帕地震 (South Napa)" = "14_Napa"
                                    )),
                        
                        uiOutput("date_ui_earthquake"),
                        
                        
                        sliderInput("zoom_E",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5)
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          tabPanel("地圖",
                                   plotOutput("map_earthquake")
                                   ),
                          tabPanel("統計圖表",
                                    plotOutput("hist_earthquake")
                                   ),
                          tabPanel("災難介紹",
                                   imageOutput("intro_earthquake")
                          )
                        )
                      )
                    )       
                    
           ),
           
           tabPanel("winter storms",
                    titlePanel("Winter Storms"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("winter", "暴風雪:",
                                    c("諾福暴風雪 (Norfolk)" = "21_Norfolk",
                                      "漢堡暴風雪 (Hamburg)" = "22_Hamburg",
                                      "亞特蘭大暴風雪 (Atlanta)" = "23_Atlanta"
                                    )),
                        
                        uiOutput("date_ui_winter"),
                        
                        sliderInput("zoom_W",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5)
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          tabPanel("地圖",
                                   plotOutput("map_winter")
                          ),
                          tabPanel("統計圖表",
                                   plotOutput("hist_winter")
                          ),
                          tabPanel("災難介紹",
                                   imageOutput("intro_winter")
                          )
                        )
                      )
                    )       
                    
           ),
           
           tabPanel("thunderstorms",
                    titlePanel("Thunderstorms"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("thunder", "雷雨:",
                                    c("鳳凰城雷雨 (Phoenix)" = "31_Phoenix",
                                      "底特律雷雨 (Detroit)" = "32_Detroit",
                                      "巴爾的摩雷雨 (Baltimore)" = "33_Baltimore"
                                    )),
                        
                        uiOutput("date_ui_thunder"),
                        
                        sliderInput("zoom_Thun",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5)
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          tabPanel("地圖",
                                   plotOutput("map_thunder")
                          ),
                          tabPanel("統計圖表",
                                   plotOutput("hist_thunder")
                          ),
                          tabPanel("災難介紹",
                                   imageOutput("intro_thunder")
                          )
                        )
                      )
                    )       
                    
           ),
           
           tabPanel("wildfires",
                    titlePanel("Wildfires"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("fire", "森林大火:",
                                    c("澳洲森林火災1 (AuFire1)" = "41_AuFire1",
                                      "澳洲森林火災2 (AuFire2)" = "42_AuFire2"
                                    )),
                        
                        uiOutput("date_ui_fire"),
                        
                        sliderInput("zoom_F",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5)
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          tabPanel("地圖",
                                   plotOutput("map_fire")
                          ),
                          tabPanel("統計圖表",
                                   plotOutput("hist_fire")
                          ),
                          tabPanel("災難介紹",
                                   imageOutput("intro_fire")
                          )
                        )
                      )
                    )       
                    
           ),
           
           tags$style(type="text/css",
                      ".shiny-output-error { visibility: hidden; }",
                      ".shiny-output-error:before { visibility: hidden; }"
           )
)

