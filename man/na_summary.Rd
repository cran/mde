% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/na_summary.R
\name{na_summary}
\alias{na_summary}
\title{An all-in-one missingness report}
\usage{
na_summary(
  df,
  grouping_cols = NULL,
  sort_by = NULL,
  descending = FALSE,
  exclude_cols = NULL,
  pattern = NULL,
  pattern_type = NULL,
  regex_kind = "exclusion",
  round_to = NULL,
  reset_rownames = FALSE
)
}
\arguments{
\item{df}{A valid R `object` for which the percentage of missing values is 
required.}

\item{grouping_cols}{A character vector. If supplied, one can provide the columns by which to group the
data.}

\item{sort_by}{One of counts or percents. This determines whether the results are sorted by counts or percentages.}

\item{descending}{Logical. Should missing values be sorted in decreasing order ie largest to smallest? Defaults to FALSE.}

\item{exclude_cols}{A character vector indicating columns to exclude when 
returning results.}

\item{pattern}{Pattern to use for exclusion or inclusion.
column inclusion criteria.}

\item{pattern_type}{A regular expression type. One of "starts_with",
"contains", or "regex". Defaults to NULL. Only use for selective inclusion.}

\item{regex_kind}{One of inclusion or exclusion. Defaults to exclusion to exclude
columns using regular expressions.}

\item{round_to}{Number of places to round 2. Defaults to user digits option.}

\item{reset_rownames}{Should the rownames be reset in the output? defaults to FALSE}
}
\description{
An all-in-one missingness report
}
\examples{
na_summary(airquality)
# grouping
test2 <- data.frame(ID= c("A","A","B","A","B"),Vals = c(rep(NA,4),"No"),
ID2 = c("E","E","D","E","D"))
df <- data.frame(A=1:5,B=c(NA,NA,25,24,53), C=c(NA,1,2,3,4))

na_summary(test2,grouping_cols = c("ID","ID2"))
# sort summary
na_summary(airquality,sort_by = "percent_missing",descending = TRUE)
na_summary(airquality,sort_by = "percent_complete")
# Include only via a regular expression
na_summary(mtcars, pattern_type = "contains",
pattern = "mpg|disp|wt", regex_kind = "inclusion")
na_summary(airquality, pattern_type = "starts_with",
pattern = "ozone", regex_kind = "inclusion")
# exclusion via a regex
na_summary(airquality, pattern_type = "starts_with",
pattern = "oz|Sol", regex_kind = "exclusion")
# reset rownames when sorting by variable
na_summary(df,sort_by="variable",descending=TRUE, reset_rownames = TRUE)
}
