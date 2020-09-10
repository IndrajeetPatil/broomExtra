#' @title Retrieve tidy dataframe if it exists.
#' @name tidy
#' @description Checks if a `tidy` method exits for a given object, either in
#'   `broom` or in `broom.mixed`. If it does, it turn an object into a tidy
#'   tibble, if not, return a `NULL`. In this case, you can try the
#'   [broomExtra::tidy_parameters()] function.
#'
#' @inheritParams generics::tidy
#'
#' @importFrom rlang is_null
#' @importFrom broom tidy
#' @importFrom broom.mixed tidy
#'
#' @inherit generics::tidy return value
#' @inheritSection generics::tidy Methods
#'
#' @seealso \code{\link{grouped_tidy}}, \code{\link{tidy_parameters}}
#'
#' @examples
#' set.seed(123)
#' lm.mod <- lm(Reaction ~ Days, sleepstudy)
#' broomExtra::tidy(x = lm.mod, conf.int = TRUE)
#' @export

tidy <- function(x, ...) {
  # check if `broom` has a tidy method for a given object
  f <- tryCatch(broom::tidy(x, ...), error = function(e) NULL)

  # if not, check if `broom.mixed` has a tidy method for a given object
  if (rlang::is_null(f)) f <- tryCatch(broom.mixed::tidy(x, ...), error = function(e) NULL)

  # return the tidy
  return(f)
}


#' @title Retrieve model summary dataframe if it exists.
#' @name glance
#' @description Check if a `glance` method exits for a given object, either in
#'   `broom` or in `broom.mixed`. If it does, return the model summary
#'   dataframe, if not, return a `NULL`. In this case, you can try the
#'   [broomExtra::glance_performance()] function.
#'
#' @inheritParams generics::glance
#'
#' @importFrom broom glance
#' @importFrom broom.mixed glance
#'
#' @inherit generics::glance return value
#' @inheritSection generics::glance Methods
#'
#' @seealso \code{\link{grouped_glance}}, \code{\link{glance_performance}}
#'
#' @examples
#' set.seed(123)
#' lm.mod <- lm(Reaction ~ Days, sleepstudy)
#' broomExtra::glance(lm.mod)
#' @export

glance <- function(x, ...) {
  # check if `broom` has a glance method for a given object
  f <- tryCatch(broom::glance(x, ...), error = function(e) NULL)

  # if not, check if `broom.mixed` has a glance method for a given object
  if (rlang::is_null(f)) f <- tryCatch(broom.mixed::glance(x, ...), error = function(e) NULL)


  # return the glance
  return(f)
}

#' @title Retrieve augmented dataframe if it exists.
#' @name augment
#' @description Check if a `augment` method exits for a given object, either in
#'   `broom` or in `broom.mixed`. If it does, return the model summary
#'   dataframe, if not, return a `NULL`.
#'
#' @inheritParams generics::augment
#'
#' @importFrom broom augment
#' @importFrom broom.mixed augment
#'
#' @inherit generics::augment return value
#' @inheritSection generics::augment Methods
#'
#' @seealso \code{\link{grouped_augment}}
#'
#' @examples
#' set.seed(123)
#' lm.mod <- lm(Reaction ~ Days, sleepstudy)
#' broomExtra::augment(lm.mod)
#' @export

augment <- function(x, ...) {
  # check if `broom` has a augment method for a given object
  f <- tryCatch(broom::augment(x, ...), error = function(e) NULL)

  # if not, check if `broom.mixed` has a augment method for a given object
  if (rlang::is_null(f)) f <- tryCatch(broom.mixed::augment(x, ...), error = function(e) NULL)

  # return the augment
  return(f)
}
