Analiza bitcoina

V svojem projektu bom analiziral gibanje cene najbolj popularne kriptovalute bitcoin. Izbral bom podatke s katerimi bom opisal dnevno gibanje raznih lastnosti trgovanja z bitcoinom kot so cena, število transakcij, volumen transakcij, volumen celotnega števila bitcoinov. Poleg časovnega gibanja bom primerjal število bitcoin bankomatov po več državah. 
Podatke o časovnih vrstah sem dobil v CSV obliki na spletni strani https://www.blockchain.com/charts, število bitcoin bankomatov po državah pa uvozil iz spletne strani https://coinatmradar.com/countries/ . 
Vsi podatki za časovne vrste bodo bili shranjeni v obliki data frame, kjer bo prvi stolpec datum, vsi naslednji pa npr. cena, število transakcij,... Porazdelitev bitcoin bankomatov bo shranjena v drugi spremenljivki, kjer bodo v prvem stolpcu države, v drugem pa število lokacij bankomatov v državah.
Iskal bom povezave med ceno bitcoina in številom transakcij, med ceno in celotnega števila bitcoinov v obtoku,... Čeprav zelo optimistično, bom s pomočjo prejšnjih cen poskušal napovedati prihodnje z uporabo linearne regresije.
