#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
setwd("c:/Users/BENOIT/Documents/projetopen/")
library(shiny)
library(readxl)
Tabledonnee <- read_excel("nutrisara/Tabledonnee.xls")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    selectInput(inputId = "idSelect", label = "Select among the list: ",
                selected = F,choices =c(Tabledonnee$alim_nom_fr))
))
