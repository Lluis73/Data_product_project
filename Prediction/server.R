#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic 
shinyServer(function(input, output) {
    
    model1 <- lm(mpg~factor(am)+hp,mtcars)
    
    model1pred <- reactive({
        hpInput <- input$sliderHP
        amInput <- ifelse(input$am=="0",0,1)
        predict(model1, newdata = data.frame(hp = hpInput, am = amInput),
                interval = (input$con), level = as.numeric(input$cf))
    })
    
    output$plot1 <- renderPlot({
        hpInput <- input$sliderHP
        plot(mtcars$hp, mtcars$mpg, col=as.factor(mtcars$am), xlab = "Horsepower",
             ylab = "Miles per Gallon", bty = "n", pch = 16,
             xlim = c(50, 350), ylim = c(0, 35))
        
        model1lines <- predict(model1,
                               newdata = data.frame(hp = 50:350, am = rep(0,times=301)))
        
        lines(50:350, model1lines, col = "black", lwd = 2)
        model2lines <- predict(model1,
                               newdata = data.frame(hp = 50:350, am = rep(1,times=301)))
        lines(50:350, model2lines, col = "red", lwd = 2)
        
        legend(270, 35, c("Automatic cars", "Manual cars"), pch = 16,
               col = c("black", "red"), bty = "n", cex = 1.2)
        if (input$am=="0"){
            points(hpInput, model1pred()[1], col = "black", pch = 16, cex = 2)
            segments(hpInput,model1pred()[2],hpInput,model1pred()[3], col = "black")
        } else {
            points(hpInput, model1pred()[1], col = "red", pch = 16, cex =2)
            segments(hpInput,model1pred()[2],hpInput,model1pred()[3], col = "red")
        }
        
    })
    
    output$pred1 <- renderText({
        format(model1pred()[1],digits=5)
    })    
    output$int1 <- renderText({
        c("(",format(model1pred()[2],digits = 5),","
          ,format(model1pred()[3],digits = 5),")")
    })
    
})
