Sys.setlocale(category = 'LC_ALL', 'Czech')

uiUcastnici<- function(){
  fluidPage(
    fluidRow(
            selectizeInput("ucastnikS",enc2utf8( "Účastník:"),
                            choices = NULL, multiple = TRUE, width= "100%" )
             ),

                        fluidRow(
                          column(width = 6,
                                 leafletOutput("mapaUcastnici")
                                 ), 
                          column(width = 6,
                          plotlyOutput("ucastStanoviste"))
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
  if(idMax > 0){
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
  }}

  
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
  ZavodDataF <- StanovisteSkupinyZavodUcast %>% filter(ID_Cip %in% seznamUcastniku)
  
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
      label = ~Id_Prezdivka)}
  mapaTrasy
}


getUcastniciGraf <- function(ucastnici){
  seznamUcastniku = vybranniUcastnici(ucastnici)
  pocetUcastniku = length(seznamUcastniku)
  ZavodDataF <- StanovisteSkupinyZavodUcast %>% filter(ID_Cip %in% seznamUcastniku)
  
    grafUcastnici <-ggplot(data = ZavodDataF,
          aes(x = factor(NazevStanoviste, 
           levels =unique(NazevStanoviste)),
           text = paste(
             "Čas: ", format(Cas, format="%H:%M:%S"), "<br>",
             "ID: ",ID_Ucastnik," ",Prezdivka,"<br>",
             "Stanoviště: ",ID_Stanoviste," ",NazevStanoviste,sep= ""),
                                          
          y = Cas,group = ID_Ucastnik, color=factor(Id_Prezdivka) ))+
      geom_line(
       
      )+
      geom_point(size=2.0, shape=20) +
      ylim(CasStartu, CasPosledniVCili) + 
      scale_x_discrete(limit = SeznamStanovist)+
      
      labs(colour = "Účastník")+
      
      xlab("Stanoviště")+
      ylab("Čas")+
      theme_bw()+
      theme(axis.text.x = element_text(angle = 45))
    
    vyslednyGraf<- ggplotly(grafUcastnici, tooltip = "text") %>%
      config(displaylogo = FALSE, 
             displayModeBar = FALSE)
    vyslednyGraf
    
}


# seznamUcastniku<<- Ucastnici_DB$ID_Cip

gradientFunction <- colorRampPalette(c("red", "blue", "green"))