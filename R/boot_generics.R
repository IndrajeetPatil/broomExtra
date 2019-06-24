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

#' @title Bootstrapped dataframe with augmented predictions from each sample.
#' @name boot_augment
#' @author Indrajeet Patil
#'
#' @inheritParams grouped_augment
#' @inheritParams rsample::bootstraps
#'
#' @inherit augment return value
#' @inheritSection augment Methods
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
#' broomExtra::boot_augment(
#'   data = mtcars,
#'   times = 10,
#'   ..f = stats::lm,
#'   formula = mpg ~ wt,
#'   na.action = na.omit
#' )
#'
#' # example-2: linear mixed-effects model
#' library(lme4)
#'
#' broomExtra::boot_augment(
#'   data = sleepstudy,
#'   times = 25,
#'   ..f = lme4::lmer,
#'   formula = Reaction ~ Days + (Days | Subject)
#' )
#' @export

# function
boot_augment <- function(data,
                         times = 25,
                         strata = NULL,
                         apparent = FALSE,
                         ..f,
                         ...,
                         augment.args = list()) {

  # create a bootstrapped dataframe
  boots <-
    rsample::bootstraps(
      data = data,
      times = times,
      strata = strata,
      apparent = apparent
    )

  # `.x` and `.y` arguments, where `.x` is the data
  augment_group <- function(.x, .y) {

    # presumes `..f` will work with these args
    model <- ..f(.y = ..., data = .x)

    # variation on `do.call` to call function with list of arguments
    rlang::exec(.fn = broomExtra::augment, model, !!!augment.args)
  }

  # execute function for each bootstrapped sample and tidy output
  boots_fits <- boots %>%
    dplyr::mutate(
      .data = .,
      augment_df = purrr::map(
        .x = splits,
        .f = augment_group
      )
    ) %>%
    tidyr::unnest(data = ., augment_df)

  # return the final dataframe
  return(boots_fits)
}
