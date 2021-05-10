
tab <- read.csv2("TabTest.csv", dec=",")

head(Tab)
names(tab)

# selection : colonne EAu =2 et en ligne un ingrédient ou recette
tab
head(Tab$alim_nom_fr)

tab[1,2]
hist(tab[,2])

## selection d'une recette, colonne 2
selection <- "Salade de pommes de terre, fait maison"

tab[tab$alim_nom_fr==selection, ]
tab[tab$alim_nom_fr==selection, 2]

as.numeric(tab[tab$alim_nom_fr==selection, 2])

## dplyr
library(dplyr)

tab %>% filter(alim_nom_fr==selection) %>% 
  select(Eau..g.100.g.)

tab %>% filter(alim_nom_fr==selection) %>% 
  select(2)


