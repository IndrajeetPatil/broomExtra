#' @title Bootstrapped dataframe with model summaries from each sample.
#' @name boot_glance
#' @author Indrajeet Patil
#'
#' @inheritParams grouped_glance
#' @inheritParams rsample::bootstraps
#'
#' @inherit glance return value
#' @inheritSection glance Methods
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
#' broomExtra::boot_glance(
#'   data = mtcars,
#'   times = 500,
#'   ..f = stats::lm,
#'   formula = mpg ~ wt,
#'   na.action = na.omit
#' )
#'
#' # example-2: linear mixed-effects model
#' library(lme4)
#'
#' broomExtra::boot_glance(
#'   data = sleepstudy,
#'   times = 25,
#'   ..f = lme4::lmer,
#'   formula = Reaction ~ Days + (Days | Subject)
#' )
#' @export

# function
boot_glance <- function(data,
                        times = 25,
                        strata = NULL,
                        apparent = FALSE,
                        ..f,
                        ...) {

  # create a bootstrapped dataframe
  boots <-
    rsample::bootstraps(
      data = data,
      times = times,
      strata = strata,
      apparent = apparent
    )

  # `.x` and `.y` arguments, where `.x` is the data
  glance_group <- function(.x, .y) {

    # presumes `..f` will work with these args
    model <- ..f(.y = ..., data = .x)

    # variation on `do.call` to call function with list of arguments
    rlang::exec(.fn = broomExtra::glance, model)
  }

  # execute function for each bootstrapped sample and tidy output
  boots_fits <- boots %>%
    dplyr::mutate(
      .data = .,
      glance_df = purrr::map(
        .x = splits,
        .f = glance_group
      )
    ) %>%
    tidyr::unnest(data = ., glance_df)

  # return the final dataframe
  return(boots_fits)
}
