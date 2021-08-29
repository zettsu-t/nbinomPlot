#' Calculate the mu of a negative binomial distribution from its size and prob parameters
#'
#' @param size The size parameter of a negative binomial distribution
#' @param prob The prob parameter of a negative binomial distribution
#' @return The mu based ont the input size and prob
calculate_nbinom_mu_from_size_prob <- function(size, prob) {
  size * (1 - prob) / prob
}

#' Calculate the size of a negative binomial distribution from its prob and mu parameters
#'
#' @param prob The prob parameter of a negative binomial distribution
#' @param mu The mu parameter of a negative binomial distribution
#' @return The size based on the input prob and mu
calculate_nbinom_size_from_prob_mu <- function(prob, mu) {
  mu * prob / (1 - prob)
}

#' Calculate densities of a negative binomial distribution
#'
#' @param size The size parameter of a negative binomial distribution
#' @param prob The prob parameter of a negative binomial distribution
#' @param lower_quantile Coverage of quantile of a distribution
#' @return A data frame of the densities of the negative binomial distribution
calculate_nbinom_density <- function(size, prob, lower_quantile) {
  limit <- stats::qnbinom(lower_quantile, size, prob)
  xs <- seq(from = 0, to = limit, by = 1)
  ys <- stats::dnbinom(xs, size = size, prob = prob)
  tibble::tibble(x = xs, density = ys)
}

#' Draw a density plot of a negative binomial distribution
#'
#' @param size The size parameter of a negative binomial distribution
#' @param prob The prob parameter of a negative binomial distribution
#' @param lower_quantile Coverage of quantile of a distribution
#' @return A drawable object to pass to plot()
#' @importFrom rlang .data
draw_nbinom_density <- function(size, prob, lower_quantile) {
  df <- calculate_nbinom_density(size, prob, lower_quantile)
  g <- ggplot2::ggplot(df)
  g <- g + ggplot2::geom_line(ggplot2::aes(x = .data$x, y = .data$density))
  g
}

#' Calculate densities of a negative binomial distribution
#'
#' @param size The size parameter of a negative binomial distribution
#' @param prob The prob parameter of a negative binomial distribution
#' @param lower_quantile Coverage of quantile of a distribution
#' @return A data frame of the densities of the negative binomial distribution
get_nbinom_density_dataframe <- function(size, prob, lower_quantile) {
  ## Share with draw_nbinom_density()
  calculate_nbinom_density(size, prob, lower_quantile)
}

#' Get the default size parameter of negative binomial distributions
#'
#' @return The initial size parameter
get_default_nbinom_size <- function() {
  1.0
}

#' Get the default prob parameter of negative binomial distributions
#'
#' @return The default prob parameter
get_default_nbinom_prob <- function() {
  0.5
}

#' R6 Class representing a negative binomial distribution
#'
#' @description A negative binomial distribution has size and prob parameters.
NbinomDist <- R6::R6Class("NbinomDist",
  public = list(
    #' @description Initialize and set default parameters
    #'
    #' @param size The size parameter whicn must be a positive number
    #' @param prob The prob parameter which must be positive and lower than 1.0
    initialize = function(size, prob) {
      initial_size <- ifelse(private$is_valid_size(size), size, get_default_nbinom_size())
      initial_prob <- ifelse(private$is_valid_prob(prob), prob, get_default_nbinom_prob())
      private$initial_size <- initial_size
      private$initial_prob <- initial_prob
      private$size <- initial_size
      private$prob <- initial_prob
    },

    #' @description Set the size parameter of this negative binomial distribution
    #'
    #' @param size The size parameter whicn must be a positive number
    set_size = function(size) {
      if (private$is_valid_size(size)) {
        private$size <- size
      }
    },

    #' @description Set the prob parameter of this negative binomial distribution
    #'
    #' @param prob The prob parameter which must be positive and lower than 1.0
    set_prob = function(prob) {
      if (private$is_valid_prob(prob)) {
        private$prob <- prob
      }
    },

    #' @description Set the mu parameter of this negative binomial distribution
    #'
    #' @param mu The mu parameter which must be a positive number.
    set_mu = function(mu) {
      if (is_numeric(mu) && (mu > 0)) {
        private$size <- calculate_nbinom_size_from_prob_mu(private$prob, mu)
      }
    },

    #' @description Get the size parameter of this negative binomial distribution
    #'
    #' @return The size parameter
    get_size = function() {
      private$size
    },

    #' @description Get the prob parameter of this negative binomial distribution
    #'
    #' @return The prob parameter
    get_prob = function() {
      private$prob
    },

    #' @description Get the mu parameter of this negative binomial distribution
    #'
    #' @return The mu parameter. This is derived from the size and prob parameters and may slightly different from the value set in set_mu(mu)
    get_mu = function() {
      calculate_nbinom_mu_from_size_prob(private$size, private$prob)
    },

    #' @description Reset parameters
    #'
    reset = function() {
      private$size <- private$initial_size
      private$prob <- private$initial_prob
    },

    #' @description Draw a density plot of this negative binomial distribution
    #'
    #' @param lower_quantile Coverage of quantile of this distribution
    #' @return A drawable object to pass to plot()
    draw = function(lower_quantile) {
      draw_nbinom_density(private$size, private$prob, lower_quantile = lower_quantile)
    },

    #' @description Get a data frame to plot
    #'
    #' @return A data frame to plot
    get_dataframe = function(lower_quantile) {
      get_nbinom_density_dataframe(private$size, private$prob, lower_quantile = lower_quantile)
    }
  ),
  private = list(
    # The initial size parameter of this negative binomial distribution
    initial_size = NA,

    # The initial prob parameter of this negative binomial distribution
    initial_prob = NA,

    # The size parameter of this negative binomial distribution
    size = NA,

    # The prob parameter of this negative binomial distribution
    prob = NA,

    # Check if a size is valid
    is_valid_size = function(x) {
      is_numeric(x) && (x > 0)
    },

    # Check if a prob is valid
    is_valid_prob = function(x) {
      is_numeric(x) && ((x > 0) & (x < 1.0))
    }
  )
)

#' Read parameters from the config file
#'
#' @return A parameter set
read_config_parameters <- function() {
  size_initial <- as.numeric(get_golem_config("initial_size"))
  prob_initial <- as.numeric(get_golem_config("initial_prob"))
  default_max_nbinom_size <- as.numeric(get_golem_config("default_max_nbinom_size"))

  stopifnot(is_numeric(size_initial))
  stopifnot(is_numeric(prob_initial))
  stopifnot(is_numeric(default_max_nbinom_size))
  stopifnot(default_max_nbinom_size >= 2)

  list(
    size_initial = size_initial, prob_initial = prob_initial,
    default_max_nbinom_size = default_max_nbinom_size
  )
}
