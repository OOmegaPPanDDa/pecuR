# tab page 1 #

output$histCentile <- renderPlot({
  id   <- which( vars == input$feature )
  x    <- houseprice[, id]
  bins <- seq(min(x), max(x), length.out = input$house_bins + 1)
  hist(x, breaks = bins, col = 'darkgray', border = 'white')
})

output$houseMap <- renderLeaflet({
  houseMap <- leaflet() %>% addTiles() %>%
    setView(lng = houseprice$long[1], lat = houseprice$lat[1], zoom = 11)
  
  id = which(vars == input$feature )
  col  <- palette()
  radius <- ifelse(houseprice[, id] >= mean(houseprice[, id]), 300, 30)
  
  houseMap <- addCircles(houseMap, lng=houseprice$long, lat=houseprice$lat, radius = radius
                         , stroke=FALSE, fillOpacity=0.4, fillColor=col[id])
  houseMap
  
})

# This observer is responsible for maintaining the circles and legend,
# according to the variables the user has chosen to map to color and size.
# observe({
#   id   <- which( vars == input$feature )
#   col  <- palette()
#   
#   radius <- ifelse(houseprice[, id] >= mean(houseprice[, id]), 300, 30)
#   
#   leafletProxy("houseMap", data = houseprice) %>%
#     clearShapes() %>%
#     addCircles(~long, ~lat, radius=radius,
#                stroke=FALSE, fillOpacity=0.4, fillColor=col[id])
# })

selectedData <- reactive({
  idx   <- which( vars == input$featureX )
  idy   <- which( vars == input$featureY )
  houseprice[, c(idx, idy)]
})

clusters <- reactive({
  kmeans(selectedData(), input$clusters)
})