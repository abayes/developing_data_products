library(caret)
price_model <- train(log(price) ~ cut + clarity + color + carat, data = diamonds, method = 'lm')
predictedprice <- function(cut, clarity, color, carat) {
  new_data <- data.frame(cbind(cut, clarity, color, carat))
  new_data$carat <- as.numeric(as.character(new_data$carat))
  return(exp(predict(price_model,new_data)))
}


budget_data <- function(budget, cut, clarity, color, carat) {
  price <- predictedprice(cut, clarity, color, carat)
  data <- data.frame(cbind(rbind(budget, price), rbind("budget", "price"), rbind("$$$", "$$$")))
  data$X1 <- as.numeric(as.character(data$X1))
}


shinyServer(
  function(input, output) {
    price <- reactive({predictedprice(input$cut, input$clarity, input$color, input$carat)})
    budget_data <- reactive(data.frame(cbind(rbind(input$budget, price()), rbind("budget", "price"), rbind("$$$", "$$$"))))
    output$outprice <- renderText(c("$",round(price())))
    output$budget_plot <- renderPlot(
      ggplot(budget_data(), aes(x = V3, y = as.numeric(as.character(X1)), fill = V2)) +
        geom_bar(position = "identity", stat = "identity", alpha = .75,  fill = c("steelblue", "red")) +
        geom_text(aes(label = c("Max Budget", "Diamond Price"), y = .05*max(as.numeric(as.character(X1))) + as.numeric(as.character(X1)), x = c(0.9,1.1))) +
        ggtitle("Your Budget") +
        xlab("") +
        ylab("$$$") +
        theme(axis.text.x = element_blank(),
              axis.text.x = element_blank())
    )
  }
)




