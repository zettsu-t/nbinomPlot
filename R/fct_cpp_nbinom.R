#' Calculate densities of a negative binomial distribution in C++
#'
#' @param size The size parameter of a negative binomial distribution
#' @param prob The prob parameter of a negative binomial distribution
#' @param lower_quantile Coverage of quantile of a distribution
#' @param step The step of vector of quantiles
#' @return A data frame of the densities of the negative binomial distribution
#' @useDynLib nbinomPlot, .registration=TRUE
#' @importFrom Rcpp sourceCpp
calculate_nbinom_density_cpp <- function(size, prob, lower_quantile, step) {
  limit <- stats::qnbinom(lower_quantile, size, prob)
  xs <- seq(from = 0, to = limit, by = step)
  ys <- get_nbinom_pdf(size, prob, xs)
  tibble::tibble(x = xs, density = ys)
}
