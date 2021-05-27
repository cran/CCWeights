#' @title Run CCWeights Gui
#' @description Run CCWeights Gui.
#' @author Yonghui Dong
#' @export
#' @return Gui
#' @examples
#' if(interactive()){}


#' @export
runGui <- function() {
  appDir <- system.file("shiny", "Gui", package = "CCWeights")
  if (appDir == "") {
    stop("Could not find Shiny Gui directory. Try re-installing `CCWeightd`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
