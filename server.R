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
        output$tab <-renderTable({tab %>% filter(nom==input$ingre1)}) 
        #%>%  tab ["input$ingre1", 2] tab ["input$ingre1", 2]*input$gram1/100 })
        #filter(nom==input$ingre1) 
    
    #output$listingre <- reactive(ingre1)
    #output$Calctab <- renderTable(Tableau <- filter(Tableau, alim_nom_fr == reactive(ingre1)))
    #output$introduction <-renderText({c("Nutrisara est une application qui permet de calculer la valeur nutritionnelle d'un plat ou d'un argument selon sa quantité, afin d'obtenir une assiette équilibrée")})
    #output$calculette <-renderText({c("Entrer votre plat/recette et définissez vos quantités")})
    
    
    
    #PARTIE EXPORTATION EN PDF (noms à modifier)
    output$report <- downloadHandler(
        filename = "report.pdf",
        content = function(file) {
            
            tempReport <- file.path(tempdir(), "report.Rmd")
            file.copy("report.Rmd", tempReport, overwrite = TRUE)
            
            # Set up parameters to pass to Rmd document
            params <- list(nom = input$operateur, dateCre = input$idDate, datemsj = input$IDdate, nrecette = input$idrecette, tab = head(cars))
            
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
            file.copy(from = "report.pdf",
                      to = paste0('Fiche_Recette_',paste0(params$nrecette),'.pdf'))
        })
})
