fluidRow(

  column(width = 12,

         bs4Card(
           width = 12,
           title = "Instruction",
           status = "secondary",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           p("It has been suggested that a weighting factor should only be used when homoscedasticity is not met for analytical data.
             CCWeights first tests data homoscedasticity by calculating the probability that the variance of measurements at the highest
             concentration level is smaller than the variance of measurements at the lowest concentration level using an F-test."),
           p("The test of homoscedasticity is accepted when", span("Experimental F value", style = "color:#f15c42"), "is smaller than corresponding",
             span("Critical F value (or F Table value)", style = "color:#f15c42"), "at confidence of", span("99% (i.e., 1 - p-value).", style = "color:#f15c42")),
           p("1. You can customize the p-value to test the homoscedasticity of your dataset."),
           p("2. You can click", strong('+'), "and", strong('-'), "in the tab to show or hide the contents in the tab.")
           )
         ),

  column(width = 3,

         bs4Card(
           width = 12,
           inputId = "homoTest_card",
           title = "Homoscedasticity Test Parameters",
           status = "primary",
           solidHeader = FALSE,
           collapsible = FALSE,
           collapsed = FALSE,
           closable = FALSE,
           numericInput("pval_cutoff", strong("p-value threshold"), value = 0.01, min = 0, max = 1, step = 0.01),
           actionButton("homoTest", "Start Test", icon("paper-plane"),
                        style="color: #fff; background-color: #CD0000; border-color: #9E0000")
           )
         ),

  column(width = 9,

         bs4Card(
           width = 12,
           inputId = "homoResult_card",
           title = "Homoscedasticity Test Result",
           status = "secondary",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           DT::dataTableOutput("homescedasticityResult")
           )
         )
  )





