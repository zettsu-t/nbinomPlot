test_that("mod_update_ui", {
  testthat::expect_snapshot(mod_update_ui("nbplot"))
})

testServer(mod_update_server, {
})
