#' Drop columns or variables that are all NA
#'
#' @param x A dataframe.
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' (x <- data.frame(a = 1:4, b = rep(NA, 4), c = 5:8, d = c(NA, 'B', 'C', 'D')))
#' drop_vars_all_na(x)
drop_vars_all_na <- function(x){
  x |> dplyr::select(tidyselect::where(~any(!is.na(.x))))
}
