test_that("mod_mu_var_ui", {
  testthat::expect_snapshot(mod_mu_var_ui("nbplot"))
})

testServer(mod_mu_var_server, {
})
