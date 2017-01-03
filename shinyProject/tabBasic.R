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