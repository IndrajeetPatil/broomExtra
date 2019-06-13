#' @title Retrieve model summary dataframe if it exists.
#' @name glance
#' @author Indrajeet Patil
#' @description Check if a `glance` method exits for a given object, either in
#'   `broom` or in `broom.mixed`. If it does, return the model summary
#'   dataframe, if not, return a `NULL`.
#'
#' @inheritParams generics::glance
#'
#' @importFrom broom glance
#' @importFrom broom.mixed glance
#'
#' @inherit generics::glance return value
#' @inheritSection generics::glance Methods
#'
#' @examples
#' set.seed(123)
#' library(lme4)
#'
#' # mixed-effects models (`broom.mixed` will be used)
#' lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
#' broomExtra::glance(lmm.mod)
#'
#' # linear model (`broom` will be used)
#' lm.mod <- lm(Reaction ~ Days, sleepstudy)
#' broomExtra::glance(lm.mod)
#' @export

glance <- function(x, ...) {

  # check if `broom` has a glance method for a given object
  f <- tryCatch(
    expr = broom::glance(x, ...),
    error = function(x) {
      NULL
    }
  )

  # if not, check if `broom.mixed` has a glance method for a given object
  if (is.null(f)) {
    f <- tryCatch(
      expr = broom.mixed::glance(x, ...),
      error = function(x) {
        NULL
      }
    )
  }

  # return the glance
  return(f)
}
