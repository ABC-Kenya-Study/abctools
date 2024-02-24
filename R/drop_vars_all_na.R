drop_vars_all_na <- function(x){
  x |> dplyr::select(tidyselect::where(~any(!is.na(.x))))
}
