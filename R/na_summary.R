#' An all-in-one missingness report
#' @inheritParams percent_missing
#' @inheritParams sort_by_missingness
#' @importFrom stats "aggregate" "as.formula" "na.pass"
#' @examples
#' na_summary(airquality)
#' # grouping
#' test2 <- data.frame(ID= c("A","A","B","A","B"),Vals = c(rep(NA,4),"No"),
#' ID2 = c("E","E","D","E","D"))
#' na_summary(test2,grouping_cols = c("ID","ID2"))
#' # sort summary
#' na_summary(airquality,sort_by = "percent_missing",descending = TRUE)

#' na_summary(airquality,sort_by = "percent_complete")
#'
#' @export

na_summary <- function(df,grouping_cols=NULL,sort_by=NULL,descending=FALSE, exclude_cols = NULL){
  UseMethod("na_summary")


}

#' @export

na_summary.data.frame <- function(df,grouping_cols=NULL,sort_by=NULL,descending=FALSE,
                                  exclude_cols= NULL){
  # stick to(with?) base as much as possible
  # get total NAs columnwise
all_counts <-stack(get_na_counts(df,  exclude_cols = exclude_cols))
all_percents <- stack(percent_missing(df, exclude_cols = exclude_cols))
names(all_counts) <- c("missing","variable")
names(all_percents) <- c("percent_missing","variable")
if(is.null(grouping_cols)){

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
      tidyr::separate(name,c("variable","metric"),sep="\\.(?=percent|miss|complete)")  %>%
      tidyr::pivot_wider(names_from=metric,values_from=value)


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
res
}



