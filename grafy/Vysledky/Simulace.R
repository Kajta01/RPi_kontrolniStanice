Sys.setlocale(category = 'LC_ALL', 'Czech')

uiSimAbsolutePanelInfo <- function() {
  absolutePanel(
    top = 10,
    right = 10,
    class = "panel",
    width = "250px",
    bsCollapse(
      bsCollapsePanel(
        title = "Info",
        style = "info",
        HTML('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'),
        HTML(
          "<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-blue awesome-marker icon-panel'>
         <i class='fas fa-running'></i></div>Probíhací stanoviště"
        ),
        HTML("<br>"),
        HTML(
          "<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-blue awesome-marker icon-panel'>
         <i class='fa fa-puzzle-piece'></i></div>Úkolové stanoviště"
        ),
        HTML("<br>"),
        HTML(
          "<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-blue awesome-marker icon-panel'>
         <i class='fab fa-font-awesome-flag'></i></div>Start/Cíl"
        ),
        HTML("<hr class='hr'>"),
        
        HTML("<p style='text-align: center;'>Kapacita baterie</p>"),
        
        HTML(
          "<div style='display: inline-block'>100%<br>
        <div style='position: relative; display: inline-block'
         class='awesome-marker-icon-green awesome-marker icon-panel'>
         </div></div>"
        ),
        HTML(
          "<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-orange awesome-marker icon-panel'>
         </div>"
        ),
        HTML(
          "<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-red awesome-marker icon-panel'>
        </i></div>"
        ),
        HTML(
          "<div style='position: relative; display: inline-block'
         class='awesome-marker-icon-darkred awesome-marker icon-panel'>
        </i></div>"
        ),
        HTML(
          "<div style='display: inline-block; text-align: center;'>0%<br>
        <div style='position: relative; display: inline-block'
         class='awesome-marker-icon-gray awesome-marker icon-panel'>
        </i></div></div>"
        ),
        
        
        HTML("<hr class='hr'>"),
        HTML("<p style='text-align: center;'>Počet účastníků</p>"),
        
        
        HTML(
          '<i style="background:white;
             width:20px; height:20px;
             border:3px solid blue;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'
        ),
        HTML(
          '<i style="background:white;
             width:25px; height:25px;
             border:3px solid blue;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'
        ),
        HTML(
          '<i style="background:white;
             width:30px; height:30px;
             border:3px solid blue;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'
        ),
        HTML(
          '<i style="background:white;
             width:35px; height:35px;
             border:3px solid blue;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'
        ),
        HTML(
          '<i style="background:white;
             width:40px; height:40px;
             border:3px solid blue;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i>'
        ),
        HTML("<hr class='hr'>"),
        
        HTML(
          "<p style='text-align: center;'>Poslední návštěva (minuty)</p>"
        ),
        
        HTML(
          '<div style="display: inline-block; text-align: center;">10<br>
        <i style="background:green;
            width:35px; height:35px;
             border:1px solid green;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i></div>'
        ),
        HTML(
          '<div style="display: inline-block; text-align: center;">30<br>
            <i style="background:yellow;
            width:35px; height:35px;
             border:1px solid yellow;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i></div>'
        ),
        HTML(
          '<div style="display: inline-block; text-align: center;">60<br>
        <i style="background:orange;
            width:35px; height:35px;
             border:1px solid orange;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i></div>'
        ),
        HTML(
          '<div style="display: inline-block; text-align: center;"><span>&#8734;</span><br>
        <i style="background:red;
            width:35px; height:35px;
             border:1px solid red;
             border-radius:50%;opacity:0.5;
             display: inline-block;"></i></div>'
        ),
        
        HTML(
          "<div style='display: inline-block; text-align: center;'>None <br>
        <div style='position: relative; display: inline-block'
         class='awesome-marker-icon-lightgray awesome-marker icon-panel'>
        </i></div></div>"
        )
      ),
      bsCollapsePanel(
        title = "Nastavení",
        style = "info",
        HTML("<hr class='hr'>"),
        numericInput(
          "krok",
          "Krok animace (m)",
          10,
          min = 1,
          max = 60*60 ,
          step = 10
        ),
        numericInput(
          "velikost",
          "Velikost kruhů",
          1,
          min = 0.1,
          max = 20 ,
          step = 1
        )
      )))
}

uiSimTimeSliderPanel <- function() {
  absolutePanel(
    bottom = 10,
    left = "10%",
    width = "80%",
    class = "panel  panelBottom",
    uiOutput("myList")
  )
}

getMapaSimulace <- function() {
  icons <- makeAwesomeIcon(
    icon = ifelse(
      Stanoviste_DB$Ukolove == 0,
      "running",
      ifelse(Stanoviste_DB$Ukolove == 1,
             "puzzle-piece",
             "flag")
    ),
    library = "fa"
  )
  
  mapa <- leaflet(data = Stanoviste_DB) %>%
    addTiles() %>%
    addAwesomeMarkers(~ GPSE ,
                      ~ GPSN,
                      icon = icons)
  idMax <- (Stanoviste_DB %>% arrange(desc(ID_Skupina)) %>% drop_na(ID_Skupina))$ID_Skupina[1]
  
  if(idMax > 0){
  
  for (val in c(1:idMax)) {
    mapa <- addPolylines(
      mapa,
      data = (Stanoviste_DB %>% arrange(Nazev)) %>%
        filter(ID_Skupina == val),
      lng = ~ GPSE,
      lat = ~ GPSN,
      weight = 2,
      color = "#000000"
    )
   # browser()
  }}
  mapa
}

getColorCas <- function(data)  {
  sapply(data$Rozdil, function(rozdil) {
    # browser()
    if (!is.na(rozdil)) {
      if (rozdil >= (1 * 60)) {
        "red"
      } else if (rozdil >= (30)) {
        "orange"
      } else if (rozdil >= (10)) {
        "yellow"
      } else {
        "green"
      }
    }
  })
}
SimulaceProxy <- function(input, inVelikost) {
  
  if(!is.null(input)){
  cas = input
  velikost =  inVelikost
  Skupina <<- ifelse(Skupina == "n", "s","n")
  AktualiCas <<- cas
  
  Zavod_DB_F <<- Zavod_DB %>%
    filter(Cas <= cas)
  Zavod_Stanoviste <<-  Zavod_DB_F %>%
    group_by(ID_Stanoviste) %>%
    arrange(Cas)%>%
    summarise(
      Posledni = last(Cas),
      Pocet = n(),
      Rozdil = round(difftime(AktualiCas,last(Cas),units = "mins"),2)
    ) 
  
  Zavod_Stanoviste <<- left_join(Stanoviste_DB, Zavod_Stanoviste, by = "ID_Stanoviste")%>% 
    select( GPSE, GPSN, Pocet, Rozdil)
  
  mapa <-  leafletProxy("mapaSimulace", data = Zavod_Stanoviste) %>%
    addCircleMarkers(~ GPSE ,
                     ~ GPSN,
                     color = getColorCas(Zavod_Stanoviste),
                     group = Skupina,
                     radius = ~ Pocet * velikost)
  
  if (Skupina == "s") {
    leafletProxy('mapaSimulace') %>% clearGroup(group = "n")
  } else {
    leafletProxy('mapaSimulace') %>% clearGroup(group = "s")
  }
  }
}

renderSliderSimulace<- function() {


sliderInput(
  "timeSliderSim",
  "Time:",
  min = as.POSIXct(Zavod_Time$First),
  max = as.POSIXct(Zavod_Time$Last),
  value = as.POSIXct(Zavod_Time$First),
  timeFormat = "%H:%M",
  step = 60 * 10,
  width = "100%",
  timezone = "+0000",
  animate = animationOptions(interval = 1000)
)
}



Skupina <<- "n"




