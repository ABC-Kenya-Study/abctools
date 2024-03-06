#' ETS exposed
#'
#' @description
#' Environmental tobacco smoke exposed.
#'
#' @param x A dataframe containing lbt_closetosmokers, en_peoplesmoking,
#' en_ind_cig, en_ind_marig, en_wrk_cig, and en_wrk_marij variables.
#' @param freq_factor A named list containing elements "yes" and "no", which
#' contain character vectors to define categories. For example:
#' list(no = c('Not at all', 'Rarely'), yes = c('Some days', 'Most days', 'Daily'))
#'
#' @return A dataframe containing the new categorical variable
#'   "calc_ets_exposed" with values: No, Yes and Unknown.
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
#'                  lbt_closetosmokers = c("I don't know", "No", "Yes"),
#'                  en_peoplesmoking = c(0, 0, 1),
#'                  en_ind_cig = c(rep('Not at all', 3)),
#'                  en_ind_marig = c("Not at all", "Not at all", 'Some days'),
#'                  en_wrk_cig = c("Sometimes", "Not at all", "Not at all"),
#'                  en_wrk_marij = c(rep('Not at all', 3))) )
#'
#' # assess ETS exposure
#' ets_exposed(x, smoke_factor)
ets_exposed <- function(x, freq_factor){

  # check for required variables
  var_names <- c("lbt_closetosmokers", "en_peoplesmoking", "en_ind_cig",
                 "en_ind_marig", "en_wrk_cig", "en_wrk_marij")

  if (!all(var_names %in% names(x))) {
    stop("Input dataframe must contain all of the following variables:
         lbt_closetosmokers, en_peoplesmoking, en_ind_cig, en_ind_marig,
         en_wrk_cig, and en_wrk_marij.")
  }

  x |>
    dplyr::rowwise() |>
    dplyr::mutate(calc_ets_exposed = dplyr::case_when(
      any(
        .data$lbt_closetosmokers == 'Yes',
        .data$en_peoplesmoking >= 1,
        .data$en_ind_cig %in% freq_factor$yes,
        .data$en_ind_marig %in% freq_factor$yes,
        .data$en_wrk_cig %in% freq_factor$yes,
        .data$en_wrk_marij %in% freq_factor$yes
        ) ~ 'Yes',
      all(
        .data$lbt_closetosmokers == 'No',
        .data$en_peoplesmoking == 0,
        .data$en_ind_cig %in% freq_factor$no,
        .data$en_ind_marig %in% freq_factor$no,
        .data$en_wrk_cig %in% freq_factor$no,
        .data$en_wrk_marij %in% freq_factor$no
        ) ~ 'No',
      .data$lbt_closetosmokers == "I don't know" ~ 'Unknown'
    )) |>
    dplyr::ungroup() |>
    dplyr::mutate(calc_ets_exposed = factor(.data$calc_ets_exposed,
                                            levels = c("No", "Yes", "Unknown")))
}
