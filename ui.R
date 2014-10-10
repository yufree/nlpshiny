
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
        # Set the page title
        titlePanel("Data Science Capstone: Simple SwiftKey"),
        
        sidebarPanel(
                textInput("entry",
                          h5("Input the sentence"),
                          "Data Science"),
                numericInput("n",
                             label = "numbers of words", 
                             value = 3),
                radioButtons("radio", 
                             h5("Smoothing selection"),
                             choices = list("Stupid Back-off" = 1, "Kneser-Ney " = 2),
                             selected = 1),
                submitButton("SUBMIT"),
                br(),
                img(src = "logo.jpg", height = 50, width = 50),
                "This app is created by ", 
                a("Miao Yu", href = "mailto:yufreecas@gmail.com")
                ),
        
        mainPanel(
                tabsetPanel(type = "tabs", 
                            tabPanel("Instruction", 
                                     h4("Instruction"),
                                     p('Portable office actually means the works done on the cellphones or tablets and we need input system to saving our time on typing on those device. So a smart and efficient keyboard is required. The core of this input system is a predictive language model and this shiny app is builded based on n-gram model with Stupid Bach-off Smoothing and Kneser-Ney Smoothing.'),
                                     h4("Usage"),
                                     p("You could input a sentence in the topleft panel, select the words you'd like to see, e.g. 3 words by default and try to find a smooth method for the n-gram model. Then press SUBMIT. You will see:"),
                                     h5(textOutput('sent')),
                                     p('as your sentences and'),
                                     h5(textOutput('text')),
                                     p('as prediceted words or just a WARNING.'),
                                     'See technique details in the',
                                     span('Tech',style = "color:blue"),
                                     'tag and limitations in the',
                                     span('Limitation',style = "color:blue"),
                                     'tag.'), 
                            tabPanel("Tech", h4("Summary")), 
                            tabPanel("Limitaions",
                                     h4("Known BUGs"),
                                     h5("Can't pass quiz ..."),
                                     p("To make the model faster, I only extracted the terms occurred in the whole sources more than 5 times. "),
                                     h5("Nothing return while you input something"),
                                     p('This will occur when you only input punctuation, numbers and some common words. The model will remove them in the input and nothing will return.'),
                                     h5("Number of the words can't be set too large in Kneser-Ney Smoothing"),
                                     p("When the number of the words were too large, NA will return and I just remove NA to show the words less than you want. Also some dirty words will be deleted from the final result."),
                                     h5("Kneser-Ney Smoothing is slow"),
                                     p('Well, I suggested using Stupid Kick-off first and then using Kneser-Ney when necessary.'),
                                     h6('Well, I have a better idea...'),
                                     "Contact me by click",
                                     a("here", href = "mailto:yufreecas@gmail.com"),
                                     'or just debug the code from',
                                     a("Github",href = "https://github.com/yufree/nlpshiny")
                                     )
        ))
))