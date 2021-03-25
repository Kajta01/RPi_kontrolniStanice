Sys.setlocale(category = 'LC_ALL', 'Czech')

library(shiny)
library(shinydashboard)
library(tidyverse)
library(shinyBS)
library(leaflet)
library(plotly)
library(Cairo)
library(lubridate)
library(geosphere)

options(bitmapType='cairo')

source("../databaze.R")
source("Data.R", encoding = "UTF-8")
source("Simulace.R", encoding = "UTF-8")
source("Prehled.R", encoding = "UTF-8")
source("Ucastnici.R", encoding = "UTF-8")
source("Stanoviste.R", encoding = "UTF-8")


updateData(NULL)

ui <- dashboardPage(
 

  dashboardHeader(title = "Výsledky závodu",
                  tags$li( class="dropdown",
                           tags$li( selectizeInput("akceS","k",
                  choices = getAllAkce, multiple = F )
                                                     
                  ),  tags$li( actionButton("zmenaAkce", "Změnit akci")            )
                           
                           ) ),
  dashboardSidebar(
    sidebarMenu(
      
      menuItem("Přehled", tabName = "prehled", icon = icon("stack-overflow")),
      menuItem("Tabulka", tabName = "tabulka", icon = icon("stack-overflow")),
      menuItem("Účastníci", tabName = "ucastnici", icon = icon("users")),
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
        valueBoxOutput("aktualniDatabaze", width = 12),
        valueBoxOutput("celkovyCas"),
        valueBoxOutput("nejStanoviste"),
        valueBoxOutput("pocetUcast"),
        valueBoxOutput("casDobehu"),
        valueBoxOutput("pocetZivotu"),
        valueBoxOutput("pocetZivychMrtvych"),
        valueBoxOutput("delkaTrasy")
        
        
        
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
        tabName = "stanoviste",
        uiStanoviste()
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

  
  observeEvent(input$zmenaAkce,{

    if(input$akceS != Akce){
    updateData(input$akceS)
    #  browser()
      session$reload()
    }
    
  }, ignoreInit = T)
  output$table <- renderDataTable(Stanoviste_DB)
  output$myList <- renderUI({
    
    renderSliderSimulace()
  
})
  
  ###################################################################
  ##### #Simulace
  ################################################################## 
  
  output$mapaSimulace <- renderLeaflet({ getMapaSimulace()})
  observeEvent(input$timeSliderSim,{
     
  SimulaceProxy(input$timeSliderSim, input$velikost) },ignoreInit = T, ignoreNULL = T)
  
  observeEvent(input$krok,{
    if(!is.na(input$krok )){
      if(input$krok < 0) {updateNumericInput(session,"krok", value = 1)}
      updateSliderInput(session,"timeSliderSim", value = input$timeSliderSim,
                        step =input$krok * 60*1000, timeFormat = "%H:%M" )
    }})
  observeEvent(input$velikost,{
    if(!is.na(input$velikost )){
      if(input$velikost < 0) {updateNumericInput(session,"velikost", value = 1)}
      SimulaceProxy(input$timeSliderSim, input$velikost)
    }})
  
  ###################################################################
  ##### Přehled
  ##################################################################
  
  output$aktualniDatabaze <- renderValueBox({
    valueBox( getAktualAkce(), "Aktuální akce", icon = icon("info"),color = "green" )})
  
  output$celkovyCas <- renderValueBox({
    valueBox( celkovyCasHodnota(), "Celkový naběhaný čas", icon = icon("list"),color = "purple" )})
  
  output$nejStanoviste <- renderValueBox({
    valueBox( nejlepsiStanoviste(), "Nejvíce navštěvované stanoviště", icon = icon("list"),color = "blue" )})
  
  output$pocetUcast <- renderValueBox({
    valueBox( pocetUcastniku(), "Počet účastníků", icon = icon("users"),color = "green" )})
  
  output$casDobehu <- renderValueBox({
    valueBox( casDobehu(), "Čas v cíli", icon = icon("users"),color = "green" )})
  
  output$pocetZivotu <- renderValueBox({
    valueBox( pocetZivotu(), "Počet odebraných životů", icon = icon("users"),color = "green" )})
  
  output$pocetZivychMrtvych <- renderValueBox({
    valueBox( pocetZivychMrtvych(), "Počet živých / mrtvých", icon = icon("users"),color = "green" )})
  
  output$delkaTrasy <- renderValueBox({
    valueBox( delkaTrasy(), "Délka trasy", icon = icon("route"),color = "blue" )})
  

  ###################################################################
  ##### Ucastnnici
  ##################################################################
  
  updateSelectizeInput(session, 'ucastnikS', choices = SeznamUcastniku, server = TRUE)
  output$mapaUcastnici <- renderLeaflet({ getUcastniciMapa()})
  

  observeEvent(input$ucastnikS, {
    proxyPohybUcastniku(input$ucastnikS)
  
  }, ignoreNULL  = F)
  
  output$ucastStanoviste <- renderPlotly({ getUcastniciGraf(input$ucastnikS) })
  
  ###################################################################
  ##### Stanoviste
  ##################################################################
  output$pocetStanoviste <- renderPlotly({ getStanovisteGraf() })
  
}


shinyApp(ui, server)