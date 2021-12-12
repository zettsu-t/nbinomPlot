source("test-helpers.R")

test_that("mod_main_panel_ui", {
  testthat::expect_snapshot(mod_main_panel_ui("nbplot"))
})

test_that("mod_main_panel_server_plot", {
  testServer(mod_main_panel_server, args = list(
    nbinom_dist = NbinomDist$new(size = 4.0, prob = 0.25, tick_per_one = 1.0),
    default_max_nbinom_size = 10
  ), {
    gargoyle::init("render_plot")
    session$setInputs(quantile = "0.99")
    gargoyle::trigger("render_plot")

    image_data <- output$plot$src
    expect_true(stringr::str_starts(image_data, "data:image\\/png;"))
    image_restored <- decode_base64_png_image(image_data)
    info <- magick::image_info(image_restored)

    expect_true(info$width > 0)
    expect_true(info$height > 0)
    expect_equal(object = stringr::str_to_lower(info$format), expected = "png")
  })
})

test_that("mod_main_panel_server_download", {
  testServer(mod_main_panel_server, args = list(
    nbinom_dist = NbinomDist$new(size = 4.0, prob = 0.25, tick_per_one = 1.0),
    default_max_nbinom_size = 10
  ), {
    session$setInputs(quantile = "0.99")
    download_filename <- output$download
    expect_true(stringr::str_ends(download_filename, "dist\\.csv"))

    df <- readr::read_csv(download_filename)
    expect_true(NROW(df) > 0)
    expect_equal(object = sort(colnames(df)), expected = sort(c("x", "density")))
  })
})
