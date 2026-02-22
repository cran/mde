## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------

library(mde)


## -----------------------------------------------------------------------------

na_summary(airquality)


## -----------------------------------------------------------------------------

na_summary(airquality,sort_by = "percent_complete")


## ----reset_rownames-----------------------------------------------------------

na_summary(airquality,sort_by = "percent_complete", reset_rownames = TRUE)


## -----------------------------------------------------------------------------
na_summary(airquality, sort_by = "percent_missing")


## -----------------------------------------------------------------------------
na_summary(airquality, sort_by="percent_missing", descending = TRUE)


## -----------------------------------------------------------------------------

na_summary(airquality, exclude_cols = c("Day", "Wind"))


## -----------------------------------------------------------------------------
na_summary(airquality, regex_kind = "inclusion",pattern_type = "starts_with", pattern = "O|S")

## -----------------------------------------------------------------------------
na_summary(airquality, regex_kind = "exclusion",pattern_type = "regex", pattern = "^[O|S]")

## -----------------------------------------------------------------------------

test2 <- data.frame(ID= c("A","A","B","A","B"), Vals = c(rep(NA,4),"No"),ID2 = c("E","E","D","E","D"))

na_summary(test2,grouping_cols = c("ID","ID2"))


## -----------------------------------------------------------------------------

na_summary(test2, grouping_cols="ID")



## -----------------------------------------------------------------------------

get_na_counts(airquality)



## -----------------------------------------------------------------------------

test <- structure(list(Subject = structure(c(1L, 1L, 2L, 2L), .Label = c("A", 
"B"), class = "factor"), res = c(NA, 1, 2, 3), ID = structure(c(1L, 
1L, 2L, 2L), .Label = c("1", "2"), class = "factor")), class = "data.frame", row.names = c(NA, 
-4L))

get_na_counts(test, grouping_cols = "ID")



## -----------------------------------------------------------------------------


percent_missing(airquality)



## -----------------------------------------------------------------------------

percent_missing(test, grouping_cols = "Subject")




## -----------------------------------------------------------------------------

percent_missing(airquality,exclude_cols = c("Day","Temp"))



## -----------------------------------------------------------------------------


sort_by_missingness(airquality, sort_by = "counts")



## -----------------------------------------------------------------------------

sort_by_missingness(airquality, sort_by = "counts", descend = TRUE)


## -----------------------------------------------------------------------------

sort_by_missingness(airquality, sort_by = "percents")


