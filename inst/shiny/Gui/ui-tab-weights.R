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
           strong("*How is the best weighting factor selected?"),
           br(),
           p("(a)", span("If the data are homoscedastic,", style = "color:#f15c42"), "weighting factor = 1 (1/x^0, unweight linear regression) is suggested."),
           p("(b)", span("If the data are heteroscedastic,", style = "color:#f15c42"), "five commonly used weighting factors, i.e., 1/x^0, 1/x, 1/x^2, 1/y and 1/y^2,
             together with user-defined weighting factors (if present) are tested. By applying regression with different weighting
             factors on a set of calibration curve standard data, the best weighting factor is identified by choosing the
             one generating the smallest sum of the absolute relative errors (sum%RE)."),
           strong("*Instruction"),
           br(),
           p("1. The results are displayed for each compound, you can select the compound name in", strong("View Result"), "tab to check
             the corresponding result."),
           p("2. Additionally, you can define and test your own preferred weighting factors in", strong("Add your own weights"), "tab (e.g., 1/x^3).
             Don't worry if you input some wrong weighting schemes. CCWeights knows how to skip them."),
           p("3. Two types of results are given here. One is a summerized table, which contains the evaluation results of each model, and
             the suggested model. The residual and linear regression plots for each model are also provided here to allow the user
             to interactively visulize the results."),
           p("4. You can download the figures of interest in", span("svg", style = "color:#f15c42"), "format by clicking the", span("Camera", style = "color:#f15c42"), "icon (download plot) in the figure."),
           p("5. You can click", strong('+'), "and", strong('-'), "in the tab to show or hide the contents in the tab.")
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
