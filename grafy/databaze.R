Sys.setlocale(category = 'LC_ALL', 'Czech')

library(RMySQL)

conApp <- DBI::dbConnect(RMySQL::MySQL(),
  driver = "MySQL Driver",
  dbname = "App",
  user    = "remote",
  password    = "grafana",
  host = "localhost",
  port = 3302,
  encoding = "UTF-8")

DBI::dbListTables(conApp)
AkceDB <- DBI::dbReadTable(conApp,"Aktualni_Akce")[1,"Nazev"] %>% as.character()

conAkce <-
 DBI::dbConnect(RMySQL::MySQL(),
  driver = "MySQL Driver",
  dbname = AkceDB,
  user    = "remote",
  password    = "grafana",
  host = "localhost",
  port = 3302,
  encoding = "UTF-8")

getAllAkce <- (DBI::dbReadTable(conApp,"Akce")%>%arrange(desc(Vytvoreno)))$Nazev

getDefaultActionCon <- conAkce



getActionCon <- function(akce) {
  
  DBI::dbConnect(RMySQL::MySQL(),
  driver = "MySQL Driver",
  dbname = akce,
  user    = "remote",
  password    = "grafana",
  host = "localhost",
  port = 3302,
  encoding = "UTF-8")
  
}