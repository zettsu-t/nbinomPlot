#' nbinom UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_nbinom_ui <- function(id) {
  shiny::fluidPage(
    shinyjs::useShinyjs(),
    shiny::titlePanel("Negative Binomial Distribution"),
    shiny::sidebarLayout(
      mod_params_ui("nbplot"),
      shiny::mainPanel(mod_main_panel_ui("nbplot"))
    )
  )
}

#' nbinom Server Functions
#'
#' @noRd
mod_nbinom_server <- function(id, nbinom_dist, default_max_nbinom_size) {
  mod_params_server("nbplot", nbinom_dist, default_max_nbinom_size)
  mod_main_panel_server("nbplot",
    nbinom_dist = nbinom_dist,
    default_max_nbinom_size = default_max_nbinom_size
  )
}
