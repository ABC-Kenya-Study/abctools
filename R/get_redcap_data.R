#' Get ABC data from REDCap with API token
#'
#'@description
#'A wrapper function for `REDCapR::redcap_read_oneshot()` that simplifies
#'obtaining ABC data from REDCap.
#'
#' @param token A character vector containing the API token.
#' @param token_path A file path to the .R file containing the API token.
#' @param ... optional arguments passed to `REDCapR::redcap_read_oneshot()`.
#'
#' @return A dataframe (tibble) containing ABC data from REDCap.
#' @export
#'
#' @examples
#' # path to .R script containing ABC API token
#' tp <- file.path(Sys.getenv("R_USER"), "R", "access_tokens", "abc_token.R")
#'
#' # collect REDCap data
#' get_redcap_data(token_path = tp)
get_redcap_data <- function(token = NULL,
                            token_path = NULL,
                            ...){

  # argument checks
  if(all(is.null(token), is.null(token_path))){
    stop("must provide 'token' or 'token_path'")
  }

  # collect dots
  dots <- list(...)
  if(is.null(dots$raw_or_label)){ dots$raw_or_label <- "label" }
  if(is.null(dots$export_checkbox_label)){ dots$export_checkbox_label <- TRUE }

  # if token path provided
  if(!is.null(token_path) & is.null(token)){
    token <- source(token_path, local = TRUE)$value
  }

  # collect data from redcap
  REDCapR::redcap_read_oneshot(redcap_uri = "https://redcap.iths.org/api/",
                               token = token,
                               raw_or_label = dots$raw_or_label,
                               export_checkbox_label = dots$export_checkbox_label
                               ) |>
    purrr::pluck("data") |>
    tibble::as_tibble() |>
    suppressWarnings()
}
