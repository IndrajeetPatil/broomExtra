context("grouped_augment works")

# `grouped_augment()` works ------------------------------------------------------

testthat::test_that(
  desc = "`grouped_augment()` works",
  code = {
    library(lme4)
    set.seed(123)

    # broom.mixed
    lmer_df <- broomExtra::grouped_augment(
      data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
      grouping.vars = cut,
      ..f = lme4::lmer,
      formula = price ~ carat + (carat | color) - 1,
      control = lme4::lmerControl(optimizer = "bobyqa")
    )
    testthat::expect_equal(dim(lmer_df), c(26970L, 15L))

    # broom
    lm_df <- broomExtra::grouped_augment(
      data = ggplot2::diamonds,
      grouping.vars = c(cut, color),
      ..f = stats::lm,
      formula = price ~ carat - 1
    )
    testthat::expect_equal(dim(lm_df), c(53940L, 10L))
  }
)
