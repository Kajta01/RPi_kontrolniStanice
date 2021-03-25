Sys.setlocale(category = 'LC_ALL', 'Czech')

dhms <- function(t){
  paste(t %/% (60*60*24) , "dnů" 
        ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,sep = ":"
        )
  )
}
celkovyCasHodnota <- function() {

  
  DataStart <- Zavod_DB %>%
    filter(ID_Stanoviste == ID_Start) %>%
    rename("Start" = Cas)
  DataCil <- Zavod_DB %>%
    filter(ID_Stanoviste == ID_Cil)  %>%
    rename("Cil" = Cas)
  DataVse <- left_join(DataStart, DataCil, by = "ID_Cip") %>%
    mutate(Rozdil = as.integer(round(difftime(Cil, Start, units = "sec"), 2)))
  vysledek =  sum((DataVse %>% drop_na(Rozdil))$Rozdil)
  dhms (vysledek)
}

nejlepsiStanoviste <- function(){

  NejCP <- head(PocetNaCP_BezStartCil,1)
  paste(NejCP$Nazev, " - ",NejCP$Popis)
}

pocetUcastniku <- function(){
  count(Ucastnici_DB)
}
casDobehu <- function(){
  data <- (StanovisteSkupinyZavodUcast %>% 
    filter(ID_Stanoviste == ID_Cil)%>%
    arrange(Cas))$Cas
  paste( format(head(data,1), format="%H:%M"),"/", format(tail(data,1), format="%H:%M"))
}
pocetZivotu <- function(){
  sum(Zivoty_DB$Pocet)
}
pocetZivychMrtvych <- function(){
  zivi <-UcastniciZivoty %>%
    filter(Pocet == 0 | is.na(Pocet))
  mrtvi <-UcastniciZivoty %>%
    filter(!(Pocet == 0 | is.na(Pocet)))
  paste( count(zivi),"/", count(mrtvi))
}
delkaTrasy <- function(){
  start <- Stanoviste_DB %>% filter(ID_Stanoviste == ID_Start)
  cil <- Stanoviste_DB %>% filter(ID_Stanoviste == ID_Cil)
  
  kratka <-distm(c(start$GPSE, start$GPSN), c(cil$GPSE, cil$GPSN))
  
  SSU <- StanovisteSkupiny %>% distinct(NazevStanoviste, .keep_all = TRUE )%>%
    select(NazevStanoviste, GPSN, GPSE)
  dlouha =0 
  for(i in c(1:(count(SSU)$n - 1))){
    dlouha <- distm(c(SSU$GPSE[i], SSU$GPSN[i]),c(SSU$GPSE[i+1],SSU$GPSN[i+1])) + dlouha
   # print(paste(SSU$NazevStanoviste[i], SSU$NazevStanoviste[i+1]))
  }
  kratka <- format(round(kratka),big.mark=" ")
  dlouha <- format(round(dlouha),big.mark=" ")
  paste(kratka,"m","/",dlouha,"m")
  
}



