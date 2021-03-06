# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package("Rcpp")
usethis::use_package("BH")
usethis::use_package("shiny")
usethis::use_package("golem")
usethis::use_package("ggplot2")
usethis::use_package("readr")
usethis::use_package("tibble")
usethis::use_package("rlang")
usethis::use_package("R6")
usethis::use_package("gargoyle")
usethis::use_package("shinyjs")
usethis::use_package("devtools", "Suggests")
usethis::use_package("base64enc", "Suggests")
usethis::use_package("covr", "Suggests")
usethis::use_package("curl", "Suggests")
usethis::use_package("dplyr", "Suggests")
usethis::use_package("lintr", "Suggests")
usethis::use_package("magick", "Suggests")
usethis::use_package("png", "Suggests")
usethis::use_package("purrr", "Suggests")
usethis::use_package("rmarkdown", "Suggests")
usethis::use_package("shinytest", "Suggests")
usethis::use_package("stringr", "Suggests")
usethis::use_package("styler", "Suggests")

## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "nbinom") # Name of the module
golem::add_module(name = "params") # Name of the module
golem::add_module(name = "main_panel") # Name of the module
golem::add_module(name = "size_var") # Name of the module
golem::add_module(name = "prob_var") # Name of the module
golem::add_module(name = "mu_var") # Name of the module
golem::add_module(name = "fix_size_mu") # Name of the module
golem::add_module(name = "quantile_var") # Name of the module
golem::add_module(name = "update") # Name of the module
golem::add_module(name = "reset") # Name of the module

## Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct("nbinom")
golem::add_fct("cpp_nbinom")
golem::add_utils("helpers")

## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file("script")
golem::add_js_handler("handlers")
golem::add_css_file("custom")

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "my_dataset", open = FALSE)

## Tests ----
## Add one line by test you want to create
usethis::use_test("app_config")
usethis::use_test("fct_nbinom")
usethis::use_test("fct_cpp_nbinom")
usethis::use_test("utils_helpers")
usethis::use_test("app")
usethis::use_test("mod_nbinom")
usethis::use_test("mod_params")
usethis::use_test("mod_main_panel")
usethis::use_test("mod_size_var")
usethis::use_test("mod_prob_var")
usethis::use_test("mod_mu_var")
usethis::use_test("mod_fix_size_mu")
usethis::use_test("mod_quantile_var")
usethis::use_test("mod_update")
usethis::use_test("mod_reset")

# Use C++ code
usethis::use_rcpp()

# Documentation

## Vignette ----
usethis::use_vignette("nbinomPlot")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
# usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
# covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
##
## (You'll need GitHub there)
# usethis::use_github()

# GitHub Actions
# Run on a cloned working directory
# usethis::use_github_actions()

# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
# usethis::use_github_action_check_release()
# usethis::use_github_action_check_standard()
# usethis::use_github_action_check_full()
# Add action for PR
# usethis::use_github_action_pr_commands()

# Travis CI
# Use use_github_actions() instead of usethis::use_travis()
# Run on a cloned working directory
# usethis::use_travis_badge()

# AppVeyor
# usethis::use_appveyor()
# usethis::use_appveyor_badge()

# Circle CI
# usethis::use_circleci()
# usethis::use_circleci_badge()

# Jenkins
# usethis::use_jenkins()

# GitLab CI
# usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
