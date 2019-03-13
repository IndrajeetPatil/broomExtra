context("grouped_glance works")

# `grouped_glance()` works ------------------------------------------------------

testthat::test_that(
  desc = "`grouped_glance()` works",
  code = {
    library(lme4)
    set.seed(123)

    # broom.mixed
    lmer_df <- broomExtra::grouped_glance(
      data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
      grouping.vars = cut,
      ..f = lme4::lmer,
      formula = price ~ carat + (carat | color) - 1,
      control = lme4::lmerControl(optimizer = "bobyqa")
    )
    testthat::expect_equal(dim(lmer_df), c(5L, 7L))

    # broom
    lm_df <- broomExtra::grouped_glance(
      data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.1),
      grouping.vars = color,
      ..f = stats::lm,
      formula = price ~ carat
    )
    testthat::expect_equal(dim(lm_df)[1], 7L)
  }
)
