
output$date_ui_winter <- renderUI({
  data_W <- dt_W %>%
    filter(disaster.event == input$winter)
  
  dateInput('day_W',"Day",value = data_W$date[1], 
            min = min(data_W$date), max = max(data_W$date))
  
}) 




output$map_winter <- renderPlot({
  
  data_W <- dt_W %>%
    filter(disaster.event == input$winter & date == input$day_W) %>%
    select(lon,lat)
  
  colnames(data_W) <- c('lon','lat')
  
  if(nrow(data_W) == 0)
  {
    map <- get_googlemap(center = c(lon = 120.233937, lat = 22.993013),
                         zoom =  input$zoom_W , maptype = "roadmap", language = "zh-TW")
  }else{
    map <- get_googlemap(center= c(lon=median(data_W$lon),lat=median(data_W$lat))
                         ,zoom = input$zoom_W , maptype = "roadmap", language = "zh-TW")
  }
  
  ggmap(map) + 
    geom_point(aes(x = lon, y = lat), size = 1, col="coral", data = data_W, alpha = 1)
  
  
  
})



# output$leaf_winter <- renderLeaflet({
#   
#   
#   data_W <- dt_W %>%
#     filter(disaster.event == input$winter & date == input$day_W) %>%
#     select(lon,lat)
#   
#   colnames(data_W) <- c('lon','lat')
#   
#   map_markers <- leaflet() %>% 
#     addTiles() %>%
#     setView(median(data_W$lon), median(data_W$lat), zoom = input$zoom_W)
# 
#   iconF = paste('./www/winter.png')
#   
#   LeafIcon <- makeIcon(
#     iconUrl = iconF,
#     iconWidth = 18, iconHeight = 18,
#     iconAnchorX = 18, iconAnchorY = 18)
#   
#   lng.path = data_W$lon
#   lat.path = data_W$lat
#   
#   map_markers <- addMarkers(map_markers, lng=lng.path,lat=lat.path, icon=LeafIcon)
#   
#   map_markers
#   
# })







output$hist_winter <- renderPlot({
  data_W <- dt_W %>%
    filter(disaster.event == input$winter) %>%
    arrange(date) %>%
    group_by(date) %>%
    mutate(day_count = n()) %>%
    ungroup() %>%
    select(disaster.event,date,day_count) %>%
    unique()
  
  
  options(scipen=999)
  ggplot(data_W, aes(x=date,y=day_count,fill=day_count)) + 
    geom_histogram(stat='identity',alpha = .7) + 
    scale_fill_gradient("Count", low = "#84C1FF", high = "#0066CC") + 
    labs(title= paste0(input$winter,' 暴風雪每日 Tag 數')) +
    labs(x="日期", y="Tag 分佈量") + 
    theme(text = element_text(family= 'Arial Unicode MS'))
})









output$intro_winter <- renderImage({
  
  
  
  intro_image = paste0('./www/',input$winter,'.JPG',collapse = '')
  
  
  list(src = intro_image,
       contentType = 'image/JPG',
       width = '100%',
       height = '100%',
       alt = "Disaster Introduction")
  
}, deleteFile = FALSE)




