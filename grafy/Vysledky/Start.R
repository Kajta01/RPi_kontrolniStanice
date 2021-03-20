Sys.setlocale(category = 'LC_ALL', 'Czech')

setwd("/var/www/html/grafy/Vysledky")

# w = system("ifconfig", intern=TRUE)
# x = w[grep("inet 19", w)]
# y = sub(".*? ([[:digit:]])", "1", x)
# z = sub(" .*","",y)
# toString(z)

shiny::runApp("app.R", host = "192.168.0.109",
	      port = 3355)


