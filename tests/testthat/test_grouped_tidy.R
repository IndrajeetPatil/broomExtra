context("grouped_tidy works")

# `grouped_tidy()` works ------------------------------------------------------

testthat::test_that(
  desc = "`grouped_tidy()` works",
  code = {
    library(lme4)
    set.seed(123)

    # broom.mixed
    lmer_df <- broomExtra::grouped_tidy(
      data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
      grouping.vars = cut,
      ..f = lme4::lmer,
      formula = price ~ carat + (carat | color) - 1,
      control = lme4::lmerControl(optimizer = "bobyqa"),
      tidy.args = list(conf.int = TRUE, conf.level = 0.99)
    )
    testthat::expect_equal(dim(lmer_df), c(25L, 9L))

    # broom
    lm_df <- broomExtra::grouped_tidy(
      data = ggplot2::diamonds,
      grouping.vars = c(cut, color),
      ..f = stats::lm,
      formula = price ~ carat - 1,
      tidy.args = list(conf.int = TRUE, conf.level = 0.99)
    )
    testthat::expect_equal(dim(lm_df), c(35L, 9L))
  }
)
