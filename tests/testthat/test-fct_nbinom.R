test_that("calculate_nbinom_mu_from_size_prob", {
  tolerance <- 1e-7
  expect_equal(object = calculate_nbinom_mu_from_size_prob(size = 1.0, prob = 0.5), expected = 1.0, tolerance = tolerance)
  expect_equal(object = calculate_nbinom_mu_from_size_prob(size = 4.0, prob = 0.25), expected = 12.0, tolerance = tolerance)
  expect_equal(object = calculate_nbinom_mu_from_size_prob(size = 6.0, prob = 0.75), expected = 2.0, tolerance = tolerance)
})

test_that("calculate_nbinom_size_from_prob_mu", {
  tolerance <- 1e-7
  expect_equal(object = calculate_nbinom_size_from_prob_mu(prob = 0.5, mu = 1.0), expected = 1.0, tolerance = tolerance)
  expect_equal(object = calculate_nbinom_size_from_prob_mu(prob = 0.25, mu = 12.0), expected = 4.0, tolerance = tolerance)
  expect_equal(object = calculate_nbinom_size_from_prob_mu(prob = 0.75, mu = 2.0), expected = 6.0, tolerance = tolerance)
})

test_that("Initialize NbinomDist and reset", {
  tolerance <- 1e-7
  size_initial <- 4.0
  prob_initial <- 0.25

  nb_dist <- NbinomDist$new(size_initial, prob_initial)
  expect_equal(object = nb_dist$get_size(), expected = size_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_initial, tolerance = tolerance)

  size_updated <- size_initial * 2
  prob_updated <- prob_initial * prob_initial
  nb_dist$set_size(size = size_updated)
  nb_dist$set_prob(prob = prob_updated)

  nb_dist$reset()
  expect_equal(object = nb_dist$get_size(), expected = size_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_initial, tolerance = tolerance)
})

test_that("Initialize NbinomDist with wrong parameters", {
  tolerance <- 1e-7
  size_initial <- get_default_nbinom_size()
  prob_initial <- get_default_nbinom_prob()

  nb_dist <- NbinomDist$new(NA, NA)
  expect_equal(object = nb_dist$get_size(), expected = size_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_initial, tolerance = tolerance)
})

test_that("NbinomDist set and update the size parameter", {
  tolerance <- 1e-7
  size_initial <- 1.0
  prob_initial <- 0.5
  mu_initial <- 1.0

  nb_dist <- NbinomDist$new(size_initial, prob_initial)
  expect_equal(object = nb_dist$get_size(), expected = size_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_mu(), expected = mu_initial, tolerance = tolerance)

  size_updated <- 4.0
  prob_updated <- 0.25
  mu_updated <- 12.0
  nb_dist$set_size(size = size_updated)
  expect_equal(object = nb_dist$get_size(), expected = size_updated, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_initial, tolerance = tolerance)

  nb_dist$set_prob(prob = prob_updated)
  expect_equal(object = nb_dist$get_size(), expected = size_updated, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_updated, tolerance = tolerance)
  expect_equal(object = nb_dist$get_mu(), expected = mu_updated, tolerance = tolerance)
})

test_that("NbinomDist set and update the mu parameter", {
  tolerance <- 1e-7
  size_initial <- 1.0
  prob_initial <- 0.5
  mu_initial <- 1.0

  nb_dist <- NbinomDist$new(size_initial, prob_initial)
  prob_updated <- 0.75
  mu_updated <- 2.0
  size_updated <- 6.0
  nb_dist$set_prob(prob = prob_updated)
  expect_equal(object = nb_dist$get_prob(), expected = prob_updated, tolerance = tolerance)
  expect_equal(object = nb_dist$get_size(), expected = size_initial, tolerance = tolerance)

  nb_dist$set_mu(mu = mu_updated)
  expect_equal(object = nb_dist$get_mu(), expected = mu_updated, tolerance = tolerance)
  expect_equal(object = nb_dist$get_size(), expected = size_updated, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_updated, tolerance = tolerance)
})

test_that("NbinomDist set invalid values", {
  tolerance <- 1e-7
  size_initial <- 1.0
  prob_initial <- 0.5
  size_updated <- 4.0
  prob_updated <- 0.25
  mu_updated <- 12.0

  nb_dist <- NbinomDist$new(size_initial, prob_initial)
  nb_dist$set_size(size = size_updated)
  nb_dist$set_prob(prob = prob_updated)
  purrr::map(list(-1, 0, NA, NULL, TRUE, "abc"), function(x) {
    nb_dist$set_size(size = x)
    expect_equal(object = nb_dist$get_size(), expected = size_updated, tolerance = tolerance)
    expect_equal(object = nb_dist$get_prob(), expected = prob_updated, tolerance = tolerance)
    expect_equal(object = nb_dist$get_mu(), expected = mu_updated, tolerance = tolerance)
  })

  purrr::map(list(-1, 0, 1, NA, NULL, TRUE, "abc"), function(x) {
    nb_dist$set_prob(prob = x)
    expect_equal(object = nb_dist$get_size(), expected = size_updated, tolerance = tolerance)
    expect_equal(object = nb_dist$get_prob(), expected = prob_updated, tolerance = tolerance)
    expect_equal(object = nb_dist$get_mu(), expected = mu_updated, tolerance = tolerance)
  })

  purrr::map(list(-1, 0, NA, NULL, TRUE, "abc"), function(x) {
    nb_dist$set_mu(mu = x)
    expect_equal(object = nb_dist$get_size(), expected = size_updated, tolerance = tolerance)
    expect_equal(object = nb_dist$get_prob(), expected = prob_updated, tolerance = tolerance)
    expect_equal(object = nb_dist$get_mu(), expected = mu_updated, tolerance = tolerance)
  })
})

test_that("NbinomDist reset and update the size parameter", {
  tolerance <- 1e-7
  size_initial <- 6.0
  prob_initial <- 0.75
  nb_dist <- NbinomDist$new(size_initial, prob_initial)
  mu_initial <- nb_dist$get_mu()

  size_updated <- size_initial * 2
  nb_dist$set_size(size = size_updated)
  expect_equal(object = nb_dist$get_size(), expected = size_updated, tolerance = tolerance)
  nb_dist$reset()
  expect_equal(object = nb_dist$get_size(), expected = size_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_mu(), expected = mu_initial, tolerance = tolerance)

  prob_updated <- prob_initial * prob_initial
  nb_dist$set_prob(prob = prob_updated)
  expect_equal(object = nb_dist$get_prob(), expected = prob_updated, tolerance = tolerance)
  nb_dist$reset()
  expect_equal(object = nb_dist$get_size(), expected = size_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_mu(), expected = mu_initial, tolerance = tolerance)

  mu_updated <- mu_initial * 2.0
  nb_dist$set_mu(mu = mu_updated)
  expect_equal(object = nb_dist$get_mu(), expected = mu_updated, tolerance = tolerance)
  nb_dist$reset()
  expect_equal(object = nb_dist$get_size(), expected = size_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_prob(), expected = prob_initial, tolerance = tolerance)
  expect_equal(object = nb_dist$get_mu(), expected = mu_initial, tolerance = tolerance)
})

test_that("draw_nbinom_density", {
  expect_s3_class(draw_nbinom_density(size = 4.0, prob = 0.25, lower_quantile = 0.999), "gg")
})

test_that("read_config_parameters", {
  config <- read_config_parameters()
  expect_true(is.list(config))
  expect_false(is.null(config$size_initial))
  expect_false(is.null(config$prob_initial))
  expect_true(is.numeric(config$size_initial))
  expect_true(is.numeric(config$prob_initial))
})
