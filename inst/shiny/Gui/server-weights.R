#weights

observe({

  if(!is.null((userInput()))){
    x <- unique(userInput()$Compound)
    updateSelectInput(session,
                      "selected_compound",
                      choices = x,
                      selected = x[1])
  }
})


selectedDF <- reactive({
  userInput()[userInput()$Compound == input$selected_compound, ]
})


## user defined weights

userWeights <- reactive({
  if(shiny::isTruthy(input$userWeights)){
    return(input$userWeights)
  }
})

observeEvent(input$evaluate, {

  shiny::withProgress(message = 'Evaluation in progress',
                      detail = 'It may take a while...', value = 0.7,{


                        output$Weights_recommondation <- renderDataTable({

                          shiny::validate(need(nrow(selectedDF()) > 0, "No data"))
                          datatable(cbind.data.frame("p-value used" = pval_selected(),
                                                     CCWeights::doEvaluation(selectedDF(), p = pval_selected(), userWeights =  userWeights())),
                                    class = 'cell-border stripe',
                                    rownames = FALSE,
                                    options = list(scrollX = TRUE))
                        })


                        output$weightPlot1 <- renderPlotly({

                          validate(need(nrow(selectedDF()) > 0, "No data"))
                          CCWeights::doWlm(selectedDF(), weights = NULL)$figResult

                        })

                        output$weightPlot2 <- renderPlotly({

                          validate(need(nrow(selectedDF()) > 0, "No data"))
                          CCWeights::doWlm(selectedDF(), weights = "1/x")$figResult

                        })

                        output$weightPlot3 <- renderPlotly({

                          validate(need(nrow(selectedDF()) > 0, "No data"))
                          CCWeights::doWlm(selectedDF(), weights = "1/x^2")$figResult

                        })

                        output$weightPlot4 <- renderPlotly({

                          validate(need(nrow(selectedDF()) > 0, "No data"))
                          CCWeights::doWlm(selectedDF(), weights = "1/y")$figResult

                        })

                        output$weightPlot5 <- renderPlotly({

                          validate(need(nrow(selectedDF()) > 0, "No data"))
                          CCWeights::doWlm(selectedDF(), weights = "1/y^2")$figResult

                        })


                        output$weightPlot6 <- renderPlotly({

                          validate(need(!is.null(userWeights()), "No defined weights from user"))
                          validate(need(nrow(selectedDF()) > 0, "No data"))

                          ## skip the wrong input weights
                          if(inherits(try(CCWeights::doWlm(selectedDF(), weights = userWeights())$figResult, silent = TRUE), "try-error")){NULL
                          } else {
                            CCWeights::doWlm(selectedDF(), weights = userWeights())$figResult
                          }

                        })
                      })
  })







