#' update UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_update_ui <- function(id) {
  shiny::actionButton(NS(id, "update"), "Update parameters")
}

#' update Server Functions
#'
#' @noRd
mod_update_server <- function(id) {
  moduleServer(id, function(input, output, session) {
  })
}
