## IMPORT


library(rvest)

#vir :https://www.blockchain.com/charts

# zapisemo datoteke

uvoz <- c("market-price.csv","market-cap.csv","n-transactions.csv","n-transactions-total.csv","trade-volume.csv","total-bitcoins.csv")

# vstavimo v data frame
setwd("../podatki")
BTC <- do.call(cbind, lapply(uvoz, function(x) read.csv(file = x, 
                                                header = F, encoding = "UTF-8", stringsAsFactors = FALSE)))
# odstranimo ponavljajoce se stolpce
BTC <- BTC[!duplicated(as.list(BTC))]

# imenujemo stolpce
colnames(BTC) <- c("Datum", "Cena", "Trzna_kap", "St_transakcij", "Skupno_st_transakcij", "Promet", "BTC_v_obtoku")

BTC[,2:7] <- lapply(BTC[,2:7], function(x) round(x, digits =  2))


#odstranimo uro

BTC[,1] <- gsub(pattern = " 00:00:00", replacement = "", BTC[,1])

#spremenimo v datume

BTC[,1] <- as.Date(BTC[,1], format = "%Y-%m-%d")

# trgovanje po valutah vir: https://data.bitcoinity.org/markets/volume/30d?c=e&t=b

val <- read.csv("../podatki/bitcoinity_data.csv")
val[,1] <- gsub(pattern = " 00:00:00 UTC", replacement = "", x = val[,1])
val[,2:11] <- lapply(val[,2:11], function(x) round(x, digits =  2))

val[,1] <- as.Date(val[,1], format="%Y-%m-%d")

#skupen promet za 180 dni

Skup_promet <- setNames(data.frame(colSums(val[,-1])), c("Skupen_promet"))

a <- merge(Skup_promet, atm, by =c('JPY' = 'Japan'))

# bitcoin bankomati po svetu

atm <- read_html("https://coinatmradar.com/countries/", encoding = "UTF-8") %>% 
html_nodes(xpath = '//*[@class="country"]') %>% 
html_text()

atm <- strsplit(atm, " (", fixed = TRUE)

atm <- data.frame(matrix(unlist(atm), nrow=74, byrow=T))
colnames(atm) <- c("Država", "Število lokacij")

atm[,2] <- gsub(" .*", "", atm[,2])
atm[,2] <- as.integer(as.character(atm[,2]))
atm[,1] <- as.character(as.factor(atm[,1]))
atm[1,1] <- "USA"
atm[grep("United Kingdom", atm[,1]),1] <- "UK"


#GRAFI BANKOMATOV NISO VSA IMENA ISTA
library(ggplot2)
library(dplyr)
library(maps)

data <- map_data('world') %>% group_by(region) %>% summarise() %>% print(n = Inf)
data <- map_data("world")
hf <- left_join(data, atm, by = c('region' = 'Država'))

ggplot(data = hf, aes(x = long, y = lat, group = group)) + geom_polygon(aes(fill = `Število lokacij`) )+
        scale_colour_brewer()+
        theme_bw()




# zapis datotek v csv obliki
write.csv(BTC, file = "BTC.csv", row.names = F)
write.csv(atm, file = "atm.csv", row.names = F)
write.csv(val, file = "val.csv", row.names = F)