uiStanoviste <- function(){
  plotlyOutput("pocetStanoviste")
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
  xlab("Stanoviště")+
  ylab("Počet")+
  theme_bw()+
  
  scale_fill_brewer(palette="Dark2")+

  theme(legend.position = "none",
    axis.text.x = element_text(angle = 45)))
, tooltip = "text")
}
