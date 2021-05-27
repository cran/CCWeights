#### load Data
userInput <- reactive({

  if(input$example_data == "yes") {

    if(input$example_dataset == "std"){
      target <- CCWeights::expData$STD
    } else{
      target <- CCWeights::expData$noSTD
    }
    return(target)
  }

  else if (input$example_data == "umd") {

    infile <- input$target

    if (is.null(infile)){
      return(NULL)
    }

    else {

      extension <- tools::file_ext(infile$name)
      filepath <- infile$datapath
      target = switch(extension,
                      csv = readr::read_csv(filepath),
                      xls = readxl::read_xls(filepath),
                      xlsx = readxl::read_xlsx(filepath)
      )

      # Assign the compound name if it is not specified
      if (is.null(target$Compound)) {target$Compound = "X"}
      return(as.data.frame(target))
    }
  }
})


observeEvent(input$upload_data, {

  output$rawData <- DT::renderDataTable({

    shiny::validate(need(all(c("Concentration", "Response") %in% colnames(userInput())),
                         "You data should contain at least 'Concentration' and 'Response' columns"))

    datatable(userInput(),
              class = 'cell-border stripe',
              rownames = FALSE,
              filter = "top",
              extensions = 'Buttons'
              )
    })

  output$summaryData <- DT::renderDataTable({

    shiny::validate(need(all(c("Concentration", "Response") %in% colnames(userInput())),
                         "You data should contain at least 'Concentration' and 'Response' columns"))

    # get summary
    dataSummary <- userInput() %>%
      dplyr::group_by(Compound, Concentration) %>%
      dplyr::summarise(Count = dplyr::n(), .groups = 'drop')

    datatable(dataSummary,
              options = list(ordering = FALSE),
              class = 'cell-border stripe',
              rownames = FALSE,
              extensions = 'Buttons',
              editable = FALSE
              )
    })

})
