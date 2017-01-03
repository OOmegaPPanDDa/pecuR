output$gdpPlot <- renderPlot({
  
  #TabletempIdC = 2004
  #TabletempIdP = 1999
  #inputc = input$totalC - TabletempIdC
  #inputp = input$totalP - TabletempIdP
  
  inputc = paste0('TotalC',input$totalC)
  inputp = paste0('TotalP',input$totalP)
  
  x = gdp[,inputc]
  y = gdp[,inputp]
  
  plot(x,y)
})

