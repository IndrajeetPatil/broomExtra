#' @name tidy_parameters
#' @title Tidy dataframes of model parameters using `broom` and `easystats`.
#' @description Computes parameters for regression models.
#' @inheritParams tidy
#' @param conf.int Indicating whether or not to include a confidence interval in
#'   the tidied output.
#' @return A data frame of indices related to the model's parameters.
#' @details The function will attempt to get these details either using
#'   `broom::tidy` or `parameters::model_parameters`.
#'
#' @examples
#' set.seed(123)
#' mod <- lm(mpg ~ wt + cyl, data = mtcars)
#' broomExtra::tidy_parameters(mod)
#' @importFrom rlang is_null
#' @importFrom parameters model_parameters p_value
#'
#' @export

tidy_parameters <- function(x, conf.int = TRUE, ...) {
  # broom family --------------------------------------------
  # check if `broom` family has a tidy method for a given object
  m <- tryCatch(
    expr = broomExtra::tidy(x, conf.int = conf.int, ...),
    error = function(e) NULL
  )

  if (rlang::is_null(m)) {
    m <- tryCatch(
      expr = broomExtra::tidy(x, conf.int = conf.int),
      error = function(e) NULL
    )
  }

  # easystats family ---------------------------------------
  # check if `easystats` family has a tidy method for a given object
  if (rlang::is_null(m)) {
    m <- tryCatch(
      expr = parameters::model_parameters(x, ...) %>%
        easystats_to_tidy_names(.),
      error = function(e) NULL
    )
  }

  if (rlang::is_null(m)) {
    m <- tryCatch(
      expr = parameters::model_parameters(x) %>%
        easystats_to_tidy_names(.),
      error = function(e) NULL
    )
  }

  # p-value check -----------------------------------------------
  if (!rlang::is_null(m) && !"p.value" %in% names(m)) {
    tryCatch(
      expr = m %<>%
        dplyr::full_join(
          x = .,
          y = parameters::p_value(x, ...) %>%
            dplyr::rename(.data = ., p.value = p),
          by = c("term" = "Parameter")
        ) %>%
        dplyr::filter(.data = ., !is.na(estimate)) %>%
        as_tibble(.),
      error = function(e) m
    )
  }

  # last attempt: dataframe ---------------------------------------
  # if not, try to convert it to a tibble (relevant for dataframe)
  if (rlang::is_null(m)) {
    m <- tryCatch(
      expr = as_tibble(x, ...),
      error = function(e) NULL
    )
  }

  # return the final object
  return(m)
}


#' @name glance_performance
#' @title Model performance summary dataframes using `broom` and `easystats`.
#' @description Computes indices of model performance for regression models.
#' @inheritParams glance
#' @return A data frame (with one row) and one column per "index".
#'
#' @details The function will attempt to get these details either using
#'   `broom::glance` or `performance::model_performance`. If both function
#'   provide model performance measure summaries, the function will try to
#'   combine them into a single dataframe.
#'
#' @examples
#' set.seed(123)
#' mod <- lm(mpg ~ wt + cyl, data = mtcars)
#' broomExtra::glance_performance(mod)
#' @importFrom dplyr select intersect
#' @importFrom rlang is_null
#' @importFrom performance model_performance
#'
#' @export

glance_performance <- function(x, ...) {
  # broom family --------------------------------------------
  # check if `broom` family has a tidy method for a given object
  df_broom <- tryCatch(
    expr = broomExtra::glance(x),
    error = function(e) NULL
  )

  # for consistency with `performance` output, convert column names to lowercase
  if (!rlang::is_null(df_broom)) df_broom %<>% dplyr::rename_all(., .f = tolower)

  # easystats family ---------------------------------------
  # check if `easystats` family has a tidy method for a given object
  df_performance <- tryCatch(
    expr = performance::model_performance(x, metrics = "all") %>%
      easystats_to_tidy_names(.),
    error = function(e) NULL
  )

  # marry the families ---------------------------------------
  # combine if both are available
  if (!rlang::is_null(df_broom) && !rlang::is_null(df_performance)) {
    df_combined <-
      dplyr::bind_cols(
        df_broom,
        dplyr::select(df_performance, -dplyr::intersect(names(df_broom), names(df_performance))),
      )
  }

  # otherwise return what's not a `NULL`
  if (rlang::is_null(df_broom)) df_combined <- df_performance
  if (rlang::is_null(df_performance)) df_combined <- df_broom

  # return the final object
  return(df_combined)
}
