#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Installation de la library (kableExtra)

# Chargement des libraries
library(knitr)
library(ggplot2)
library(shiny)
library(readxl)
library(shinythemes)
library(dplyr)
library(rmarkdown)

Tabledonnee <- read_excel("Tabledonnee.xls")


shinyUI(fluidPage(theme = shinytheme("cerulean"),

                  titlePanel(tags$img(src="Logo.png",width="450px",height="150px")),
                  titlePanel("Calculer la valeur nutritionnelle de son assiette, c'est facile !"),
                  navbarPage(icon("utensils"),
                  tabPanel(("Introduction"), #Explication du fonctionnement de l'application
                           fluidRow(
                                    
                                    br(),
                                    p(strong("NutrISARA")," est une application qui permet de calculer la valeur nutritionnelle d'un plat ou d'un ingrédient.", br(),"Pour vous permettre d'avoir des assietes équilibrés."),style="text-align:justify;color:#229954;background-color:#EAECEE;padding:20px;border-radius:10px"),
                                    br(),
                  
                          fluidRow(column(width=2),
                                   column(
                                     h4(p("Comment calculer la valeur nutritionnelle de mon assiette ?",style="color:black;text-align:center")),
                                     width=10,style="background-color:#3498DB;border-radius: 10px")),
                          br(),
                          
                          fluidRow(column(width=2, icon("hand-point-right","fa-5x"),align="center"),
                                   column(
                                     br(),
                                     p(strong("Pour calculer la valeur nutritionnelle"), " de votre assiette, vous aurez besoin de notre calculette !"),style="color:black;text-align:justify",
                                     width=10,style="background-color:#EAECEE;border-radius: 10px"),
                                     br(),
                                     column(
                                     p("Et pour uiliser notre calculette il vous suffriras d'enregister votre nom :",style="color:black;text-align:justify"),
                                     p('Nom et Prenom',style="color:grey;border:1px solid black;background-color:white"),
                                     p("La date du jour :",style="color:black;text-align:justify"),
                                     p('JJ/MM/AAAA',style="color:grey;border:1px solid black;background-color:white"),
                                     p("Le nom de la recette :",style="color:black;text-align:justify"),
                                     p('Nom de la recette',style="color:grey;border:1px solid black;background-color:white"),
                                     width=10,style="background-color:#EAECEE;border-radius: 10px")),
                          br(),
                          fluidRow(
                                   column(
                                     p("Cliquez sur l'onglet", strong("Calculette")," pour calculer la valeur nutritionnelle de votre assiette !",style="color:black; text-align:center"),width = 12,style="background-color:#3498DB; border-radius: 10px"
                                   )),
                          br(),
                          fluidRow(column(width = 4),
                                    column(
                                      p("Source des données : ",a(href="https://ciqual.anses.fr/"," La base Ciqual"),style="color:black; text-align:center"),width = 4,style="background-color:#EAECEE; border-radius: 10px")),
                                    
                                  ),
                 
                  tabPanel(("La Base Ciqual"), #Onglet de la base Ciqual
                           DT::datatable(Tabledonnee)
                           ),
                  tabPanel(("La Calculette"), #Onglet de la calculette
                          textInput(inputId = "recette",label = "Nom de votre recette", value = "", width =NULL, placeholder=NULL),
                          dateInput(inputId = "IdDate", label = "Date de création", value =NULL,min =NULL, max =NULL, format ="dd/mm/yyyy", startview ="month", weekstart =0, language ="FR"),
                          dateInput(inputId ="IDdate", label="Date de mise à jour",value =NULL, min =NULL, max =NULL,format ="dd/mm/yyyy", startview ="month", weekstart =0, language ="FR"),
                           wellPanel(
                             selectInput(inputId = "ingre1", label = "Sélectionner l'ingrédient ",
                                         selected = F,choices =c(Tabledonnee$alim_nom_fr)),
                             numericInput(inputId = "gram1", label = "Sélectionner le grammage",
                                          value = 0, min = 0, max = F, step = 5)),
                          downloadButton("report", "Generer un rapport")),
                  tabPanel("L'Analyse",tableOutput("Calctab")
                           )),
                  
                  hr(),
                  p(strong("Développé par des étudiants de la Promo50/ISARA : Module Open "),style ="text-align:center",
                  br(
                  p(em("Brice Levasseur Théo Masselis Honorine Favet Marianne Manry Valentine Mouche Célia Devillard"),
                  p(em("Benoit Barré  Mariama Issa Emma MANSON"),style ="text-align:center"),style ="text-align:center"),
                  p(tags$img(src="logoisara.jpg",width="150px",height="80px"),style ="text-align:center"))),
                  hr(),
            ))      
       

