#' Check package in current CRAN
#' @description Check whether packages in current CRAN
#' @param package one or more package names
#' @param data NULL or result of loadData() function.
#' @param repo repository
#'
#' @return logical
#' @export
#'
#' @examples
#' is.inCRAN(c('do','export'),repo="https://cloud.r-project.org/")
is.inCRAN <- function(package,data=NULL,repo=getOption('repos')){
    if (is.null(data)){
        if (do::right(repo,1)=='/'){
            url=paste0(repo,'src/contrib/Meta/current.rds')
        }else{
            url=paste0(repo,'/src/contrib/Meta/current.rds')
        }
        current <- rio::import(url)
    }else{
        current=data$current
    }
    sapply(package, function(i) i %in% rownames(current))
}
