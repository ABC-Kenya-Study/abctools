#' Make wide data
#'
#'@description
#'Creates a wide dataframe of one row per participant, compiling all REDCap
#'events (CRFs).
#'
#' @param x A dataframe containing a variable "redcap_event".
#'
#' @return A dataframe with one row per participant
#' @export
#'
#' @examples
#' (x <- data.frame(cp_ptid = rep(paste0("50-22-000", 1:3, "-M1"), 3),
#'                  redcap_event = c(rep("enr", 3), rep("del", 3), rep("w6", 3) ),
#'                  cp_frmcompldate = as.Date(paste("2022", "03", sample(1:30, 9), sep = "-")) ))
#'
#' wide_data(x)
wide_data <- function(x){

  if(!any(grepl('^redcap_event$', names(x)))){
    stop("input dataframe must have variable 'redcap_event', e.g., from `abb_redcap_events()`.")
  }

  # split by participant
  x <- split(x, x$cp_ptid)

  x <- lapply(x, function(y){
    # split by redcap event
    y <- split(y, y$redcap_event)

    # drop NAs from each CRF
    y <- lapply(y, abctools::drop_vars_all_na)

    # prepend CRF name to variables
    y <- lapply(y, function(z){
      purrr::set_names(z, paste(z$redcap_event, names(z), sep = '_'))
    })

    # undo for ID
    y <- lapply(y, function(z){ dplyr::select(z, cp_ptid = 1, tidyselect::everything()) })

    # join all CRFs
    y <- purrr::reduce(y, dplyr::left_join, by = 'cp_ptid')
    })

  # combine all participants
  x <- dplyr::bind_rows(x)

  # drop redcap_event columns
  x <- dplyr::select(x, -tidyselect::matches('_redcap_event$'))

  return(x)
}
