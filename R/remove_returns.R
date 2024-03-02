#' Remove returns
#'
#' @description
#' Searches through variables of a dataframe and removes carriage returns in
#' free text.
#'
#' @param x A dataframe.
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' (x <- data.frame(var1 = "line1\r\nline2", var2 = 2) )
#' remove_returns(x)
remove_returns <- function(x){
  char_cols <- sapply(x, is.character)
  char_cols <- char_cols[char_cols == TRUE] |> names()

  dplyr::mutate(x, dplyr::across(tidyselect::all_of(char_cols),
                          ~stringr::str_replace_all(.x, "[\r\n]" , " ")))
}
