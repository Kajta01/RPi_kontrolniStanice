library(shiny)
library(tidyverse)
library(leaflet)

source("../databaze.R")

Stanoviste <- DBI::dbReadTable(conAkce, "Stanoviste")
idMax = (Stanoviste %>% arrange(desc(ID_Skupina)) %>% drop_na(ID_Skupina))$ID_Skupina[1]
if(is.na(idMax)){idMax = 0 }

PocetStanovist = (count(Stanoviste)$n[1])
E = (Stanoviste$GPSE[1] + Stanoviste$GPSE[PocetStanovist]) / 2
N = (Stanoviste$GPSN[1] + Stanoviste$GPSN[PocetStanovist]) / 2
mapa <- NULL

mapa <- leaflet(data = Stanoviste) %>%
  addTiles() %>% setView(E, N, 13)



# Make output for our router in main UI of Shiny app.
ui <- shinyUI(
  bootstrapPage(
    tags$head(tags$link(rel="shortcut icon", 
                                href="https://www.noaa.gov/sites/all/themes/custom/noaa/favicon.ico", 
                                type="image/vnd.microsoft.icon"),
                                HTML("<script src='https://use.fontawesome.com/releases/v5.15.2/js/all.js'
                    data-auto-a11y='true'></script>")),
    tags$style(
        type = "text/css",
        "html, body {width:100%;height:100%} 
        .panel { margin-bottom: 0px;  } 
        .hr{margin: 5px !important;}
        .awesome-marker svg { margin-top: 10px; color: black;}
        .slider-animate-container a { opacity: 0.7 !important;}
        .shiny-input-container{position:relative;}"),
    
    leafletOutput("mymap", width = "100%", height = "100%"), 
    absolutePanel(  top = 10,
                    right = 10,
                    class = "panel",
                    actionButton("update", "Aktualizovat"))
))



# Plug router into Shiny server.
server <- shinyServer(function(input, output, session) {
    output$mymap <- renderLeaflet({mapa })
    

    
    Update <- function(){
    
    Stanoviste <<- DBI::dbReadTable(conAkce, "Stanoviste")
    leafletProxy('mymap') %>% clearGroup(group = "g")
    
    icons <- makeAwesomeIcon(
      icon= ifelse(Stanoviste$Ukolove == 0,
                   "running", 
                   ifelse(Stanoviste$Ukolove == 1,
                          "puzzle-piece",
                          "flag")), 
      library = "fa")
    
    for (val in c(1:idMax)) {
      leafletProxy("mymap", session) %>% addPolylines(data = (Stanoviste %>% arrange(Nazev)) %>%
                                                        filter(ID_Skupina==val),lng = ~GPSE,
                                                      lat = ~GPSN,
                                                      layerId = ~ID_Skupina, 
                                                      fill = F, weight = 5, color = "#000000",
                                                      group = "g")}
    #browser()
    leafletProxy("mymap", session) %>%
      addAwesomeMarkers(data =Stanoviste, icon = icons,
                        lng= ~GPSE ,lat = ~GPSN,  
                        label = ~as.character(Nazev), labelOptions = labelOptions(noHide = F),
                        group = "g")
    }
    
    Update()
    
    observe({
      req(input$update)
      
      Update()
      
      
    })
    
})

# Run server in a standard way.
shinyApp(ui, server)

