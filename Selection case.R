
tab <- read.csv2("Tabtest.csv", dec=",")

head(tab)
names(tab)

# selection : colonne EAu =2 et en ligne un ingrÃ©dient ou recette
tab
head(tab$nom)

tab[1,2]
hist(tab[,2])

## selection d'une recette, colonne 2
selection <- "Salade de thon et légumes, appertisée"

tab[tab$nom==selection, ]
tab[tab$nom==selection, 2]

as.numeric(tab[tab$nom==selection, 2])

## dplyr
library(dplyr)

tab %>% filter(nom==selection) %>% 
  select(Eau)
tab %>% filter(nom==selection) %>% 
  select(Protéines)
tab %>% filter(nom==selection) %>% 
  select(Glucides)
tab %>% filter(nom==selection) %>% 
  select(Lipides)
tab %>% filter(nom==selection) %>% 
  select(Sucres)
tab %>% filter(nom==selection) %>% 
  select(Fibresalimentaires)
tab %>% filter(nom==selection) %>% 
  select(AGsaturés)
tab %>% filter(nom==selection) %>% 
  select(Sel)


