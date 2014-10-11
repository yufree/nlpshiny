
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source('models.R')
badwords <- readLines('badword.txt')
load('ngram0.RData')

shinyServer(function(input, output) {
        dataInput <- reactive({
                if(input$radio == 1){
                        predict0(input$entry,badwords,unigramDF,bigramDF,trigramDF,maxResults = input$n)
                }else{
                        predictKN(input$entry,badwords,unigramDF,bigramDF,trigramDF,maxResults = input$n)
                }
                })
        
        output$text <- renderText({
                dataInput()
        })
        
        output$sent <- renderText({
                input$entry
        })
})
