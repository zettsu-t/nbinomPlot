test_that("mod_size_var_ui", {
  testthat::expect_snapshot(mod_size_var_ui("nbplot"))
})

testServer(mod_size_var_server, {
})
