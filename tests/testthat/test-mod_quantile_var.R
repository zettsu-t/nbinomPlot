test_that("mod_quantile_var_ui", {
  testthat::expect_snapshot(mod_quantile_var_ui("nbplot"))
})

testServer(mod_quantile_var_server, {
})
