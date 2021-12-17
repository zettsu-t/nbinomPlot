test_that("calculate_nbinom_density_cpp", {
  tolerance <- 1e-6
  expected <- c(
    0.56250000, 0.42187500, 0.28125000, 0.17578125, 0.10546875,
    0.06152344, 0.03515625, 0.01977539, 0.01098633
  )

  size <- 2.0
  prob <- 0.75
  step <- 0.5
  df_actual <- calculate_nbinom_density_cpp(
    size = size, prob = prob,
    lower_quantile = 0.99, step = step
  )

  expect_equal(object = NROW(df_actual), expected = NROW(expected))
  expect_equal(
    object = df_actual$x,
    expected = seq(from = 0, to = (NROW(expected) - 1) * step, by = step)
  )
  expect_equal(object = df_actual$density, expected = expected, tolerance = tolerance)

  df_integers <- df_actual %>%
    dplyr::filter(round(x) == x)

  expected <- dnbinom(df_integers$x, size = size, prob = prob)
  expect_equal(object = df_integers$density, expected = expected, tolerance = tolerance)
})
