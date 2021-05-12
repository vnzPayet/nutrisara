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

   
    tab <- read.csv2("Tab.csv", dec=",")                  #Lecture du fichier csv contenant les données
    output$tab <-renderTable({  #output du tableau
        tab %>% filter(nom==input$ingre1)})                   #filtrer le tableau d'analyse en fonction des ingrédients sélectionnés
        #tab %>% apply(tab, 2, function(x){x*input$gram1})})  #test non concluant
    
    
    #PARTIE EXPORTATION EN PDF (noms a modifier)
    
    
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
                    geom_point(mapping = aes(x = class, y = pourc))+
                    labs(title = "Proportion d'éléments",
                         caption = "Nutrisara",
                         y = "g/100g",
                         x = "Elements")
            })
            
            output$scatterPlot2 <- renderPlot({
                tabtest2<-read.csv2("Tab.csv", header=TRUE, dec=",", sep=";", encoding = "latin1")
                newtab2<-pivot_longer(tabtest2,c("Eau","Protéines", "Glucides", "Lipides", "Sucres", "Fibres.alimentaires", "AG.saturés","Sel"))
                colnames(newtab2)<-c("nomr", "class", "pourc")
                #newtab3 <- filter(newtab2, newtab2$nomr == "Dessert (aliment moyen)")
                newtab3 <- filter(newtab2, newtab2$nomr == input$ingre1)
                ggplot(data = newtab3) + 
                    geom_point(mapping = aes(x = class, y = pourc))+
                    labs(title = "Proportion d'éléments",
                         caption = "Nutrisara",
                         y = "g/100g",
                         x = "Elements")
                ggsave("scatterplot2.png")
                tempReport <- file.path(".\\www", "scatterplot2.png")
                file.copy("scatterplot2.png", tempReport, overwrite = TRUE)
            })
            
            output$PlotEmpile <- renderPlot({
                tabtest2<-read.csv2("Tab.csv", header=TRUE, dec=",", sep=";", encoding = "latin1")
                newtab2<-pivot_longer(tabtest2,c("Eau","Protéines", "Glucides", "Lipides", "Sucres", "Fibres.alimentaires", "AG.saturés","Sel"))
                colnames(newtab2)<-c("nomr", "class", "pourc")
                newtab3 <- filter(newtab2, newtab2$nomr == input$ingre1)
                ggplot(data = newtab3, aes(x = nomr, y = pourc))+
                    geom_col(aes(fill = class), width = 0.7) +
                labs(title = "Proportion d'éléments",
                    caption = "Nutrisara",
                    y = "g/100g",
                    x = "Elements")
            })
            
            output$PlotEmpile2 <- renderPlot({
                tabtest2<-read.csv2("Tab.csv", header=TRUE, dec=",", sep=";", encoding = "latin1")
                newtab2<-pivot_longer(tabtest2,c("Eau","Protéines", "Glucides", "Lipides", "Sucres", "Fibres.alimentaires", "AG.saturés","Sel"))
                colnames(newtab2)<-c("nomr", "class", "pourc")
                newtab3 <- filter(newtab2, newtab2$nomr == input$ingre1)
                ggplot(data = newtab3, aes(x = nomr, y = pourc))+
                    geom_col(aes(fill = class), width = 0.7) +
                    labs(title = "Proportion d'éléments",
                         caption = "Nutrisara",
                         y = "g/100g",
                         x = "Elements")
                ggsave("plotempile2.png")
                tempReport <- file.path(".\\www", "plotempile2.png")
                file.copy("plotempile2.png", tempReport, overwrite = TRUE)
            })
            
})

