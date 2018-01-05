#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
# use only numeric collumns of attenu
datt <- attenu[,sapply(attenu,is.numeric)] # Define server logic required to draw a plot and fit selected variables
shinyServer(function(input, output) {
    # Define x, y, fit in a reactive statement used to create the plot and fit summary
    output$scatterPlot <- renderPlot({
      if (input$XLog) {
        x <- log10(with(datt,get(input$xvar)))
        xlab <- c("log ",input$xvar)
      }
      else {
        x <- with(datt,get(input$xvar))
        xlab <- input$xvar
      }
      if (input$YLog) {
        y <- log10(with(datt,get(input$yvar)))
        ylab <- c("log ", input$yvar)
      }
      else {
        y <- with(datt,get(input$yvar))
        ylab <- input$yvar
      }
      fit <- lm(y~I(x^2) +x)
      xNew <- data.frame(x = seq(min(x),max(x), length.out = 50))
      pred <- predict(fit, newdata= xNew)
      plot(x, y, main= input$title, xlab = xlab, ylab = ylab)
      lines(xNew$x, pred)
      legend("topright", bty="n", 
             legend=paste(
                paste('R^2* is ',
                           format(summary(fit)$adj.r.squared, digits=2)),
                paste(format(summary(fit)$coefficients[2], digits =2 ), "x^2",
                           format(summary(fit)$coefficients[3], digits=2),"x",
                           format(summary(fit)$coefficients[1],digits=2)),
                    sep="\n"))
  })
    
  
})
