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
#' @examples
#' \dontrun{
#' library(lme4)
#'
#' # mixed-effects models (`broom.mixed` will be used)
#' lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
#' broomExtra::augment(lmm.mod)
#'
#' # linear model (`broom` will be used)
#' lm.mod <- lm(Reaction ~ Days, sleepstudy)
#' broomExtra::augment(lm.mod)
#'
#' # no augment available (`NULL` will be returned)
#' broomExtra::augment(stats::anova(stats::lm(wt ~ am, mtcars)))
#' }
#'
#' @export

augment <- function(x, ...) {

  # check if `broom` has a augment method for a given object
  f <- tryCatch(
    expr = broom.mixed::augment(x, ...),
    error = function(x) {
      NULL
    }
  )

  # if not, check if `broom.mixed` has a augment method for a given object
  if (is.null(f)) {
    f <- tryCatch(
      expr = broom::augment(x, ...),
      error = function(x) {
        NULL
      }
    )
  }

  # return the augment
  return(f)
}
