library(tidyverse)
library(cloc)
library(rlang)

#' Extract module names from R script filenames in a golem project
# '
#' @param filenames *.R characters as filenames in a golem project
#' @return Module names of the filenames
extract_module_name <- function(filenames) {
  purrr::map_chr(filenames, function(filename) {
    x <- stringr::str_replace(filename, "\\.R.*", "")
    if (stringr::str_detect(x, "^(test\\-)?app_config")) {
      "app_config"
    } else if (stringr::str_detect(x, "^(test\\-)?fct_")) {
      "fct"
    } else if (stringr::str_detect(x, "^(test\\-)?utils_")) {
      "utils"
    } else if (stringr::str_detect(x, "^(test\\-)?mod_")) {
      stringr::str_replace_all(x, "^(test\\-)?mod_(.*)$", "\\2")
    } else if (stringr::str_detect(x, "app") | stringr::str_detect(x, "^(test\\-)")) {
      "app"
    } else {
      "others"
    }
  })
}

#' Summarize LOCs of R scripts in a golem project directory
# '
#' @param dir_name A directory in which R scripts exist
#' @param loc_name A name of the LOC column in the output
#' @param comment_name A name of the comment column in the output
#' @return A data.frame of LOCs for each module
summarize_module_loc <- function(dir_name, loc_name, comment_name) {
  cloc::cloc_by_file(dir_name) %>%
    dplyr::filter(language == "R") %>%
    dplyr::mutate(filename = stringr::str_replace_all(filename, "\\\\+", "/")) %>%
    dplyr::mutate(src = basename(filename)) %>%
    dplyr::mutate(module = extract_module_name(src)) %>%
    dplyr::select(c("module", "loc", "comment_lines")) %>%
    dplyr::group_by(module) %>%
    dplyr::summarize_all(sum) %>%
    dplyr::ungroup() %>%
    dplyr::rename(!!rlang::sym(loc_name) := loc) %>%
    dplyr::rename(!!rlang::sym(comment_name) := comment_lines) %>%
    dplyr::arrange(module)
}

#' Calculate the test-to-code ratio
# '
#' @param df A data.frame of LOCs for each module
#' @return One is the test-to-code ratio for each module in the df.
#' Another is the test-and-comment to code ratio for each module in the df.
calculate_loc_ratio <- function(df) {
  df %>%
    dplyr::mutate(loc_ratio = (impl_loc + test_loc) / impl_loc) %>%
    dplyr::mutate(ratio = (impl_loc + impl_comment + test_loc + test_comment) / impl_loc)
}

#' Summarize LOCs and the test-to-code ratio of R scripts in a golem project
#' directory on the current working directory
#' @return A list of data.frames of LOCs and their test-to-code ratios
summarize_package_loc <- function() {
  df_impl <- summarize_module_loc(dir_name = "R", loc_name = "impl_loc", comment_name = "impl_comment")
  df_test <- summarize_module_loc(dir_name = "tests/testthat", loc_name = "test_loc", comment_name = "test_comment")
  df_impl_test <- dplyr::full_join(df_impl, df_test)

  df_each <- calculate_loc_ratio(df_impl_test)
  df_all <- df_impl_test %>%
    dplyr::mutate(module = "ALL") %>%
    dplyr::group_by(module) %>%
    dplyr::summarize_all(sum) %>%
    dplyr::ungroup() %>%
    calculate_loc_ratio()

  df_summary <- dplyr::bind_rows(df_all, df_each)
  list(df_summary = df_summary, impl = df_impl, df_test = df_test, df_impl_test = df_impl_test)
}

summarize_package_loc()
