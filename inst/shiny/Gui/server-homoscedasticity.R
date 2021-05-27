# F-test Function

pval_selected <- reactive(
  return(input$pval_cutoff)
)

observeEvent(input$homoTest, {

  output$homescedasticityResult <- renderDataTable({

    validate(need(nrow(userInput()) > 0, "No data"))
    datatable(CCWeights::doFtest(DF = userInput(), p = pval_selected()),
              class = 'cell-border stripe',
              rownames = FALSE,
              options = list(scrollX = TRUE))
    })

  })
