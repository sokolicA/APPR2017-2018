
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
#opazimo: ko je cena nizja - negativna korelacija, res:
#indeksi od <9000
i <- which(BTC$Cena %in% BTC$Cena[BTC$Cena < 9000])
cor(BTC$Cena[i], BTC$St_transakcij[i])


#predikcija

cena <- msts(BTC$Cena, seasonal.periods = c(5,365))
c <- tbats(cena)
fc <- forecast(c, h = 20)
plot(fc)
cena <- ts(BTC$Cena, frequency = 7)


