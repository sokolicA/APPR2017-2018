## IMPORT



# vir :https://www.blockchain.com/charts

# zapisemo vse datoteke
setwd("C:/Users/andre/Desktop/R PROJEKT/Bitcoin analiza")
files <- list.files(path = "../Bitcoin analiza", pattern = "*.csv")

# vstavimo v data frame
BTC <- do.call(cbind, lapply(files, function(x) read.csv(file = x, header = F, stringsAsFactors = FALSE)))
# odstranimo ponavljajoce se stolpce
BTC <- BTC[!duplicated(as.list(BTC))]

# imenujemo stolpce
colnames(BTC) <- c("Datum", files)

BTC[,2:7] <- lapply(BTC[,2:7], function(x) round(x, digits =  2))


#odstranimo uro

BTC[,1] <- gsub(pattern = "00:00:00", replacement = "", BTC[,1])
        
# po valutah vir: https://data.bitcoinity.org/markets/volume/30d?c=e&t=b

val <- read.csv("C:/Users/andre/Desktop/R PROJEKT/bitcoinity_data.csv")
val[,1] <- gsub(pattern = "00:00:00 UTC", replacement = "", x = val[,1])
val[,2:11] <- lapply(val[,2:11], function(x) round(x, digits =  2))


# bitcoin bankomati po svetu

atm <- read_html("https://coinatmradar.com/countries/") %>% 
html_nodes(xpath = '//*[@class="country"]') %>% 
html_text()

atm <- strsplit(atm, " (", fixed = TRUE)

atm <- data.frame(matrix(unlist(atm), nrow=74, byrow=T))
colnames(atm) <- c("Država", "Število lokacij")

atm[,2] <- gsub(" .*", "", atm[,2])
atm[,2] <- as.integer(as.character(atm[,2]))
atm[,1] <- as.character(as.factor(atm[,1]))
atm[1,1] <- "USA"


# GRAFI BANKOMATOV NISO VSA IMENA ISTA
# library(ggplot2)
# library(dplyr)
# 
# data <- map_data('world') %>% group_by(region) %>% summarise() %>% print(n = Inf)
# data <- map_data("world")
# hf <- left_join(data, atm, by = c('region' = 'Država'))
# 
# ggplot(data = hf, aes(x = long, y = lat, group = group)) + geom_polygon(aes(fill = `Število lokacij`) )+
#         scale_colour_brewer()+ 
#         theme_bw()
# 
