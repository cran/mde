testthat::test_that(desc="percent_missing warns",
                    code = {
                      test <- data.frame(ID= c("A","B","A","B","A","B","A"),
                                         Vals = c(NA,25,34,NA,67,NA,45))
                    testthat::expect_equal(percent_missing(test,
                                          grouping_cols =
                                                 "ID")[[2]][1],
                                          25)
                    })
