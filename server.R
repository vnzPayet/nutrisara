#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$introduction <-renderText({c("Ceci est l'introduction, on y parle de truc super, comme par exemple ce qu'est cette application, a quoi elle sert etc etc")})
    output$calculette <-renderText({c("Ici, vous pouvez entrer les ingrédients de votre plat/recette, vous pouvez par à la suite définir la quantité de cette ingrédient")})
    #output$listingre <- reactive(ingre1)
    #output$Calctab <- renderTable(Tableau <- filter(Tableau, alim_nom_fr == reactive(ingre1)))
    
    
    #PARTIE EXPORTATION EN PDF (noms a modifier)
    #output$report <- downloadHandler(
        #filename = "report.pdf",
        #content = function(file) {
            
            #tempReport <- file.path(tempdir(), "report.Rmd")
            #file.copy("report.Rmd", tempReport, overwrite = TRUE)
            
            # Set up parameters to pass to Rmd document
            #params <- list(nom = input$nompre, dateCre = input$idDateCre, tab = head(cars))
            
            # Knit the document, passing in the `params` list, and eval it in a
            # child of the global environment (this isolates the code in the document
            # from the code in this app).
            #rmarkdown::render(tempReport, output_file = file,
                              #params = params,
                              #envir = new.env(parent = globalenv())
            #)
            
            #output$dateText  <- renderText({
                #paste("input$date is", as.character(input$date))
            #})
        #})
})
