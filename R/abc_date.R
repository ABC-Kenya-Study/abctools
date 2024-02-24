#' Make an ABC-style date
#'
#'@description
#'Creates a string following the ABC date convention to prevent any ambiguity.
#'For example: "2024_02feb_08." Accepts a variety of inputs and formats. If
#'`abc_date()` is used without any input arguments, or is missing year (y),
#'month (m), or date (d) arguments, today's date will be output (using
#'`Sys.Date()`).
#'
#'
#' @param y A year. Character or numeric, 2 or 4 digits.
#' @param m A month. Character (full name, abbreviation, or character numbers) or numeric (2 or 4 digits).
#' @param d A date. Character or numeric (2 or 4 digits or characters).
#' @param ymd A character string with format YYYY-mm-dd.
#'
#' @return A character string with format YYYY_mmbbb_dd.
#' @export
#'
#' @examples
#'abc_date()
#'abc_date(y = '2023', m = '5', d = 6)
#'abc_date(y = 23, m = 'April', d = 06)
#'abc_date(ymd = "2024-01-20")
abc_date <- function(y = NULL, m = NULL, d = NULL, ymd = NULL){

  # if YMD is present, convert
  if(!is.null(ymd)){
    out <- paste0(format(as.Date(ymd), '%Y'), '_',
                  format(as.Date(ymd), '%m'),
                  tolower(format(as.Date(ymd), '%b')), '_',
                  format(as.Date(ymd), '%d')
    )
  }

  # if any date components missing, use system date
  if((is.null(y)|is.null(m)|is.null(d)) & is.null(ymd)){
    out <- paste0(format(Sys.Date(), '%Y'), '_',
                  format(Sys.Date(), '%m'),
                  tolower(format(Sys.Date(), '%b')), '_',
                  format(Sys.Date(), '%d')
    )
  }

  # if all date components are provided, construct
  if(all(!is.null(y), !is.null(m), !is.null(d))){

    # year
    if(nchar(y) == 2) {y <- paste0('20', y)}

    # month
    if(tolower(m) %in% tolower(month.name) | tolower(m) %in% tolower(month.abb)){
      m_name <- substr(tolower(m), start = 1, stop = 3)
      m_num <- which(tolower(m) == tolower(month.name))
    } else {
      m <- as.numeric(m)
      m_name <- tolower(month.abb[m])
      m_num <- m
    }

    # build output
    out <- paste0(y, '_',
                  formatC(m_num, flag = '0', width = 2),
                  m_name, '_',
                  formatC(d, flag = '0', width = 2)
    )
  }
  return(out)
}
