library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("CAPM Capital Asset Pricing Mode"),
  sidebarPanel(
    selectInput("stock", "Stock Name:",
                c("Total" =  "FP.PA",
                  "Societe Generale" = "GLE.PA",
                  "Renault" = "RNO.PA",
                  "EDF" = "EDF.PA")),
    dateRangeInput("daterange", "Date range:",
                   min  = "2008-01-01",
                   max    = Sys.Date()-10,
                   start = "2010-01-01",
                   end =   Sys.Date()-10,
                   format = "mm/dd/yy",
                   separator = " - "),
    submitButton('Submit')
    
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