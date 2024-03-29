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
library(tidyr)
library(ggplot2)

Tabledonnee <- read_excel("Tabledonnee.xls")
tab <- read.csv2("Tab.csv", dec=",")
tabtest2<-read.csv2("Tab.csv", header=TRUE, dec=",", sep=";", encoding = "latin1")
newtab2<-pivot_longer(tabtest2,c("Eau","Protéines", "Glucides", "Lipides", "Sucres", "Fibres.alimentaires", "AG.saturés","Sel"))
colnames(newtab2)<-c("nomr","class","pourc")

shinyUI(fluidPage(theme = shinytheme("cerulean"),

                  titlePanel(tags$img(src="Logo.png",width="450px",height="150px")),
                  titlePanel("Calculer la valeur nutritionnelle de son assiette, c'est facile !"),
                  navbarPage(icon("utensils"),
                  tabPanel(("Introduction"), #Explication du fonctionnement de l'application
                           fluidRow(
                                    
                                    br(),
                                    p(strong("NutrISARA")," est une application qui permet de calculer la valeur nutritionnelle d'un plat ou d'un ingrédient.", br(),"Pour vous permettre d'avoir des assietes équilibrés."),style="text-align:justify;color:#229954;background-color:#EAECEE;padding:20px;border-radius:10px"),
                                    br(),
                  
                          fluidRow(
                                   column(
                                     h4(p("Comment calculer la valeur nutritionnelle de mon assiette ?",style="color:black;text-align:center")),
                                     width=12,style="background-color:#3498DB;border-radius: 10px")),
                          br(),
                          
                          fluidRow(column(width=2, icon("hand-point-right","fa-5x"),align="center"),
                                   column(
                                     br(),
                                     p(strong("Pour calculer la valeur nutritionnelle"), " de votre assiette, vous aurez besoin de notre calculette dans l'onglet", strong("La Calculette"), "!"),style="color:black;text-align:justify",
                                     p("Vous avez également accès à la base ciqual dans l'onglet ",strong("La Base Ciqual.")),style="color:black;text-align:justify",width=9),
                                     
                                     
                                   br(),
                                     column(
                                     p(icon("tools")," Pour uiliser notre calculette, il vous suffriras d'enregister la dénomination de la recette :",style="color:black;text-align:justify"),
                                     p('Dénomination de la recette',style="color:grey;border:1px solid black;background-color:white"),
                                     p(" Le nom de l'opérateur :",style="color:black;text-align:justify"),
                                     p(' Nom et Prénom',style="color:grey;border:1px solid black;background-color:white"),
                                     p(" La date de création :",style="color:black;text-align:justify"),
                                     p(' AAAA/MM/JJ',style="color:grey;border:1px solid black;background-color:white"),
                                     p(" La date de mise à jour :",style="color:black;text-align:justify"),
                                     p(' AAAA/MM/JJ',style="color:grey;border:1px solid black;background-color:white"),
                                     p(" Puis sélectionner le ou les types d'ingrédients et le ou leurs grammages (g):",style="color:black;text-align:justify"),
                                     column(p(' Ingrédients',style="color:grey;border:1px solid black;background-color:white"),width=6),
                                     column(p(' Grammages (g)',style="color:grey;border:1px solid black;background-color:white"),width=6),
                                     width=12,style="background-color:#EAECEE;border-radius: 10px")),
                          br(),
                          fluidRow(
                                   column(
                                     p("Cliquez sur l'onglet", strong("Calculette")," pour calculer la valeur nutritionnelle de votre assiette !",style="color:black; text-align:center"),width = 12,style="background-color:#3498DB; border-radius: 10px"
                                   )),
                          ),
                 
                  tabPanel(("La Base Ciqual"), #Onglet de la base Ciqual
                           DT ::datatable(Tabledonnee)
                           ),
                  tabPanel(("La Calculette"), #Onglet de la calculette

                           fluidRow(
                           br(),
                             p("Merci de ", strong("remplir tout les champs")," et ", strong("d'éditer")," la valeur nutritionel de votre recette :",style="color:black;text-align:justify"),
                             style="background-color:#EAECEE;padding:20px; border-radius: 10px"),
                          br(),
                          textInput(inputId = "recette",label = "Entrer votre recette", value = "", width =NULL, placeholder=NULL),
                          textInput(inputId = "operateur",label = "Entrer votre nom d'opérateur", value = "", width =NULL, placeholder=NULL),
                          fluidRow(column(dateInput(inputId = "IdDate", label = "Date de création", value =NULL,min =NULL, max =NULL, format ="yyyy-mm-dd", startview ="month", weekstart =0, language ="FR"),width=6),
                                  column(dateInput(inputId ="IDdate", label="Date de mise à jour",value =NULL, min =NULL, max =NULL,format ="yyyy-mm-dd", startview ="month", weekstart =0, language ="FR"),width=6)),

                           wellPanel(
                             fluidRow(column(selectInput(inputId = "ingre1", label = "Sélectionner l'ingrédient ",
                                         selected =F, choices =c(Tabledonnee$nom)),width=8),
                                      column(numericInput(inputId = "gram1", label = "Sélectionner le grammage",
                                      value = 0, min = 0, max = F, step = 5),width=4)),
                             ),
                    actionButton("add", "Ajouter un ingrédient"),
                    hr(),
                  
                    
                  
                      downloadButton("report", "Générer un rapport")
                  ),
                  
                  tabPanel("L'Analyse",tableOutput("tab"),
                           plotOutput("scatterPlot"),
                           plotOutput("PlotEmpile"),
                           plotOutput("scatterPlot2"),
                           plotOutput("PlotEmpile2"),
                           )),
                
                  
                  hr(),
                  p(strong("Développé par des étudiants de la Promo50/ISARA : Module Open "),style ="text-align:center",
                  br(
                  p(em("Brice Levasseur Théo Masselis Honorine Favet Marianne Manry Valentine Mouche Célia Devillard"),
                  p(em("Benoit Barré  Mariama Issa Emma MANSON"),style ="text-align:center"),style ="text-align:center"),
                  p(tags$img(src="logoisara.png",width="150px",height="80px"),style ="text-align:center"))), 
                  fluidRow(br(),
                    p(strong("Source des données : ",a(href="https://ciqual.anses.fr/",em(" La base Ciqual")),style="color:bleue"),style="text-align:center"),width = 4,style="background-color:#EAECEE; border-radius: 10px"),
                  hr(),
            ))      
       

