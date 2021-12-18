Sys.setlocale("LC_ALL", "C")
options(future.globals.onMissing = "ignore")

test_that("App", {
  skip_if_not(interactive())

  # Set tick_per_one to 1
  Sys.setenv(GOLEM_CONFIG_ACTIVE = "test_r_nbinom")

  app <- shinytest::ShinyDriver$new(run_app())
  app$waitForShiny()
  app$click(NS("nbplot", "update"))
  app$waitForShiny()

  path_initital_plot <- tempfile()
  path_initital_screen <- tempfile()
  app$takeScreenshot(path_initital_plot, NS("nbplot", "plot"))
  expect_snapshot_file(path_initital_plot, "screenshots/initital_plot.png")
  app$takeScreenshot(path_initital_screen)
  expect_snapshot_file(path_initital_screen, "screenshots/initital_screen.png")

  tolerance <- 1e-7
  size_first <- 6.0
  prob_first <- 0.75
  mu_first <- 2.0
  quantile_first <- 0.9999

  app$setValue(NS("nbplot", "quantile"), quantile_first)
  app$waitForShiny()
  app$setValue(NS("nbplot", "fix"), "size")
  app$waitForShiny()
  app$setValue(NS("nbplot", "size"), size_first)
  app$waitForShiny()
  app$setValue(NS("nbplot", "prob"), prob_first)
  app$waitForShiny()

  app$click(NS("nbplot", "update"))
  app$waitForShiny()

  expect_equal(
    object = app$getValue(NS("nbplot", "size")),
    expected = size_first, tolerance = tolerance
  )
  expect_equal(
    object = app$getValue(NS("nbplot", "prob")),
    expected = prob_first, tolerance = tolerance
  )
  print(app$getValue(NS("nbplot", "size")))
  expect_equal(
    object = as.numeric(app$getValue(NS("nbplot", "mu"))),
    expected = mu_first, tolerance = tolerance
  )
  expect_equal(
    object = as.numeric(app$getValue(NS("nbplot", "quantile"))),
    expected = quantile_first, tolerance = tolerance
  )

  path_first_plot <- tempfile()
  path_first_screen <- tempfile()
  app$takeScreenshot(path_first_plot, NS("nbplot", "plot"))
  expect_snapshot_file(path_first_plot, "screenshots/first_plot.png")
  app$takeScreenshot(path_first_screen)
  expect_snapshot_file(path_first_screen, "screenshots/first_screen.png")

  size_updated <- 3.0
  prob_updated <- 0.25
  mu_updated <- 9.0
  quantile_updated <- 0.999

  app$setValue(NS("nbplot", "quantile"), quantile_updated)
  app$waitForShiny()
  app$setValue(NS("nbplot", "fix"), "mu")
  app$waitForShiny()
  app$setValue(NS("nbplot", "mu"), mu_updated)
  app$waitForShiny()
  app$setValue(NS("nbplot", "prob"), prob_updated)
  app$waitForShiny()

  app$click(NS("nbplot", "update"))
  app$waitForShiny()

  expect_equal(
    object = app$getValue(NS("nbplot", "size")),
    expected = size_updated, tolerance = tolerance
  )
  expect_equal(
    object = app$getValue(NS("nbplot", "prob")),
    expected = prob_updated, tolerance = tolerance
  )
  expect_equal(
    object = as.numeric(app$getValue(NS("nbplot", "mu"))),
    expected = mu_updated, tolerance = tolerance
  )
  expect_equal(
    object = as.numeric(app$getValue(NS("nbplot", "quantile"))),
    expected = quantile_updated, tolerance = tolerance
  )

  path_updated_plot <- tempfile()
  path_updated_screen <- tempfile()
  app$takeScreenshot(path_updated_plot, NS("nbplot", "plot"))
  expect_snapshot_file(path_updated_plot, "screenshots/updated_plot.png")
  app$takeScreenshot(path_updated_screen)
  expect_snapshot_file(path_updated_screen, "screenshots/updated_screen.png")

  app$click(NS("nbplot", "reset"))
  app$waitForShiny()

  size_initial <- get_golem_config("initial_size")
  prob_initial <- get_golem_config("initial_prob")
  mu_initial <- calculate_nbinom_mu_from_size_prob(size_initial, prob_initial)
  expect_equal(
    object = app$getValue(NS("nbplot", "size")),
    expected = size_initial, tolerance = tolerance
  )
  expect_equal(
    object = app$getValue(NS("nbplot", "prob")),
    expected = prob_initial, tolerance = tolerance
  )
  expect_equal(
    object = as.numeric(app$getValue(NS("nbplot", "mu"))),
    expected = mu_initial, tolerance = tolerance
  )
  expect_equal(object = app$getValue(NS("nbplot", "fix")), expected = "mu")
  expect_equal(
    object = as.numeric(app$getValue(NS("nbplot", "quantile"))),
    expected = quantile_updated, tolerance = tolerance
  )

  path_reset_plot <- tempfile()
  path_reset_screen <- tempfile()
  app$takeScreenshot(path_reset_plot, NS("nbplot", "plot"))
  expect_snapshot_file(path_reset_plot, "screenshots/reset_plot.png")
  app$takeScreenshot(path_reset_screen)
  expect_snapshot_file(path_reset_screen, "screenshots/reset_screen.png")

  app$stop()
})

compare_downloaded_file <- function(df_actual, expected, step) {
  tolerance <- 1e-7
  testthat::expect_equal(object = NROW(df_actual), NROW(expected))
  testthat::expect_equal(object = df_actual$x, expected = (0:(NROW(expected) - 1)) * step)
  testthat::expect_equal(object = df_actual$density, expected = expected, tolerance = tolerance)
}

set_and_download <- function(app, size, prob, quantile, expected, step) {
  app$setValue(NS("nbplot", "quantile"), quantile)
  app$waitForShiny()
  app$setValue(NS("nbplot", "size"), size)
  app$waitForShiny()
  app$setValue(NS("nbplot", "prob"), prob)
  app$waitForShiny()
  app$click(NS("nbplot", "update"))
  app$waitForShiny()

  suffix <- stringr::str_replace_all(paste0(size, prob, quantile), "\\D", "_")
  download_filename <- paste0("testout", suffix, ".csv")

  download_top_dir <- file.path(app$getAppDir(), "tests")
  dir.create(download_top_dir, showWarnings = FALSE)
  download_dir <- file.path(app$getAppDir(), "tests", "snapshot-current")
  dir.create(download_dir, showWarnings = FALSE)

  app$snapshotDownload(NS("nbplot", "download"), download_filename)
  actual_filename <- file.path(download_dir, download_filename)
  df_actual <- readr::read_csv(actual_filename)

  compare_downloaded_file(df_actual = df_actual, expected = expected, step = step)
}

download_without_dialog <- function(app, id) {
  xpath <- paste0("//*[@id='", id, "']")
  elements <- app$findElements(xpath = xpath)
  df <- NULL
  if (NROW(elements) == 1) {
    filename <- tempfile()
    curl::curl_download(elements[[1]]$getAttribute("href"), filename)
    df <- readr::read_csv(filename)
  }
  df
}

test_that("Download", {
  skip_if_not(interactive())

  # Set tick_per_one to 1
  Sys.setenv(GOLEM_CONFIG_ACTIVE = "test_r_nbinom")
  step <- 1.0

  app <- shinytest::ShinyDriver$new(run_app())
  app$waitForShiny()
  app$click(NS("nbplot", "update"))
  app$waitForShiny()
  app$setValue(NS("nbplot", "fix"), "size")
  app$waitForShiny()

  size_first <- 4
  prob_first <- 0.75
  quantile_first <- 0.99
  expected_first <- c(0.31640625, 0.31640625, 0.19775391, 0.09887695, 0.04325867, 0.01730347)

  set_and_download(
    app = app, size = size_first, prob = prob_first,
    quantile = quantile_first, expected = expected_first, step = step
  )
  df_actual <- download_without_dialog(app = app, id = NS("nbplot", "download"))
  compare_downloaded_file(df_actual = df_actual, expected = expected_first, step = step)

  size_second <- 8
  prob_second <- 0.85
  quantile_second <- 0.999
  expected_second <- c(
    0.272490525, 0.326988630, 0.220717325, 0.110358663,
    0.045522948, 0.016388261, 0.005326185, 0.001597855
  )
  set_and_download(
    app = app, size = size_second, prob = prob_second,
    quantile = quantile_second, expected = expected_second, step = step
  )
  df_actual <- download_without_dialog(app = app, id = NS("nbplot", "download"))
  compare_downloaded_file(df_actual = df_actual, expected = expected_second, step = step)

  app$stop()
})

test_that("AppCpp", {
  skip_if_not(interactive())

  # Set tick_per_one to more than 1
  Sys.setenv(GOLEM_CONFIG_ACTIVE = "test_cpp_nbinom")
  step <- 0.5

  app <- shinytest::ShinyDriver$new(run_app())
  app$waitForShiny()
  app$click(NS("nbplot", "update"))
  app$waitForShiny()

  path_initital_screen <- tempfile()
  app$takeScreenshot(path_initital_screen)
  expect_snapshot_file(path_initital_screen, "screenshots/initital_screen_cpp.png")

  size_first <- 4
  prob_first <- 0.75
  quantile_first <- 0.99
  expected_first <- c(
    0.31640625, 0.34606934, 0.31640625, 0.25955200,
    0.19775391, 0.14275360, 0.09887695, 0.06627846,
    0.04325867, 0.02761602, 0.01730347
  )

  set_and_download(
    app = app, size = size_first, prob = prob_first,
    quantile = quantile_first, expected = expected_first, step = step
  )
  df_actual <- download_without_dialog(app = app, id = NS("nbplot", "download"))
  compare_downloaded_file(df_actual = df_actual, expected = expected_first, step = step)

  app$stop()
})

test_that("AppCppDefault", {
  skip_if_not(interactive())
  app <- shinytest::ShinyDriver$new(run_app())
  app$waitForShiny()
  app$click(NS("nbplot", "update"))
  app$waitForShiny()

  path_initital_screen <- tempfile()
  app$takeScreenshot(path_initital_screen)
  expect_snapshot_file(path_initital_screen, "screenshots/initital_screen_cpp_default.png")
  app$stop()
})
