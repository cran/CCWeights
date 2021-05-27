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
           p("In this section you can quantify the compounds in your samples based on the calibration curve. Although optimum weighting
             scheme has been suggested, here different weighting schemes including the user defined one if available,
             are used to quantify each compound in the sample. This allows the user to compare the results and make their final desicion."),
           p("1. You can click <Calibrate> button to perform calibration."),
           p("2. Subsequently, you can save the result by clicking the <Save Result> button.")
           )
         ),

  column(width = 3,

         bs4Card(
           width = 12,
           inputId = "caliResult_card",
           title = "Perform Calibration",
           status = "primary",
           solidHeader = FALSE,
           collapsible = FALSE,
           collapsed = FALSE,
           closable = FALSE,
           p("Perform calibration with different weights"),
           actionButton("caliDo", "Calibrate", icon("paper-plane"),
                        style="color: #fff; background-color: #CD0000; border-color: #9E0000")
         ),

         bs4Card(
           width = 12,
           inputId = "caliResult_card",
           title = "Save Calibration Result",
           status = "primary",
           solidHeader = FALSE,
           collapsible = FALSE,
           collapsed = FALSE,
           closable = FALSE,
           p("Calibration results can be downloaded in csv format"),
           shinyjs::hidden(downloadButton("caliSave", "Save Result", icon("download"),
                                          style="color: #fff; background-color: #0091ff; border-color: #0091ff"))
           )
         ),

  column(width = 9,

         bs4Card(
           width = 12,
           inputId = "homoResult_card",
           title = "Calibration Result",
           status = "secondary",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           DT::dataTableOutput("caliResult")
           )
         )
  )





