output$mymap <- renderLeaflet({
  
  map_markers <- leaflet() %>% 
    addTiles() %>%
    setView(stores$lng[1], stores$lat[1], zoom = input$zoom)
  
  for( i in input$Area)
  {
    subid = which(stores$tag == i)
    iconF = paste('./img/i_', i, '.png', sep='')
    
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



# totalIcons <- iconList(
#   star = makeIcon("i_star.png", iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18),
#   cosmed = makeIcon("i_cosmed.png",  iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18),
#   post = makeIcon("i_post.png", iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18),
#   cafe8mrt = makeIcon("i_cafe85.png",  iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18),
#   mrt = makeIcon("i_mrt.png", iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18),
#   rent = makeIcon("i_rent.png", iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18)
# )
# 
# 
# valueIcons <- iconList(
#   high = makeIcon("i_red.png", iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18),
#   medium = makeIcon("i_3star.png",  iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18),
#   low = makeIcon("i_2star.png", iconWidth=18, iconHeight=18, iconAnchorX=18, iconAnchorY=18)
# )
# 
# starIcons <- icons(
#   iconUrl = "i_star.png" ,
#   iconWidth = 20, iconHeight = 20,
#   iconAnchorX = 20, iconAnchorY = 20
# )
# mrtIcons <- icons(
#   iconUrl = "i_mrt.png" ,
#   iconWidth = 20, iconHeight = 20,
#   iconAnchorX = 20, iconAnchorY = 20
# )
# 
# leafIcons <- icons(
#   iconUrl = ifelse(stores$tag =="star",
#                    "i_mrt.png",
#                    "i_star.png"),
#   iconWidth = 18, iconHeight = 18,
#   iconAnchorX = 18, iconAnchorY = 18
# )