library(ggplot2)
library(dplyr)
library(maps)

source(file ="./4faza/analiza.R")
source(file="./lib/uvozi.zemljevid.R")

maxc <- max(BTC$Cena)
minc <- min(BTC$Cena)
sdc <- sd(BTC$Cena)

# Graf gibanja cene BTC

 graf_cene <- ggplot(data = BTC, aes(x = Datum, y = Cena)) + 
        geom_line()+ 
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5))+
        ggtitle('Graf gibanja cene BTC')+
        ylab('Cena(USD)')
        

graf_trans <- ggplot(data = BTC, aes(x = Datum, y = St_transakcij))+ geom_line() +
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5))+
        ggtitle('Graf gibanja dnevnega števila transakcij')+
        ylab('Število transakcij')

ggplot(data = BTC, aes(x = Datum, y = Skupno_st_transakcij)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = Promet)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = Trzna_kap)) + geom_line()


min(BTC$St_transakcij)

#GRAFI BANKOMATOV NISO VSA IMENA ISTA


# data <- map_data('world') %>% group_by(region) %>% summarise() %>% print(n = Inf)

data <- map_data("world")

evropske <- sort(c("UK", "Austria", "Spain", "France", "Czech Republic", "Poland", "Slovakia", "Slovenia", 
              "Germany", "Finland", "Sweden", "Italy", "Hungary", "Switzerland", "Norway", "Ukraine", 
              "Denmark", "Netherlands", "Ireland", "Estonia", "Latvia", "Lithuania", "Belgium"))
evropske_lok <- data.frame(Drzave = evropske, st_lok =sapply(evropske, function(x) stlok(x), USE.NAMES = F))
evropske_lok$Drzave <- as.character(evropske_lok$Drzave)
hf1 <- inner_join(data, evropske_lok, by = c('region' = 'Drzave'))

zemljevid <- ggplot(data = hf1, aes(x = long, y = lat, group = group)) + geom_polygon(aes(fill = st_lok) )+
        ylim(c(25,75))+
        xlab("Longituda")+
        ylab("Latituda")+
        theme_bw()+
        theme(plot.title = element_text(hjust = 0.5))+
        ggtitle('Evropske države glede na število lokacij BTC bankomatov') +
        labs(fill = 'Stevilo lokacij')

zemljevid2 <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                              "ne_50m_admin_0_countries", 
                              encoding = "UTF-8") %>%
        pretvori.zemljevid() %>% filter(long > -25, long < 45, lat > 35, lat < 75)

colnames(zemljevid2)[11] <- "drzava"
zemljevid2$drzava <- as.character(zemljevid2$drzava)
zemljevid2[grep("United Kingdom", zemljevid2[,1]),11] <- "UK"
#zemljevid2[zemljevid2$drzava == "United Kingdom", 11] <- "UK"
atm$Drzava <- as.character(atm$Drzava)

ggplot(data = zemljevid2) +
        geom_polygon(data = zemljevid2 %>% left_join(atm, by = c("drzava" = "Drzava")),
                     aes(x = long, y = lat, group = group, fill = Stevilo_lokacij),color = 'black', show.legend=T) +
        labs(fill ='Stevilo lokacij')+
        scale_fill_gradient(low = "red", high = "purple")+
        geom_text(data = inner_join(zemljevid2, evropske_lok[5:10,], by = c("drzava" = "Drzave")) %>%
                          group_by(drzava) %>%
                          summarise(avg_long = mean(long), avg_lat = mean(lat)),
                  aes(x = avg_long, y = avg_lat, label = drzava), color = "yellow") +
        xlab("Longituda") + ylab("Latituda") +
        coord_quickmap(xlim = c(-25, 40), ylim = c(32, 72))
