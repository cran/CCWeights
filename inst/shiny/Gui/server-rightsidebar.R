RightSidebar <- reactive({
  if(is.null(prepareData()$data)){
    return(NULL)
  }
  else{
    data <- prepareData()$data
    return(data)
  }
})

## samples

output$samples_num <- renderText({

  data <- RightSidebar()

  paste0("Samples: ", length(Biobase::sampleNames(data)))

})

## features

output$features_num <- renderText({

  data <- RightSidebar()

  paste0("Features: ", length(Biobase::featureNames(data)))

})

## groups

output$groups_num <- renderText({

  data <- RightSidebar()

  paste0("Groups: ", length(table(Biobase::pData(data)[1])))

})

## covariates

output$covariates_num <- renderText({

  data <- RightSidebar()

  paste0("Covariates: ", ncol(Biobase::pData(data)) -1)

})

