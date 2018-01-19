## UI Part
library(shiny)
shinyUI(fluidPage(
    titlePanel("House Price Estimator"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("SqFt", "what is size of the house", value =2000, 
                        min =1450,max =2600, step = 10),
            selectInput("Bedrooms", label = h3("Select No of Bedrooms"), 
                        choices = list("2 Bedrooms " = 2, "3 Bedrooms" = 3, "4 Bedrooms" = 4), 
                        selected =2),
            selectInput("Baths", label = h3("Select Bathrooms"), 
                        choices = list("2 Bathrooms" = 2, "3 Bathrooms" = 3, "4 Bathrooms" = 4), 
                        selected =2),
            
            selectInput("Bricks", label = h3("Select Type of Construction"), 
                        choices = list("With Brick" = "Yes", "No Bricks" = "No"), 
                        selected = "Yes"),
            
            selectInput("Neighborhood", label = h3("Select Neighborhood Type"), 
                        choices = list("East" = "East", "West" = "West", "North" = "North"), 
                        selected ="East"),
            submitButton('Check Price')
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("House Price for your choice of Home"),
            textOutput("pred1")
            
        )
    )
))