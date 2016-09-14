library(shiny)
library(ggplot2)
shinyUI(fluidPage(
  fluidRow(h1("Design your diamond!")),
  fluidRow(p("Adjust the cut, clarity, color, and carats of your diamond and we'll show you how much you can expect to pay.")),
  fluidRow(p("If you enter your budget, we'll show you how the price of your diamond compares.")),
  column(5,
    fluidRow(
        textInput("budget", "What is your budget?", "0")),
    fluidRow(
      column(4,
        radioButtons("cut", "Select a cut", choices = list("Fair","Good","Very Good","Premium","Ideal"))),
      column(4,
        radioButtons("clarity", "Select a clarity", choices = list("I1","SI2","SI1","VS2","VS1","VVS2","VVS1","IF"))),
      column(4,
        radioButtons("color", "Select a color", choices = list("D", "E", "F", "G", "H", "I", "J")))
    ),
    fluidRow(
      #sliderInput("clarity", "Select clarity", value = 1, min = 1, max = 8, step = 1, ticks = F),
      sliderInput("carat", "How many carets?", value = 0.1, min = 0.1, max = 5, step = 0.1)
    )
  ),
  column(7,
    h4("Diamond Price:"),
    textOutput('outprice'),
    plotOutput('budget_plot')
  )
))

