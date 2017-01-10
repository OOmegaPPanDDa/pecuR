
output$date_ui_fire <- renderUI({
  data_F <- dt_F %>%
    filter(disaster.event == input$fire)
  
  dateInput('day_F',"Day",value = data_F$date[1], 
            min = min(data_F$date), max = max(data_F$date))
  
}) 




output$map_fire <- renderPlot({
  
  data_F <- dt_F %>%
    filter(disaster.event == input$fire & date == input$day_F) %>%
    select(lon,lat)
  
  colnames(data_F) <- c('lon','lat')
  
  if(nrow(data_F) == 0)
  {
    map <- get_googlemap(center = c(lon = 120.233937, lat = 22.993013),
                         zoom =  input$zoom_F , maptype = "roadmap", language = "zh-TW")
  }else{
    map <- get_googlemap(center= c(lon=median(data_F$lon),lat=median(data_F$lat))
                         ,zoom = input$zoom_F , maptype = "roadmap", language = "zh-TW")
  }
  
  ggmap(map) + 
    geom_point(aes(x = lon, y = lat), size = 1, col="coral", data = data_F, alpha = 1)
  
  
  
})



# output$leaf_fire <- renderLeaflet({
#   
#   
#   data_F <- dt_F %>%
#     filter(disaster.event == input$fire & date == input$day_F) %>%
#     select(lon,lat)
#   
#   colnames(data_F) <- c('lon','lat')
#   
#   map_markers <- leaflet() %>% 
#     addTiles() %>%
#     setView(median(data_F$lon), median(data_F$lat), zoom = input$zoom_F)
# 
#   iconF = paste('./www/fire.png')
#   
#   LeafIcon <- makeIcon(
#     iconUrl = iconF,
#     iconWidth = 18, iconHeight = 18,
#     iconAnchorX = 18, iconAnchorY = 18)
#   
#   lng.path = data_F$lon
#   lat.path = data_F$lat
#   
#   map_markers <- addMarkers(map_markers, lng=lng.path,lat=lat.path, icon=LeafIcon)
#   
#   map_markers
#   
# })







output$hist_fire <- renderPlot({
  data_F <- dt_F %>%
    filter(disaster.event == input$fire) %>%
    arrange(date) %>%
    group_by(date) %>%
    mutate(day_count = n()) %>%
    ungroup() %>%
    select(disaster.event,date,day_count) %>%
    unique()
  
  
  options(scipen=999)
  ggplot(data_F, aes(x=date,y=day_count,fill=day_count)) + 
    geom_histogram(stat='identity',alpha = .7) + 
    scale_fill_gradient("Count", low = "#84C1FF", high = "#0066CC") + 
    labs(title= paste0(input$fire,' 火災每日 Tag 數')) +
    labs(x="日期", y="Tag 分佈量") + 
    theme(text = element_text(family= 'Arial Unicode MS'))
})









output$intro_fire <- renderImage({
  
  
  
  intro_image = paste0('./www/',input$fire,'.JPG',collapse = '')
  
  
  list(src = intro_image,
       contentType = 'image/JPG',
       width = '100%',
       height = '100%',
       alt = "Disaster Introduction")
  
}, deleteFile = FALSE)




