library(shiny)
library(leaflet)
library(tidyverse)
library(htmltools)
library(shinyBS)

source("databaze.R")
###################################################################
###  Aktualizace dat z databáze
###################################################################

UpdateDataTable <- function() {
  Stanoviste <<- DBI::dbReadTable(conAkce, "Stanoviste")
  idMax <<- (Stanoviste %>% arrange(desc(ID_Skupina)) %>% drop_na(ID_Skupina))$ID_Skupina[1]

  
  TTN_DataDB <<- DBI::dbReadTable(conApp, "TTN_Data") 
  
  
  
  TTN_Time <<- TTN_DataDB %>%
    arrange(Zapsano) %>%
    summarise(
      Last = last(Zapsano),
      First = first(Zapsano)
    )
  AktualiCas <- Sys.time()
  

  TTN_Data <<-  TTN_DataDB %>%
    group_by(ID_Stanoviste) %>%
    arrange(Zapsano)%>%
    summarise(
      Posledni = last(Zapsano),
      Pocet = n(),
      BaterieV = last(Baterie),
      Baterie = round(((last(Baterie)-3)/(4.5-3)*100)),
      Teplota = last(Teplota),
      Rozdil = round(difftime(AktualiCas,last(Zapsano),units = "mins"),2)
    ) %>%
    rename("ID" = ID_Stanoviste)
  
  Stanoviste <<- left_join(Stanoviste, TTN_Data, by = "ID")
  
  Stanoviste <-
    mutate(
      Stanoviste,
      Popisek = paste(
        "<b>ID: </b>",
        as.character(ID),
        
        "<br>",
        "<b>Název: </b>",
        Nazev,
        
        "<br>",
        "<b>Popis: </b>",
        Popis,
        
        "<br>",
        "<b>Poslední: </b>",
        as.character(Rozdil),
        " m",
        
        "<br>",
        as.character(Posledni),
        "<br>",
        
        "<b>Počet účastníků: </b>",
        Pocet,
        "<br>",
        
        "<b>Baterie: </b>",
        BaterieV,
        " V, ",
        Baterie,
        " %",
        "<br>",
        
        "<b>Teplota: </b>",
        Teplota,
        " °C",
        sep = ""
      )
    )
  Stanoviste$Popisek <<- Stanoviste$Popisek %>% map(HTML)
}

###################################################################
###  Počáteční vykreslení mapy
###################################################################
UpdateDataTable()

PocetStanovist = (count(Stanoviste)$n[1])
E = (Stanoviste$GPSE[1] + Stanoviste$GPSE[PocetStanovist]) / 2
N = (Stanoviste$GPSN[1] + Stanoviste$GPSN[PocetStanovist]) / 2
mapa <- NULL

mapa <- leaflet(data = Stanoviste) %>%
  addTiles() %>% setView(E, N, 13)

# Set timer
timer <- reactiveTimer(2000)
Skupina <- "s"

###################################################################
###  ui, panel
###################################################################

ui <- bootstrapPage(
  tags$style(
    type = "text/css",
    "html, body {width:100%;height:100%} 
    .panel { margin-bottom: 0px;  } 
    .hr{margin: 5px !important;}
    .awesome-marker svg { margin-top: 10px;}
    .slider-animate-container {
    position: absolute; top: 10px;
    left: 48%;}
    .shiny-input-container{
    position:relative;}
    .glyphicon{ font-size: 30px; }
    .panelBottom{
    padding: 0 10px 0 10px; }
    .panel-group { margin-bottom: 0px;}
    "
  ),
  tags$head(HTML("<script src='https://use.fontawesome.com/releases/v5.15.2/js/all.js'
      data-auto-a11y='true'
    ></script>")),
  
  leafletOutput("mymap", width = "100%", height = "100%"),
  
  absolutePanel(

    top = 10,
    right = 10,
    class = "panel",
    width = "250px",
    bsCollapse(
      bsCollapsePanel(
        title = "Info", 
        style = "info",
        HTML("<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-blue awesome-marker icon-panel'>
         <i class='fas fa-running'></i></div>Probíhací stanoviště"),
        HTML("<br>"),
        HTML("<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-blue awesome-marker icon-panel'>
         <i class='fa fa-puzzle-piece'></i></div>Úkolové stanoviště"),
        HTML("<br>"),
        HTML("<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-blue awesome-marker icon-panel'>
         <i class='fab fa-font-awesome-flag'></i></div>Start/Cíl"),
        HTML("<hr class='hr'>"),
        
        HTML("<p style='text-align: center;'>Kapacita baterie</p>"),
        
        HTML("<div style='display: inline-block'>100%<br>
        <div style='position: relative; display: inline-block'
         class='awesome-marker-icon-green awesome-marker icon-panel'>
         </div></div>"),
        HTML("<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-orange awesome-marker icon-panel'>
         </div>"),
        HTML("<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-red awesome-marker icon-panel'>
        </i></div>"),
        HTML("<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-darkred awesome-marker icon-panel'>
        </i></div>"),
        HTML("<div style='display: inline-block; text-align: center;'>0%<br>
        <div style='position: relative; display: inline-block'
         class='awesome-marker-icon-gray awesome-marker icon-panel'>
        </i></div></div>"),
        
        
        HTML("<hr class='hr'>"),
        HTML("<p style='text-align: center;'>Počet účastníků</p>"),
        
     
        HTML('<i style="background:white; 
             width:20px; height:20px; 
             border:3px solid blue; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'),
        HTML('<i style="background:white; 
             width:25px; height:25px; 
             border:3px solid blue; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'),
        HTML('<i style="background:white; 
             width:30px; height:30px; 
             border:3px solid blue; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'),
        HTML('<i style="background:white; 
             width:35px; height:35px; 
             border:3px solid blue; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'),
        HTML('<i style="background:white; 
             width:40px; height:40px; 
             border:3px solid blue; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'),
        HTML("<hr class='hr'>"),
        
        HTML("<p style='text-align: center;'>Poslední návštěva (minuty)</p>"),
        
        HTML('<div style="display: inline-block; text-align: center;">10<br>
        <i style="background:green; 
            width:35px; height:35px;  
             border:1px solid green; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i></div>'),
        HTML('<div style="display: inline-block; text-align: center;">30<br>
            <i style="background:yellow; 
            width:35px; height:35px;  
             border:1px solid yellow; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i></div>'),
        HTML('<div style="display: inline-block; text-align: center;">60<br>
        <i style="background:orange; 
            width:35px; height:35px; 
             border:1px solid orange; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i></div>'),
        HTML('<div style="display: inline-block; text-align: center;"><span>&#8734;</span><br>
        <i style="background:red; 
            width:35px; height:35px;  
             border:1px solid red; 
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i></div>'),

        HTML("<div style='display: inline-block; text-align: center;'>None <br>
        <div style='position: relative; display: inline-block'
         class='awesome-marker-icon-lightgray awesome-marker icon-panel'>
        </i></div></div>")),
        bsCollapsePanel(
          title = "Nastavení", 
          style = "info",
        HTML("<hr class='hr'>"),
        numericInput("rychlost", "Rychlost obnovování (s)",2, min=1, max = 60 ,step = 1),
        numericInput("velikost", "Velikost kruhů",10, min=0.1, max = 20 ,step = 1 )
     
        
      ))
  ))
###################################################################
###  server
###################################################################

server <- function(input, output, session) {
  output$mymap <- renderLeaflet({
    mapa
  })
  
  updateStanoviste <- function(session, skupina) {
    
    ###################################################################
    ###  skupiny probíhacích stanovist
    ###################################################################
    
    for (val in c(1:idMax)) {
      leafletProxy("mymap") %>%
        addPolylines(
          data = (Stanoviste %>% arrange(Nazev)) %>%
            filter(ID_Skupina == val),
          lng = ~ GPSE,
          lat = ~ GPSN,
          weight = 2,
          group = skupina,
          color = "#000000"
        )
    }
    ###################################################################
    ###  body (stanovistě, baterie)
    ###################################################################
    
    getColorBaterie <- function(data) {
      sapply(data$BaterieV, function(Baterie) {
        
        if(!is.na(Baterie)){
          
          if(Baterie >= 4.2) {
            "green"
          } else if(Baterie >= 4) {
            "orange"
          } else if(Baterie >= 3.75) {
            "red"
          } else if(Baterie >= 3.5) {
            "darkred"
          } else {
            "gray"
          }}
        else{ #bez dat
          "lightgray"
        }
      })
    }
    icons <- makeAwesomeIcon(
      icon= ifelse(Stanoviste$Ukolove == 0,
                   "running", 
                   ifelse(Stanoviste$Ukolove == 1,
                          "puzzle-piece",
                          "flag")), 
      library = "fa",
      markerColor = getColorBaterie(Stanoviste))
    
    leafletProxy("mymap", data = Stanoviste) %>%
      addAwesomeMarkers(
        ~ GPSE ,
        ~ GPSN,
        group = skupina,
        icon =  icons,
        label =~ Popisek, # ~ Popisek,icons$markerColor
        labelOptions = labelOptions(noHide = FALSE)
      )
    ###################################################################
    ###  ucastnici pocet - kruhy - cas
    ###################################################################
    
    
    getColorCas <- function(data)  {
      sapply(data$Rozdil, function(rozdil) {
       # browser()
        if(!is.na(rozdil)){
        if(rozdil >= (1*60)) {
          "red"
        } else if(rozdil >= (30)) {
          "orange"
        } else if(rozdil >= (10)) {
          "yellow"
        } else {
          "green"
        }
          }})
    }
    
    leafletProxy("mymap", data = Stanoviste) %>%
      addCircleMarkers( ~ GPSE , ~ GPSN,
                        group = skupina,
                        color = getColorCas(Stanoviste),
                        radius = ~ Pocet * input$velikost )
  }
  
  observeEvent(input$rychlost,{
    if(!is.na(input$rychlost )){
    if(input$rychlost < 1) {updateNumericInput(session,"rychlost", value = 1)}
      timer <<- reactiveTimer(input$rychlost * 1000)
    }})
  observeEvent(input$velikost,{
    if(!is.na(input$velikost )){
      if(input$velikost < 0) {updateNumericInput(session,"velikost", value = 0)}
    }})
  
  observe({
    timer()
   

   UpdateDataTable() 
    
   
    if (Skupina == "n") {
      Skupina <<- "s"
    } else {
      Skupina <<- "n"
    }
    
    updateStanoviste(session, Skupina)
    if (Skupina == "s") {
      leafletProxy('mymap') %>% clearGroup(group = "n")
    } else {
      leafletProxy('mymap') %>% clearGroup(group = "s")
    }


  })
}

shinyApp(ui, server)
