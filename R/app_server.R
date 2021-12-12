#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  gargoyle::init("render_plot", "update_params", "update_size", "update_mu")

  config <- read_config_parameters()
  nbinom_dist <- NbinomDist$new(size = config$size_initial, prob = config$prob_initial,
                                tick_per_one = config$tick_per_one)
  mod_nbinom_server("nbplot",
    nbinom_dist = nbinom_dist,
    default_max_nbinom_size = config$default_max_nbinom_size
  )
}
