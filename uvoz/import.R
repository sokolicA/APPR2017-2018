## IMPORT


source('./lib/libraries.r')

# TABELA 1
#vir :https://www.blockchain.com/charts
# zapisemo datoteke

uvoz <- c("market-price.csv","market-cap.csv","n-transactions.csv","n-transactions-total.csv","trade-volume.csv","total-bitcoins.csv")

# vstavimo v data frame
BTC <- do.call(cbind, lapply(uvoz, function(x) read.csv(file = paste("./podatki/",x, sep = ""), 
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

# Za shiny

BTCshiny <- data.frame(Datum = BTC$Datum, Cena = BTC$Cena, Trzna_kap = BTC$Trzna_kap/1000000000,
                       St_transakcij = BTC$St_transakcij/1000, Skupno_st_transakcij = BTC$Skupno_st_transakcij/1000000,
                       Promet = BTC$Promet/1000000, BTC_v_obtoku = BTC$BTC_v_obtoku/1000000)

# TABELA 2
# trgovanje po valutah vir: https://data.bitcoinity.org/markets/volume/30d?c=e&t=b

val <- read.csv("./podatki/bitcoinity_data.csv")
val[,1] <- gsub(pattern = " 00:00:00 UTC", replacement = "", x = val[,1])
val[,2:11] <- lapply(val[,2:11], function(x) round(x, digits =  2))
val[,1] <- as.Date(val[,1], format="%Y-%m-%d")

#bolj nas bo zanimal skupen promet v BTC po valutah v zadnjem polletju
Skup_promet <- data.frame(valuta = colnames(val[,-1]), promet  =colSums(val[,-1]), row.names = NULL)
Skup_promet$valuta <- as.character(Skup_promet$valuta)

# TABELA 3
# bitcoin bankomati po svetu
atm <- read_html("https://coinatmradar.com/countries/", encoding = "UTF-8") %>% 
html_nodes(xpath = '//*[@class="country"]') %>% 
html_text()

atm <- strsplit(atm, " (", fixed = TRUE)

atm <- data.frame(matrix(unlist(atm), nrow=length(atm), byrow=T))
colnames(atm) <- c("Drzava", "Stevilo_lokacij")

atm[,2] <- gsub(" .*", "", atm[,2])
atm[,2] <- as.integer(as.character(atm[,2]))
atm[,1] <- as.character(as.factor(atm[,1]))

#niso vsa imena v isti obliki..
atm[1,1] <- "USA"
atm[grep("United Kingdom", atm[,1]),1] <- "UK"



# zapis datotek v csv obliki
write.csv(BTC, file = "./podatki/BTC.csv", row.names = F)
write.csv(atm, file = "./podatki/atm.csv", row.names = F)
write.csv(val, file = "./podatki/val.csv", row.names = F)
