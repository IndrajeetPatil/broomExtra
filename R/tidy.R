#' @title Retrieve tidy dataframe if it exists.
#' @name tidy
#' @author Indrajeet Patil
#' @description Checks if a `tidy` method exits for a given object, either in
#'   `broom` or in `broom.mixed`. If it does, it turn an object into a tidy
#'   tibble, if not, return a `NULL`.
#'
#' @inheritParams generics::tidy
#'
#' @importFrom broom tidy
#' @importFrom broom.mixed tidy
#'
#' @inherit generics::tidy return value
#' @inheritSection generics::tidy Methods
#'
#' @examples
#' set.seed(123)
#' library(lme4)
#'
#' # mixed-effects models (`broom.mixed` will be used)
#' lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
#' broomExtra::tidy(lmm.mod, effects = "fixed", exponentiate = TRUE)
#'
#' # linear model (`broom` will be used)
#' lm.mod <- lm(Reaction ~ Days, sleepstudy)
#' broomExtra::tidy(lm.mod, conf.int = TRUE)
#' @export

tidy <- function(x, ...) {

  # check if `broom` has a tidy method for a given object
  f <- tryCatch(
    expr = broom.mixed::tidy(x, ...),
    error = function(x) {
      NULL
    }
  )

  # if not, check if `broom.mixed` has a tidy method for a given object
  if (is.null(f)) {
    f <- tryCatch(
      expr = broom::tidy(x, ...),
      error = function(x) {
        NULL
      }
    )
  }

  # return the tidy
  return(f)
}
