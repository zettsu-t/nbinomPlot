#' params UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_params_ui <- function(id) {
  shiny::sidebarPanel(
    mod_size_var_ui("nbplot"),
    mod_prob_var_ui("nbplot"),
    mod_mu_var_ui("nbplot"),
    mod_fix_size_mu_ui("nbplot"),
    mod_update_ui("nbplot"),
    mod_quantile_var_ui("nbplot"),
    mod_reset_ui("nbplot")
  )
}

#' params Server Functions
#'
#' @noRd
mod_params_server <- function(id, nbinom_dist, default_max_nbinom_size) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$fix, {
    })

    observeEvent(input$reset, {
      nbinom_dist$reset()
      gargoyle::trigger("render_plot")
    })

    observeEvent(input$update, {
      req(input$size)
      req(input$prob)
      isolate(input$size)
      isolate(input$prob)
      isolate(input$mu)
      isolate(input$quantile)
      isolate(input$reset)
      isolate(input$update)

      nbinom_dist$set_prob(input$prob)
      if (input$fix == "size") {
        nbinom_dist$set_size(input$size)
      } else {
        req(input$mu)
        mu_value <- as.numeric(input$mu)
        req(!is.na(mu_value))
        nbinom_dist$set_mu(mu_value)
      }

      gargoyle::trigger("render_plot")
    })

    params <- list(
      size = shiny::reactive(input$size),
      prob = shiny::reactive(input$prob),
      mu = shiny::reactive(input$mu),
      quantile = shiny::reactive(input$quantile)
    )
    params
  })
}
