uiStanoviste <- function(){
  fluidPage(

  fluidRow(
    column(width = 7,
    plotlyOutput("pocetNavstivenych")),
    column(width = 5,
           fluidRow(
           valueBoxOutput("pocetStanovistCelkem", width = 6),
           valueBoxOutput("pocetStanovistPobihacich", width = 6)),
           fluidRow(
             valueBoxOutput("pocetStanovistVse", width = 6),
           valueBoxOutput("pocetStanovistUkolovych", width = 6)
           )
           
           )
    ),
  fluidRow(
    plotlyOutput("pocetStanoviste"))
  )
}


getStanovisteGraf <- function(){
  graf<-  ggplot(data = PocetNaCPNazev %>% arrange(Poradi),
                 aes(x = factor(NazevStanoviste, 
                                levels =unique(NazevStanoviste)), y = Pocet,  fill = factor(Ukolove),
                     text = paste(
                       "Stanoviště: ",ID_Stanoviste," ",Nazev,"<br>",
                       "Počet: ",Pocet,sep= ""),
                     customdata = Pocet))+ 
    geom_bar(stat='identity', color="black")+
    
    ylab("Počet účastníků")+
    
    theme_bw()+
    theme(axis.title.x=element_blank())+
    scale_color_gradientn(colours = rainbow(5))+
    theme(legend.position = "none",
          axis.text.x = element_text(angle = 45))
  
ggplotly(graf, originalData = FALSE, tooltip = "text")  %>%
  config(displaylogo = FALSE, displayModeBar = FALSE ) %>% 
  add_text( text = ~customdata, size = I(16), color = I("black"), hoverinfo="none", textposition = 'bottom') 


}



getPocetNavstivenychGraf <- function(){

ggplotly((
StanovistePocetU %>%
  ggplot(aes(x = Pocet))+
  geom_bar()+
  scale_x_continuous(breaks = c(0:100), limits = c(0,length(SeznamStanovist)-1))+
  scale_y_continuous(breaks = c(0:100))+
  aes(
  text = paste(
    "Účastník: ",Id_Prezdivka,sep= ""),
  fill = Id_Prezdivka)+
  theme_bw()+
  xlab("Počet navštívených stanovišť") +
  ylab("Počet účastníků")+
  scale_color_gradientn(colours = rainbow(5))+
  theme(legend.position = "none")),

tooltip = "text")%>%
    config(displaylogo = FALSE, 
           displayModeBar = FALSE)
}


