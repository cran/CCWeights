shinyServer(function(input, output, session) {
  options(shiny.maxRequestSize = 100 * 1024^2) ## file size limit: 100MB
  source("server-inputdata.R",local = TRUE)
  source("server-homoscedasticity.R",local = TRUE)
  source("server-weights.R",local = TRUE)
  source("server-calibration.R",local = TRUE)
  }
)

