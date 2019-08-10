context("boot_generics work")

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
    testthat::expect_equal(dim(df_boot), c(50L, 8L))
    testthat::expect_equal(df_broom$estimate[2], df_summary$mean[1], tolerance = 0.01)
    testthat::expect_equal(df_summary$sd[1], 0.872, tolerance = 0.01)
  }
)

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
    testthat::expect_equal(dim(df_boot), c(25L, 9L))
    testthat::expect_equal(1696, df_summary$mean[1], tolerance = 1)
    testthat::expect_equal(length(unique(df_boot$df.residual)), 1L)
  }
)

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
    testthat::expect_equal(dim(df_boot), c(320L, 13L))
    testthat::expect_equal(mean(df_broom$.resid), df_summary$mean[1], tolerance = 0.00001)
  }
)
