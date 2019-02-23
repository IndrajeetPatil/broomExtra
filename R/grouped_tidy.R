#' @title Tidy output from grouped analysis of any function that has `data`
#'   argument in its function call.
#' @name grouped_tidy
#' @author Indrajeet Patil
#'
#' @param data Dataframe (or tibble) from which variables are to be taken.
#' @param grouping.vars Grouping variables.
#' @param ..f A function, or function name as a string.
#' @inheritParams rlang::exec
#' @param tidy.args A list of arguments to be used in the relevant `S3` method.
#'
#' @importFrom rlang !! !!! exec quo_squash enquo
#' @importFrom dplyr group_by ungroup mutate group_map
#'
#' @examples
#' set.seed(123)
#'
#' # linear model
#' grouped_tidy(
#'   data = mtcars,
#'   grouping.vars = c(cyl),
#'   formula = wt ~ am - 1,
#'   ..f = stats::lm,
#'   na.action = na.omit,
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
  tidy_group <- function(.x, .y) {

    # presumes `..f` will work with these args
    model <- ..f(.y = ..., data = .x)

    # variation on `do.call` to call function with list of arguments
    rlang::exec(.fn = broomExtra::tidy, model, !!!tidy.args)
  }

  # dataframe with grouped analysis results
  df_results <- data %>%
    dplyr::group_by(.data = ., !!!grouping.vars, .drop = TRUE) %>%
    dplyr::group_map(.tbl = ., .f = tidy_group) %>%
    dplyr::ungroup(x = .)

  # return the final dataframe with results
  return(df_results)
}
