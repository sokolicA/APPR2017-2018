---
title: "Analiza bitcoina"
date: 30.08.2018
Avtor: Andrej Sokolič
---




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

* obdelava, uvoz in čiščenje podatkov: 'uvoz/uvoz.r'
* vizualizacija podatkov: 'vizualizacija/vizualizacija.r'
* napredna analiza podatkov: 
