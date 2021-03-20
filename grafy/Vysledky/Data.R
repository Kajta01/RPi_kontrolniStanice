Sys.setlocale(category = 'LC_ALL', 'Czech')

updateData <- function(){

  
Stanoviste_DB <<- dbReadTable(conAkce, "Stanoviste", database = databaze) %>%
                     rename(ID_Stanoviste = "ID")
Zavod_DB <<- DBI::dbReadTable(conAkce, "Zavod") 
Ucastnici_DB <<- dbReadTable(conAkce, "Ucastnik", database = databaze) %>%
  filter(Vyloucen == 0)

Zavod_s_GPS <<- left_join(Zavod_DB, Stanoviste_DB, "ID_Stanoviste") %>%
  select(ID_Cip, Cas, GPSE, GPSN, ID_Stanoviste)


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
    label = paste(ID, " ",Jmeno)
  )
}
