library(shiny)
library(shinythemes)
library(dplyr)
library(ggmap)
#library(leaflet)
source('readdata.R')



navbarPage("Disaster Info",
           theme = shinytheme("flatly"),
           
           tabPanel(HTML("<img src='typhoon.png' width = '40px' height='40px'>"),
                    titlePanel("Typhoon"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("typhoon", "颱風:",
                                    c("薇帕颱風 (Wipha)" = "01_Wipha",
                                      "夏浪颱風 (Halong)" = "02_Halong",
                                      "卡玫基颱風 (Kalmaegi)" = "06_Kalmaegi",
                                      "雷馬遜颱風 (Rammasun Manila)" = "08_Rammasun_Manila"
                                    )),
                        
                        sliderInput("zoom_Ty",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5),
                        
                        uiOutput("date_ui_typhoon")
                        
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
           
           tabPanel(HTML("<img src='earthquake.png' width = '40px' height='40px'>"),
                    titlePanel("Earthquakes"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("earthquake", "地震:",
                                    c("保和地震 (Bohol)" = "12_Bohol",
                                      "伊基克地震 (Iquique)" = "13_Iquique",
                                      "南納帕地震 (South Napa)" = "14_Napa"
                                    )),
                        
                        
                        
                        
                        sliderInput("zoom_E",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5),
                        
                        uiOutput("date_ui_earthquake")
                        
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
           
           tabPanel(HTML("<img src='snow.png' width = '40px' height='40px'>"),
                    titlePanel("Winter Storms"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("winter", "暴風雪:",
                                    c("諾福暴風雪 (Norfolk)" = "21_Norfolk",
                                      "漢堡暴風雪 (Hamburg)" = "22_Hamburg",
                                      "亞特蘭大暴風雪 (Atlanta)" = "23_Atlanta"
                                    )),
                        
                        
                        sliderInput("zoom_W",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5),
                        
                        uiOutput("date_ui_winter")
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
           
           tabPanel(HTML("<img src='thunder.png' width = '40px' height='40px'>"),
                    titlePanel("Thunderstorms"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("thunder", "雷雨:",
                                    c("鳳凰城雷雨 (Phoenix)" = "31_Phoenix",
                                      "底特律雷雨 (Detroit)" = "32_Detroit",
                                      "巴爾的摩雷雨 (Baltimore)" = "33_Baltimore"
                                    )),
                        
                        
                        sliderInput("zoom_Thun",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5),
                        
                        
                        uiOutput("date_ui_thunder")
                        
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
           
           tabPanel(HTML("<img src='fire.png' width = '40px' height='40px'>"),
                    titlePanel("Wildfires"),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        
                        selectInput("fire", "森林大火:",
                                    c("澳洲森林火災1 (AuFire1)" = "41_AuFire1",
                                      "澳洲森林火災2 (AuFire2)" = "42_AuFire2"
                                    )),
                        
                        
                        sliderInput("zoom_F",
                                    "Zoom:",
                                    min = 1,
                                    max = 15,
                                    value = 5),
                        
                        
                        uiOutput("date_ui_fire")
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
           
           
           tabPanel(HTML("<img src='reference.png' width = '40px' height='40px'>"),
                    mainPanel(
                      HTML('<center>'),
                      HTML('<br><hr><br>'),
                      HTML('災害數據資料來源'),
                      HTML('<br>'),
                      HTML('<a href="https://www.kaggle.com/dryad/human-mobility-during-natural-disasters">kaggle -- human-mobility-during-natural-disasters</a>'),
                      HTML('<br><hr><br>'),
                      HTML('圖片來源'),
                      HTML('<br>'),
                      HTML('<a href="https://cdn1.iconfinder.com/data/icons/weather-elements/512/Weather_TornadoVetor.png">Typhoon</a>'),
                      HTML('<br>'),
                      HTML('<a href="https://cdn0.iconfinder.com/data/icons/disaster-blaster/250/Earthquake-512.png">Earthquakes</a>'),
                      HTML('<br>'),
                      HTML('<a href="http://vignette2.wikia.nocookie.net/camphalfbloodroleplay/images/5/50/White_snow.png/revision/latest?cb=20121201141304">Winter Storms</a>'),
                      HTML('<br>'),
                      HTML('<a href="http://www.freeiconspng.com/free-images/thunderstorm-icon-15884">Thunderstorms</a>'),
                      HTML('<br>'),
                      HTML('<a href="https://img.clipartfest.com/f24f08fa9a50dda6e137b50449b9dcfb_fire-flames-clipart-free-flame-clipart-png_5084-7399.png">WildFires</a>'),
                      HTML('<br>'),
                      HTML('<a href="http://www.melissadata.com/dqt/images/data-quality-reference-data-icon.png">Reference</a>'),
                      HTML('<br><hr><br>'),
                      HTML('</center>')
                      )
                  ),
           
           tags$style(type="text/css",
                      ".shiny-output-error { visibility: hidden; }",
                      ".shiny-output-error:before { visibility: hidden; }"
           )
)

