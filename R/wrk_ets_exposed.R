#' Work ETS exposed
#'
#' @description
#' Work/occupational environmental tobacco smoke exposed.
#'
#' @param x A dataframe containing variables: en_wrk_cig and en_wrk_marij.
#' @param freq_factor A named list containing elements "yes" and "no", which
#' contain character vectors to define categories. For example:
#' list(no = c('Not at all', 'Rarely'), yes = c('Some days', 'Most days', 'Daily'))
#'
#' @return A dataframe containing the new logical variable
#'   "calc_wrk_ets_exposed."
#' @export
#'
#' @importFrom rlang .data
#'
#' @examples
#' # make frequency factor list
#' (smoke_factor <- list(no = c('Not at all', 'Rarely'),
#'                       yes = c('Some days', 'Most days', 'Daily')))
#'
#' # example data
#' (x <- data.frame(cp_ptid = paste0("50-22-000", 1:3, "-M1"),
#'                  en_wrk_cig = c("Some days", "Not at all", "Not at all"),
#'                  en_wrk_marij = c(rep('Not at all', 3))) )
#'
#' # assess ETS exposure
#' wrk_ets_exposed(x, smoke_factor)
wrk_ets_exposed <- function(x, freq_factor){
  # check all variables present
  if(!all( c("en_wrk_cig", "en_wrk_marij") %in% names(x) )){
    stop("Input dataframe must contain all of the following variables: en_wrk_cig and en_wrk_marij")
  }

  x |>
    dplyr::rowwise() |>
    dplyr::mutate(calc_wrk_ets_exposed = dplyr::case_when(
      any(.data$en_wrk_cig %in% freq_factor$yes,
          .data$en_wrk_marij %in% freq_factor$yes) ~ TRUE,
      all(.data$en_wrk_cig %in% freq_factor$no,
          .data$en_wrk_marij %in% freq_factor$no) ~ FALSE)
    ) |>
    dplyr::ungroup()
}
