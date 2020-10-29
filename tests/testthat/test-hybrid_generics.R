# hybrid methods work ------------------------------------------------------

testthat::test_that(
  desc = "hybrid methods works",
  code = {
    testthat::skip_on_cran()

    library(lme4)
    # merMord
    set.seed(123)
    lmm_mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
    df_lmm <- tidy_parameters(lmm_mod, effects = "fixed")

    # test
    testthat::expect_equal(
      df_lmm$estimate,
      c(251.40510, 10.46729),
      tolerance = 0.001
    )

    testthat::expect_equal(
      dim(glance_performance(lmm_mod, effects = "fixed")), c(1L, 10L)
    )

    # lm
    set.seed(123)
    lm_mod <- lm(Reaction ~ Days, sleepstudy)
    df_lm <- tidy_parameters(lm_mod, robust = TRUE)

    # test
    testthat::expect_equal(df_lm$estimate[1], 251.4051, tolerance = 0.001)

    testthat::expect_equal(
      dim(glance_performance(lm_mod, effects = "fixed"))[[1]], 1L
    )

    # setup
    set.seed(123)
    library(lavaan)

    # model specs
    HS.model <- " visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 "

    # model
    mod_lavaan <-
      lavaan(
        HS.model,
        data = HolzingerSwineford1939,
        auto.var = TRUE,
        auto.fix.first = TRUE,
        auto.cov.lv.x = TRUE
      )

    # test
    testthat::expect_identical(
      tidy_parameters(mod_lavaan, effects = "fixed"),
      tidy_parameters(mod_lavaan, effects = "fixed", exponentiate = TRUE)
    )

    # p-value check
    library(MASS)
    mod <- rlm(stack.loss ~ ., stackloss)
    df_rlm <- tidy_parameters(mod)
    df <- suppressMessages(suppressWarnings(tidy_parameters(tidy(mod))))

    # test
    testthat::expect_equal(dim(df_rlm), c(4L, 8L))
    testthat::expect_is(df, "tbl_df")

    # model (not covered by easystats but covered by broom)
    testthat::expect_equal(
      dim(broomExtra::tidy_parameters(acf(lh, plot = FALSE))),
      c(17L, 2L)
    )

    # where functions are not supposed to work
    testthat::expect_null(broomExtra::glance_performance(acf(lh, plot = FALSE)))
    testthat::expect_null(broomExtra::tidy_parameters(list(1, c("x", "y")), verbose = FALSE))
  }
)
