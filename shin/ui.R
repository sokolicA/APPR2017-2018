#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Grafični prikaz"),
  
  tabsetPanel(
          
          
          tabPanel("Graf", 
                   
                   sidebarPanel(
                           selectInput("spr", label="Izberi spremenljivko",
                                       choices=colnames(BTC[1,-1]), selected="ia"),
                           checkboxGroupInput("ostalo", label="",
                                              selected=c(1))
                   ),
                   mainPanel(plotOutput("graf"))),
          
          tabPanel("Napoved",
                   sidebarPanel(
                           selectInput("spr2", label = "Izberi spremenljivko", choices = colnames(BTC[,-1]), selected = "aa"),
                           selectInput("spr3", label = "Izberi časovno obdobje", choices = seq(3,100, by =1), selected = "ab")
                   ),
                   mainPanel(plotOutput("pred")))
                   
                   
                   )
          )
  
  
)
