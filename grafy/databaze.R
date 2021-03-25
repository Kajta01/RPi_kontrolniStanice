Sys.setlocale(category = 'LC_ALL', 'Czech')

library(RMySQL)

conApp <- DBI::dbConnect(RMySQL::MySQL(),
  driver = "MySQL Driver",
  dbname = "App",
  user    = "remote",
  password    = "grafana",
  host = "localhost",
  port = 3302)

DBI::dbListTables(conApp)
Akce <- DBI::dbReadTable(conApp,"Aktualni_Akce")[1,"Nazev"] %>% as.character()

conAkce <-
 DBI::dbConnect(RMySQL::MySQL(),
  driver = "MySQL Driver",
  dbname = Akce,
  user    = "remote",
  password    = "grafana",
  host = "localhost",
  port = 3302)

getAllAkce <- (DBI::dbReadTable(conApp,"Akce")%>%arrange(desc(Vytvoreno)))$Nazev

getDefaultActionCon <- conAkce



getActionCon <- function(akce) {
  
  DBI::dbConnect(RMySQL::MySQL(),
  driver = "MySQL Driver",
  dbname = akce,
  user    = "remote",
  password    = "grafana",
  host = "localhost",
  port = 3302)
  
}