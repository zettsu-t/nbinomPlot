#' size_var UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_size_var_ui <- function(id) {
  shiny::sliderInput(shiny::NS(id, "size"), "Size Paramater",
    min = 0.2, max = 10, value = 1.0
  )
}

#' size_var Server Functions
#'
#' @noRd
mod_size_var_server <- function(id) {
  moduleServer(id, function(input, output, session) {
  })
}
