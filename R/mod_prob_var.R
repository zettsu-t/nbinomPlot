#' prob_var UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_prob_var_ui <- function(id) {
  shiny::sliderInput(shiny::NS(id, "prob"), "Prob Paramater",
    min = 0.01, max = 1.0, value = 0.5
  )
}

#' prob_var Server Functions
#'
#' @noRd
mod_prob_var_server <- function(id) {
  moduleServer(id, function(input, output, session) {
  })
}
