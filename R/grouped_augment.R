#' @title Augmented data from grouped analysis of any function that has `data`
#'   argument in its function call.
#' @name grouped_augment
#' @author Indrajeet Patil
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
#'   na.action = na.omit
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
  grouping.vars <-
    as.list(rlang::quo_squash(rlang::enquo(grouping.vars)))
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
  if (utils::packageVersion("dplyr") > "0.8.0") {
    df_results <- data %>%
      dplyr::group_by(.data = ., !!!grouping.vars, .drop = TRUE) %>%
      dplyr::group_modify(.tbl = ., .f = augment_group, keep = TRUE) %>%
      dplyr::ungroup(x = .)
  } else {
    df_results <- data %>%
      dplyr::group_by(.data = ., !!!grouping.vars, .drop = TRUE) %>%
      dplyr::group_map(.tbl = ., .f = augment_group) %>%
      dplyr::ungroup(x = .)
  }

  # return the final dataframe with results
  return(df_results)
}
