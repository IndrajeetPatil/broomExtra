# `grouped_tidy()` works ------------------------------------------------------

test_that(
  desc = "`grouped_tidy()` works",
  code = {
    options(tibble.width = Inf)
    library(lme4)

    # broom.mixed
    set.seed(123)
    lmer_df <-
      broomExtra::grouped_tidy(
        data = dplyr::mutate(MASS::Aids2, interval = death - diag),
        grouping.vars = sex,
        ..f = lme4::lmer,
        formula = interval ~ age + (1 | status),
        control = lme4::lmerControl(optimizer = "bobyqa"),
        tidy.args = list(conf.int = TRUE, conf.level = 0.99)
      )

    # broom
    set.seed(123)
    lm_df <-
      broomExtra::grouped_tidy(
        data = dplyr::mutate(MASS::Aids2, interval = death - diag),
        grouping.vars = sex,
        ..f = stats::lm,
        formula = interval ~ age,
        tidy.args = list(conf.int = TRUE, conf.level = 0.99)
      )

    expect_equal(dim(lmer_df), c(8L, 9L))
    expect_equal(dim(lm_df), c(4L, 8L))

    expect_snapshot(list(lmer_df, lm_df))
  }
)

# `grouped_glance()` works ------------------------------------------------------

test_that(
  desc = "`grouped_glance()` works",
  code = {
    library(lme4)
    set.seed(123)

    # broom.mixed
    set.seed(123)
    lmer_df <-
      broomExtra::grouped_glance(
        data = dplyr::mutate(MASS::Aids2, interval = death - diag),
        grouping.vars = sex,
        ..f = lme4::lmer,
        formula = interval ~ age + (1 | status),
        control = lme4::lmerControl(optimizer = "bobyqa")
      )

    # broom
    set.seed(123)
    lm_df <-
      broomExtra::grouped_glance(
        data = dplyr::mutate(MASS::Aids2, interval = death - diag),
        grouping.vars = sex,
        ..f = stats::lm,
        formula = interval ~ age
      )

    expect_equal(dim(lmer_df), c(2L, 7L))
    expect_equal(dim(lm_df)[1], 2L)

    expect_snapshot(list(lmer_df, lm_df))
  }
)

# `grouped_augment()` works ------------------------------------------------------

test_that(
  desc = "`grouped_augment()` works",
  code = {
    library(lme4)

    # broom.mixed
    set.seed(123)
    lmer_df <-
      broomExtra::grouped_augment(
        data = dplyr::mutate(MASS::Aids2, interval = death - diag),
        grouping.vars = sex,
        ..f = lme4::lmer,
        formula = interval ~ age + (1 | status),
        control = lme4::lmerControl(optimizer = "bobyqa")
      )

    # broom
    set.seed(123)
    lm_df <-
      broomExtra::grouped_augment(
        data = dplyr::mutate(MASS::Aids2, interval = death - diag),
        grouping.vars = sex,
        ..f = stats::lm,
        formula = interval ~ age
      )

    expect_equal(dim(lmer_df), c(2843L, 15L))
    expect_equal(dim(lm_df)[1], 2843L)
  }
)
