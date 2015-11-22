library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("CAPM Capital Asset Pricing Mode"),
  sidebarPanel(
    selectInput("stock", "Select the stock:",
                c("Total" =  "FP.PA",
                  "Societe Generale" = "GLE.PA",
                  "Renault" = "RNO.PA",
                  "EDF" = "EDF.PA")),
    dateRangeInput("daterange", "Select the Date range:",
                   min  = "2008-01-01",
                   max    = Sys.Date()-10,
                   start = "2010-01-01",
                   end =   Sys.Date()-10,
                   format = "mm/dd/yy",
                   separator = " - "),
    submitButton('Submit'),
    h4("Help:"),
    h5("The capital asset pricing model (CAPM) assumes that a stock 
       belonging to a given market, has a return linearly 
       dependent on the market return"),
    h5("Select the stock and the period (date range) 
       of the calculation in order to fit your linear regression."),
    h5("Plots and summary results are shown in the main panel ")
    
  ),
  mainPanel(
    plotOutput("plotCAC"),
    plotOutput("plotStock"),
    h4("Linear regression plot"),
    plotOutput("plotReg"),
    h4("Summary of linear regression result"),
    verbatimTextOutput("fitSum")
  )
))