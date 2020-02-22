# hybrid methods work ------------------------------------------------------

testthat::test_that(
  desc = "hybrid methods works",
  code = {
    library(lme4)
    # merMord
    set.seed(123)
    lmm_mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)

    # test
    testthat::expect_equal(
      tidy(lmm_mod, conf.int = TRUE, effects = "fixed"),
      dplyr::select(tidy_parameters(lmm_mod, effects = "fixed"), -p.value)
    )
    testthat::expect_equal(
      glance(lmm_mod, conf.int = TRUE, effects = "fixed"),
      glance_performance(lmm_mod, effects = "fixed")
    )

    # lm
    set.seed(123)
    lm_mod <- lm(Reaction ~ Days, sleepstudy)

    # test
    testthat::expect_equal(
      tidy(lm_mod, conf.int = TRUE, effects = "fixed"),
      tidy_parameters(lm_mod, effects = "fixed")
    )
    testthat::expect_equal(
      glance(lm_mod, conf.int = TRUE, effects = "fixed"),
      glance_performance(lm_mod, effects = "fixed")
    )

    # mixor object
    set.seed(123)
    library(mixor)
    data("SmokingPrevention")
    SmokingPrevention <- SmokingPrevention[order(SmokingPrevention$class), ]
    suppressWarnings(mod_mixor <-
      mixor(
        formula = thksord ~ thkspre + cc + tv + cctv,
        data = SmokingPrevention,
        id = school,
        link = "logit"
      ))

    # test
    testthat::expect_equal(dim(tidy_parameters(mod_mixor)), c(8L, 8L))
    testthat::expect_equal(
      tidy_parameters(mod_mixor),
      tidy_parameters(mod_mixor, effects = "fixed")
    )
    testthat::expect_equal(dim(glance_performance(mod_mixor)), c(1L, 2L))

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
    df <- tidy_parameters(tidy(mod))

    # test
    testthat::expect_equal(dim(df_rlm), c(4L, 7L))
    testthat::expect_is(df, "tbl_df")
    testthat::expect_equal(df$p.value[[1]], NA_real_)
  }
)
