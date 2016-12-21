
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
source('source.R')

shinyServer(function(input, output, session) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

  output$randomNumber <- renderPlot({

    getmean <- input$getmean
    getvar <- input$getvar
    n <- input$getn

    # generate bins based on input$bins from ui.R
    getnum <- rnorm(n, mean = getmean, sd = getvar^0.5)

    # draw the histogram with the specified number of bins
    plot(getnum, col = 'deepskyblue')

  }
  )
  
  
  
  
  # ShowId <- eventReactive(input$Area, {
  #   which(stores$tag == input$Area)
  # })
  
  
  # observeEvent(input$Area, {
  #   # ShowId()
  #   which(stores$tag == input$Area)
  #   m <- leafletProxy('mymap',session) %>% clearMarkers()
  #   for( i in input$Area )
  #   {
  #     subid = which(stores$tag == i)
  #     iconF = paste('i_', i, '.png', sep='')
  #     
  #     LeafIcon <- makeIcon(
  #       iconUrl = iconF,
  #       iconWidth = 18, iconHeight = 18,
  #       iconAnchorX = 18, iconAnchorY = 18)
  #     
  #     lng.path = stores$lng[subid]
  #     lat.path = stores$lat[subid]
  #     
  #     m <- addMarkers(m, lng=lng.path,lat=lat.path, icon=LeafIcon)
  #   }
  # })
  
  
  
  
  output$mymap <- renderLeaflet({
    
    map_markers <- leaflet() %>% 
      addTiles() %>%
      setView(stores$lng[1], stores$lat[1], zoom = input$zoom)
    
    for( i in input$Area)
    {
      subid = which(stores$tag == i)
      iconF = paste('i_', i, '.png', sep='')

      LeafIcon <- makeIcon(
        iconUrl = iconF,
        iconWidth = 18, iconHeight = 18,
        iconAnchorX = 18, iconAnchorY = 18)

      lng.path = stores$lng[subid]
      lat.path = stores$lat[subid]

      map_markers <- addMarkers(map_markers, lng=lng.path,lat=lat.path, icon=LeafIcon)
    }
    
    map_markers
  })
  
  output$mapcheck <- renderText({
    print(input$Area)
  })
  
  output$store <- renderTable({
    ids = which(stores$tag == input$Area)
    stores[ids,]
    })

})
