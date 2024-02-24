
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
#> The REDCapR read/export operation was not successful.  The error message was:
#> ERROR: REDCap will be performing an upgrade on February 23rd from 6pm to 11pm.
#> We apologize for any inconvenience, if you have any questions please contact the REDCap administrator at redcaphelp@uw.edu Thank you for you patience.
```

## Helper functions

Once you have ABC data, `abctools::` also has helper functions for
wrangling tasks. For instance, `drop_vars_all_na()` deletes columns that
are all NA:

``` r

library(dplyr)
#> Warning: package 'dplyr' was built under R version 4.2.3
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(stringr)
#> Warning: package 'stringr' was built under R version 4.2.3

ncol(abc_data)
#> [1] 0

# enroll <- abc_data |>
#   filter(str_detect(redcap_event_name, 'Enrollment')) |>
#   drop_vars_all_na()
# 
# enroll
# 
# ncol(enroll)
```

Enjoy!
