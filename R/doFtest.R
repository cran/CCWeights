#' @title Perform F Test
#' @description perform F test to evaluate homoscedasticity.
#' @author Yonghui Dong
#' @param DF data frame, it must contain a column named 'Concentration' and a column named 'Response'
#' @param p p-value
#' @param lower.tail default is FALSE
#' @importFrom stats qf var
#' @importFrom magrittr %>%
#' @export
#' @return dataframe, F test result
#' @examples
#' Concentration <- rep(c(10, 50, 100, 500), each = 3)
#' Response <- c(133, 156, 177, 1300, 1450, 1600, 4000, 3881, 3700, 140000, 139000, 140000)
#' DF <- cbind.data.frame(Concentration, Response)
#' result <- doFtest(DF, p = 0.01)

doFtest <- function(DF, p = 0.01, lower.tail = FALSE){

  ## suppress the warning: no visible binding for global variable ‘Concentration’ and 'Compound'
  Concentration <- Compound <- NULL
  # calculate IS normalized peak areas if IS are used
  if (is.null(DF$IS)) {
    DF$Ratio = DF$Response
  } else {
    DF$Ratio = DF$Response/DF$IS
  }

  # Assign the compound name if it is not specified
  if (is.null(DF$Compound)) {DF$Compound = "X"}

  # remove samples, keep only STD
  DF <- DF %>%
    dplyr::filter(Concentration != 'unknown') %>%
    dplyr::mutate(Concentration = as.numeric(Concentration))

  # test homoscedasticity per compound
  DF$Compound <- as.factor(DF$Compound)
  n = length(levels(DF$Compound))
  myTest <- setNames(data.frame(matrix(ncol = 4, nrow = n)), c("Compound", "Experimental_F-value", "Critical_F-Value", "Homoscedasticity"))

  for (i in 1:n){
    minCon <- DF %>%
      dplyr::filter(Compound == levels(DF$Compound)[i]) %>%
      dplyr::slice_min(order_by = Concentration)
    maxCon <- DF %>%
      dplyr::filter(Compound == levels(DF$Compound)[i]) %>%
      dplyr::slice_max(order_by = Concentration)

    ## Skip F test if there are no replicates
    if(nrow(minCon) > 1 & nrow(maxCon) > 1){
      varMin <- var(minCon$Ratio)
      nMin <- dim(minCon)[1] - 1
      varMax <- var(maxCon$Ratio)
      nMax <- dim(maxCon)[1] -1
      fExp <- round(varMax/varMin, 3)
      fTab <- round(qf(p = p, df1 = nMax, df2 = nMin, lower.tail = lower.tail), 3)
      myTest[i, "Compound"] <- levels(DF$Compound)[i]
      myTest[i, "Experimental_F-value"] <- fExp
      myTest[i, "Critical_F-Value"] <- fTab
      if (fExp > fTab) {
        myTest[i, "Homoscedasticity"] <- "No"
        } else {
        myTest[i, "Homoscedasticity"] <- "Yes"
        }
    } else {
      myTest[i, "Compound"] <- levels(DF$Compound)[i]
      myTest[i, "Experimental_F-value"] <- "unknown: no replicates"
      myTest[i, "Critical_F-Value"] <- "unknown: no replicates"
      myTest[i, "Homoscedasticity"] <- "unknown"
      }

  }
  return(myTest)
}
