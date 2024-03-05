#' Yes/No to logical
#'
#' @description
#' Convert yes/no variables in a dataframe to logical. Uppercase, lowercase or
#' mixed case yes or no responses are recognized.
#'
#' @param x A dataframe.
#'
#' @return A dataframe with variables character "yes/no" variables convert to
#'   logicals.
#' @export
#'
#' @examples
#' # example data
#' (x <- data.frame(var1 = c("Yes", "NO", "N"),
#'                  var2 = c("sometimes", "rarely", "never"),
#'                  var3 = c("No", "no", "n")) )
#'
#' # variable classes
#' sapply(x, class)
#'
#' # convert yes/no variables
#' (x <- yesno_to_logical(x))
#'
#' # new variable classes
#' sapply(x, class)
yesno_to_logical <- function(x){
  vars <- abctools::id_yesno_vars(x)
  x |>
    dplyr::mutate(dplyr::across(dplyr::all_of(vars),
                                ~dplyr::case_match(.x,
                                                   c("Yes", "YES", "yes", "Y", "y") ~ TRUE,
                                                   c("No", "NO", "no", "N", "n") ~ FALSE))
    )
}
