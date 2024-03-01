#' Fix ID variables
#'
#' @description
#' Fix incorrectly entered participant ID variables.
#'
#'
#' @param x A dataframe containing variables with names "ptid."
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' (x <- data.frame(cp_ptid = c("50-22-0001-M1", "50-22-0002-M1", "50-22-0003-M1"),
#' gps_ptid = c("001", "0002", "50-22-0003-M1"),
#' con_ptid = c("01", 002, "0003") ))
#'
#'fix_ptid(x)
fix_ptid <- function(x){

  var_names <- names(x) |>
    stringr::str_subset('ptid') |>
    stringr::str_subset('cp_ptid', negate = TRUE)

  x |>
    dplyr::mutate(dplyr::across(tidyselect::all_of(var_names), function(y){
      y |>
        stringr::str_remove('50-22-') |>
        stringr::str_remove('-[:alpha:][:digit:]$') |>
        stringr::str_pad(4, pad = '0')
    }))
}
