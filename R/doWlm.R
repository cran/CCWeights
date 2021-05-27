#' @title Perform Weighted Linear Regression
#' @description Perform weighted linear regression and evaluate by using summed residual.
#' @author Yonghui Dong
#' @param DF data frame, it must contain a column named 'Concentration' and a column named 'Response'
#' @param weights the weights used in linear regression, default is NULL. User can easily define weights, e.g., "1/x", "1/x^2", "1/y"
#' @importFrom stats coef fitted lm resid setNames
#' @export
#' @return list, weighted linear regression result
#' @examples
#' Concentration <- rep(c(10, 50, 100, 500), each = 3)
#' Response <- c(133, 156, 177, 1300, 1450, 1600, 4000, 3881, 3700, 140000, 139000, 140000)
#' DF <- cbind.data.frame(Concentration = Concentration, Response = Response)
#' result <- doWlm(DF, weights = "1/x^2")

doWlm <- function(DF, weights = NULL) {

  ## suppress the warning: no visible binding for global variable ‘Concentration’ and 'Compound'
  Concentration <- NULL

  #(1) prepare the data
  # remove samples, keep only STD
  DF <- DF %>%
    dplyr::filter(Concentration != 'unknown') %>%
    dplyr::mutate(Concentration = as.numeric(Concentration))

  ## calculate IS normalized peak areas if IS are used
  if (is.null(DF$IS)) {
    DF$Ratio = DF$Response
  } else {
    DF$Ratio = DF$Response/DF$IS
  }

  # Assign the compound name if it is not specified
  if (is.null(DF$Compound)) {DF$Compound = "X"}

  x <- DF$Concentration
  y <- DF$Ratio

  if(is.null(weights)){
    models <- lm(y ~ x)
    weights = "1"
  } else {
    models <- lm(y ~ x, weights = eval(parse(text = weights)))
  }

  if(is.null(weights)){
    models <- lm(y ~ x)
    weights = "1"
  }

  #(2) residual plot
  myResid <- resid(models)
  dfResid <- cbind.data.frame(Concentration = x, RE = myResid/y * 100)

  ## H-line
  hline <- function(y = 0, color = 'rgba(1, 50, 67, 1)') {
    list(
      width = 2,
      x0 = 0,
      x1 = 1,
      xref = "paper",
      y0 = y,
      y1 = y,
      line = list(color = color)
    )
  }

  pResid <- plotly::plot_ly(dfResid,
                            x = ~ Concentration,
                            y = ~ RE,
                            type = "scatter",
                            mode = "markers") %>%
    plotly::add_markers(marker = list(size = 10,
                                      color = 'rgba(107, 185, 240, 1)',
                                      line = list(color = 'rgba(1, 50, 67, 1)', width = 2))) %>%
    plotly::layout(yaxis = list(title = "% Relative Error"),
                   shapes = list(hline(0)))

  #(3) regression plot

  ## get expression

  a = format(unname(coef(models)[1]), digits = 4)
  b = format(unname(coef(models)[2]), digits = 4)
  r2 = format(summary(models)$r.squared, digits = 4)

  ## get regression plot
  PLinear <- plotly::plot_ly(DF,
                             x = ~Concentration,
                             y = ~Ratio,
                             type = "scatter",
                             mode = "markers") %>%
    plotly::add_markers(marker = list(size = 10,
                                      color = 'rgba(255, 182, 193, .9)',
                                      line = list(color = 'rgba(152, 0, 0, .8)', width = 2))) %>%
    plotly::add_lines(x = ~ Concentration,
                      y = fitted(models),
                      line = list(width = 2, dash = "dot", color = 'rgba(152, 0, 0, .8)')) %>%
    plotly::layout(yaxis = list(title = "Reponse")) %>%
    plotly::add_annotations(x = mean(x) * 0.8, y = max(y) * 0.9,
                            text = paste("y = ", a, " + ", b, "x", " , ", "R<sup>2</sup>", " = ", r2, sep = ""),
                            showarrow = F)

  ## combine the two plots
  figResult <- plotly::subplot(PLinear, pResid, nrows = 2, shareX = T, shareY = F,
                       titleX = T, titleY = T) %>%
    plotly::layout(showlegend = F,
                   title = paste("<b>weights: </b>", weights, sep = "")) %>%
    plotly::config(
      toImageButtonOptions = list(
        format = "svg",
        filename = "myplot",
        width = 600,
        height = 700
      )
    )

  #(4) get sum residual
  sumResid <- round(sum(abs(myResid/y * 100)), 2)

  #(5) save needed results
  resultList <- list(sumResid = sumResid, figResult = figResult, R2 = r2, model = models)

  return(resultList)

  }
