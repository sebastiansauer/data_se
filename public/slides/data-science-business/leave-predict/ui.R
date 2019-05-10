

shinyUI(fluidPage(theme="bootstrap.css",
                        
                        headerPanel(title=div(img(src="running-solid.png", height = 40, width = 40),
                            "Predicting customer churn probability"),
                          windowTitle = "What's the propensity of losing a given customer?"
                        ),
                        
                        
                        titlePanel("DEMONSTRATION ONLY"),
                        
                        # Sidebar with a slider input for number of bins
                        sidebarLayout(
                          sidebarPanel(
                            sliderInput("total_bill",
                                        "Number of weeks since last contact?",
                                        min = 3,
                                        max = 50,
                                        value = 30),
                            sliderInput("size.num",
                                        "Number of mandates from this customer",
                                        min = 2,
                                        max = 6,
                                        value = 3),
                            radioButtons("smoker", "Any known complaints from this customer?",
                                         c("Yes" = "Yes", "Yes" = "No")),
                            radioButtons("day", "Main industry",
                                         c("Industry A" = "Fri", "Industry B" = "Sat", "Industry C" = "Sun",
                                           "Industry D" = "Thur")),
                            radioButtons("sex", "Median response time of this customer",
                                         c("Above average" = "Female", "Below average" = "Male")),
                            radioButtons("time", "Have there been late payments by this customer?",
                                         c("Yes" = "Dinner", "No" = "Lunch")) #,
                            
                            
                            #img(src="./running-solid.png", height = 40, width = 40)
                          ),
                          
                          
                          # Show a plot of the generated distribution
                          mainPanel(
                            tabsetPanel(type = "tabs", 
                                        tabPanel("Prediction", h3(textOutput("Prediction"))),
                                        tabPanel("Model", verbatimTextOutput("Model")), 
                                        tabPanel("Data", tableOutput("Data")),
                                        #tabPanel("Information")),
                                        tabPanel("Diagram", plotOutput("Diagram"))
                            )
                          )
                        )
))

