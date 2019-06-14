context("boot_augment works")

# `boot_augment()` works ------------------------------------------------------

testthat::test_that(
  desc = "`boot_augment()` works",
  code = {

    # results with broom
    set.seed(123)
    df_broom <- broom::augment(
      x = stats::lm(formula = mpg ~ wt, data = mtcars)
    )

    # results using this package function
    set.seed(123)
    df_boot <-
      broomExtra::boot_augment(
        data = mtcars,
        times = 10,
        ..f = stats::lm,
        formula = mpg ~ wt,
        na.action = na.omit,
        augment.args = list(se_fit = TRUE)
      )

    # mean estimate should match with what you get from broom
    df_summary <- df_boot %>%
      dplyr::summarise(.data = ., mean = mean(.resid))

    # tests
    testthat::expect_is(df_boot, "tbl_df")
    testthat::expect_equal(dim(df_boot), c(320L, 11L))
    testthat::expect_equal(mean(df_broom$.resid), df_summary$mean[1], tolerance = 0.00001)
  }
)
