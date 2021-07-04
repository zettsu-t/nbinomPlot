Sys.setlocale("LC_ALL", "C")
options(future.globals.onMissing = "ignore")

test_that("App", {
  skip_if_not(interactive())

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
