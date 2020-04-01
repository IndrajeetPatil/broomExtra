#' @name easystats_to_tidy_names
#' @title Convert `easystats` package outputs to `tidymodels` conventions.
#' @description Both `broom` package from `tidymodels` universe and `parameters`
#'   package from `easystats` universe can provide model summaries for a large
#'   number of model objects. This is a convenience function that converts
#'   naming conventions adopted in `easystats` to the ones adopted in the
#'   `broom` package.
#'
#' @param x A statistical model object
#'
#' @importFrom dplyr rename_all recode
#'
#' @examples
#' # example model object
#' mod <- stats::lm(formula = wt ~ am * cyl, data = mtcars)
#'
#' # `tidy`-fied output
#' easystats_to_tidy_names(parameters::model_parameters(mod))
#' @export

easystats_to_tidy_names <- function(x) {
  tibble::as_tibble(x) %>%
    dplyr::rename_all(
      .tbl = .,
      .funs = tolower
    ) %>%
    dplyr::rename_all(
      .tbl = .,
      .funs = ~ gsub(
        x = .,
        pattern = "_",
        replacement = "."
      )
    ) %>%
    dplyr::rename_all(
      .tbl = .,
      .funs = dplyr::recode,
      # parameters
      "parameter" = "term",
      "coefficient" = "estimate",
      "median" = "estimate",
      "se" = "std.error",
      "ci.low" = "conf.low",
      "ci.high" = "conf.high",
      "f" = "statistic",
      "t" = "statistic",
      "z" = "statistic",
      "p" = "p.value",
      # effectsize
      "cohens.d" = "estimate",
      "hedges.g" = "estimate",
      # correlation
      # "df" = "parameter",
      "r" = "estimate",
      "rho" = "estimate",
      "s" = "statistic",
      # performance
      "r2" = "r.squared",
      "r2.adjusted" = "adj.r.squared"
    )
}
