
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
                             h5("numbers of words"), 
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
                                     p('Portable office actually means the works done on the cellphones or tablets and we need input system to saving our time on typing on those device. So a smart and efficient keyboard is required. The core of this input system is a predictive language model and this shiny app is builded based on n-gram model with Stupid Back-off Smoothing and Kneser-Ney Smoothing.'),
                                     h4("Usage"),
                                     p("You could input a sentence in the topleft panel, select the words you'd like to see, e.g. 3 words by default and try to find a smooth method for the n-gram model. Then press SUBMIT. You will see:"),
                                     h5(textOutput('sent')),
                                     p('as your sentence and'),
                                     h5(textOutput('text')),
                                     p('as prediceted words or just a WARNING.'),
                                     'See technique details in the',
                                     span('Tech',style = "color:blue"),
                                     'tag and limitations in the',
                                     span('Limitation',style = "color:blue"),
                                     'tag.'), 
                            tabPanel("Tech", 
                                     h4("N-gram model"),
                                     p("Using a higher probability of the last words in terms will predict next words for certain sentence and this is the core of N-gram model. The n-gram model worked well if the terms were huge enough to cover any cases. However, such model will cost a lot of time training the data. Another way is just using a back-off model to change n-gram model into (n-1)-gram model. The simplest back-off model will first get the probability of every (n-1) terms, order them and show the first few words as prediction. When no words were shown, a (n-1)-gram model will be used until uni-gram model, which will show the most common words in the corpus."),
                                     h5('Smoothing'),
                                     p("However, such case that there were only one terms in a tri-gram while many terms in a bi-gram for certain words will make a simple back-off model hard to distribute the probability to the candidates. A common way is that smoothing the counts on the n-gram. Good-Turing Estimate show a good idea to get the probability space for (n-1)-gram model."),
                                     p("I use an absolute discounting on each counts based on Ney et al.'s study.The Kneser-Ney Smoothing were employed to get the probability with a combination of (n-1)-gram. I actually combined a Kneser-Ney Smoothing with a back-off model: When the model could find terms in the tri-gram, a tri-gram Kneser-Ney model will be used. While the model can't find a hit in tri-gram, a bi-gram Kneser-Ney Smoothing were run. Those two Kneser-Ney Smoothing have different discountings."),
                                     h5("Stupid Backoff Implementation"),
                                     p("The model above were slow to show predicted words and I speed up the model with less code and a relative small loss of prediction accuracy. The core of the code called Stupid Backoff implementation, which is often used in web-based corpus. The core of this backoff implementation is that using a fixed discount for (n-1)-gram's possibiliy. With a huge corpus, the performance of Stupid Backoff implementation will show a similar prediction accuracy with the Kneser-Ney Smoothing.")), 
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
                                     ),
                            tabPanel("Reference",
                                     h6("Körner, M. C. (n.d.). Implementation of Modified Kneser-Ney Smoothing on Top of Generalized Language Models for Next Word Prediction Bachelorarbeit, (September 2013)."),
                                     h6("Williams, G. (2014). Data Science with R Text Mining."),
                                     h6(a("Coursera Discussion Board",href = "https://class.coursera.org/dsscapstone-001/forum)")),
                                     h6(a("Google",href = "http://www.google.com"))
                                     )
                            
        ))
))