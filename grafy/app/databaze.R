
con <- DBI::dbConnect(RMySQL::MySQL(),
  driver = "MySQL Driver",
  dbname = "CJTZV_19",
  user    = "remote",
  password    = "grafana",
  host = "localhost",
  port = 3302)



