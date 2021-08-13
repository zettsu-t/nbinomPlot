#' reset UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_reset_ui <- function(id) {
  tagList(
    shiny::actionButton(shiny::NS(id, "reset"), "Reset parameters")
  )
}

#' reset Server Functions
#'
#' @noRd
mod_reset_server <- function(id) {
  moduleServer(id, function(input, output, session) {
  })
}
