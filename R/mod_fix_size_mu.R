#' fix_size_mu UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_fix_size_mu_ui <- function(id) {
  tagList(
    radioButtons(shiny::NS(id, "fix"),
      label = "Fix", choices = c("size", "mu"), selected = "size"
    )
  )
}

#' fix_size_mu Server Functions
#'
#' @noRd
mod_fix_size_mu_server <- function(id) {
  moduleServer(id, function(input, output, session) {
  })
}
