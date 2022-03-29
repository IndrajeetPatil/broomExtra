# hybrid methods work ------------------------------------------------------

test_that(
  desc = "hybrid methods works",
  code = {
    options(tibble.width = Inf)
    library(lme4)

    # merMord
    set.seed(123)
    lmm_mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
    lmm_tidy <- tidy_parameters(lmm_mod, effects = "fixed")
    lmm_glance <- glance_performance(lmm_mod)

    expect_snapshot(lmm_tidy)
    expect_snapshot(lmm_glance)

    # lm
    set.seed(123)
    lm_mod <- lm(Reaction ~ Days, sleepstudy)
    lm_tidy <- tidy_parameters(lm_mod, vcov = TRUE)
    lm_glance <- glance_performance(lm_mod)

    expect_snapshot(lm_tidy)
    expect_snapshot(lm_glance)

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
    expect_identical(
      tidy_parameters(mod_lavaan, effects = "fixed"),
      tidy_parameters(mod_lavaan, effects = "fixed", exponentiate = TRUE)
    )

    # p-value check
    library(MASS)
    set.seed(123)
    mod <- rlm(stack.loss ~ ., stackloss)
    df_rlm <- tidy_parameters(mod)
    df <- suppressMessages(suppressWarnings(tidy_parameters(tidy(mod))))

    # test
    expect_snapshot(df_rlm)
    expect_equal(dim(df_rlm)[[1]], 4L)
    expect_s3_class(df, "tbl_df")

    # model (not covered by easystats but covered by broom)
    expect_equal(
      dim(suppressWarnings(broomExtra::tidy_parameters(acf(lh, plot = FALSE)))),
      c(17L, 2L)
    )

    # where functions are not supposed to work
    expect_null(suppressWarnings(broomExtra::glance_performance(acf(lh, plot = FALSE))))
    expect_null(broomExtra::tidy_parameters(list(1, c("x", "y")), verbose = FALSE))
  }
)
