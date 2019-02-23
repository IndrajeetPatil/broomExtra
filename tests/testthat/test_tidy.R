context("tidy works")

# `tidy()` works ------------------------------------------------------

testthat::test_that(
  desc = "`tidy()` works",
  code = {
    library(lme4)
    set.seed(123)

    # broom.mixed
    lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
    testthat::expect_equal(
      broomExtra::tidy(lmm.mod), broom.mixed::tidy(lmm.mod)
    )

    # broom
    lm.mod <- lm(Reaction ~ Days, sleepstudy)
    testthat::expect_equal(broomExtra::tidy(lm.mod), broom::tidy(lm.mod))

    # unsupported
    x <- c(2, 2:4, 4, 4, 5, 5, 7, 7, 7)
    y <- c(1:6, 5:4, 3:1)
    appr <- stats::approx(x, y, xout = x)
    testthat::expect_null(broomExtra::tidy(appr))
  }
)
