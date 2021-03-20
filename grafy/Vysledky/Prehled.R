Sys.setlocale(category = 'LC_ALL', 'Czech')

dhms <- function(t){
  paste(t %/% (60*60*24) , "dnů" 
        ,paste(formatC(t %/% (60*60) %% 24, width = 2, format = "d", flag = "0")
               ,formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0")
               ,formatC(t %% 60, width = 2, format = "d", flag = "0")
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
  (PocetNaCP %>% filter(ID_Stanoviste == ID_Cil))$Pocet
}

