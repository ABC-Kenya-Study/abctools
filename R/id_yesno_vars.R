#' ID "yes/no" variables
#'
#'@description
#'Identify yes/no variables. Recognizes a variety of values, e.g.: Yes, yes,
#'YES, Y, y.
#'
#' Helpful on its own, also used in `yesno_to_logical()` function.
#'
#' @param x A dataframe.
#'
#' @return A character vector of variable names.
#' @export
#'
#' @examples
#' (x <- data.frame(var1 = c('Yes', 'yes', 'no', 'No'), var2 = 1:4, var3 = c('yes', rep(NA, 3))))
#' id_yesno_vars(x)
id_yesno_vars <- function(x){
  x <- abctools::drop_vars_all_na(x)
  lapply(x, stringr::str_detect, '^Yes$|^yes$|^YES$|^Y$|^y$|^No$|^no$|^NO$|^N$|^n$') |>
    lapply(all, na.rm = TRUE) |>
    purrr::keep(isTRUE) |>
    names()
}
