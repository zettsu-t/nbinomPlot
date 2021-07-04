test_that("mod_params_ui", {
  testthat::expect_snapshot(mod_params_ui("nbplot"))
})

testServer(mod_params_server, {
  size_initial <- 4.0
  prob_initial <- 0.25
  mu_initial <- 12.0
  quantile_initial <- 0.99

  session$setInputs(size = size_initial)
  session$setInputs(prob = prob_initial)
  session$setInputs(mu = mu_initial)
  session$setInputs(quantile = quantile_initial)
  session$flushReact()

  actual <- session$getReturned()
  expect_equal(actual$size(), size_initial)
  expect_equal(actual$prob(), prob_initial)
  expect_equal(actual$mu(), mu_initial)
  expect_equal(actual$quantile(), quantile_initial)

  size_updated <- 6.0
  prob_updated <- 0.75
  mu_updated <- 2.0
  quantile_updated <- 0.999

  session$setInputs(size = size_updated)
  session$setInputs(prob = prob_updated)
  session$setInputs(mu = mu_updated)
  session$setInputs(quantile = quantile_updated)
  session$flushReact()

  actual <- session$getReturned()
  expect_equal(actual$size(), size_updated)
  expect_equal(actual$prob(), prob_updated)
  expect_equal(actual$mu(), mu_updated)
  expect_equal(actual$quantile(), quantile_updated)
})
