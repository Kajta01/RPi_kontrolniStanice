Sys.setlocale(category = 'LC_ALL', 'Czech')

library(shiny)
library(shinydashboard)
library(tidyverse)
library(shinyBS)
library(leaflet)

source("../databaze.R")
source("Data.R", encoding = "UTF-8")
source("Simulace.R", encoding = "UTF-8")
source("Prehled.R", encoding = "UTF-8")
source("Ucastnici.R", encoding = "UTF-8")


updateData()

ui <- dashboardPage(

  dashboardHeader(title = paste("Výsledky ",Akce,sep=""),
                  tags$li( class="dropdown",actionButton("button", "Aktualizovat data"),
                           style = "padding: 8px; color: #fff;") ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Účastníci", tabName = "ucastnici", icon = icon("users")),
      menuItem("Přehled", tabName = "prehled", icon = icon("stack-overflow")),
      menuItem("Tabulka", tabName = "tabulka", icon = icon("stack-overflow")),
      
      menuItem("Stanoviště", tabName = "stanoviste", icon = icon("map-marker")),
      menuItem("Simulace", tabName = "simulace", icon = icon("play-circle"))
     
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "stylesheet.css"),
      HTML('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'),
      HTML("<script src='https://use.fontawesome.com/releases/v5.15.2/js/all.js'data-auto-a11y='true'></script>")
    ),

    tabItems(
      tabItem(
        tabName = "prehled",
        valueBoxOutput("celkovyCas"),
        valueBoxOutput("nejStanoviste"),
        valueBoxOutput("pocetUcast")
        
      ),
      tabItem(
        tabName = "tabulka",
        dataTableOutput("table")
      ),
      tabItem(
        tabName = "ucastnici",
        uiUcastnici()
        
      ),
      tabItem(
        tabName = "stanoviste"
      ),
      tabItem(
        tabName = "simulace",
        leafletOutput("mapaSimulace"),
        uiSimAbsolutePanelInfo(), 
        uiSimTimeSliderPanel()
      )
    )
  )
)



server <- function(input, output, session) {
  updateData()
  
  
  output$table <- renderDataTable(Stanoviste_DB)
  
  ###################################################################
  ##### #Simulace
  ################################################################## 
  
  output$mapaSimulace <- renderLeaflet({ getMapaSimulace()})
  observeEvent(input$timeSliderSim,{
    SimulaceProxy(input) })
  
  observeEvent(input$krok,{
    if(!is.na(input$krok )){
      if(input$krok < 0) {updateNumericInput(session,"krok", value = 1)}
      updateSliderInput(session,"timeSliderSim", value = input$timeSliderSim,
                        step =input$krok * 60*1000, timeFormat = "%H:%M" )
    }})
  observeEvent(input$velikost,{
    if(!is.na(input$velikost )){
      if(input$velikost < 0) {updateNumericInput(session,"velikost", value = 1)}
      SimulaceProxy(input)
    }})
  
  ###################################################################
  ##### Přehled
  ##################################################################
  output$celkovyCas <- renderValueBox({
    valueBox( celkovyCasHodnota(), "Celkový naběhaný čas", icon = icon("list"),color = "purple" )})
  
  output$nejStanoviste <- renderValueBox({
    valueBox( nejlepsiStanoviste(), "Nejvíce navštěvované stanoviště", icon = icon("list"),color = "blue" )})
  
  output$pocetUcast <- renderValueBox({
    valueBox( pocetUcastniku(), "Počet účastníků", icon = icon("users"),color = "green" )})
  
  ###################################################################
  ##### Ucastnnici
  ##################################################################
  
  updateSelectizeInput(session, 'ucastnikS', choices = SeznamUcastniku, server = TRUE)
  output$mapaUcastnici <- renderLeaflet({
    getUcastniciMapa()})
  

  observeEvent(input$ucastnikS, {
    print(input$ucastnikS)
    proxyPohybUcastniku(input$ucastnikS)
  }, ignoreNULL  = F)

  
  

}
getUcastniciMapa

shinyApp(ui, server)