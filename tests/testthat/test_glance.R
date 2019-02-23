context("glance works")

# `glance()` works ------------------------------------------------------

testthat::test_that(
  desc = "`glance()` works",
  code = {
    library(lme4)
    set.seed(123)

    # broom.mixed
    lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
    testthat::expect_equal(
      broomExtra::glance(lmm.mod), broom.mixed::glance(lmm.mod)
    )

    # broom
    lm.mod <- lm(Reaction ~ Days, sleepstudy)
    testthat::expect_equal(broomExtra::glance(lm.mod), broom::glance(lm.mod))

    # unsupported
    x <- c(2, 2:4, 4, 4, 5, 5, 7, 7, 7)
    y <- c(1:6, 5:4, 3:1)
    appr <- stats::approx(x, y, xout = x)
    testthat::expect_null(broomExtra::glance(appr))
  }
)
