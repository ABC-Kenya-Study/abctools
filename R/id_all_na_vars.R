#' Identify NA variables
#'
#' @description
#' Identify variables or columns that are all NA.
#'
#' @param x A dataframe.
#'
#' @return A character vector consisting of a subset of column names of `x`.
#' @export
#'
#' @examples
#' (x<- data.frame(var1 = c(1, 2, 3),
#'                 var2 = c(NA, NA, NA),
#'                 var3 = c(3, NA, 4),
#'                 var4 = c(NA, NA, NA) ) )
#' id_all_na_vars(x)
id_all_na_vars <- function(x){
  y <- sapply(x, function(x){ all(is.na(x)) })
  names(y[y==TRUE])
}
