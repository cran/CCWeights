#' @title Perform Calibration
#' @description Perform calibration
#' @author Yonghui Dong
#' @param DF data frame, it must contain a column named 'Concentration' and a column named 'Response'
#' @param weights default is NULL
#' @importFrom stats predict
#' @importFrom magrittr %>%
#' @export
#' @return dataframe, the quantification result
#' @examples
#' Concentration <- rep(c(10, 50, 100, "unknown"), each = 3)
#' Response <- c(133, 156, 177, 6650, 7800, 8850, 13300, 15600, 17700, 156, 1450, 1400)
#' DF <- cbind.data.frame(Concentration = Concentration, Response = Response)
#' result <- doCalibration(DF)


doCalibration <- function(DF, weights = NULL){

  ## suppress the warning: no visible binding for global variable ‘Concentration’
  Concentration <- NULL
  ## select only samples
  DFA <- DF %>%
    dplyr::filter(Concentration == 'unknown')

  if(nrow(DFA) > 0){

    # get ratio
    if (is.null(DFA$IS)) {
      DFA$Ratio = DFA$Response
    } else {
      DFA$Ratio = DFA$Response/DFA$IS
    }

    # get model
    model <-  if(inherits(try(doWlm(DF, weights = weights)$model, silent = TRUE), "try-error")){NULL} else {doWlm(DF, weights = weights)$model}

    # get y
    if (!is.null(model)){
      for (i in 1:dim(DFA)[1]) {
        DFA$Concentration[i] <- round((DFA$Ratio[i] - coef(model)[1])/coef(model)[2], 3)
      }
    }

    if (is.null(weights)){weights = "1"}
    DFA$Ratio <- NULL
    calResult <- cbind.data.frame(DFA, Model = weights)

  } else {

    if (is.null(weights)){weights = "1"}
    calResult <- cbind.data.frame(Sample = "No sample detected", Model = weights)
  }

  return(calResult)
}

