#
# This is the server logic of a Shiny web application. You can run the
# Application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    #tab %>% filter(alim_nom_fr==selection) %>% select(2)
    #reactive(input$ingre1)
    tab <- read.csv2("TabTest.csv", dec=",")
    #observe(label = gram1,x = input$gram1)
    #observeEvent(eventExpr = input$ingre1, tab%>%filter(nom==input$ingre1))
    #observeEvent(eventExpr = input$gram1, apply(tab, 1, function(x){5 %*% 2}))
    output$tab <-renderTable({tab %>% filter(nom==input$ingre1)}) 
    #output$tab <-renderTable({tab}) %>% apply(tab, 1, function(x){x*input$gram1})})
        #output$tab <-renderTable({tab %>% filter(nom==input$ingre1) %>% select(Eau)})# [input$ingre1, 2]}) #= tab ["input$ingre1", 2]*input$gram1/100 })
        
    #output$listingre <- reactive(ingre1)
    #output$Calctab <- renderTable(Tableau <- filter(Tableau, alim_nom_fr == reactive(ingre1)))
    #output$introduction <-renderText({c("Nutrisara est une application qui permet de calculer la valeur nutritionnelle d'un plat ou d'un argument selon sa quantité, afin d'obtenir une assiette équilibrée")})
    #output$calculette <-renderText({c("Entrer votre plat/recette et définissez vos quantités")})
    
    #PARTIE EXPORTATION EN PDF (noms a modifier)

########################################################################################
    'library(dplyr)
    
    tab <- read.csv2("TabTest.csv", dec=",", encoding = "latin1")
    head(tab)
    
    plat <- tab %>% filter(nom=="Dessert (aliment moyen)")
    
    ## Calcul
    plat$Eau+plat$Protéines
    
    ## Modif de plat
    plat$Eau <- plat$Eau/100*5
    plat
    
    tab %>% filter(nom=="Dessert (aliment moyen)")
    
    ## Modif de tab
    tab %>% filter(nom=="Dessert (aliment moyen)"| nom=="Salade de thon et légumes, appertisée")
    
    tab$Eau <- tab$Eau*(1:14)/100
    tab$Eau*c(0.45,1)
    
    ## input 
    # sélectionner des lignes 
    ligne <- c(1,3,5)
    qt <- c(2,3,1,4,5)
    
    tabsel <- tab[ligne,2:5]
    tabsel
    apply(tabsel, 2, function(x){x*qt})
    apply(tabsel, 2, function(x){sum(x*qt)})
    # check
    0.454*2+2.301*3+3.8'
    
###################################################################################

    output$report <- downloadHandler(
        filename = function() {
            paste0('Fiche_Recette_',paste0(input$recette),'.pdf')
        },
        content = function(file) {
            
            tempReport <- file.path(".\\www", "report.Rmd")
            file.copy("report.Rmd", tempReport, overwrite = TRUE)
            
            # Set up parameters to pass to Rmd document

            params <- list(nom = input$operateur, dateCre = input$IdDate, datemsj = input$IDdate, nrecette = input$recette, tab = head(cars))


            # Knit the document, passing in the `params` list, and eval it in a
            # Child of the global environment (this isolates the code in the document
            # from the code in this app).
            rmarkdown::render(tempReport, output_file = file,
                              params = params,
                              envir = new.env(parent = globalenv())
            )
            
            output$dateText  <- renderText({
                paste("input$date is", as.character(input$date))
            })
        })
           
            output$scatterPlot <- renderPlot({
                tabtest2<-read.csv2("Tab.csv", header=TRUE, dec=",", sep=";", encoding = "latin1")
                newtab2<-pivot_longer(tabtest2,c("Eau","Protéines", "Glucides", "Lipides", "Sucres", "Fibres.alimentaires", "AG.saturés","Sel"))
                colnames(newtab2)<-c("nomr", "class", "pourc")
                #newtab3 <- filter(newtab2, newtab2$nomr == "Dessert (aliment moyen)")
                newtab3 <- filter(newtab2, newtab2$nomr == input$ingre1)
                ggplot(data = newtab3) + 
                    geom_point(mapping = aes(x = class, y = pourc))
            })
        
})

