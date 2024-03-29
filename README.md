
<!-- README.md is generated from README.Rmd. Please edit that file -->

## `{broomExtra}`: Enhancement for `{broom}` and `{easystats}`

[![lifecycle](https://img.shields.io/badge/lifecycle-deprecated-red.svg)](https://lifecycle.r-lib.org/articles/stages.html#deprecated)

<img src="man/figures/logo.png" align="right" width="240" />

<!-- The goal of `{broomExtra}` is to provide helper functions that assist in data -->
<!-- analysis workflows involving regression analyses. The goal is to combine the -->
<!-- functionality offered by different set of packages through a common syntax to -->
<!-- return tidy tibbles containing model parameters and summaries. -->
<!-- It combines functionality from `{broom}` and `{easystats}` ecosystems, and this package has the -->
<!-- following advantages over the underlying individual packages (see examples -->
<!-- below for concrete instantiations of these benefits): -->
<!--   - Covers more number of regression models than these individual packages. -->
<!--   - If possible to compute, the output tibbles contains a *p*-value column. -->
<!--   - More robust to extraneous input arguments that might sometimes cause -->
<!--     problems for the underlying methods. -->
<!--   - Follows consistent `{tidymodels}` column-naming schema. -->
<!--   - Returns a more comprehensive model performance measure summary. -->
<!-- If you want to add support for a regression model, the natural place to do this -->
<!-- would be to contribute either to `{broom}` or to `{parameters}`. -->

This package has been archived on CRAN. Additionally, it is deprecated
in favour of the [easystats](https://easystats.github.io/easystats/)
project.

The package can still be downloaded from GitHub:
`pak::pak("IndrajeetPatil/broomExtra")`

<!-- ## Lifecycle -->
<!-- Function | Lifecycle -->
<!-- ------------------------ | -----  -->
<!-- `tidy_parameters` | [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html) -->
<!-- `glance_performance` | [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html) -->
<!-- `tidy`, `glance`, `augment` | [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html) -->
<!-- `grouped_tidy`, `grouped_glance`, `grouped_augment` | [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html) -->
<!-- ## Hybrid generics -->
<!-- The `{broom}`-family of packages are not the only ones which return such tidy -->
<!-- summaries for model parameters and model performance. The `{easystats}`-family of -->
<!-- packages also provide similar functions, more specifically -->
<!-- [parameters](https://easystats.github.io/parameters/) and -->
<!-- [performance](https://easystats.github.io/performance/). Sometimes the `{broom}` -->
<!-- packages might not contain a `tidy`/`glance` method for a given regression -->
<!-- object, while `{easystats}` packages would and *vice versa*.  -->
<!-- The hybrid functions in `{broomExtra}` make it easy to retrieve these summaries -->
<!-- with the appropriate method and do so robustly: -->
<!--   - `broom::tidy` + `parameters::model_parameters` = -->
<!--     `broomExtra::tidy_parameters` -->
<!--   - `broom::glance` + `performance::model_performance` = -->
<!--     `broomExtra::glance_performance` -->
<!-- Benefits of using hybrid generics -->
<!-- - The `tidy_parameters` will return a model summary either from `broomExtra::tidy` -->
<!-- or `parameters::model_parameters`, so you get best of the both worlds. -->
<!-- - These functions are robust such that they won't fail if the `...` contains -->
<!-- misspecified arguments. This makes these functions much easier to work with while writing wrapper -->
<!-- functions around `broomExtra::tidy` or `parameters::model_parameters`. -->
<!-- ## Generic functions -->
<!-- Currently, `S3` methods for mixed-effects model objects are included in the -->
<!-- `{broom.mixed}` package, while the rest of the object classes are included in the -->
<!-- `{broom}` package. This means that you constantly need to keep track of the class -->
<!-- of the object (e.g., "if it is `merMod` object, use -->
<!-- `broom.mixed::tidy()`/`broom.mixed::glance()`/`broom.mixed::augment()`, but if -->
<!-- it is `polr` object, use `broom::tidy()`/`broom::glance()`/`broom::augment()`"). -->
<!-- Using generics from `{broomExtra}` means you no longer have to worry about this, -->
<!-- as calling `broomExtra::tidy()`/`broomExtra::glance()`/`broomExtra::augment()` -->
<!-- will search the appropriate method from these two packages and return the -->
<!-- results. -->
<!-- #### tidy dataframe -->
<!-- Let's get a tidy tibble back containing results from various regression models. -->
<!-- ```{r tidy, error = TRUE} -->
<!-- set.seed(123) -->
<!-- library(lme4) -->
<!-- library(ordinal) -->
<!-- library(broomExtra) -->
<!-- library(dplyr) -->
<!-- ## mixed-effects models (`{broom.mixed}` will be used) -->
<!-- lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy) -->
<!-- broomExtra::tidy(x = lmm.mod, effects = "fixed") -->
<!-- ## linear model (`{broom}` will be used) -->
<!-- lm.mod <- lm(Reaction ~ Days, sleepstudy) -->
<!-- broomExtra::tidy(lm.mod, conf.int = TRUE) -->
<!-- ## another example with `{broom}` -->
<!-- ## cumulative Link Models -->
<!-- clm.mod <- clm(rating ~ temp * contact, data = wine) -->
<!-- broomExtra::tidy(x = clm.mod, exponentiate = TRUE) -->
<!-- ## unsupported object (the function will return `NULL` in such cases) -->
<!-- broomExtra::tidy(list(1, c("x", "y"))) -->
<!-- ``` -->
<!-- #### model summaries -->
<!-- Getting a `tibble` containing model summary and other performance measures. -->
<!-- ```{r glance, error = TRUE} -->
<!-- set.seed(123) -->
<!-- library(lme4) -->
<!-- library(ordinal) -->
<!-- ## mixed-effects model -->
<!-- lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy) -->
<!-- broomExtra::glance(lmm.mod) -->
<!-- ## linear model -->
<!-- lm.mod <- lm(Reaction ~ Days, sleepstudy) -->
<!-- broomExtra::glance(lm.mod) -->
<!-- ## another example with `{broom}` -->
<!-- ## cumulative Link Models -->
<!-- clm.mod <- clm(rating ~ temp * contact, data = wine) -->
<!-- broomExtra::glance(clm.mod) -->
<!-- ## in case no glance method is available (`NULL` will be returned) -->
<!-- broomExtra::glance(acf(lh, plot = FALSE)) -->
<!-- ``` -->
<!-- #### augmented dataframe -->
<!-- Getting a `tibble` by augmenting data with information from an object. -->
<!-- ```{r augment, error = TRUE} -->
<!-- set.seed(123) -->
<!-- library(lme4) -->
<!-- library(ordinal) -->
<!-- ## mixed-effects model -->
<!-- lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy) -->
<!-- broomExtra::augment(lmm.mod) -->
<!-- ## linear model -->
<!-- lm.mod <- lm(Reaction ~ Days, sleepstudy) -->
<!-- broomExtra::augment(lm.mod) -->
<!-- ## another example with `{broom}` -->
<!-- ## cumulative Link Models -->
<!-- clm.mod <- clm(rating ~ temp * contact, data = wine) -->
<!-- broomExtra::augment(x = clm.mod, newdata = wine, type.predict = "prob") -->
<!-- ## in case no augment method is available (`NULL` will be returned) -->
<!-- broomExtra::augment(stats::anova(stats::lm(wt ~ am, mtcars))) -->
<!-- ``` -->
<!-- ## `grouped_` variants of generics -->
<!-- `grouped` variants of the generic functions (`tidy`, `glance`, and `augment`) -->
<!-- make it easy to execute the same analysis for all combinations of grouping -->
<!-- variable(s) in a dataframe. Currently, these functions work only for methods -->
<!-- that depend on a `data` argument (e.g., `stats::lm`), but not for functions that -->
<!-- don't (e.g., `stats::prop.test()`). -->
<!-- #### `grouped_tidy` -->
<!-- ```{r grouped_tidy} -->
<!-- ## to speed up computation, let's use only 50% of the data -->
<!-- set.seed(123) -->
<!-- library(lme4) -->
<!-- library(ggplot2) -->
<!-- library(broomExtra) -->
<!-- ## linear model (tidy analysis across grouping combinations) -->
<!-- grouped_tidy( -->
<!--   data = sample_frac(ggplot2::diamonds, size = 0.5), -->
<!--   grouping.vars = c(cut, color), -->
<!--   formula = price ~ carat - 1, -->
<!--   ..f = stats::lm, -->
<!--   na.action = na.omit, -->
<!--   tidy.args = list(quick = TRUE) -->
<!-- ) -->
<!-- ## linear mixed effects model (tidy analysis across grouping combinations) -->
<!-- grouped_tidy( -->
<!--   data = sample_frac(ggplot2::diamonds, size = 0.5), -->
<!--   grouping.vars = cut, -->
<!--   ..f = lme4::lmer, -->
<!--   formula = price ~ carat + (carat | color) - 1, -->
<!--   control = lme4::lmerControl(optimizer = "bobyqa"), -->
<!--   tidy.args = list(conf.int = TRUE, conf.level = 0.99) -->
<!-- ) -->
<!-- ``` -->
<!-- #### `grouped_glance` -->
<!-- ```{r grouped_glance} -->
<!-- ## to speed up computation, let's use only 50% of the data -->
<!-- set.seed(123) -->
<!-- ## linear model (model summaries across grouping combinations) -->
<!-- grouped_glance( -->
<!--   data = sample_frac(ggplot2::diamonds, size = 0.5), -->
<!--   grouping.vars = c(cut, color), -->
<!--   formula = price ~ carat - 1, -->
<!--   ..f = stats::lm, -->
<!--   na.action = na.omit -->
<!-- ) -->
<!-- ## linear mixed effects model (model summaries across grouping combinations) -->
<!-- grouped_glance( -->
<!--   data = sample_frac(ggplot2::diamonds, size = 0.5), -->
<!--   grouping.vars = cut, -->
<!--   ..f = lme4::lmer, -->
<!--   formula = price ~ carat + (carat | color) - 1, -->
<!--   control = lme4::lmerControl(optimizer = "bobyqa") -->
<!-- ) -->
<!-- ``` -->
<!-- #### `grouped_augment` -->
<!-- ```{r grouped_augment} -->
<!-- ## to speed up computation, let's use only 50% of the data -->
<!-- set.seed(123) -->
<!-- ## linear model -->
<!-- grouped_augment( -->
<!--   data = ggplot2::diamonds, -->
<!--   grouping.vars = c(cut, color), -->
<!--   ..f = stats::lm, -->
<!--   formula = price ~ carat - 1 -->
<!-- ) -->
<!-- ## linear mixed-effects model -->
<!-- grouped_augment( -->
<!--   data = sample_frac(ggplot2::diamonds, size = 0.5), -->
<!--   grouping.vars = cut, -->
<!--   ..f = lme4::lmer, -->
<!--   formula = price ~ carat + (carat | color) - 1, -->
<!--   control = lme4::lmerControl(optimizer = "bobyqa") -->
<!-- ) -->
<!-- ``` -->

## Acknowledgments

The hexsticker was generously designed by Sarah Otterstetter (Max Planck
Institute for Human Development, Berlin). Thanks are also due to the
maintainers and contributors to `{broom}`- and `{easystats}`-package
families who have indulged in all my feature requests!
