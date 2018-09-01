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
   
  output$graf <- renderPlot({
          podatki <- BTC[c('Datum', input$spr)]
          colnames(podatki) <- c('Datum', 'spr')
          ggplot(data = podatki, aes(Datum, spr)) + geom_line() +
                  theme_bw() + 
                  theme(plot.title = element_text(hjust = 0.5))+
                  xlab('Datum')+ 
                  ylab(input$spr)+
                  ggtitle(paste(input$spr, ' v preteklem letu', sep =''))
                  
          
    
    # # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2] 
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    # # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    # 
  })
  
  output$pred <- renderPlot({
          a <- ts(BTC[c(input$spr2)], start = c(2017,238), frequency = 365)
          b <- tbats(a)
          c <- forecast(b, h = as.numeric(input$spr3))
          plot(c, xlab = "Leto", ylab = input$spr2, main = paste("Napoved ", input$spr2, " za ", input$spr3, " dni", sep = ""))
          })
})
 
