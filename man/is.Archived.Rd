% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is.Archive.R
\name{is.Archived}
\alias{is.Archived}
\title{Check package in archive CRAN}
\usage{
is.Archived(package, data = NULL, repo = getOption("repos"))
}
\arguments{
\item{package}{one or more package names}

\item{data}{NULL or result of loadData() function.}

\item{repo}{repository}
}
\value{
logical
}
\description{
Check whether packages in archive CRAN
}
\examples{

is.Archived(c('do','export'),repo="https://cloud.r-project.org/")

}
