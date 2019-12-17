#' @title Tidy output from grouped analysis of any function that has `data`
#'   argument in its function call.
#' @name grouped_tidy
#' @author \href{https://github.com/IndrajeetPatil}{Indrajeet Patil}
#'
#' @param data Dataframe (or tibble) from which variables are to be taken.
#' @param grouping.vars Grouping variables.
#' @param ..f A function, or function name as a string.
#' @inheritParams rlang::exec
#' @param tidy.args A list of arguments to be used in the relevant `S3` method.
#'
#' @note For available methods, see-
#' \url{https://indrajeetpatil.github.io/broomExtra/articles/available_methods.html}
#'
#' @importFrom rlang !! !!! exec quo_squash enquo
#' @importFrom dplyr group_by ungroup mutate group_map
#'
#' @inherit tidy return value
#' @inheritSection tidy Methods
#'
#' @seealso \code{\link{tidy}}
#'
#' @examples
#' set.seed(123)
#' # to speed up computation, let's use only 50% of the data
#'
#' # linear model
#' broomExtra::grouped_tidy(
#'   data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
#'   grouping.vars = c(cut, color),
#'   formula = price ~ carat - 1,
#'   ..f = stats::lm,
#'   na.action = na.omit,
#'   tidy.args = list(quick = TRUE)
#' )
#'
#' # linear mixed effects model
#' broomExtra::grouped_tidy(
#'   data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
#'   grouping.vars = cut,
#'   ..f = lme4::lmer,
#'   formula = price ~ carat + (carat | color) - 1,
#'   control = lme4::lmerControl(optimizer = "bobyqa"),
#'   tidy.args = list(conf.int = TRUE, conf.level = 0.99)
#' )
#' @export

# function body
grouped_tidy <- function(data,
                         grouping.vars,
                         ..f,
                         ...,
                         tidy.args = list()) {
  # check how many variables were entered for grouping variable vector
  grouping.vars <- as.list(rlang::quo_squash(rlang::enquo(grouping.vars)))
  grouping.vars <-
    if (length(grouping.vars) == 1) {
      grouping.vars
    } else {
      grouping.vars[-1]
    }

  # functions passed to `group_map` must accept
  # `.x` and `.y` arguments, where `.x` is the data
  tidy_group <- function(.x, .y) {

    # presumes `..f` will work with these args
    model <- ..f(.y = ..., data = .x)

    # variation on `do.call` to call function with list of arguments
    rlang::exec(.fn = broomExtra::tidy, model, !!!tidy.args)
  }

  # dataframe with grouped analysis results
  df_results <- data %>%
    dplyr::group_by(.data = ., !!!grouping.vars, .drop = TRUE) %>%
    dplyr::group_modify(.f = tidy_group, keep = TRUE) %>%
    dplyr::ungroup(x = .)

  # return the final dataframe with results
  return(df_results)
}

#' @title Model summary output from grouped analysis of any function that has
#'   `data` argument in its function call.
#' @name grouped_glance
#' @author \href{https://github.com/IndrajeetPatil}{Indrajeet Patil}
#'
#' @note For available methods, see-
#' \url{https://indrajeetpatil.github.io/broomExtra/articles/available_methods.html}
#'
#' @inheritParams grouped_tidy
#'
#' @importFrom rlang !! !!! exec quo_squash enquo
#' @importFrom dplyr group_by ungroup mutate group_map group_modify
#'
#' @inherit glance return value
#' @inheritSection glance Methods
#'
#' @seealso \code{\link{glance}}
#'
#' @examples
#' set.seed(123)
#' # to speed up computation, let's use only 50% of the data
#'
#' # linear model
#' broomExtra::grouped_glance(
#'   data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
#'   grouping.vars = c(cut, color),
#'   formula = price ~ carat - 1,
#'   ..f = stats::lm,
#'   na.action = na.omit
#' )
#'
#' # linear mixed effects model
#' broomExtra::grouped_glance(
#'   data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
#'   grouping.vars = cut,
#'   ..f = lme4::lmer,
#'   formula = price ~ carat + (carat | color) - 1,
#'   control = lme4::lmerControl(optimizer = "bobyqa")
#' )
#' @export

# function body
grouped_glance <- function(data,
                           grouping.vars,
                           ..f,
                           ...) {
  # check how many variables were entered for grouping variable vector
  grouping.vars <- as.list(rlang::quo_squash(rlang::enquo(grouping.vars)))
  grouping.vars <-
    if (length(grouping.vars) == 1) {
      grouping.vars
    } else {
      grouping.vars[-1]
    }

  # functions passed to `group_map` must accept
  # `.x` and `.y` arguments, where `.x` is the data
  glance_group <- function(.x, .y) {

    # presumes `..f` will work with these args
    model <- ..f(.y = ..., data = .x)

    # variation on `do.call` to call function with list of arguments
    rlang::exec(.fn = broomExtra::glance, model)
  }

  # dataframe with grouped analysis results
  df_results <- data %>%
    dplyr::group_by(.data = ., !!!grouping.vars, .drop = TRUE) %>%
    dplyr::group_modify(.f = glance_group, keep = TRUE) %>%
    dplyr::ungroup(x = .)

  # return the final dataframe with results
  return(df_results)
}

#' @title Augmented data from grouped analysis of any function that has `data`
#'   argument in its function call.
#' @name grouped_augment
#' @author \href{https://github.com/IndrajeetPatil}{Indrajeet Patil}
#'
#' @note For available methods, see-
#' \url{https://indrajeetpatil.github.io/broomExtra/articles/available_methods.html}
#'
#' @inheritParams grouped_tidy
#' @param augment.args A list of arguments to be used in the relevant `S3` method.
#'
#' @importFrom rlang !! !!! exec quo_squash enquo
#' @importFrom dplyr group_by ungroup mutate group_map
#'
#' @inherit augment return value
#' @inheritSection augment Methods
#'
#' @seealso \code{\link{augment}}
#'
#' @examples
#' set.seed(123)
#' # to speed up computation, let's use only 50% of the data
#'
#' # linear model
#' broomExtra::grouped_augment(
#'   data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
#'   grouping.vars = c(cut, color),
#'   formula = price ~ carat - 1,
#'   ..f = stats::lm,
#'   na.action = na.omit,
#'   augment.args = list(se_fit = TRUE)
#' )
#'
#' # linear mixed effects model
#' broomExtra::grouped_augment(
#'   data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
#'   grouping.vars = cut,
#'   ..f = lme4::lmer,
#'   formula = price ~ carat + (carat | color) - 1,
#'   control = lme4::lmerControl(optimizer = "bobyqa")
#' )
#' @export

# function body
grouped_augment <- function(data,
                            grouping.vars,
                            ..f,
                            ...,
                            augment.args = list()) {
  # check how many variables were entered for grouping variable vector
  grouping.vars <- as.list(rlang::quo_squash(rlang::enquo(grouping.vars)))
  grouping.vars <-
    if (length(grouping.vars) == 1) {
      grouping.vars
    } else {
      grouping.vars[-1]
    }

  # functions passed to `group_map` must accept
  # `.x` and `.y` arguments, where `.x` is the data
  augment_group <- function(.x, .y) {

    # presumes `..f` will work with these args
    model <- ..f(.y = ..., data = .x)

    # variation on `do.call` to call function with list of arguments
    rlang::exec(.fn = broomExtra::augment, model, !!!augment.args)
  }

  # dataframe with grouped analysis results
  df_results <- data %>%
    dplyr::group_by(.data = ., !!!grouping.vars, .drop = TRUE) %>%
    dplyr::group_modify(.f = augment_group, keep = TRUE) %>%
    dplyr::ungroup(x = .)

  # return the final dataframe with results
  return(df_results)
}
