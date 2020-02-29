## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------

# install.packages("mde")



## -----------------------------------------------------------------------------
library(mde)


## -----------------------------------------------------------------------------
get_na_counts(airquality)

## -----------------------------------------------------------------------------

test <- structure(list(Subject = structure(c(1L, 1L, 2L, 2L), .Label = c("A", 
"B"), class = "factor"), res = c(NA, 1, 2, 3), ID = structure(c(1L, 
1L, 2L, 2L), .Label = c("1", "2"), class = "factor")), class = "data.frame", row.names = c(NA, 
-4L))

get_na_counts(test, grouped = TRUE, grouping_cols = "ID")


## -----------------------------------------------------------------------------

percent_missing(airquality)



## -----------------------------------------------------------------------------

percent_missing(test, grouping_cols = "Subject")



## -----------------------------------------------------------------------------
percent_missing(airquality,exclude_cols = c("Day","Temp"))


## -----------------------------------------------------------------------------

dummy_test <- data.frame(ID = c("A","B","B","A"), 
                         values = c("n/a",NA,"Yes","No"))
# Convert n/a to NA
recode_as_na(dummy_test, value = "n/a")


## -----------------------------------------------------------------------------

another_dummy <- data.frame(ID = 1:5, Subject = 7:11, 
Change = c("missing","n/a",2:4 ))
# Only change values at the column Change
recode_as_na(another_dummy, subset_df = TRUE,
             subset_cols = "Change", value = c("n/a",
                                               "missing"))
                                               


## -----------------------------------------------------------------------------
mde::recode_as_na(airquality, subset_df = TRUE,
tidy=TRUE, pattern_type="starts_with",
pattern="Solar")


## -----------------------------------------------------------------------------

sort_by_missingness(airquality, sort_by = "counts")


## -----------------------------------------------------------------------------

# sort in descending order

sort_by_missingness(airquality, sort_by = "counts",
descend = TRUE)



## -----------------------------------------------------------------------------

# Use percents
sort_by_missingness(airquality, sort_by = "percents")



## -----------------------------------------------------------------------------
# defaults
head(recode_na_as(airquality))


## -----------------------------------------------------------------------------
head(recode_na_as(airquality, value=NaN))


## -----------------------------------------------------------------------------

head(recode_na_as(airquality, value=0, subset_df=TRUE, subset_cols="Ozone"))


## -----------------------------------------------------------------------------

head(mde::recode_na_as(airquality, subset_df=TRUE, tidy=TRUE,
                  value=0, pattern_type="starts_with",
                  pattern="solar",ignore.case=TRUE))


## -----------------------------------------------------------------------------
some_data <- data.frame(ID=c("A1","A2","A3", "A4"), 
                        A=c(5,NA,0,8), B=c(10,0,0,1),
                        C=c(1,NA,NA,25))
                        
recode_na_if(some_data,grouping_col="ID", target_groups=c("A2","A3"),
           replacement= 0)  


## -----------------------------------------------------------------------------
drop_na_if(airquality, sign = "gteq",percent_na = 24)


## -----------------------------------------------------------------------------

drop_na_if(airquality, sign="gteq",percent_na = 0.24)


## -----------------------------------------------------------------------------

head(drop_na_if(airquality, percent_na = 24, keep_columns = "Ozone"))



## -----------------------------------------------------------------------------

head(drop_na_if(airquality, percent_na = 24))



## -----------------------------------------------------------------------------

drop_na_at(airquality,pattern_type = "starts_with","O")


## -----------------------------------------------------------------------------

recode_as_na_for(airquality,criteria="gt",value=25)


## -----------------------------------------------------------------------------

recode_as_na_for(airquality, value=25,subset_cols="Solar.R",
criteria="gt")


