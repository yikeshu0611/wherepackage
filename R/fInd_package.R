#' Find package by a keyword in function
#'
#' @param funkey one character
#' @param data NULL or result of loadData() function.
#' @param exact logical, whether to match exactly
#' @param repo repository
#'
#' @return a datafram contains package and function
#' @export
#'
#' @examples
#' \donttest{
#' find_package('nomogram')
#' }
#'
find_package <- function(funkey,
                         data=NULL,
                         exact=FALSE,
                         repo = getOption("repos")){
    if (length(funkey)>1) stop('funkey must be one character')
    if (is.null(data)){
        aliases <-rio::import('https://mirrors.tongji.edu.cn/CRAN//src/contrib/Meta/aliases.rds')
    }else{
        aliases=data$aliases
    }
    df=lapply(1:length(aliases), function(i) cbind(names(aliases[i]),unlist(aliases[[i]])))
    df2=df[sapply(df,function(i) ncol(i))==2]
    df3=do.call(rbind,df2)
    rownames(df3)=NULL
    df4=ifelse(exact,
               list(df3[df3[,2]==funkey,]),
               list(df3[grepl(funkey,df3[,2]),]))
    df5=data.frame(df4[[1]],stringsAsFactors = FALSE)
    colnames(df5)=c('package','function')
    df5
}
