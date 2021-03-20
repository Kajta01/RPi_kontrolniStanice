Sys.setlocale(category = 'LC_ALL', 'Czech')

uiUcastnici<- function(){
  sidebarLayout(
      sidebarPanel(width = 2,
            selectizeInput("ucastnikS",enc2utf8( "Účastník:"),
                            choices = NULL, multiple = TRUE)
             ),
             mainPanel( width = 10,
                        fluidRow(
                          column(width = 5,
                                 leafletOutput("mapaUcastnici")
                                 ))
                    
             )
    )
}
getUcastniciMapa <- function(){
  icons <- makeAwesomeIcon(
    icon= ifelse(Stanoviste_DB$Ukolove == 0,
                 "running", 
                 ifelse(Stanoviste_DB$Ukolove == 1,
                        "puzzle-piece",
                        "flag")), 
    library = "fa")
  
  mapaTrasy <- leaflet(data = Stanoviste_DB) %>%
    addTiles() %>%
    addAwesomeMarkers( ~ GPSE , ~ GPSN, icon = icons)
  
  idMax <- (Stanoviste_DB %>% arrange(desc(ID_Skupina)) %>% drop_na(ID_Skupina))$ID_Skupina[1]
  for (val in c(1:idMax)) {
    mapaTrasy <- addPolylines(
      map = mapaTrasy,
      data = (Stanoviste_DB %>% arrange(Nazev)) %>%
        filter(ID_Skupina == val),
      lng = ~ GPSE,
      lat = ~ GPSN,
      weight = 2,
      color = "#000000"
    )
  }

  
  mapaTrasy
}
vybranniUcastnici <-function(ucastnici){
  if(length(ucastnici) != 0){
    lapply(str_split(ucastnici, ' '), as.integer)
  }else{
    Ucastnici_DB$ID_Cip
  }
}

proxyPohybUcastniku <- function(ucastnici){
  leafletProxy("mapaUcastnici") %>% clearGroup(group = "ucastnik")
  seznamUcastniku = vybranniUcastnici(ucastnici)
  pocetUcastniku = length(seznamUcastniku)
  ZavodDataF <- Zavod_s_GPS %>% filter(ID_Cip %in% seznamUcastniku)
  
  colorGradient <- gradientFunction(pocetUcastniku)
  
  for (zavodnik in c(1:pocetUcastniku)) {
    mapaTrasy <- leafletProxy("mapaUcastnici", data = ZavodDataF) %>%
     addPolylines(
      data = ZavodDataF %>%
        arrange(Cas) %>%
        filter(ID_Cip == seznamUcastniku[zavodnik]),
      lng = ~ GPSE,
      lat = ~ GPSN,
      fill = F,
      weight = 5,
      group = "ucastnik",
      color = as.character(colorGradient[zavodnik]),
      popup = zavodnik)}
  mapaTrasy
}


gradientFunction <- colorRampPalette(c("red", "blue", "green"))