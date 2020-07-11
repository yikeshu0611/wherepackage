#' Check package in archive CRAN
#' @description Check whether packages in archive CRAN
#' @param package one or more package names
#' @param data NULL or result of loadData() function.
#' @param repo repository
#'
#' @return logical
#' @export
#'
#' @examples
#'
#' is.Archived(c('do','export'),repo="https://cloud.r-project.org/")
#'
is.Archived <- function(package,data=NULL,repo=getOption('repos')){
    if (is.null(data)){
        if (do::right(repo,1)=='/'){
            url=paste0(repo,'src/contrib/Meta/current.rds')
        }else{
            url=paste0(repo,'/src/contrib/Meta/current.rds')
        }
        archive=rio::import(url)
    }else{
        archive=data$archive
    }
    sapply(package, function(i) i %in% names(archive))
}
