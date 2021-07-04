test_that("mod_reset_ui", {
  testthat::expect_snapshot(mod_reset_ui("nbplot"))
})

testServer(mod_reset_server, {
})
