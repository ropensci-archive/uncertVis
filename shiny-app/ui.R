
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
           plotOutput("excplot")
    ),
    column(3,
           sliderInput("range", "Thresholds", 1, length(thresholdLabels),
                       value = 1, step = 1
           ),
           
           paste(thresholdLabels, collapse=', '),
           
           checkboxInput("threshold", "Check to show only values above threshold; uncheck to show only values below threshold", TRUE),
           selectInput("colors", "Color Scheme",
                       rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
           ),
           checkboxInput("legend", "Show legend", TRUE)
    )
  )
))
