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
    titlePanel("Predict MPG from Horsepower and type of transmission"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderHP",
                        "Horsepower of the car",
                        min = 50,
                        max = 350,
                        value = 150),
            radioButtons("am","Type of transmission",
                         c("Automatic" = "0",
                           "Manual" = "1")),
            radioButtons("con","Type of confidence interval",
                         c("Predicted mean" = "confidence",
                           "Value" = "prediction")),
            radioButtons("cf","Confidence level",
                         c("90%" = 0.9,
                           "95%" = 0.95,
                           "99%" = 0.99))
            #checkboxInput("showModel1", "Show/Hide Model 1", value =TRUE),
            #checkboxInput("showModel2", "Show/Hide Model 2", value =TRUE)
        ),
        
        # Show a plot of the prediction and predicted values
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Results",plotOutput("plot1"),
                                 h3("Predicted Miles per Gallon:"),
                                 textOutput("pred1"),
                                 h3("Confidence interval:"),
                                 textOutput("int1")),
                        tabPanel("User's Guide", br(),
                                 p("This application returns the consumption,
                                    measured in miles per gallon, using a regression model
                                    on the Horsepower and the type of transmission (manual or
                                    automatic). The result is given with a confidence level and
                                    a graph showing the points from which the regression model
                                    was built is plotted."),
                                 h3("Inputs:"),
                                 p(strong("Horsepower:"),"Horsepower of the car. Cars with a lot
                                   of horsepower have greater consumption (they can drive less
                                   miles per gallon)."),
                                 p(strong("Type of transmission:"),"Type of transmission
                                    (manual or automatic). Automatic cars have bigger consumptions
                                   than manual ones."),
                                 p(strong("Type of confidence interval:"),"The confidence interval
                                   is bigger for the values than for the predicted mean. In the
                                   second case the confidence interval only accounts for the error
                                   due to the estimation of parameters, while in the first case
                                   (bigger intervals) the confidence interval accounts for the
                                   parameters estimation error and the individual error around the 
                                   regression line."),
                                 p(strong("Confidence level:"),"The confidence level determines the
                                   width of the confidence interval."),
                                 p("You can find the ui.R and server.R in following link:"),
                                 a(href="https://github.com/Lluis73/Data_product_project", "link to Github"))
                        
            )
            
        )
    )
))
