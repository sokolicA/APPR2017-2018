
# podatki

source(file = "./uvoz/import.R")

library(forecast)

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

scatter.smooth(x=BTC$Cena, y = BTC$St_transakcij, main ="Sevilo transakcij ~ Cena", 
               xlab = "Cena (USD)", ylab = "Število transakcij")
#povezava zadnjih 180 dni
scatter.smooth(x=tail(BTC$Cena,180), y = tail(BTC$St_transakcij, 180), main ="Sevilo transakcij ~ Cena", 
               xlab = "Cena (USD)", ylab = "Število transakcij")

scatter.smooth(x=tail(BTC$Datum,180), y = tail(BTC$Cena, 180), main ="Cena ~ Datum", 
               xlab = "Datum", ylab = "Cena (USD)", xaxt = "n")  # %>%
axis.Date(side = 1, BTC$Datum, format = "%d/%m/%Y")

#opazimo: ko je cena nizja - negativna korelacija, res:
#indeksi od <9000
i <- which(BTC$Cena %in% BTC$Cena[BTC$Cena < 8000])
cor(BTC$Cena[i], BTC$St_transakcij[i])

i <- which(BTC$Cena %in% BTC$Cena[BTC$Cena > 8000])
cor(BTC$Cena[i], BTC$St_transakcij[i])


#CENA
#ETS
#format %j preracuna kateri zaporedni dan v letu je datum
etspl <- function() {
        cena <- ts(BTC$Cena, frequency = 365, start = c(2017,as.numeric(format(BTC$Datum[1], "%j"))))
        cc <- ets(cena)
        fc <- forecast(cc, h = 30)
        df <- as.data.frame(fc)
        df$Datum <- as.Date(date_decimal(as.numeric(rownames(df))))
        colnames(df) <- c("Cena", "lo80", "hi80", "lo95", "hi95", "Datum")
        ggplot(df, aes(x = Datum, y = Cena)) + geom_line(data = BTC) +
                theme_bw()+
                theme(plot.title = element_text(hjust = 0.5))+
                ggtitle("Napoved za 30 dni") + geom_line(color = "blue") +
                geom_ribbon(aes(ymin = lo80, ymax = hi80), alpha = .25) +
                geom_ribbon(aes(ymin = lo95, ymax = hi95), alpha = .25) +
                xlim(as.Date("2018-07-01"), as.Date("2018-10-01")) + ylim(2000, 12000)
}



# TBATS

cena <- ts(BTC$Cena, frequency = 365, start = c(2017, as.numeric(format(BTC$Datum[1], "%j")))) # začne 239 dan leta 2017
c <- tbats(cena)
fc <- forecast(c, h = 20)
plot(fc, xaxt = 'n')
Axis(BTC$Datum, side = 1)


#ST trans

etspltr <- function(){cena <- ts(BTC$St_transakcij, frequency = 365, start = c(2017,as.numeric(format(BTC$Datum[1], "%j"))))
c <- ets(cena)
fc <- forecast(c, h = 30)
return(plot(fc, xlim= c(2018.5, 2018.8), main = "Napoved za 30 dni", ylab = "Število transakcij", xlab = "Datum"))}


cena <- ts(BTC$St_transakcij, frequency = 365, start = c(2017, as.numeric(format(BTC$Datum[1], "%j")))) # začne 239 dan leta 2017
c <- tbats(cena)
fc <- forecast(c, h = 20)
plot(fc, xaxt = 'n')
Axis(BTC$Datum, side = 1)

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

# povezava
cor(stlok_prom$st_lok, stlok_prom$promet)
# na to zelo vplivajo ZDA:
cor(stlok_prom$st_lok[stlok_prom$st_lok < 1000], stlok_prom$promet[stlok_prom$st_lok < 1000] )
