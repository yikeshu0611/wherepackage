#' Load Package Information
#'
#' @param repo CRAN repository
#'
#' @return a list contains archive, current and available package information on
#'     current repository, and bioconductor package information containing
#'     Software, AnnotatonData, ExperimentData and Workflow from the current
#'     release version.
#'
#' @export
#'
#' @examples
#' # see
#' \code{\link[wherepackage]{where}}
loadData <- function(repo = getOption("repos")){
    message()
    message('---------- Loading data')
    message()
    message('    CRAN: Archive packages')
    # cran
    archive <- tryCatch({
        con <- gzcon(url(paste0(repo,'/src/contrib/Meta/archive.rds'), "rb"))
        on.exit(close(con))
        readRDS(con)
    })
    message('    CRAN: Current packages')
    # current
    current <-{
        con <- gzcon(url(paste0(repo,'/src/contrib/Meta/current.rds'), "rb"))
        on.exit(close(con))
        readRDS(con)
    }
    message('    CRAN: Available packages')
    # available
    available=available.packages(repos = repo)
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
    list(current=current,archive=archive,available=available,bioconductor=bioc)
}
