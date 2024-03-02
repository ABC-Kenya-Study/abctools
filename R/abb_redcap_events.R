#' Abbreviate REDCap event names
#'
#' @description
#' shorten "redcap_event_name" values for easier coding.
#'
#' @param x A dataframe containing variable "redcap_event_name".
#' @param long_short A character 'long' (default) or 'short' indicating whether
#'   to use long or short variable abbreviations.
#'
#' @return A dataframe with new variable "redcap_event".
#' @export
#'
#' @importFrom rlang .data
#'
#' @examples
#'(x <- data.frame(cp_ptid = c("50-22-0001-M1", "50-22-0001-B1"),
#'                  redcap_event_name = c("Enrollment (Arm 1: Mothers)",
#'                                        "Vaccination & PMTCT (Arm 2: Babies)")))
#'
#'abb_redcap_events(x)
#'abb_redcap_events(x, long_short = 'short')
abb_redcap_events <- function(x, long_short = 'long'){

  if(long_short == 'long'){
    out <- x |>
      dplyr::mutate(redcap_event = .data$redcap_event_name |>
               stringr::str_remove(' \\(.*\\)') |>
               stringr::str_remove(' 1') |>
               stringr::str_remove(' & PMTCT') |>
               stringr::str_replace_all(' ', '_') |>
               tolower() |>
               stringr::str_replace('6', 'six') |>
               stringr::str_replace('12', 'twelve') |>
               stringr::str_replace('18', 'eighteen') |>
               stringr::str_replace('24', 'twentyfour') |>
               stringr::str_replace('30', 'thirty') |>
               stringr::str_replace('36', 'thirtysix'),
             .after = .data$redcap_event_name)
  }

  if(long_short == 'short'){
    out <- x |>
      dplyr::mutate(redcap_event = dplyr::case_when(
        stringr::str_detect(.data$redcap_event_name, "6 weeks") ~ "w6",
        stringr::str_detect(.data$redcap_event_name, "6 months") ~ "m6",
        stringr::str_detect(.data$redcap_event_name, "12 months") ~ "m12",
        stringr::str_detect(.data$redcap_event_name, "18 months") ~ "m18",
        stringr::str_detect(.data$redcap_event_name, "24 months") ~ "m24",
        stringr::str_detect(.data$redcap_event_name, "30 months") ~ "m30",
        stringr::str_detect(.data$redcap_event_name, "36 months") ~ "m36",

        stringr::str_detect(.data$redcap_event_name, "Enrollment") ~ "enr",
        stringr::str_detect(.data$redcap_event_name, "Second trimester") ~ "t2",
        stringr::str_detect(.data$redcap_event_name, "Third trimester") ~ "t3",
        stringr::str_detect(.data$redcap_event_name, "Delivery") ~ "del",
        stringr::str_detect(.data$redcap_event_name, "GPS") ~ "gps",
        stringr::str_detect(.data$redcap_event_name, "Air monitoring") ~ "air",

        stringr::str_detect(.data$redcap_event_name, "Study exit") ~ "exi",
        stringr::str_detect(.data$redcap_event_name, "Vaccination") ~ "vax",
        stringr::str_detect(.data$redcap_event_name, "Mortality") ~ "mor"
      ),
      .after = .data$redcap_event_name)
  }
  return(out)
}
