# Analiza bitcoina

Avtor: Andrej Sokolič



V svojem projektu bom analiziral gibanje cene najbolj popularne kriptovalute bitcoin. Izbral bom podatke s katerimi bom opisal dnevno gibanje raznih lastnosti trgovanja z bitcoinom kot so cena, število transakcij, volumen transakcij, volumen celotnega števila bitcoinov. Poleg časovnega gibanja bom primerjal število bitcoin bankomatov po več državah. 
Podatke o časovnih vrstah sem dobil v CSV obliki na spletni strani https://www.blockchain.com/charts, število bitcoin bankomatov po državah pa uvozil iz spletne strani https://coinatmradar.com/countries/ . 
Vsi podatki za časovne vrste bodo bili shranjeni v obliki data frame, kjer bo prvi stolpec datum, vsi naslednji pa npr. cena, število transakcij,... Porazdelitev bitcoin bankomatov bo shranjena v drugi spremenljivki, kjer bodo v prvem stolpcu države, v drugem pa število lokacij bankomatov v državah.
Iskal bom povezave med ceno bitcoina in številom transakcij, med ceno in celotnega števila bitcoinov v obtoku,... Čeprav zelo optimistično, bom s pomočjo prejšnjih cen poskušal napovedati prihodnje z uporabo linearne regresije.

## Tabela 1:
Stolpci:
1. Datum
2. Cena bitcoina
3. Tržna kapitalizacija
4. Število transakcij
5. Skupno število transakcij
6. Dnevni promet
7. Skupno število vseh bitcoinov

## Tabela 2:
Stolpci:
1. Ime države
2. Promet bitcoinov z valuto 


## Tabela 3:
Stolpci:
1. Ime države
2. Število bitcoin bankomatov v državi

## Program:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.R`
* vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `4faza/analiza.R`

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
* `maps` - za vgrajene zemljevide
* `forecast` - za napovedovanje
