## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------

library(mde)


## -----------------------------------------------------------------------------

dummy_test <- data.frame(ID = c("A","B","B","A"), 
                         values = c("n/a",NA,"Yes","No"))
# Convert n/a and no to NA
head(recode_as_na(dummy_test, value = c("n/a","No")))



## -----------------------------------------------------------------------------


another_dummy <- data.frame(ID = 1:5, Subject = 7:11, 
Change = c("missing","n/a",2:4 ))
# Only change values at the column Change
head(recode_as_na(another_dummy, subset_cols = "Change", value = c("n/a","missing")))
                                               


## -----------------------------------------------------------------------------
# only change at columns that start with Solar
head(recode_as_na(airquality,value=190,pattern_type="starts_with",pattern="Solar"))

## -----------------------------------------------------------------------------
# recode at columns that start with O or S(case sensitive)
head(recode_as_na(airquality,value=c(67,118),pattern_type="starts_with",pattern="S|O"))


## -----------------------------------------------------------------------------
# use my own RegEx
head(recode_as_na(airquality,value=c(67,118),pattern_type="regex",pattern="(?i)^(s|o)"))


## -----------------------------------------------------------------------------

head(recode_as_na_if(airquality,sign="gt", percent_na=20))


## -----------------------------------------------------------------------------

partial_match <- data.frame(A=c("Hi","match_me","nope"), B=c(NA, "not_me","nah"))

recode_as_na_str(partial_match,"ends_with","ME", case_sensitive=FALSE)


## -----------------------------------------------------------------------------

head(recode_as_na_for(airquality,criteria="gt",value=25))




## -----------------------------------------------------------------------------

head(recode_as_na_for(airquality, value=40,subset_cols=c("Solar.R","Ozone"), criteria="gt"))


## -----------------------------------------------------------------------------

head(recode_na_as(airquality))

# use NaN

head(recode_na_as(airquality, value=NaN))


## -----------------------------------------------------------------------------

head(recode_na_as(airquality, value=0, subset_cols="Ozone"))


## -----------------------------------------------------------------------------

head(mde::recode_na_as(airquality, value=0, pattern_type="starts_with",pattern="Solar"))


## -----------------------------------------------------------------------------


head(column_based_recode(airquality, values_from = "Wind", values_to="Wind", pattern_type = "regex", pattern = "Solar|Ozone"))


## -----------------------------------------------------------------------------

head(custom_na_recode(airquality))
 

## -----------------------------------------------------------------------------



head(custom_na_recode(airquality,func="mean",across_columns=c("Solar.R","Ozone")))



## -----------------------------------------------------------------------------

# use lag for a backfill
head(custom_na_recode(airquality,func=dplyr::lead ))



## -----------------------------------------------------------------------------

some_data <- data.frame(ID=c("A1","A1","A1","A2","A2", "A2"),A=c(5,NA,0,8,3,4),B=c(10,0,0,NA,5,6),C=c(1,NA,NA,25,7,8))

head(custom_na_recode(some_data,func = "mean", grouping_cols = "ID"))



## -----------------------------------------------------------------------------

head(custom_na_recode(some_data,func = "mean", grouping_cols = "ID", across_columns = c("C", "A")))


## -----------------------------------------------------------------------------

some_data <- data.frame(ID=c("A1","A2","A3", "A4"), 
                        A=c(5,NA,0,8), B=c(10,0,0,1),
                        C=c(1,NA,NA,25))
                        
head(recode_na_if(some_data,grouping_col="ID", target_groups=c("A2","A3"),
           replacement= 0))   


## -----------------------------------------------------------------------------

head(drop_na_if(airquality, sign="gteq",percent_na = 24))


## -----------------------------------------------------------------------------


head(drop_na_if(airquality, percent_na = 24, keep_columns = "Ozone"))



## -----------------------------------------------------------------------------

head(drop_na_if(airquality, percent_na = 24))


## -----------------------------------------------------------------------------
grouped_drop <- structure(list(ID = c("A", "A", "B", "A", "B"), 
          Vals = c(4, NA,  NA, NA, NA), Values = c(5, 6, 7, 8, NA)), 
          row.names = c(NA, -5L), class = "data.frame")
# Drop all columns for groups that meet a percent missingness of greater than or
# equal to 67
drop_na_if(grouped_drop,percent_na = 67,sign="gteq",
                                    grouping_cols = "ID")

## -----------------------------------------------------------------------------
# Drop rows with at least two NAs
head(drop_row_if(airquality, sign="gteq", type="count" , value = 2))


## -----------------------------------------------------------------------------
# Drops 42 rows
head(drop_row_if(airquality, type="percent", value=16, sign="gteq",
                 as_percent=TRUE))

## -----------------------------------------------------------------------------

head(drop_na_at(airquality,pattern_type = "starts_with","O"))



## -----------------------------------------------------------------------------

test2 <- data.frame(ID= c("A","A","B","A","B"), Vals = c(4,rep(NA, 4))) 

drop_all_na(test2, grouping_cols="ID")



## -----------------------------------------------------------------------------

test2 <- data.frame(ID= c("A","A","B","A","B"), Vals = rep(NA, 5)) 

head(drop_all_na(test2, grouping_cols = "ID"))



## -----------------------------------------------------------------------------
head(dict_recode(airquality, use_func="recode_na_as",
                 patterns = c("solar", "ozone"),
                 pattern_type="starts_with", values = c(520,42)))

## -----------------------------------------------------------------------------

head(recode_as_value(airquality, value=c(67,118),replacement=NA,
                     pattern_type="starts_with",pattern="S|O"))

