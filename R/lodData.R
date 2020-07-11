#' Load Package Information
#' @param repo CRAN repository
#' @importFrom utils available.packages
#' @return a list contains archive, current and available package information on
#'     current repository, and bioconductor package information containing
#'     Software, AnnotatonData, ExperimentData and Workflow from the current
#'     release version. see \code{\link[wherepackage]{where}}
#'
#' @export
#'
loadData <- function(repo = getOption("repos")){
    message()
    message('---------- Loading data')
    message()
    # ----------------------------------------archive
    message('    CRAN: Archive packages')
    if (do::right(repo,1)=='/'){
        url=paste0(repo,'src/contrib/Meta/archive.rds')
    }else{
        url=paste0(repo,'/src/contrib/Meta/archive.rds')
    }
    archive <- rio::import(url)
    # --------------------------------------------current
    message('    CRAN: Current packages')
    if (do::right(repo,1)=='/'){
        url=paste0(repo,'src/contrib/Meta/current.rds')
    }else{
        url=paste0(repo,'/src/contrib/Meta/current.rds')
    }
    current <- rio::import(url)
    # ---------------------------------------------available
    message('    CRAN: Available packages')
    available=available.packages(repos = repo)
    # ---------------------------------------------aliases
    message('    CRAN: Aliases')
    aliases <- rio::import('https://mirrors.tongji.edu.cn/CRAN//src/contrib/Meta/aliases.rds')

    # bioconductor
    message('    Bioc: Software')
    bioc=available.packages(repos = 'https://bioconductor.org/packages/release/bioc')
    message('    Bioc: Annotation')
    annotate=available.packages(repos = 'https://bioconductor.org/packages/release/data/annotation')
    message('    Bioc: Experiment')
    experiment=available.packages(repos = 'https://bioconductor.org/packages/release/data/experiment')
    message('    Bioc: Wordflow')
    workflows=available.packages(repos = 'https://bioconductor.org/packages/release/workflows')
    bioc=rbind(bioc,annotate,experiment,workflows)
    message()
    message('---------- OK')
    message()
    list(current=current,
         archive=archive,
         available=available,
         aliases=aliases,
         bioconductor=bioc)
}
