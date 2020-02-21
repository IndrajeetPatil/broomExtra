testthat::test_that(
  desc = "easystats_to_tidy_names works as expected",
  code = {
    set.seed(123)

    # example model object
    mod <- stats::lm(formula = wt ~ am * cyl, data = mtcars)

    # `tidy`-fied output
    df <- easystats_to_tidy_names(parameters::model_parameters(mod))

    testthat::expect_is(df, "tbl_df")
    testthat::expect_identical(
      names(df),
      c(
        "term", "estimate", "std.error", "conf.low", "conf.high", "statistic",
        "df.error", "p.value"
      )
    )
    testthat::expect_equal(dim(df), c(4L, 8L))
  }
)
