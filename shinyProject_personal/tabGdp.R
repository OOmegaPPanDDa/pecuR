output$gdpPlot <- renderPlot({
  
  #TabletempIdC = 2004
  #TabletempIdP = 1999
  #inputc = input$totalC - TabletempIdC
  #inputp = input$totalP - TabletempIdP
  
  inputc = paste0('TotalC',input$totalC)
  inputp = paste0('TotalP',input$totalP)
  inpute = paste0('TotalE',input$totalP)
  
  x = gdp[,inputc]
  y = gdp[,inputp]
  z = gdp[,inpute]
  region = gdp[,"Region"]
  
  df <- data.frame(inputc = x, inputp = y, inpute = z, region = region)
  
  options(scipen=999)
  ggplot(df,aes(inputc,inputp)) +
    geom_point(aes(size = inpute)) + 
    scale_size_area() +
    aes(shape = factor(region)) +
    geom_point(aes(colour = factor(region)), size = 4) +
    geom_point(colour="grey90", size = 1.5) +
    labs(title = paste(inputc,',', inputp, 'and', inpute, 'Relationship') , x= inputc , y= inputp)
})



output$gdpPlotGvis <- renderGvis({
  
  inputc = paste0('TotalC',input$totalC)
  inputp = paste0('TotalP',input$totalP)
  inpute = paste0('TotalE',input$totalP)
  
  Bubble <- gvisBubbleChart(gdp, idvar="StateCodes", 
                            xvar=inputc, yvar=inputp,
                            sizevar = inpute,
                            colorvar='Region',
                            options = list(width=1000,
                                           height=600 ))
                            
  Bubble
  
})
  
  