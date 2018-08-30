library(ggplot2)

source(file = "../uvoz/import.R")



ggplot(data = BTC, aes(x = Datum, y = Cena)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = St_transakcij)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = Skupno_st_transakcij)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = Promet)) + geom_line()

ggplot(data = BTC, aes(x = Datum, y = Trzna_kap)) + geom_line()
