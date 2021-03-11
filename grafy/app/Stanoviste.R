
library(leaflet)

Stanoviste <- DBI::dbReadTable(conAkce, "Stanoviste")
idMax = (Stanoviste %>% arrange(desc(ID_Skupina)) %>% drop_na(ID_Skupina))$ID_Skupina[1]


mapa <- NULL

mapa <- leaflet(data = Stanoviste ) %>% 
  addTiles() %>%
  addMarkers(~GPSE , ~GPSN, popup = ~as.character(Nazev), label = ~as.character(Popis), group = ~ID_Skupina)

updateStanoviste <- function(name,session) {
  source("Stanoviste.R")

  for (val in c(1:idMax)) {
  mapa <- leafletProxy(name, session) %>% addPolylines(data = (Stanoviste %>% arrange(Nazev)) %>%
                                   filter(ID_Skupina==val),lng = ~GPSE,
                                 lat = ~GPSN,
                                 layerId = ~ID_Skupina, 
                                 fill = F, weight = 5, color = "#000000")
  
  }}
