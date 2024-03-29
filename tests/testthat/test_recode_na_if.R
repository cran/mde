# Tests that recode_na_if fails if either of the required args is missing
test_that(desc = "recode_na_if errors on absence of args",
          code = {
            skip_on_oldrel()
            some_data <-
              data.frame(
                ID = c("A1", "A2", "A3", "A4"),
                A = c(NA, NA, 0, 8),
                B = c(10, 0, 0, 1),
                C = c(1, NA, NA, 25)
              )
            
            expect_snapshot({
              expect_error(mde::recode_na_if(some_data, grouping_col = "ID"))
              
              expect_error(recode_na_if(some_data, "nuh", c("A2", "A3"), replacement =
                                          0))
              expect_error(recode_na_if(some_data, "ID", c("A2", "no"), replacement =
                                          0))
              
            })
            
            test_specificity <-
              recode_na_if(some_data, "ID", c("A2", "A3"), replacement = 0)
            expect_true(is.na(test_specificity[[2]][1]))
          })
