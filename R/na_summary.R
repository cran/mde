#' An all-in-one missingness report
#' @inheritParams percent_missing
#' @inheritParams sort_by_missingness
#' @param round_to Number of places to round 2. Defaults to user digits option.
#' @param pattern_type A regular expression type. One of "starts_with",
#' "contains", or "regex". Defaults to NULL. Only use for selective inclusion.
#' @param regex_kind One of inclusion or exclusion. Defaults to exclusion to exclude
#' columns using regular expressions.
#' @param pattern Pattern to use for exclusion or inclusion.
#' column inclusion criteria.
#' @param reset_rownames Should the rownames be reset in the output? defaults to FALSE
#' @importFrom stats "aggregate" "as.formula" "na.pass"
#' @examples
#' na_summary(airquality)
#' # grouping
#' test2 <- data.frame(ID= c("A","A","B","A","B"),Vals = c(rep(NA,4),"No"),
#' ID2 = c("E","E","D","E","D"))
#' df <- data.frame(A=1:5,B=c(NA,NA,25,24,53), C=c(NA,1,2,3,4))
#'
#' na_summary(test2,grouping_cols = c("ID","ID2"))
#' # sort summary
#' na_summary(airquality,sort_by = "percent_missing",descending = TRUE)

#' na_summary(airquality,sort_by = "percent_complete")
#' # Include only via a regular expression
#' na_summary(mtcars, pattern_type = "contains",
#' pattern = "mpg|disp|wt", regex_kind = "inclusion")
#' na_summary(airquality, pattern_type = "starts_with",
#' pattern = "ozone", regex_kind = "inclusion")
#' # exclusion via a regex
#' na_summary(airquality, pattern_type = "starts_with",
#' pattern = "oz|Sol", regex_kind = "exclusion")
#' # reset rownames when sorting by variable
#' na_summary(df,sort_by="variable",descending=TRUE, reset_rownames = TRUE)
#' @export

na_summary <- function(df,grouping_cols=NULL,
                       sort_by=NULL,
                       descending=FALSE,
                       exclude_cols = NULL,
                       pattern = NULL,
                       pattern_type = NULL,
                       regex_kind = "exclusion",
                       round_to = NULL,
                       reset_rownames = FALSE){
  UseMethod("na_summary")


}

#' @export

na_summary.data.frame <- function(df,grouping_cols=NULL,
                                   sort_by=NULL,
                                   descending=FALSE,
                                   exclude_cols = NULL,
                                   pattern = NULL,
                                   pattern_type = NULL,
                                   regex_kind = "exclusion",
                                   round_to = NULL,
                                   reset_rownames = FALSE){
  # Round percents to chosen round
  round_to = ifelse(is.null(round_to),
                    options("digits")[[1]], round_to)
  if(all(!is.null(exclude_cols), !is.null(pattern_type))){
    stop("Use either exclude_cols or pattern_type, not both.")

  }

  if(!is.null(pattern_type)){
    if(is.null(pattern)) stop("Please provide a pattern to use.")
    if(!regex_kind %in% c("inclusion", "exclusion")) stop(paste0("Use either inclusion or exclusion not ", regex_kind))
    df<-switch(regex_kind,
           inclusion =df[recode_selectors(df,
                              pattern_type = pattern_type,
                              pattern = pattern)],
           exclusion =  df[-recode_selectors(df,
                                  pattern_type =pattern_type,
                                   pattern = pattern)]
    )
  }

  if(!is.null(exclude_cols)){
    exclude_cols_indices <- which(names(df) %in% exclude_cols)
    df <- df[-exclude_cols_indices]
  }
if(is.null(grouping_cols)){
  # stick to(with?) base as much as possible
  # get total NAs columnwise
  all_counts <-stack(get_na_counts(df))
  all_percents <- stack(percent_missing(df))

  all_percents$values <- round(all_percents$values, digits=round_to)

  names(all_counts) <- c("missing","variable")
  names(all_percents) <- c("percent_missing","variable")

  if(nrow(all_counts) != nrow(all_percents)){
  stop("Binding of datasets failed. Please check using percent_missing and get_na_counts first")
}


all_counts$complete <- ifelse(all_counts$missing==0,nrow(df),nrow(df) - all_counts$missing)

all_counts$percent_complete <- ifelse(all_percents$percent_missing==0,100,100 - all_percents$percent_missing)

res <- merge(all_counts,all_percents,by="variable")

}



else{

    non_grouping = setdiff(names(df), grouping_cols)
    #matched_groups = which(names(df) %in% grouping_cols)
if(length(non_grouping) > 1) warning("All non grouping values used. Using select non groups is currently not supported")

    check_column_existence(df,grouping_cols, "to group by")
    grouping_cols_formula = paste0(grouping_cols,collapse="+")
    agg_formula <- as.formula(paste0(".~",
                                     grouping_cols_formula))
    res<-do.call(data.frame,aggregate(agg_formula,data=df,
                                      function(x) c(missing = sum(is.na(x)),
                                      complete = length(x) - sum(is.na(x)),
                             percent_complete = mean(!is.na(x)) * 100,
                             percent_missing = mean(is.na(x)) * 100
        ) , na.action = na.pass)) %>%
    tidyr::pivot_longer(cols = -all_of(grouping_cols)) %>%
      tidyr::separate(name,c("variable","metric"),
                      sep="\\.(?=percent|miss|complete)")  %>%
      tidyr::pivot_wider(names_from=metric,values_from=value)


    res$percent_complete=round(res$percent_complete, digits = round_to)
    res$percent_missing=round(res$percent_missing, digits = round_to)


}
if(!is.null(sort_by)){
stopifnot("sort_by should be a valid name in the output of na_summary" =
            sort_by %in% names(res))


# Get the value to sort by
target_column <- res[[sort_by]]
  # Check class of this value and use appropriate sorting
if (is.factor(target_column)) target_column <- as.character(target_column)

res <- res[sort(target_column,decreasing=descending,index.return=TRUE)[[2]],]


}
if(reset_rownames) rownames(res) <- NULL
res
}



