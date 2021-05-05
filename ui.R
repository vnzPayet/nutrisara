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

Tabledonnee <- read_excel("Tabledonnee.xls")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  titlePanel("NutrISARA"),# title
  sidebarLayout(
    sidebarPanel("La Calculette Nutritionelle"),
    mainPanel(
      tabsetPanel(
        tabPanel("Introduction",textOutput(outputId= "introduction")),
        textInput(inputId = "intro", label = "Nutrisara est une application qui permet de calculer la valeur nutritionnelle d'un plat ou d'un ingrédient, pour vous permettre d'avoir des assietes équilibrés.", value = "", width =NULL, placeholder =NULL),
    
        tabPanel("La calculette",textOutput(outputId= "calculette"),tableOutput("La Calculette"),
             wellPanel(
                selectInput(inputId = "ingre1", label = "Sélectionner l'ingrédient ",
                            selected = F,choices =c(Tabledonnee$alim_nom_fr)),
                numericInput(inputId = "gram1", label = "Sélectionner le grammage",
                             value = 0, min = 0, max = F, step = 5)))
    ))
  )
)
)