% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drop_all_na.R
\name{drop_all_na}
\alias{drop_all_na}
\title{Drop columns for which all values are NA}
\usage{
drop_all_na(df, grouping_cols = NULL)
}
\arguments{
\item{df}{A valid R `object` for which the percentage of missing values is 
required.}

\item{grouping_cols}{A character vector. If supplied, one can provide the columns by which to group the
data.}
}
\description{
Drop columns for which all values are NA
}
\examples{
test <- data.frame(ID= c("A","A","B","A","B"), Vals = c(rep(NA,4),2))
test2 <- data.frame(ID= c("A","A","B","A","B"), Vals = rep(NA, 5))
# drop columns where all values are NA
drop_all_na(test2)
# drop NAs only if all are NA for a given group, drops group too.
drop_all_na(test, "ID")
}
