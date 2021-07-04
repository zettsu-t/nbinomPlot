#' Check a varibable is a non-NA single-element number.
#'
#' @param x a varibable to check
#'
#' @return TRUE if x is a non-NA single-element number, FALSE othewise.
is_numeric <- function(x) {
  is.vector(x) &&
    (NROW(x) == 1) &&
    is.numeric(x) &&
    !is.na(x)
}
