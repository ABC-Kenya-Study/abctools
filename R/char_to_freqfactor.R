#' Convert character variables to frequency factors
#'
#' @description
#' Convert character variables in a dataframe to frequency factors with given a
#' defined set of values.
#'
#'
#' @param x A data frame.
#' @param factor_levels A (character) vector of frequency factors.
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' # specify frequency factor categories
#' (ff <- c('Not at all', 'Rarely', 'Some days', 'Most days', 'Daily'))
#'
#' # example data
#' (x <- data.frame(var1 = 1:3,
#'                  var2 = c("Rarely", "Daily", NA),
#'                  var3 = rep(NA, 3)))
#'
#' # original classes
#' sapply(x, class)
#'
#' # use function
#' (x <- char_to_freqfactor(x, ff))
#'
#' # new classes
#' sapply(x, class)
char_to_freqfactor <- function(x, factor_levels){
  vars <- abctools::id_freq_factor_vars(x, factor_levels = unlist(factor_levels))
  x |>
    dplyr::mutate(dplyr::across(tidyselect::all_of(vars),
                                ~factor(.x, levels = unlist(factor_levels))) )

}
