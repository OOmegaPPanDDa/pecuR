
output$date_ui_typhoon <- renderUI({
  data_Ty <- dt_Ty %>%
    filter(disaster.event == input$typhoon)
  
  dateInput('day_Ty',"Day",value = data_Ty$date[1], 
            min = min(data_Ty$date), max = max(data_Ty$date), language = "zh-TW")
  
}) 




output$map_typhoon <- renderPlot({
  
  data_Ty <- dt_Ty %>%
    filter(disaster.event == input$typhoon & date == input$day_Ty) %>%
    select(lon,lat)
  
  colnames(data_Ty) <- c('lon','lat')
  
  if(nrow(data_Ty) == 0)
  {
    map <- get_googlemap(center = c(lon = 120.233937, lat = 22.993013),
                         zoom =  input$zoom_Ty , maptype = "roadmap", language = "zh-TW")
  }else{
    map <- get_googlemap(center= c(lon=median(data_Ty$lon),lat=median(data_Ty$lat))
                ,zoom = input$zoom_Ty , maptype = "roadmap", language = "zh-TW")
  }
  
  ggmap(map) + 
    geom_point(aes(x = lon, y = lat), size = 1, col="coral", data = data_Ty, alpha = 1)
  
  
  
})



# output$leaf_typhoon <- renderLeaflet({
#   
#   
#   data_Ty <- dt_Ty %>%
#     filter(disaster.event == input$typhoon & date == input$day_Ty) %>%
#     select(lon,lat)
#   
#   colnames(data_Ty) <- c('lon','lat')
#   
#   map_markers <- leaflet() %>% 
#     addTiles() %>%
#     setView(median(data_Ty$lon), median(data_Ty$lat), zoom = input$zoom_Ty)
# 
#   iconF = paste('./www/typhoon.png')
#   
#   LeafIcon <- makeIcon(
#     iconUrl = iconF,
#     iconWidth = 18, iconHeight = 18,
#     iconAnchorX = 18, iconAnchorY = 18)
#   
#   lng.path = data_Ty$lon
#   lat.path = data_Ty$lat
#   
#   map_markers <- addMarkers(map_markers, lng=lng.path,lat=lat.path, icon=LeafIcon)
#   
#   map_markers
#   
# })







output$hist_typhoon <- renderPlot({
  data_Ty <- dt_Ty %>%
    filter(disaster.event == input$typhoon) %>%
    arrange(date) %>%
    group_by(date) %>%
    mutate(day_count = n()) %>%
    ungroup() %>%
    select(disaster.event,date,day_count) %>%
    unique()
  
  
  options(scipen=999)
  ggplot(data_Ty, aes(x=date,y=day_count,fill=day_count)) + 
    geom_histogram(stat='identity',alpha = .7) + 
    scale_fill_gradient("Count", low = "#84C1FF", high = "#0066CC") + 
    labs(title= paste0(input$typhoon,' 颱風每日 Tag 數')) +
    labs(x="日期", y="Tag 分佈量") + 
    theme(text = element_text(family= 'Arial Unicode MS'))
})









output$intro_typhoon <- renderImage({
  
  
  
  intro_image = paste0('./www/',input$typhoon,'.JPG',collapse = '')
  
  
  list(src = intro_image,
       contentType = 'image/JPG',
       width = '100%',
       height = '100%',
       alt = "Disaster Introduction")
  
}, deleteFile = FALSE)




