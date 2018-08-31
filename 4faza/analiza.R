
# podatki

source(file = "../uvoz/import.R")
#PODATKI ZA 1 LETO 27.8.2017 - 26.8.2018

#korelacija med ceno, tržno kap (pričakujemo 1)

cor(BTC$Cena, BTC$Trzna_kap)

# bolj zanimivo - korelacija med ceno in št transakcij v dnevu

cor(BTC$Cena, BTC$St_transakcij)


# korelacija med ceno in dnevnim prometom

cor(BTC$Cena, BTC$Promet)

#variabilnost cene

sd(BTC$Cena)

#variabilnost st transakcij

sd(BTC$St_transakcij)

#linearna regresija

scatter.smooth(x=BTC$Cena, y = BTC$St_transakcij, main ="Sevilo transakcij ~ Cena")

scatter.smooth(x=tail(BTC$Cena,180), y = tail(BTC$St_transakcij, 180), main ="Sevilo transakcij ~ Cena")

scatter.smooth(x=tail(BTC$Datum,180), y = tail(BTC$Cena, 180), main ="Cena ~ Datum")

#opazimo: ko je cena nizja - negativna korelacija, res:
#indeksi od <9000
i <- which(BTC$Cena %in% BTC$Cena[BTC$Cena < 9000])
cor(BTC$Cena[i], BTC$St_transakcij[i])


#predikcija

cena <- msts(BTC$Cena, seasonal.periods = c(7,365))
c <- tbats(cena)
fc <- forecast(c, h = 20)
plot(fc)



#skupen promet za 180 dni

Skup_promet <- data.frame(valuta = colnames(val[,-1]), promet  =colSums(val[,-1]), row.names = NULL)
Skup_promet$valuta <- as.character(Skup_promet$valuta)

#pove st lokacij btc bankomatov v drzavi
stlok <- function(x){
        return(atm$Stevilo_lokacij[match(x, atm$Drzava)])
}
#izberemo nekaj drzav za primerjavo.. predpostavimo da se v vsaki drzavi lahko trguje le s svojo valuto ?
drzave <- c("Japan", "UK", "Poland", "USA", "Canada")
Valute <- c("JPY", "GBP", "PLN", "USD", "CAD")
#koncna tabela za primerjavo
stlok_prom <- data.frame(Drzava = drzave, 
                         st_lok = sapply(drzave, function(x) stlok(x), USE.NAMES = F), 
                         promet = Skup_promet$promet[match(Valute, Skup_promet$valuta)])


cor(stlok_prom$st_lok, stlok_prom$promet)
# na to zelo vplivajo ZDA:
cor(stlok_prom$st_lok[stlok_prom$st_lok < 1000], stlok_prom$promet[stlok_prom$st_lok < 1000] )
