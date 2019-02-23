context("augment works")

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
      broomExtra::augment(stats::anova(stats::lm(wt ~ am, mtcars))), NULL
    )
  }
)
