#' main_panel UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_main_panel_ui <- function(id) {
  tagList(
    shiny::plotOutput(shiny::NS(id, "plot"))
  )
}

#' main_panel Server Functions
#'
#' @noRd
mod_main_panel_server <- function(id, nbinom_dist, default_max_nbinom_size) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$fix, {
    })

    output$plot <- shiny::renderPlot({
      gargoyle::watch("render_plot")

      isolate(input$size)
      isolate(input$prob)
      isolate(input$mu)
      isolate(input$quantile)
      isolate(input$reset)
      isolate(input$update)
      quantile_value <- as.numeric(input$quantile)
      req(!is.na(quantile_value))

      size <- nbinom_dist$get_size()
      max_size <- ceiling(max(default_max_nbinom_size, size))
      shiny::updateTextInput(session, "mu", value = nbinom_dist$get_mu())
      shiny::updateTextInput(session, "prob", value = nbinom_dist$get_prob())
      shiny::updateSliderInput(session, "size", value = size, max = max_size)
      nbinom_dist$draw(quantile_value)
    })
  })
}
