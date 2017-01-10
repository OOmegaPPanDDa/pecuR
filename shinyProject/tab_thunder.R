
output$date_ui_thunder <- renderUI({
  data_Thun <- dt_Thun %>%
    filter(disaster.event == input$thunder)
  
  dateInput('day_Thun',"Day",value = data_Thun$date[1], 
            min = min(data_Thun$date), max = max(data_Thun$date))
  
}) 




output$map_thunder <- renderPlot({
  
  data_Thun <- dt_Thun %>%
    filter(disaster.event == input$thunder & date == input$day_Thun) %>%
    select(lon,lat)
  
  colnames(data_Thun) <- c('lon','lat')
  
  if(nrow(data_Thun) == 0)
  {
    map <- get_googlemap(center = c(lon = 120.233937, lat = 22.993013),
                         zoom =  input$zoom_Thun , maptype = "roadmap", language = "zh-TW")
  }else{
    map <- get_googlemap(center= c(lon=median(data_Thun$lon),lat=median(data_Thun$lat))
                         ,zoom = input$zoom_Thun , maptype = "roadmap", language = "zh-TW")
  }
  
  ggmap(map) + 
    geom_point(aes(x = lon, y = lat), size = 1, col="coral", data = data_Thun, alpha = 1)
  
  
  
})



# output$leaf_thunder <- renderLeaflet({
#   
#   
#   data_Thun <- dt_Thun %>%
#     filter(disaster.event == input$thunder & date == input$day_Thun) %>%
#     select(lon,lat)
#   
#   colnames(data_Thun) <- c('lon','lat')
#   
#   map_markers <- leaflet() %>% 
#     addTiles() %>%
#     setView(median(data_Thun$lon), median(data_Thun$lat), zoom = input$zoom_Thun)
# 
#   iconF = paste('./www/thunder.png')
#   
#   LeafIcon <- makeIcon(
#     iconUrl = iconF,
#     iconWidth = 18, iconHeight = 18,
#     iconAnchorX = 18, iconAnchorY = 18)
#   
#   lng.path = data_Thun$lon
#   lat.path = data_Thun$lat
#   
#   map_markers <- addMarkers(map_markers, lng=lng.path,lat=lat.path, icon=LeafIcon)
#   
#   map_markers
#   
# })







output$hist_thunder <- renderPlot({
  data_Thun <- dt_Thun %>%
    filter(disaster.event == input$thunder) %>%
    arrange(date) %>%
    group_by(date) %>%
    mutate(day_count = n()) %>%
    ungroup() %>%
    select(disaster.event,date,day_count) %>%
    unique()
  
  
  options(scipen=999)
  ggplot(data_Thun, aes(x=date,y=day_count,fill=day_count)) + 
    geom_histogram(stat='identity',alpha = .7) + 
    scale_fill_gradient("Count", low = "#84C1FF", high = "#0066CC") + 
    labs(title= paste0(input$thunder,' 雷雨每日 Tag 數')) +
    labs(x="日期", y="Tag 分佈量") + 
    theme(text = element_text(family= 'Arial Unicode MS'))
})









output$intro_thunder <- renderImage({
  
  
  
  intro_image = paste0('./www/',input$thunder,'.JPG',collapse = '')
  
  
  list(src = intro_image,
       contentType = 'image/JPG',
       width = '100%',
       height = '100%',
       alt = "Disaster Introduction")
  
}, deleteFile = FALSE)




