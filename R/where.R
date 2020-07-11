#' Search Package Source
#' @description Search package from CRAN, Archive, Available and Bioconductor.
#' @param data result of functin loadData()
#' @param packages one or more package names
#'
#' @return a dataframe contains package name, version, modified time and source.
#' @export
#'
#' @examples
#'
#' \donttest{
#'
#' d <- loadData()
#' where(d,c('purrrogress','do'))
#'
#' # then use command to install
#' remotes::install_version('purrrogress','0.1.1')
#' }
#'
where <- function(data,packages){
    x=lapply(packages, function(i) where.i(data,i))
    do.call(rbind,x)
}
where.i <-function (data,package){

    # df1------------------------------archive
    archive=data$archive
    df1=NULL
    if (package %in% names(archive)){
        ah=archive[[package]]
        df1=data.frame(package=package,
                       source='Archive',
                       version=do::Replace0(rownames(ah),c('.*_','.tar.gz')),
                       mtime=gsub(' .*','',ah[,'mtime']))
    }
    # ---------------------------------avalible
    version=''
    avb=data$available
    if (package %in% rownames(avb)) version=avb[package,'Version']
    # df2------------------------------cran
    df2=NULL
    current=data$current
    if (package %in% rownames(current)){
        df2=data.frame(package=package,
                       source='CRAN',
                       version=ifelse(nchar(version)>0,paste0('current:',version),'current'),
                       mtime=do::Replace0(current[package,'mtime'],' .*'))
    }
    # df3------------------------------bioconductor
    df3=NULL
    bioc=data$bioconductor[,c('Package','Version')]
    if (package %in% bioc[,'Package']){
        df3=data.frame(package=package,
                       source='Bioconductor',
                       version=bioc[package,'Version'],
                       mtime='')
    }
    rbind(df1,df2,df3)
}
