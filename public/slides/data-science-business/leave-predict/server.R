# server
shinyServer(function(input, output) {  
  
  library(shiny)
  library(reshape2)
  library(ggplot2)
  data(tips)
  
  tips$size <- as.numeric(tips$size) # change from numeric to dbl
  
  # levels(tips$smoker) <- c(0, 1) # convert to numeric    
  # tips$smoker.num <- as.numeric(tips$smoker)
  
  tips$tip.bin <- cut(tips$tip, breaks = 2) # dichotomize tip 
  
  tips$size.num <- as.numeric(tips$size)
  
  ausfall <- with(tips, glm(tip.bin ~ total_bill + size.num + smoker + time + sex, 
                            family = binomial))
  # compute logistic regression model
  
  
  new.data <- data.frame(matrix(ncol = 8, nrow = 1))
  names(new.data) <- c("total_bill", "smoker", "size.bill", "timd", "sex", "ID",
                       "ausfall.logit", "ausfall.p")
  
  
  new.data$ID <- "Firma_ABC_GmbH"
  
  
  
  output$Prediction <- renderText({
    ausfallText <- reactive({
      
      new.data$total_bill <- input$total_bill
      new.data$smoker <- input$smoker
      new.data$size.num <- input$size.num
      new.data$time <- input$time
      new.data$sex <- input$sex
      
      
      new.data$ausfall.logit <- predict(ausfall, newdata = new.data)[1] # returns logit
      
      new.data$ausfall.p <- round((exp(new.data$ausfall.logit) / 
                                     (exp(new.data$ausfall.logit) + 1)), digits = 2)
      # convert logit to percentage
      
      
      
      # paste("Logit: ", p.new.data)
      paste("Customer churn probability: ", new.data$ausfall.p * 100, " %")
    })  
    ausfallText()  
  })
  
  output$Model <- renderPrint({
    summary(ausfall)
  })
  
  output$Data <- renderTable({
    data.frame(x=tips)
  })
  
  
  output$Information <- renderPrint({
    print("test")
  })
  
  output$Diagram <- renderPlot({
    
    new.data$total_bill <- input$total_bill
    new.data$smoker <- input$smoker
    new.data$size.num <- input$size.num
    new.data$time <- input$time
    new.data$sex <- input$sex
    
    
    new.data$ausfall.logit <- predict(ausfall, newdata = new.data)[1] # returns logit
    
    new.data$ausfall.p <- round((exp(new.data$ausfall.logit) / 
                                   (exp(new.data$ausfall.logit) + 1)), digits = 2)
    # convert logit to percentage
    
    
    
    ggplot(new.data, aes(x = ID, y = ausfall.p)) + geom_bar(stat = "identity") + 
      ylim(c(0,1)) + ylab("Customer churn probability") +
      geom_hline(yintercept = .3, colour = "green") + 
      geom_hline(yintercept = .5, colour = "blue") +
      geom_hline(yintercept = .8, colour = "red")
    
  })
  
  
})
