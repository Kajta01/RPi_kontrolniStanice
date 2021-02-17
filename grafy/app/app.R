library(shiny)
library(shiny.router)

library(tidyverse)

library(RMariaDB)
library(leaflet)
library(dplyr)

source("databaze.R")
source("Stanoviste.R")

# This generates menu in user interface with links.
menu <- (
    tags$ul(
        tags$li(a(class = "item", href = route_link("/"), "Root")),
        tags$li(a(class = "item", href = route_link("Stanoviste"), "Stanoviste")),
        tags$li(a(class = "item", href = route_link("second"), "Nadpis 2"))
    )
)



# Both sample pages.
root_page <- div(menu, titlePanel("HOME"))
first_page <- div(leafletOutput("graph_one"))


# Callbacks on the server side for
# the sample pages

first_callback <- function(input, output, session) {
    output$graph_one <- renderLeaflet({
        mapa
    })
}


# Creates router. We provide routing path, a UI as
# well as a server-side callback for each page.
router <- make_router(
    route("/", root_page, NA),
    route("Stanoviste", first_page, first_callback)
)

# Make output for our router in main UI of Shiny app.
ui <- shinyUI(fluidPage(
    router$ui
))

# Plug router into Shiny server.
server <- shinyServer(function(input, output, session) {
    router$server(input, output, session)
})

# Run server in a standard way.
shinyApp(ui, server)