#' @title Retrieve tidy dataframe if it exists.
#' @name tidy
#' @description Check if a `tidy` method exits for a given object, either in
#'   `broom` or in `broom.mixed`. If it does, return the model summary
#'   dataframe, if not, return a `NULL`.
#'
#' @inheritParams generics::tidy
#'
#' @importFrom broom tidy
#' @importFrom broom.mixed tidy
#'
#' @examples
#' \dontrun{
#' library(lme4)
#'
#' # mixed-effects models (`broom.mixed` will be used)
#' lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
#' broomExtra::tidy(lmm.mod, effects = "fixed")
#'
#' # linear model (`broom` will be used)
#' lm.mod <- lm(Reaction ~ Days, sleepstudy)
#' broomExtra::tidy(lm.mod, exponentiate = TRUE, conf.int = TRUE)
#'
#' # anova (`broom` will be used)
#' broomExtra::tidy(stats::anova(stats::lm(wt ~ am, mtcars)))
#' }
#'
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
