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
#Tableau<-t(Tabledonnee)
#colnames(Tableau)<-Tableau[1,]
#listingre <- length

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("NutrISARA"), # title
  sidebarLayout(
    sidebarPanel("La Calculette Nutritionelle"),
    mainPanel(
      tabsetPanel(
        tabPanel("Introduction",textOutput(outputId= "introduction")),
    
        tabPanel("La calculette",textOutput(outputId= "calculette"),
             wellPanel(
                selectInput(inputId = "ingre1", label = "Sélectionner l'ingrédient ",
                            selected = F,choices =c(Tabledonnee$alim_nom_fr)),
                numericInput(inputId = "gram1", label = "Sélectionner le grammage",
                             value = 0, min = 0, max = F, step = 5))),
    
        tabPanel("Analyse",tableOutput("Calctab")))) 
  )
)
)
