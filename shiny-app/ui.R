
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(RColorBrewer)
source("data.R")

shinyUI(fluidPage(
  
  title = "Uncertainty Visualisation",
  
  fluidRow(
    column(9,
           leafletOutput("map"),
           plotOutput("mapPlot")
    ),
    column(3,
           sliderInput("range", "Magnitudes", round(min(displayData$displayValue),1), 
                       round(max(displayData$displayValue),1),
                       value = round(range(displayData$displayValue),1), step = 0.1
           ),
           selectInput("colors", "Color Scheme",
                       rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
           ),
           checkboxInput("legend", "Show legend", TRUE),
           checkboxInput("thresholdType", "Remove values outside threshold", TRUE)
    )
  )
))
