#' ID frequency factor variables
#'
#' @description
#' Identify variables that contain values specified in a character vector.
#'
#' @param x A dataframe.
#' @param factor_levels A character vector containing frequency factors.
#'
#' @return A character vector of variable names.
#' @export
#'
#' @examples
#' (x <- data.frame(var1 = c("Daily", "Rarely"), var2 = 1:2, var3 = c(NA, "Most days")))
#' id_freq_factor_vars(
#'     x = x,
#'     factor_levels = c('Not at all', 'Rarely', 'Some days', 'Most days', 'Daily')
#'     )
id_freq_factor_vars <- function(x, factor_levels){
  lapply(x, stringr::str_detect, paste(factor_levels, collapse = '|')) |>
    lapply(all, na.rm = TRUE) |>
    purrr::keep(isTRUE) |>
    names()
}
