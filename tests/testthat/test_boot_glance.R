context("boot_glance works")

# `boot_glance()` works ------------------------------------------------------

testthat::test_that(
  desc = "`boot_glance()` works",
  code = {
    library(lme4)

    # results with broom
    set.seed(123)
    df_broom <- broom.mixed::glance(
      x = lme4::lmer(
        data = sleepstudy,
        formula = Reaction ~ Days + (Days | Subject)
      )
    )

    # results using this package function
    set.seed(123)
    df_boot <- broomExtra::boot_glance(
      data = sleepstudy,
      times = 25,
      ..f = lme4::lmer,
      formula = Reaction ~ Days + (Days | Subject),
      control = lme4::lmerControl(
        check.conv.grad = .makeCC("ignore", tol = 2e-3, relTol = NULL),
        check.conv.singular = .makeCC(action = "ignore", tol = 1e-4),
        check.conv.hess = .makeCC(action = "ignore", tol = 1e-6)
      )
    )

    # mean estimate should match with what you get from broom
    df_summary <- df_boot %>%
      dplyr::summarise(.data = ., mean = mean(REMLcrit))

    # tests
    testthat::expect_is(df_boot, "tbl_df")
    testthat::expect_equal(dim(df_boot), c(25L, 8L))
    testthat::expect_equal(1696, df_summary$mean[1], tolerance = 1)
    testthat::expect_equal(length(unique(df_boot$df.residual)), 1L)
  }
)
