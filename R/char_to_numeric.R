#' Character to numeric
#'
#'@description
#'change variables interpreted as character variables back to numeric.
#'
#'
#' @param x A dataframe.
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' (x <- data.frame(var1 = c("a", "b", "c"),
#'                  var2 = c("01", "2,000", 3),
#'                  var3 = c(1, 2, 3)))
#'
#' # leading zeros and special characters make numbers interpreted as characters
#' sapply(x, class)
#'
#' x <- char_to_numeric(x)
#'
#' # all variables with numbers are numeric
#' sapply(x, class)
char_to_numeric <- function(x){
  vars <- sapply(x, function(y){ is.character(y) & !any(grepl("[^0-9.,]", y)) })
  vars <- vars[vars == TRUE] |>
    names() |>
    stringr::str_subset('ptid', negate = TRUE)

  dplyr::mutate(x, dplyr::across(tidyselect::all_of(vars),
                                 function(y){ y |>
                                     stringr::str_remove(',') |>
                                     as.numeric() }))
}
