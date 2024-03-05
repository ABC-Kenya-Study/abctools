#' Active smoker
#'
#' @description
#' Function to identify participants as active smokers or not. The following
#' logic applies to indicate an active smoker:
#'
#' lbt_smoke_cig: TRUE
#'
#' lbt_smoke_marij: TRUE
#'
#' pg_exp_cig: equal to a value in freq_factor$yes
#'
#' pg_exp_marij: equal to a value in freq_factor$yes
#'
#' @param x A dataframe containing variables: lbt_smoke_cig, lbt_smoke_marij,
#'   pg_exp_cig and pg_exp_marij.
#' @param freq_factor A named list containing elements "yes" and "no", which
#' contain character vectors to define categories. For example:
#' list(no = c('Not at all', 'Rarely'), yes = c('Some days', 'Most days', 'Daily'))
#'
#' @return A dataframe containing the new logical variable "calc_active_smoker".
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
#'                  lbt_smoke_cig = c(FALSE, TRUE, FALSE),
#'                  lbt_smoke_marij = c(FALSE, FALSE, FALSE),
#'                  pg_exp_cig = c(rep('Not at all', 3)),
#'                  pg_exp_marij = c(FALSE, FALSE, 'Some days')) )
#'
#' # assess active smoking
#' active_smoker(x, smoke_factor)
active_smoker <- function(x, freq_factor){
  # check all variables present
  if(!all( c("lbt_smoke_cig", "lbt_smoke_marij", "pg_exp_cig", "pg_exp_marij") %in% names(x) )){
    stop("Input dataframe must contain all of the following variables: lbt_smoke_cig, lbt_smoke_marij, pg_exp_cig, pg_exp_marij")
  }

  x |>
    dplyr::rowwise() |>
    dplyr::mutate(calc_active_smoker = dplyr::if_else(any(isTRUE(.data$lbt_smoke_cig),
                                        isTRUE(.data$lbt_smoke_marij),
                                        .data$pg_exp_cig %in% freq_factor$yes,
                                        .data$pg_exp_marij %in% freq_factor$yes),
                                        true = TRUE, false = FALSE) ) |>
    dplyr::ungroup()
}
