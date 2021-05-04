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

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })
    
    
    
    
    #PARTIE EXPORTATION EN PDF (noms a modifier)
    #output$report <- downloadHandler(
        #filename = "report.pdf",
        #content = function(file) {
            
            #tempReport <- file.path(tempdir(), "report.Rmd")
            #file.copy("report.Rmd", tempReport, overwrite = TRUE)
            
            # Set up parameters to pass to Rmd document
            #params <- list(nom = input$nompre, dateCre = input$idDateCre)
            
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
