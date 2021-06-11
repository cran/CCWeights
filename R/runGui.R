#' @title Run CCWeights Gui
#' @description Run CCWeights Gui.
#' @author Yonghui Dong
#' @import bs4Dash fresh DT tools readxl rmarkdown readr
#' @export
#' @return Gui
#' @examples
#' if(interactive()){}

runGui <- function() {
  appDir <- system.file("shiny", "Gui", package = "CCWeights")
  if (appDir == "") {
    stop("Could not find Shiny Gui directory. Try re-installing `CCWeightd`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
