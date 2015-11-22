library(UsingR)

library(quantmod)
library(tseries)
library(ggplot2)

#quantstrat

#^FCHI cac code
#FP.PA Total

getSymbols("^FCHI")

shinyServer(
  function(input, output) {

    output$plotStock <- renderPlot({
      getSymbols(input$stock)
      range <- paste0(input$daterange[1], "::", input$daterange[2])
      Stockclose <<- get(input$stock)[, grep("Close",names(get(input$stock)))][range]
      chartSeries(Stockclose, theme = chartTheme("white"), TA = NULL, name = "Selected Stock")
    })
   
    output$plotCAC <- renderPlot({
      range <- paste0(input$daterange[1], "::", input$daterange[2])
      CACclose <<- FCHI$FCHI.Close[range]
      chartSeries(CACclose, theme = chartTheme("white"), TA = NULL, name = "CAC 40")
    })

    observeEvent(c(input$stock, input$daterange),{
      
      output$plotReg <- renderPlot({

        CACreturn <<- Delt(CACclose)[-1]
        Stockreturn <<- Delt(Stockclose)[time(CACreturn)]
        qplot(x = as.numeric(CACreturn), y = as.numeric(Stockreturn), 
            geom = c("point","smooth"), method = "lm", 
            xlab  = "CAC return", ylab = paste0("Stock return ",input$stock))
      
      })

      output$fitSum <- renderPrint({     
       summary(lm(Stockreturn~CACreturn))
      })
    
    })

  }
)