#' quantile_var UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_quantile_var_ui <- function(id) {
  tagList(
    shiny::selectInput(shiny::NS(id, "quantile"), "Coverage of quantile",
      choices = c("0.99", "0.999", "0.9999", "0.99999"), selected = "0.99"
    )
  )
}

#' quantile_var Server Functions
#'
#' @noRd
mod_quantile_var_server <- function(id) {
  moduleServer(id, function(input, output, session) {
  })
}
