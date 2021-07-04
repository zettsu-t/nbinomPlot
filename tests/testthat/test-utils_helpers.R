test_that("is_numeric for right inputs", {
  expect_true(is_numeric(0))
  expect_true(is_numeric(1))
  expect_true(is_numeric(0.5))
  expect_true(is_numeric(-0.5))
  expect_true(is_numeric(Inf))
})

test_that("is_numeric for non numbers", {
  expect_false(is_numeric(NULL))
  expect_false(is_numeric(NaN))
  expect_false(is_numeric(NA))
  expect_false(is_numeric(NA_integer_))
  expect_false(is_numeric(TRUE))
  expect_false(is_numeric("12"))
})

test_that("is_numeric for non-single vectors", {
  expect_false(is_numeric(c()))
  expect_false(is_numeric(c(0, 1)))
  expect_false(is_numeric(rep(0.5, 3)))
  expect_false(is_numeric(list(0.5)))
})
