Sys.setlocale(category = 'LC_ALL', 'Czech')

updateData <- function(){

  
Stanoviste_DB <<- dbReadTable(conAkce, "Stanoviste") %>%
                     rename(ID_Stanoviste = "ID")
Zavod_DB <<- DBI::dbReadTable(conAkce, "Zavod")

Zavod_DB$Cas <<- ymd_hms(Zavod_DB$Cas)

Ucastnici_DB <<- dbReadTable(conAkce, "Ucastnik") %>%
  filter(Vyloucen == 0)



Skupiny_DB <<- dbReadTable(conAkce, "Skupina")%>%
  rename(ID_Skupina = "ID") %>% rename(NazevSkupiny = "Nazev")

################################################################

Zavod_Time <<- Zavod_DB %>%
  arrange(Cas) %>%
  summarise(
    Last = last(Cas),
    First = first(Cas)
  )

ID_Start <<- (Stanoviste_DB %>% filter(Nazev == "START"))$ID_Stanoviste
ID_Cil <<- (Stanoviste_DB %>% filter(Nazev == "CIL"))$ID_Stanoviste

PocetNaCP <<- Zavod_DB %>%
  distinct(ID_Stanoviste, ID_Cip)%>%
  group_by(ID_Stanoviste) %>%
  summarise(
    Pocet = n()
  )
PocetNaCP_BezStartCil <<- left_join(PocetNaCP, Stanoviste_DB, by = "ID_Stanoviste") %>% 
  filter(ID_Stanoviste != ID_Start) %>% 
  filter(ID_Stanoviste != ID_Cil) %>% 
  arrange(desc(Pocet))

#####################################################################################

SeznamUcastniku <<- Ucastnici_DB %>% 
  summarise(
    value = ID_Cip,
    label = paste(ID, " ",Prezdivka)
  )


StanovisteSkupiny <<- left_join(Stanoviste_DB, Skupiny_DB, "ID_Skupina")%>%
  mutate(
    NazevStanoviste = ifelse(NazevSkupiny == "NULL", Nazev,NazevSkupiny)
  )

StanovisteSkupinyZavod <<- left_join(Zavod_DB, StanovisteSkupiny, "ID_Stanoviste") %>%
  select(ID_Stanoviste, NazevStanoviste, Cas, ID_Cip, GPSE, GPSN )%>%
  arrange(ID_Stanoviste) 

StanovisteSkupinyZavodUcast <<- left_join(StanovisteSkupinyZavod, Ucastnici_DB, by = "ID_Cip")

CasStartu <<- head((Zavod_DB %>% arrange(Cas))$Cas,1)
CasPosledniVCili <<- tail((Zavod_DB %>% arrange(Cas))$Cas,1)

SeznamStanovist <<-unique(StanovisteSkupinyZavod$NazevStanoviste)


}
