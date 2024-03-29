% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/yesno_to_logical.R
\name{yesno_to_logical}
\alias{yesno_to_logical}
\title{Yes/No to logical}
\usage{
yesno_to_logical(x)
}
\arguments{
\item{x}{A dataframe.}
}
\value{
A dataframe with variables character "yes/no" variables convert to
logicals.
}
\description{
Convert yes/no variables in a dataframe to logical. Uppercase, lowercase or
mixed case yes or no responses are recognized.
}
\examples{
# example data
(x <- data.frame(var1 = c("Yes", "NO", "N"),
                 var2 = c("sometimes", "rarely", "never"),
                 var3 = c("No", "no", "n")) )

# variable classes
sapply(x, class)

# convert yes/no variables
(x <- yesno_to_logical(x))

# new variable classes
sapply(x, class)
}
