context("boot_tidy works")

# `boot_tidy()` works ------------------------------------------------------

testthat::test_that(
  desc = "`boot_tidy()` works",
  code = {
    library(lme4)

    # results with broom
    df_broom <- broom.mixed::tidy(
      x = lme4::lmer(
        data = sleepstudy,
        formula = Reaction ~ Days + (Days | Subject)
      ),
      effects = "fixed"
    )

    # results using this package function
    set.seed(123)
    df_boot <- broomExtra::boot_tidy(
      data = sleepstudy,
      times = 25,
      ..f = lme4::lmer,
      formula = Reaction ~ Days + (Days | Subject),
      control = lme4::lmerControl(
        check.conv.grad = .makeCC("ignore", tol = 2e-3, relTol = NULL),
        check.conv.singular = .makeCC(action = "ignore", tol = 1e-4),
        check.conv.hess = .makeCC(action = "ignore", tol = 1e-6)
      ),
      tidy.args = list(effects = "fixed")
    )

    # mean estimate should match with what you get from broom
    df_summary <- df_boot %>%
      dplyr::filter(.data = ., term != "(Intercept)") %>%
      dplyr::summarise(.data = ., mean = mean(estimate), sd = sd(estimate))

    # tests
    testthat::expect_is(df_boot, "tbl_df")
    testthat::expect_equal(dim(df_boot), c(50L, 6L))
    testthat::expect_equal(df_broom$estimate[2], df_summary$mean[1], tolerance = 0.01)
    testthat::expect_equal(df_summary$sd[1], 0.872, tolerance = 0.01)
  }
)
