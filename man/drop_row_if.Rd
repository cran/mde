% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drop_row_if.R
\name{drop_row_if}
\alias{drop_row_if}
\title{Conditionally drop rows based on percent missingness}
\usage{
drop_row_if(df, sign = "gt", type = "count", value = 20, as_percent = TRUE)
}
\arguments{
\item{df}{A data.frame object}

\item{sign}{Character. One of gteq,lteq,lt,gt or eq which refer to greater 
than(gt) or equal(eq) or
less than(lt) or equal to(eq) respectively.}

\item{type}{One of either count or percent. Defaults to count}

\item{value}{Value to use for the drop.}

\item{as_percent}{Logical. If set to TRUE, percent_na is treated as a percentage. Otherwise, decimals(fractions) are
used.}
}
\description{
Conditionally drop rows based on percent missingness
}
\examples{
head(drop_row_if(airquality,sign = "gteq",
type = "percent",value=16, as_percent = TRUE))
# should give the same output as above.
head(drop_row_if(airquality, sign="gteq", type="percent",value = 0.15, as_percent=FALSE))
# Drop based on NA counts
df <- data.frame(A=1:5, B=c(1,NA,NA,2, 3), C= c(1,NA,NA,2,3))
drop_row_if(df, type="count",value=2,sign="eq")
}
