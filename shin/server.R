#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(ggplot2)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$graf <- renderPlot({
          podatki <- BTCshiny[c('Datum', input$spr)]
          colnames(podatki) <- c('Datum', 'spr')
          ggplot(data = podatki, aes(Datum, spr)) + geom_line() +
                  theme_bw() + 
                  theme(plot.title = element_text(hjust = 0.5))+
                  xlab('Datum')+ 
                  ylab(names(izbire[izbire==input$spr]))+
                  ggtitle(paste(names(izbire2[izbire2==input$spr]), ' v preteklem letu', sep =''))
                  
          
    
    # # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2] 
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    # # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    # 
  })
  
  output$pred <- renderPlot({
          aa <- ts(BTCshiny[c(input$spr2)], frequency = 365, start = c(2017,as.numeric(format(BTCshiny$Datum[1], "%j"))))
          bb <- ets(aa)
          fc <- forecast(bb, h = as.numeric(input$spr3))
          df <- as.data.frame(fc)
          df$Datum <- as.Date(date_decimal(as.numeric(rownames(df))))
          colnames(df) <- c(input$spr2, "lo80", "hi80", "lo95", "hi95", "Datum")
          ime <- names(izbire[izbire==input$spr2])
          ggplot(df, aes(x = Datum, y =eval(as.name(input$spr2)))) + geom_line(data = BTCshiny) +
                  theme_bw() +
                  theme(plot.title = element_text(hjust = 0.5))+
                  ggtitle(paste("Napoved ", names(izbire3[izbire3==input$spr2]), " za ", input$spr3, " dni", sep = "")) + 
                  ylab(ime) +
                  geom_line(color = "blue") +
                  geom_ribbon(aes(ymin = lo80, ymax = hi80), alpha = .25) +
                  geom_ribbon(aes(ymin = lo95, ymax = hi95), alpha = .25) +
                  xlim(as.Date("2018-07-01"), as.Date("2018-10-01"))
         
  })
  
  
})
  
