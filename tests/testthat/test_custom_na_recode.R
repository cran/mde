testthat::test_that(desc="custom_na_recode works as expected",
                    code={
                      # This should replace values in all columns with the maximum
                    all_by_max <- custom_na_recode(airquality,func="max")
                    # Only at Ozone
                    max_ozone <- custom_na_recode(airquality,func="max",across_columns = "Ozone")
                    testthat::expect_false(is.na(all_by_max[6,2]))
                    # This should return true since we only recoded at Ozone
                    testthat::expect_true(is.na(max_ozone[6,2]))
                    # check that grouping works
                    test_groups <- data.frame(ID= c("A","A","B","A","B"),
                                        Vals = c(1,2,3,rep(NA, 2)))
                    testthat::expect_equal(mde::custom_na_recode(test_groups, func="mean",grouping_cols="ID")[[2]][5],
                                           3)
                    # test that column names exist
                    testthat::expect_error(mde::custom_na_recode(test_groups,func="mean",across_columns="nope"),
                                           "All values in across_columns must be valid column names", fixed=TRUE)

                    })