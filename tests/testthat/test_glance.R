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
    testthat::expect_null(
      broomExtra::glance(stats::anova(stats::lm(wt ~ am, mtcars))), NULL
    )
  }
)
