library(ggplot2)
library(dplyr)
library(maps)

source(file = "../uvoz/import.R")
source(file ="../4faza/analiza.R")

# Graf gibanja cene BTC

ggplot(data = BTC, aes(x = Datum, y = Cena)) + 
        geom_line()+ 
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5))+
        ggtitle('Graf gibanja cene BTC')+
        ylab('Cena(USD)')
        

ggplot(data = BTC, aes(x = Datum, y = St_transakcij)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = Skupno_st_transakcij)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = Promet)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = Trzna_kap)) + geom_line()

#GRAFI BANKOMATOV NISO VSA IMENA ISTA


# data <- map_data('world') %>% group_by(region) %>% summarise() %>% print(n = Inf)

data <- map_data("world")
# hf <- left_join(data, atm1, by = c('region' = 'Drzava'))

# ggplot(data = hf1, aes(x = long, y = lat, group = group)) + geom_polygon(aes(fill = st_lok) )+
#         scale_colour_brewer(palette = 2)+
#         ylim(c(25,75))+
#         theme_bw()
#         #geom_text(data = hf1 %>% group_by(region) %>% summarise(mlo = mean(long), mla = mean(lat)), aes(x= mlo, y = mla, label =hf1$st_lok))

evropske <- sort(c("UK", "Austria", "Spain", "France", "Czech Republic", "Poland", "Slovakia", "Slovenia", 
              "Germany", "Finland", "Sweden", "Italy", "Hungary", "Switzerland", "Norway", "Ukraine", 
              "Denmark", "Netherlands", "Ireland", "Estonia", "Latvia", "Lithuania", "Belgium"))
evropske_lok <- data.frame(Drzave = evropske, st_lok =sapply(evropske, function(x) stlok(x), USE.NAMES = F))
evropske_lok$Drzave <- as.character(evropske_lok$Drzave)
hf1 <- inner_join(data, evropske_lok, by = c('region' = 'Drzave'))

zemljevid <- ggplot(data = hf1, aes(x = long, y = lat, group = group)) + geom_polygon(aes(fill = st_lok) )+
        scale_colour_brewer(palette = 2)+
        ylim(c(25,75))+
        xlab("Longituda")+
        ylab("Latituda")+
        theme_bw()+
        theme(plot.title = element_text(hjust = 0.5))+
        ggtitle('Evropske države glede na število lokacij BTC bankomatov') +
        labs(fill = 'Stevilo lokacij')

zemljevid2 <- map
