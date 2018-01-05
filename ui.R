library(shiny)
library(datasets)
# use only numeric collumns of attenu
datt <- attenu[,sapply(attenu,is.numeric)] 
# Define UI for ploting and fitting tool
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Earthquake Attenuation"),
  
  # Code to select variables to plot and fit 
  sidebarLayout(
    sidebarPanel(
       h4("Select all settings then select \"Generate plot\""),
       radioButtons("xvar", label = "Select a variable to plot on the x-axis", 
                    choices = names(datt),"dist"),
       checkboxInput("XLog", "Check to transform Y to log scale", value = TRUE),
       radioButtons("yvar", label = "Select a variable to plot on the y-axis", 
                    choices = names(datt),"accel"),
       checkboxInput("YLog", "Check to transform Y to log scale", value = TRUE),
       textInput("title", "Enter a title or leave blank!", ""),
       submitButton("Generate plot with current settings")
    ),
    # Show a plot of the selected variable and a second order polynomial fit.
    mainPanel(
      plotOutput("scatterPlot"),
      h4("Plot generated from seleted variables of the earthquake attenuation data."),
      h4("Log scales are in log base 10.  
         The equation at the top right of the plot is in the same scale as the axis.  
         The coefficients are calculated with linear regression with 
         three terms x^2, x, and an intercept.")
      
    )
  )
))
