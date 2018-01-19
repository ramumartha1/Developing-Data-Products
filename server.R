
library(shiny)
library(caret)
library(ggplot2)
shinyServer(function(input, output) {
    setwd("C:/Users/Ramu/Ramu/SW/Courseera/9_Data_products/Week4/test1")
    House_Price<- read.csv("./HousePrices.csv")
    # Data Cleaning & Removing some outliers
    House_Price1<- House_Price[, -1]
    House_Price1<-House_Price1[!(House_Price1$Bedrooms==5 | House_Price1$Bathrooms==4 | House_Price1$Offers==6),]
    #Model Fitting
    control <- trainControl(method="repeatedcv", number=10, repeats=3, search="random")
    model1 <- train(Price ~ ., data=House_Price1, method="rf", tuneLength=15, trControl=control)
    #model1 <- train(Price~., data = House_Price1, method ="glm")
    
    
    modelpred <- reactive({
        d_SqFt <- input$SqFt
        d_Brooms <- input$Bedrooms
        d_Baths <- input$Baths
        d_Bricks <- input$Bricks
        d_Neighbor <- input$Neighborhood
        
        newdata<- data.frame(SqFt = as.integer(d_SqFt), Bedrooms = as.integer(d_Brooms), Bathrooms = as.integer(d_Baths), 
                             Offers = 4, Brick =d_Bricks, Neighborhood = d_Neighbor)
        
        predict(model1, newdata)
    })

    
    output$plot1 <- renderPlot({
        sqft1 <- input$SqFt
        
        plot(House_Price1$SqFt, House_Price1$Price, xlab = "Square Feet Area", 
             ylab = "House Price in Dollars", pch = 16)
        points(sqft1, modelpred(), col = "red", pch = 23, cex = 2, bg = "Yellow")
        
    })
    
    output$pred1 <- renderText({
        modelpred()
    })
    
})