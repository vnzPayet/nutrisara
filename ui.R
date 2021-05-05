#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(readxl)
library(shinythemes)

Tabledonnee <- read_excel("Tabledonnee.xls")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("cerulean"),

                  titlePanel(tags$img(src="Logo.png",width="450px",height="150px")),
                  titlePanel("Calculer ce qu'il y a dans son assiette, c'est facile !"),
                  navbarPage(icon("home"),
                  tabPanel(("Introduction"),
                  textInput(inputId = "intro", label = "Nutrisara est une application qui permet de calculer la valeur nutritionnelle d'un plat ou d'un ingrédient, pour vous permettre d'avoir des assietes équilibrés.", value = "", width =NULL, placeholder =NULL),
                  textInput(inputId = "Grammage", label = " Par défaut, la valeur sera pour 100g", value = "", width =NULL, placeholder =NULL  ),
                  textInput(inputId = "recette",label = "Entrer votre recette", value = "", width =NULL, placeholder=NULL),
                  dateInput(inputId = "IdDate", label = "date de création", value =NULL,min =NULL, max =NULL, format ="yyy-mmm-ddd", startview ="month", weekstart =0, language ="FR"),
                  dateInput(inputId ="IDdate", label="date de mise à jour",value =NULL, min =NULL, max =NULL,format ="yyy-mmm-ddd", startview ="month", weekstart =0, language ="FR")),
                  tabPanel("La Calculette"),
                           wellPanel(
                             selectInput(inputId = "ingre1", label = "Sélectionner l'ingrédient ",
                                         selected = F,choices =c(Tabledonnee$alim_nom_fr)),
                             numericInput(inputId = "gram1", label = "Sélectionner le grammage",
                                          value = 0, min = 0, max = F, step = 5)))
)
)