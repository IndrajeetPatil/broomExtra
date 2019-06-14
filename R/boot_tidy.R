#' @title Bootstrapped dataframe with estimates from each sample.
#' @name boot_tidy
#' @author Indrajeet Patil
#'
#' @inheritParams grouped_tidy
#' @inheritParams rsample::bootstraps
#'
#' @inherit tidy return value
#' @inheritSection tidy Methods
#'
#' @importFrom rlang !! !!! exec
#' @importFrom dplyr mutate
#' @importFrom purrr map
#' @importFrom tidyr unnest
#' @importFrom rsample bootstraps
#'
#' @examples
#' set.seed(123)
#'
#' # example-1: linear model
#' broomExtra::boot_tidy(
#'   data = mtcars,
#'   times = 500,
#'   ..f = stats::lm,
#'   formula = mpg ~ wt,
#'   na.action = na.omit,
#'   tidy.args = list(conf.int = TRUE, conf.level = 0.50)
#' )
#'
#' # example-2: linear mixed-effects model
#' library(lme4)
#'
#' broomExtra::boot_tidy(
#'   data = sleepstudy,
#'   times = 25,
#'   ..f = lme4::lmer,
#'   formula = Reaction ~ Days + (Days | Subject),
#'   tidy.args = list(effects = "fixed")
#' )
#' @export

# function
boot_tidy <- function(data,
                      times = 25,
                      strata = NULL,
                      apparent = FALSE,
                      ..f,
                      ...,
                      tidy.args = list()) {

  # create a bootstrapped dataframe
  boots <-
    rsample::bootstraps(
      data = data,
      times = times,
      strata = strata,
      apparent = apparent
    )

  # `.x` and `.y` arguments, where `.x` is the data
  tidy_group <- function(.x, .y) {

    # presumes `..f` will work with these args
    model <- ..f(.y = ..., data = .x)

    # variation on `do.call` to call function with list of arguments
    rlang::exec(.fn = broomExtra::tidy, model, !!!tidy.args)
  }

  # execute function for each bootstrapped sample and tidy output
  boots_fits <- boots %>%
    dplyr::mutate(
      .data = .,
      tidy_df = purrr::map(
        .x = splits,
        .f = tidy_group
      )
    ) %>%
    tidyr::unnest(data = ., tidy_df)

  # return the final dataframe
  return(boots_fits)
}
