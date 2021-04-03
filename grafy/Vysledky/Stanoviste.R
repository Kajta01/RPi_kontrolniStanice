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
ggplotly((
ggplot(data = PocetNaCPNazev %>% arrange(Poradi), aes(x = factor(NazevStanoviste, 
        levels =unique(NazevStanoviste)), y = Pocet,  fill = factor(Ukolove),
        text = paste(
          "Stanoviště: ",ID_Stanoviste," ",Nazev,sep= "") ))+ 
  geom_bar(stat='identity', color="black")+
  geom_text(aes(label=Pocet),stat="identity",
            position=position_stack(0.5))+
  ylab("Počet")+

  theme_bw()+
  theme(axis.title.x=element_blank())+
  
  scale_fill_brewer(palette="Dark2")+

  theme(legend.position = "none",
    axis.text.x = element_text(angle = 45)))
, tooltip = "text")%>%
    config(displaylogo = FALSE, 
           displayModeBar = FALSE )
}



getPocetNavstivenychGraf <- function(){

ggplotly((
StanovistePocetU %>%
  ggplot(aes(x = Pocet))+
  geom_bar()+
  scale_x_continuous(breaks = c(0:100), limits = c(0,length(SeznamStanovist)-2))+
  scale_y_continuous(breaks = c(0:100))+
  aes(
  text = paste(
    "Účastník: ",Id_Prezdivka,sep= ""),
  fill = Id_Prezdivka)+
  theme_bw()+
  xlab("Počet navštívených stanovišť") +
  ylab("Počet účastníků")+
  theme(legend.position = "none")),

tooltip = "text")%>%
    config(displaylogo = FALSE, 
           displayModeBar = FALSE)
}


