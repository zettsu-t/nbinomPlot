source("test-helpers.R")

test_that("mod_nbinom_ui", {
  testthat::expect_snapshot(mod_nbinom_ui("nbplot"))
})

test_that("mod_nbinom_server", {
  testServer(mod_nbinom_server, args = list(
    nbinom_dist = NbinomDist$new(size = 4.0, prob = 0.25),
    default_max_nbinom_size = 10
  ), {
    gargoyle::init("render_plot")
    session$setInputs(size = "6.0")
    session$setInputs(prob = "0.75")
    session$setInputs(quantile = "0.999")
    session$flushReact()
    gargoyle::trigger("render_plot")

    image_data <- output$plot$src
    expect_true(stringr::str_starts(image_data, "data:image\\/png;"))
    download_filename <- output$download
    expect_true(stringr::str_ends(download_filename, "dist\\.csv"))
  })
})
