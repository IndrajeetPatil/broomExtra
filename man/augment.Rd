% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generics.R
\name{augment}
\alias{augment}
\title{Retrieve augmented dataframe if it exists.}
\usage{
augment(x, ...)
}
\arguments{
\item{x}{Model object or other R object with information to append to
observations.}

\item{...}{Addition arguments to \code{augment} method.}
}
\value{
A \code{\link[tibble:tibble]{tibble::tibble()}} with information about data points.
}
\description{
Checks if a \code{augment} method exits for a given object, either in \code{{broom}} or
in \code{{broom.mixed}}. If it does, return the model summary dataframe, if not,
return a \code{NULL}.
}
\examples{
set.seed(123)
lm.mod <- lm(Sepal.Length ~ Species, iris)
broomExtra::augment(lm.mod)
}
\seealso{
\code{\link{grouped_augment}}
}
