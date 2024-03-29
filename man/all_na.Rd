% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{all_na}
\alias{all_na}
\title{Checks that all values are NA}
\usage{
all_na(x)
}
\arguments{
\item{x}{A vector or data.frame column}
}
\value{
Boolean TRUE or FALSE depending on the nature of the column/vector
}
\description{
This is a helper function to check if all column/vector values 
are NA
}
\examples{
test <- data.frame(A=c(NA, 2), B= c(NA, NA))
all_na(test)
test_vec <- c("NA",NA,"nope")
test_numeric <- c(NA, 2)
all_na(test_vec)
all_na(test_numeric)
}
