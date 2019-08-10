#' @title Bootstrapped dataframe with estimates from each sample.
#' @name boot_tidy
#' @author Indrajeet Patil
#'
#' @note For available methods, see-
#' \url{https://indrajeetpatil.github.io/broomExtra/articles/available_methods.html}
#'
#' @inheritParams grouped_tidy
#' @inheritParams rsample::bootstraps
#'
#' @inherit tidy return value
#' @inheritSection tidy Methods
#'
#' @seealso \code{\link{grouped_tidy}}, \code{\link{tidy}}
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

  # return the final dataframe
  return(boot_unnest(boots, tidy_group))
}

#' @title Bootstrapped dataframe with model summaries from each sample.
#' @name boot_glance
#' @author Indrajeet Patil
#'
#' @note For available methods, see-
#' \url{https://indrajeetpatil.github.io/broomExtra/articles/available_methods.html}
#'
#' @inheritParams grouped_glance
#' @inheritParams rsample::bootstraps
#'
#' @inherit glance return value
#' @inheritSection glance Methods
#'
#' @seealso \code{\link{grouped_glance}}, \code{\link{glance}}
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

  # return the final dataframe
  return(boot_unnest(boots, glance_group))
}

#' @title Bootstrapped dataframe with augmented predictions from each sample.
#' @name boot_augment
#' @author Indrajeet Patil
#'
#' @note For available methods, see-
#' \url{https://indrajeetpatil.github.io/broomExtra/articles/available_methods.html}
#'
#' @inheritParams grouped_augment
#' @inheritParams rsample::bootstraps
#'
#' @inherit augment return value
#' @inheritSection augment Methods
#'
#' @seealso \code{\link{grouped_augment}}, \code{\link{augment}}
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

  # return the final dataframe
  return(boot_unnest(boots, augment_group))
}


#' @noRd
#' @keywords internal

boot_unnest <- function(boots, .f_boot) {
  boots %>%
    dplyr::mutate(
      .data = .,
      results = purrr::map(
        .x = splits,
        .f = .f_boot
      )
    ) %>%
    tidyr::unnest(
      .,
      results,
      .drop = FALSE,
      .preserve = "results"
    )
}
