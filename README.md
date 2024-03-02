
<!-- README.md is generated from README.Rmd. Please edit that file -->

# abctools

<!-- badges: start -->
<!-- badges: end -->

`abctools` is a collection of functions useful across different ABC
analyses and projects.

## Installation

You can install the development version of abctools from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ABC-Kenya-Study/abctools")
```

## Getting started

`abctools::` has a friendly wrapper for collecting ABC data from REDCap:

``` r
library(abctools)

# path to .R script containing ABC API token, e.g., "abc_token.R"
tp <- file.path(Sys.getenv("R_USER"), "R", "access_tokens", "abc_token.R")

# collect REDCap data
abc_data <- get_redcap_data(token_path = tp)
#> 3,962 records and 2,438 columns were read from REDCap in 8.9 seconds.  The http status code was 200.
```

## Helper functions

Once you have ABC data, `abctools::` also has helper functions for
wrangling tasks. For instance, `drop_vars_all_na()` deletes columns that
are all NA:

``` r

library(dplyr)
library(stringr)

# original number of columns in data from REDCap
ncol(abc_data)
#> [1] 2438

# subset to enrollment rows, then drop columns with all NAs
enroll <- abc_data |>
  filter(str_detect(redcap_event_name, 'Enrollment')) |>
  drop_vars_all_na()

enroll
#> # A tibble: 400 × 523
#>    cp_ptid       redcap_event_name        cp_version cp_frmcompldate cp_mom_baby
#>    <chr>         <chr>                    <chr>      <date>          <chr>      
#>  1 50-22-0001-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-10      Mom        
#>  2 50-22-0002-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-10      Mom        
#>  3 50-22-0003-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-10      Mom        
#>  4 50-22-0004-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-11      Mom        
#>  5 50-22-0005-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-11      Mom        
#>  6 50-22-0006-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-11      Mom        
#>  7 50-22-0007-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-11      Mom        
#>  8 50-22-0008-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-12      Mom        
#>  9 50-22-0009-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-13      Mom        
#> 10 50-22-0010-M1 Enrollment (Arm 1: Moth… Version 2… 2022-01-13      Mom        
#> # ℹ 390 more rows
#> # ℹ 518 more variables: cp_followup_type <chr>, cp_trimester_enrolled <chr>,
#> #   cp_next_visit_date <date>, cp_entry_staff <chr>,
#> #   cp_entry_staff_othr_spc <chr>, cp_data_entry_date <date>,
#> #   cp_update_date <date>, client_page_complete <chr>, con_ptid <chr>,
#> #   con_frmcompldate <date>, con_enr_sign <chr>, con_enr_version <chr>,
#> #   con_complstaff_init_qc <chr>, con_review_staff_qc <chr>, …

# number of columns in 'enroll'
ncol(enroll)
#> [1] 523
```

## Derived variables

Functions that create derived variables will be added to `abctools`.
Revisit this page to check for examples as they are added.

## Output data

`abctools::` also has a straightforward workflow to prepare a flat, wide
dataset with one participant per row. Data cleaning functions and
functions that create derived variables are designed to be applied to
the data collected from REDCap, beforehand.

``` r

wide_data <- abc_data |> 
  
  # subset to moms
  filter(str_detect(redcap_event_name, 'Mothers')) |> 
  
  # apply data cleaning functions from `abctools::`
  fix_ptid() |>
  char_to_numeric() |>
  remove_returns() |>
  
  # add REDCap event name (CRF) abbreviations
  abb_redcap_events(long_short = 'short') |> 
  
  # make wide data, one row per participant 
  # (note: `wide_data()` needs variable "redcap_event" from `abb_redcap_events()`)
  wide_data()

# show
wide_data
#> # A tibble: 400 × 1,916
#>    cp_ptid       del_redcap_event_name     del_cp_version del_cp_frmcompldate
#>    <chr>         <chr>                     <chr>          <date>             
#>  1 50-22-0001-M1 Delivery (Arm 1: Mothers) Version 2.0    2022-04-13         
#>  2 50-22-0002-M1 Delivery (Arm 1: Mothers) Version 2.0    2022-05-19         
#>  3 50-22-0003-M1 Delivery (Arm 1: Mothers) <NA>           2022-03-17         
#>  4 50-22-0004-M1 Delivery (Arm 1: Mothers) Version 2.0    2022-04-19         
#>  5 50-22-0005-M1 <NA>                      <NA>           NA                 
#>  6 50-22-0006-M1 Delivery (Arm 1: Mothers) Version 2.0    2022-05-23         
#>  7 50-22-0007-M1 Delivery (Arm 1: Mothers) Version 2.0    2022-04-22         
#>  8 50-22-0008-M1 Delivery (Arm 1: Mothers) Version 2.0    2022-01-17         
#>  9 50-22-0009-M1 Delivery (Arm 1: Mothers) Version 2.0    2022-06-09         
#> 10 50-22-0010-M1 Delivery (Arm 1: Mothers) Version 1.0    2022-05-10         
#> # ℹ 390 more rows
#> # ℹ 1,912 more variables: del_cp_mom_baby <chr>, del_cp_followup_type <chr>,
#> #   del_cp_next_visit_date <date>, del_cp_entry_staff <chr>,
#> #   del_cp_data_entry_date <date>, del_cp_update_date <date>,
#> #   del_client_page_complete <chr>, del_del_ptid <chr>, del_del_version <chr>,
#> #   del_del_frmcompldate <date>, del_del_visit_code <chr>, del_del_site <chr>,
#> #   del_del_visit_type <chr>, del_del_same_contacts <chr>, …

# number of rows and columns of wide dataset
dim(wide_data)
#> [1]  400 1916
```

Enjoy!
