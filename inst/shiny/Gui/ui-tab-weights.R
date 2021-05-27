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
           p("When the assumption of homoscedasticity is not met for analytical data, a simple and effective way to
             account for the greater influence of the greater concentrations on the fitted regression line is to
             use weighted least squares linear regression. This section tests 5 different models in order
             to help the user to choose the best weights."),
           p("1. The results are displayed for each compound, you can select the compound name in <View Result> tab to check
             the corresponding result."),
           p("2. Additionally, you can define and test your own preferred weighting factors in <Add your own weights> tab.
             Don't worry if you input some wrong weighting schemes. CCWeights knows how to skip them."),
           p("3. Two types of results are given here. One is a summerized table, which contains the evaluation results of each model, and
             the suggested model. The residual and linear regression plots for each model are also provided here to allow the user
             to interactively visulize the results."),
           p("4. You can download the figures of interest in 'svg' format by clicking the 'Camera' ion (download plot) in the figure."),
           p("5. You can click '+' and '-' in the tab to show or hide the contents in the tab.")
           )
         ),

  column(width = 3,

         bs4Card(
           width = 12,
           inputId = "weightView_card",
           title = "View Result",
           status = "primary",
           solidHeader = FALSE,
           collapsible = FALSE,
           collapsed = FALSE,
           closable = FALSE,
           selectInput("selected_compound", label = "Select compound to view:", list()),
           p("Optionally: "),
           textInput("userWeights", label = "Add your own weights"),
           actionButton("evaluate", "Evaluate", icon("paper-plane"),
                        style="color: #fff; background-color: #CD0000; border-color: #9E0000")
           )

         ),


  column(width = 9,

         bs4Card(
           width = 12,
           inputId = "weightBest",
           title = "Recommondated weights for the selected compound",
           status = "secondary",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           DT::dataTableOutput("Weights_recommondation")
           ),

         fixedRow(
           column(6,
                  box(
                    width = 12,
                    title = "Regression (red) and Residual (blue) Plots",
                    status = "secondary",
                    solidHeader = FALSE,
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    plotlyOutput("weightPlot1")
                  ),

                  box(
                    width = 12,
                    title = "Regression (red) and Residual (blue) Plots",
                    status = "secondary",
                    solidHeader = FALSE,
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    plotlyOutput("weightPlot2")
                  ),

                  box(
                    width = 12,
                    title = "Regression (red) and Residual (blue) Plots",
                    status = "secondary",
                    solidHeader = FALSE,
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    plotlyOutput("weightPlot3")
                  )

           ),

           column(6,
                  box(
                    width = 12,
                    title = "Regression (red) and Residual (blue) Plots",
                    status = "secondary",
                    solidHeader = FALSE,
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    plotlyOutput("weightPlot4")
                    ),

                  box(
                    width = 12,
                    title = "Regression (red) and Residual (blue) Plots",
                    status = "secondary",
                    solidHeader = FALSE,
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    plotlyOutput("weightPlot5")
                  ),

                  box(
                    width = 12,
                    title = "@user defined weights",
                    status = "secondary",
                    solidHeader = FALSE,
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    plotlyOutput("weightPlot6")
                  )
                  )
           )
         )
  )
