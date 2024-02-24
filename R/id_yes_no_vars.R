#' ID "Yes/No" Variables
#'
#'@description
#'Identify variables that contain "Yes/yes" and "No/no" values.
#'
#' @param x A dataframe.
#'
#' @return A character vector of variable names.
#' @export
#'
#' @examples
#' (x <- data.frame(var1 = c('Yes', 'yes', 'no', 'No'), var2 = 1:4, var3 = c('yes', rep(NA, 3))))
#' id_yes_no_vars(x)
id_yes_no_vars <- function(x){
  lapply(x, stringr::str_detect, '^Yes$|^yes$|^No$|^no$') |>
    lapply(all, na.rm = TRUE) |>
    purrr::keep(isTRUE) |>
    names()
}
