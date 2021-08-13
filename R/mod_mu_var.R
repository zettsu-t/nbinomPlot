#' mu_var UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_mu_var_ui <- function(id) {
  tagList(
    shiny::textInput(shiny::NS(id, "mu"),
      "Mu Paramater",
      value = "1.0"
    )
  )
}

#' mu_var Server Functions
#'
#' @noRd
mod_mu_var_server <- function(id) {
  moduleServer(id, function(input, output, session) {
  })
}
