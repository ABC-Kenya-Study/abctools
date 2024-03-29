% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_wide.R
\name{wide_data}
\alias{wide_data}
\title{Make wide data}
\usage{
wide_data(x)
}
\arguments{
\item{x}{A dataframe containing a variable "redcap_event".}
}
\value{
A dataframe with one row per participant
}
\description{
Creates a wide dataframe of one row per participant, compiling all REDCap
events (CRFs).
}
\examples{
(x <- data.frame(cp_ptid = rep(paste0("50-22-000", 1:3, "-M1"), 3),
                 redcap_event = c(rep("enr", 3), rep("del", 3), rep("w6", 3) ),
                 cp_frmcompldate = as.Date(paste("2022", "03", sample(1:30, 9), sep = "-")) ))

wide_data(x)
}
