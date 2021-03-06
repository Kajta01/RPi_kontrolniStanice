Sys.setlocale(category = 'LC_ALL', 'Czech')

updateData <- function(akceDatabaze){
  #browser()
  
  if(is.null(akceDatabaze)){
    conAkce <<- getDefaultActionCon
    Akce <<- AkceDB
    
  }
  else{
    Akce <<- akceDatabaze
    conAkce <<- getActionCon(Akce)
    #browser()
  }  
  dbSendQuery(conAkce,'set character set "utf8"')
  Stanoviste_DB <<- dbReadTable(conAkce, "Stanoviste") %>%
    rename(ID_Stanoviste = "ID")
  Zavod_DB <<- DBI::dbReadTable(conAkce, "Zavod")
  
  Zavod_DB$Cas <<- ymd_hms(Zavod_DB$Cas)
  
  Ucastnici_DB <<- dbReadTable(conAkce, "Ucastnik") %>%
    rename("ID_Ucastnik" = ID) %>%
    filter(Vyloucen == 0)
  
  Zivoty_DB <<- DBI::dbReadTable(conAkce, "ZtraceneZivoty")
  
  
  Skupiny_DB <<- dbReadTable(conAkce, "Skupina")%>%
    rename(ID_Skupina = "ID") %>% rename(NazevSkupiny = "Nazev")
  
  Vysledky_DB <<- dbReadTable(conAkce, "V_0_FINAL", encoding = "UTF-8")
  

  ################################################################
  UcastniciZivoty <<- left_join(Ucastnici_DB,Zivoty_DB, by="ID_Ucastnik" )
  
  ################################################################
  Zavod_Time <<- Zavod_DB %>%
    arrange(Cas) %>%
    summarise(
      Last = last(Cas),
      First = first(Cas)
    )
  
  ID_Start <<- (Stanoviste_DB %>% filter(Nazev == "START"))$ID_Stanoviste
  ID_Cil <<- (Stanoviste_DB %>% filter(Nazev == "CIL"))$ID_Stanoviste
  
 StanovisteSkupiny <<- left_join(Stanoviste_DB, Skupiny_DB, "ID_Skupina")%>%
    mutate(
      NazevStanoviste = ifelse( is.na(ID_Skupina) , ifelse(Popis != "",paste(Nazev,"<br>",Popis),Nazev), NazevSkupiny)
    )
  
  
  StanovisteSkupinyZavod <<- left_join(Zavod_DB, StanovisteSkupiny, "ID_Stanoviste") %>% 
    select(ID_Stanoviste, NazevStanoviste, Cas, ID_Cip, GPSE, GPSN, Poradi) 
  
  
  PocetNaCP <<- Zavod_DB %>%
    distinct(ID_Stanoviste, ID_Cip)%>%
    group_by(ID_Stanoviste) %>%
    summarise(
      Pocet = n(),
    )
  PocetNaCPNazev <<- left_join(PocetNaCP, StanovisteSkupiny, by = "ID_Stanoviste")
  PocetNaCP_BezStartCil <<- PocetNaCPNazev %>% 
    filter(ID_Stanoviste != ID_Start) %>% 
    filter(ID_Stanoviste != ID_Cil) %>% 
    arrange(desc(Pocet))
  
  
  
  #####################################################################################
  
  SeznamUcastniku <<- Ucastnici_DB %>% 
    summarise(
      value = ID_Cip,
      label = paste(ID_Ucastnik, " ",Prezdivka)
    )
  
  
  
  
  
  
  StanovisteSkupinyZavodUcast <<- left_join(StanovisteSkupinyZavod, Ucastnici_DB, by = "ID_Cip") %>%
    mutate(
      Id_Prezdivka = paste(ID_Ucastnik," ",Prezdivka,sep="")
    ) 
  CasStartu <<- head((Zavod_DB %>% arrange(Cas))$Cas,1)
  CasPosledniVCili <<- tail((Zavod_DB %>% arrange(Cas))$Cas,1)
  
  SeznamStanovist <<-unique((StanovisteSkupinyZavod %>% arrange(Poradi) )$NazevStanoviste)
  #############################################################################################
  StanovistePocetU <<-StanovisteSkupinyZavodUcast %>%
    
    filter(ID_Stanoviste != ID_Start) %>% 
    filter(ID_Stanoviste != ID_Cil) %>% 
    distinct(ID_Stanoviste, Id_Prezdivka) %>%
    group_by(Id_Prezdivka)%>%
    summarise(Pocet = n())
 
}
