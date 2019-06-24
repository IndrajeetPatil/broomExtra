context("generics work")

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
    suppressWarnings(appr <- stats::approx(x, y, xout = x))
    testthat::expect_null(broomExtra::tidy(appr))
  }
)

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
    suppressWarnings(appr <- stats::approx(x, y, xout = x))
    testthat::expect_null(broomExtra::glance(appr))
  }
)

# `augment()` works ------------------------------------------------------

testthat::test_that(
  desc = "`augment()` works",
  code = {
    library(lme4)
    set.seed(123)

    # broom.mixed
    lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
    testthat::expect_equal(
      broomExtra::augment(lmm.mod), broom.mixed::augment(lmm.mod)
    )

    # broom
    lm.mod <- lm(Reaction ~ Days, sleepstudy)
    testthat::expect_equal(broomExtra::augment(lm.mod), broom::augment(lm.mod))

    # unsupported
    testthat::expect_null(
      broomExtra::augment(stats::anova(stats::lm(wt ~ am, mtcars)))
    )
  }
)
