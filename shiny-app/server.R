
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("data.R", local=TRUE)

r_colors <- rgb(t(col2rgb(colors()) / 255))

names(r_colors) <- colors()

shinyServer(function(input, output, session) {

  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    displayData[displayData$displayValue >= input$range[1] & displayData$displayValue <= input$range[2],]
  })
  
  # This reactive expression represents the palette function,
  # which changes as the user makes selections in UI.
  colorpal <- reactive({
    colorNumeric(input$colors, displayData$displayValue)
  })
  
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet(displayData) %>% addTiles() %>%
      fitBounds(~min(Longitude), ~min(Latitude), ~max(Longitude), ~max(Latitude))
  })
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  observe({
    pal <- colorpal()
    
    leafletProxy("map", data = filteredData()) %>%
      clearMarkers() %>%
      addTiles() %>%
      #addMarkers(~Longitude, ~Latitude)
     # addCircles(radius = ~displayValue, weight = 1, color = "#777777",
    #             fillColor = "#777777", fillOpacity = 0.7, popup = ~paste(displayValue)
    addCircleMarkers(radius = ~10, color = "#777777",
                                  fillColor = ~pal(displayValue), fillOpacity = 0.7, 
                     popup = ~paste(displayValue))
      
  })
  
  # Use a separate observer to recreate the legend as needed.
  observe({
    proxy <- leafletProxy("map", data = displayData)
    
    # Remove any existing legend, and only if the legend is
    # enabled, create a new one.
    proxy %>% clearControls()
    if (input$legend) {
      pal <- colorpal()
      proxy %>% addLegend(position = "bottomright",
                          pal = pal, values = ~displayValue
      )
    }
  })

})
