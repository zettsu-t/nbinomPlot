test_that("mod_nbinom_ui", {
  testthat::expect_snapshot(mod_nbinom_ui("nbplot"))
})

testServer(mod_nbinom_server,
  args = list(
    nbinom_dist = NbinomDist$new(size = 4.0, prob = 0.25),
    default_max_nbinom_size = 10
  ),
  {
  }
)
