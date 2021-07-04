test_that("app_sys", {
  expect_true(stringr::str_detect(app_sys("golem-config.yml"), "golem\\-config.yml"))
})

test_that("get_golem_config", {
  tolerance <- 1e-7
  actual_nb <- get_golem_config("initial_size")
  expect_type(actual_nb, "double")
  expect_true(actual_nb > 0)

  actual_prob <- get_golem_config("initial_prob")
  expect_type(actual_prob, "double")
  expect_true(actual_prob > 0.0)
  expect_true(actual_prob < 1.0)

  actual_default_max_nbinom_size <- get_golem_config("default_max_nbinom_size")
  expect_type(actual_default_max_nbinom_size, "integer")
  expect_true(actual_default_max_nbinom_size > 0)
})
