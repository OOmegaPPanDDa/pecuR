
output$date_ui_earthquake <- renderUI({
  data_E <- dt_E %>%
    filter(disaster.event == input$earthquake)
  
  dateInput('day_E',"Day",value = data_E$date[1], 
            min = min(data_E$date), max = max(data_E$date))
  
}) 




output$map_earthquake <- renderPlot({
  
  data_E <- dt_E %>%
    filter(disaster.event == input$earthquake & date == input$day_E) %>%
    select(lon,lat)
  
  colnames(data_E) <- c('lon','lat')
  
  if(nrow(data_E) == 0)
  {
    map <- get_googlemap(center = c(lon = 120.233937, lat = 22.993013),
                         zoom =  input$zoom_E , maptype = "roadmap", language = "zh-TW")
  }else{
    map <- get_googlemap(center= c(lon=median(data_E$lon),lat=median(data_E$lat))
                         ,zoom = input$zoom_E , maptype = "roadmap", language = "zh-TW")
  }
  
  ggmap(map) + 
    geom_point(aes(x = lon, y = lat), size = 1, col="coral", data = data_E, alpha = 1)
  
  
  
})



# output$leaf_earthquake <- renderLeaflet({
#   
#   
#   data_E <- dt_E %>%
#     filter(disaster.event == input$earthquake & date == input$day_E) %>%
#     select(lon,lat)
#   
#   colnames(data_E) <- c('lon','lat')
#   
#   map_markers <- leaflet() %>% 
#     addTiles() %>%
#     setView(median(data_E$lon), median(data_E$lat), zoom = input$zoom_E)
# 
#   iconF = paste('./www/earthquake.png')
#   
#   LeafIcon <- makeIcon(
#     iconUrl = iconF,
#     iconWidth = 18, iconHeight = 18,
#     iconAnchorX = 18, iconAnchorY = 18)
#   
#   lng.path = data_E$lon
#   lat.path = data_E$lat
#   
#   map_markers <- addMarkers(map_markers, lng=lng.path,lat=lat.path, icon=LeafIcon)
#   
#   map_markers
#   
# })







output$hist_earthquake <- renderPlot({
  data_E <- dt_E %>%
    filter(disaster.event == input$earthquake) %>%
    arrange(date) %>%
    group_by(date) %>%
    mutate(day_count = n()) %>%
    ungroup() %>%
    select(disaster.event,date,day_count) %>%
    unique()
  
  
  options(scipen=999)
  ggplot(data_E, aes(x=date,y=day_count,fill=day_count)) + 
    geom_histogram(stat='identity',alpha = .7) + 
    scale_fill_gradient("Count", low = "#84C1FF", high = "#0066CC") + 
    labs(title= paste0(input$earthquake,' 地震每日 Tag 數')) +
    labs(x="日期", y="Tag 分佈量") + 
    theme(text = element_text(family= 'Arial Unicode MS'))
})









output$intro_earthquake <- renderImage({
  
  
  
  intro_image = paste0('./www/',input$earthquake,'.JPG',collapse = '')
  
  
  list(src = intro_image,
       contentType = 'image/JPG',
       width = '100%',
       height = '100%',
       alt = "Disaster Introduction")
  
}, deleteFile = FALSE)




