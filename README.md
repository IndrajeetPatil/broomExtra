
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{broomExtra}`: Enhancements for `{broom}` and `{easystats}` Package Families

[![CRAN_Release_Badge](https://www.r-pkg.org/badges/version-ago/broomExtra)](https://CRAN.R-project.org/package=broomExtra)
[![pkgdown](https://github.com/IndrajeetPatil/broomExtra/workflows/pkgdown/badge.svg)](https://github.com/IndrajeetPatil/broomExtra/actions)
[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)

<img src="man/figures/logo.png" align="right" width="360" />

The goal of `{broomExtra}` is to provide helper functions that assist in
data analysis workflows involving regression analyses. The goal is to
combine the functionality offered by different set of packages through a
common syntax to return tidy tibbles containing model parameters and
summaries.

It combines functionality from `{broom}` and `{easystats}` ecosystems,
and this package has the following advantages over the underlying
individual packages (see examples below for concrete instantiations of
these benefits):

-   Covers more number of regression models than these individual
    packages.
-   If possible to compute, the output tibbles contains a *p*-value
    column.
-   More robust to extraneous input arguments that might sometimes cause
    problems for the underlying methods.
-   Follows consistent `{tidymodels}` column-naming schema.
-   Returns a more comprehensive model performance measure summary.

If you want to add support for a regression model, the natural place to
do this would be to contribute either to `{broom}` or to `{parameters}`.

# Installation

| Type        | Source | Command                                                |
|-------------|--------|--------------------------------------------------------|
| Release     | CRAN   | `install.packages("broomExtra")`                       |
| Development | GitHub | `remotes::install_github("IndrajeetPatil/broomExtra")` |

# Lifecycle

| Function                                            | Lifecycle                                                                                                                       |
|-----------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| `tidy_parameters`                                   | [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html) |
| `glance_performance`                                | [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html) |
| `tidy`, `glance`, `augment`                         | [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html) |
| `grouped_tidy`, `grouped_glance`, `grouped_augment` | [![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html) |

# Hybrid generics

The `{broom}`-family of packages are not the only ones which return such
tidy summaries for model parameters and model performance. The
`{easystats}`-family of packages also provide similar functions, more
specifically [parameters](https://easystats.github.io/parameters/) and
[performance](https://easystats.github.io/performance/). Sometimes the
`{broom}` packages might not contain a `tidy`/`glance` method for a
given regression object, while `{easystats}` packages would and *vice
versa*.

The hybrid functions in `{broomExtra}` make it easy to retrieve these
summaries with the appropriate method and do so robustly:

-   `broom::tidy` + `parameters::model_parameters` =
    `broomExtra::tidy_parameters`

-   `broom::glance` + `performance::model_performance` =
    `broomExtra::glance_performance`

Benefits of using hybrid generics

-   The `tidy_parameters` will return a model summary either from
    `broomExtra::tidy` or `parameters::model_parameters`, so you get
    best of the both worlds.

-   These functions are robust such that they won’t fail if the `...`
    contains misspecified arguments. This makes these functions much
    easier to work with while writing wrapper functions around
    `broomExtra::tidy` or `parameters::model_parameters`.

# Generic functions

Currently, `S3` methods for mixed-effects model objects are included in
the `{broom.mixed}` package, while the rest of the object classes are
included in the `{broom}` package. This means that you constantly need
to keep track of the class of the object (e.g., “if it is `merMod`
object, use
`broom.mixed::tidy()`/`broom.mixed::glance()`/`broom.mixed::augment()`,
but if it is `polr` object, use
`broom::tidy()`/`broom::glance()`/`broom::augment()`”).

Using generics from `{broomExtra}` means you no longer have to worry
about this, as calling
`broomExtra::tidy()`/`broomExtra::glance()`/`broomExtra::augment()` will
search the appropriate method from these two packages and return the
results.

## tidy dataframe

Let’s get a tidy tibble back containing results from various regression
models.

``` r
set.seed(123)
library(lme4)
library(ordinal)
library(broomExtra)
library(dplyr)

# mixed-effects models (`{broom.mixed}` will be used)
lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
broomExtra::tidy(x = lmm.mod, effects = "fixed")
#> # A tibble: 2 x 5
#>   effect term        estimate std.error statistic
#>   <chr>  <chr>          <dbl>     <dbl>     <dbl>
#> 1 fixed  (Intercept)    251.       6.82     36.8 
#> 2 fixed  Days            10.5      1.55      6.77

# linear model (`{broom}` will be used)
lm.mod <- lm(Reaction ~ Days, sleepstudy)
broomExtra::tidy(lm.mod, conf.int = TRUE)
#> # A tibble: 2 x 7
#>   term        estimate std.error statistic  p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 (Intercept)    251.       6.61     38.0  2.16e-87   238.       264. 
#> 2 Days            10.5      1.24      8.45 9.89e-15     8.02      12.9

# another example with `{broom}`
# cumulative Link Models
clm.mod <- clm(rating ~ temp * contact, data = wine)
broomExtra::tidy(x = clm.mod, exponentiate = TRUE)
#> # A tibble: 7 x 6
#>   term                estimate std.error statistic  p.value coef.type
#>   <chr>                  <dbl>     <dbl>     <dbl>    <dbl> <chr>    
#> 1 1|2                    0.244     0.545    -2.59  9.66e- 3 intercept
#> 2 2|3                    3.14      0.510     2.24  2.48e- 2 intercept
#> 3 3|4                   29.3       0.638     5.29  1.21e- 7 intercept
#> 4 4|5                  140.        0.751     6.58  4.66e-11 intercept
#> 5 tempwarm              10.2       0.701     3.31  9.28e- 4 location 
#> 6 contactyes             3.85      0.660     2.04  4.13e- 2 location 
#> 7 tempwarm:contactyes    1.43      0.924     0.389 6.97e- 1 location

# unsupported object (the function will return `NULL` in such cases)
broomExtra::tidy(list(1, c("x", "y")))
#> NULL
```

## model summaries

Getting a `tibble` containing model summary and other performance
measures.

``` r
set.seed(123)
library(lme4)
library(ordinal)

# mixed-effects model
lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
broomExtra::glance(lmm.mod)
#> # A tibble: 1 x 6
#>   sigma logLik   AIC   BIC REMLcrit df.residual
#>   <dbl>  <dbl> <dbl> <dbl>    <dbl>       <int>
#> 1  25.6  -872. 1756. 1775.    1744.         174

# linear model
lm.mod <- lm(Reaction ~ Days, sleepstudy)
broomExtra::glance(lm.mod)
#> # A tibble: 1 x 12
#>   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
#> 1     0.286         0.282  47.7      71.5 9.89e-15     1  -950. 1906. 1916.
#>   deviance df.residual  nobs
#>      <dbl>       <int> <int>
#> 1  405252.         178   180

# another example with `{broom}`
# cumulative Link Models
clm.mod <- clm(rating ~ temp * contact, data = wine)
broomExtra::glance(clm.mod)
#> # A tibble: 1 x 6
#>     edf   AIC   BIC logLik   df.residual  nobs
#>   <int> <dbl> <dbl> <logLik>       <dbl> <dbl>
#> 1     7  187.  203. -86.4162          65    72

# in case no glance method is available (`NULL` will be returned)
broomExtra::glance(acf(lh, plot = FALSE))
#> NULL
```

## augmented dataframe

Getting a `tibble` by augmenting data with information from an object.

``` r
set.seed(123)
library(lme4)
library(ordinal)

# mixed-effects model
lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
broomExtra::augment(lmm.mod)
#> # A tibble: 180 x 14
#>    Reaction  Days Subject .fitted  .resid   .hat .cooksd .fixed   .mu .offset
#>       <dbl> <dbl> <fct>     <dbl>   <dbl>  <dbl>   <dbl>  <dbl> <dbl>   <dbl>
#>  1     250.     0 308        254.   -4.10 0.229  0.00496   251.  254.       0
#>  2     259.     1 308        273.  -14.6  0.170  0.0402    262.  273.       0
#>  3     251.     2 308        293.  -42.2  0.127  0.226     272.  293.       0
#>  4     321.     3 308        313.    8.78 0.101  0.00731   283.  313.       0
#>  5     357.     4 308        332.   24.5  0.0910 0.0506    293.  332.       0
#>  6     415.     5 308        352.   62.7  0.0981 0.362     304.  352.       0
#>  7     382.     6 308        372.   10.5  0.122  0.0134    314.  372.       0
#>  8     290.     7 308        391. -101.   0.162  1.81      325.  391.       0
#>  9     431.     8 308        411.   19.6  0.219  0.106     335.  411.       0
#> 10     466.     9 308        431.   35.7  0.293  0.571     346.  431.       0
#>    .sqrtXwt .sqrtrwt .weights  .wtres
#>       <dbl>    <dbl>    <dbl>   <dbl>
#>  1        1        1        1   -4.10
#>  2        1        1        1  -14.6 
#>  3        1        1        1  -42.2 
#>  4        1        1        1    8.78
#>  5        1        1        1   24.5 
#>  6        1        1        1   62.7 
#>  7        1        1        1   10.5 
#>  8        1        1        1 -101.  
#>  9        1        1        1   19.6 
#> 10        1        1        1   35.7 
#> # ... with 170 more rows

# linear model
lm.mod <- lm(Reaction ~ Days, sleepstudy)
broomExtra::augment(lm.mod)
#> # A tibble: 180 x 8
#>    Reaction  Days .fitted .resid    .hat .sigma   .cooksd .std.resid
#>       <dbl> <dbl>   <dbl>  <dbl>   <dbl>  <dbl>     <dbl>      <dbl>
#>  1     250.     0    251.  -1.85 0.0192    47.8 0.0000149    -0.0390
#>  2     259.     1    262.  -3.17 0.0138    47.8 0.0000313    -0.0669
#>  3     251.     2    272. -21.5  0.00976   47.8 0.00101      -0.454 
#>  4     321.     3    283.  38.6  0.00707   47.8 0.00235       0.813 
#>  5     357.     4    293.  63.6  0.00572   47.6 0.00514       1.34  
#>  6     415.     5    304. 111.   0.00572   47.1 0.0157        2.33  
#>  7     382.     6    314.  68.0  0.00707   47.6 0.00728       1.43  
#>  8     290.     7    325. -34.5  0.00976   47.8 0.00261      -0.727 
#>  9     431.     8    335.  95.4  0.0138    47.3 0.0284        2.01  
#> 10     466.     9    346. 121.   0.0192    47.0 0.0639        2.56  
#> # ... with 170 more rows

# another example with `{broom}`
# cumulative Link Models
clm.mod <- clm(rating ~ temp * contact, data = wine)
broomExtra::augment(x = clm.mod, newdata = wine, type.predict = "prob")
#> # A tibble: 72 x 7
#>    response rating temp  contact bottle judge .fitted
#>       <dbl> <ord>  <fct> <fct>   <fct>  <fct>   <dbl>
#>  1       36 2      cold  no      1      1      0.562 
#>  2       48 3      cold  no      2      1      0.209 
#>  3       47 3      cold  yes     3      1      0.435 
#>  4       67 4      cold  yes     4      1      0.0894
#>  5       77 4      warm  no      5      1      0.190 
#>  6       60 4      warm  no      6      1      0.190 
#>  7       83 5      warm  yes     7      1      0.286 
#>  8       90 5      warm  yes     8      1      0.286 
#>  9       17 1      cold  no      1      2      0.196 
#> 10       22 2      cold  no      2      2      0.562 
#> # ... with 62 more rows

# in case no augment method is available (`NULL` will be returned)
broomExtra::augment(stats::anova(stats::lm(wt ~ am, mtcars)))
#> NULL
```

# `grouped_` variants of generics

`grouped` variants of the generic functions (`tidy`, `glance`, and
`augment`) make it easy to execute the same analysis for all
combinations of grouping variable(s) in a dataframe. Currently, these
functions work only for methods that depend on a `data` argument (e.g.,
`stats::lm`), but not for functions that don’t (e.g.,
`stats::prop.test()`).

## `grouped_tidy`

``` r
# to speed up computation, let's use only 50% of the data
set.seed(123)
library(lme4)
library(ggplot2)
library(broomExtra)

# linear model (tidy analysis across grouping combinations)
grouped_tidy(
  data = sample_frac(ggplot2::diamonds, size = 0.5),
  grouping.vars = c(cut, color),
  formula = price ~ carat - 1,
  ..f = stats::lm,
  na.action = na.omit,
  tidy.args = list(quick = TRUE)
)
#> # A tibble: 35 x 7
#>    cut   color term  estimate std.error statistic   p.value
#>    <ord> <ord> <chr>    <dbl>     <dbl>     <dbl>     <dbl>
#>  1 Fair  D     carat    5246.     207.       25.3 4.45e- 41
#>  2 Fair  E     carat    4202.     158.       26.6 3.52e- 47
#>  3 Fair  F     carat    4877.     149.       32.7 1.68e- 71
#>  4 Fair  G     carat    4538.     152.       29.8 1.03e- 66
#>  5 Fair  H     carat    4620.     146.       31.6 7.68e- 66
#>  6 Fair  I     carat    3969.     136.       29.2 4.86e- 44
#>  7 Fair  J     carat    4024.     197.       20.4 4.80e- 27
#>  8 Good  D     carat    5207.     115.       45.4 2.66e-145
#>  9 Good  E     carat    5102.      91.9      55.5 2.50e-206
#> 10 Good  F     carat    5151.      92.4      55.8 1.76e-204
#> # ... with 25 more rows

# linear mixed effects model (tidy analysis across grouping combinations)
grouped_tidy(
  data = sample_frac(ggplot2::diamonds, size = 0.5),
  grouping.vars = cut,
  ..f = lme4::lmer,
  formula = price ~ carat + (carat | color) - 1,
  control = lme4::lmerControl(optimizer = "bobyqa"),
  tidy.args = list(conf.int = TRUE, conf.level = 0.99)
)
#> # A tibble: 25 x 9
#>    cut   effect   group    term                   estimate std.error statistic
#>    <ord> <chr>    <chr>    <chr>                     <dbl>     <dbl>     <dbl>
#>  1 Fair  fixed    <NA>     carat                  3800.         228.      16.7
#>  2 Fair  ran_pars color    sd__(Intercept)        2158.          NA       NA  
#>  3 Fair  ran_pars color    cor__(Intercept).carat   -0.975       NA       NA  
#>  4 Fair  ran_pars color    sd__carat              2545.          NA       NA  
#>  5 Fair  ran_pars Residual sd__Observation        1830.          NA       NA  
#>  6 Good  fixed    <NA>     carat                  9217.         105.      87.6
#>  7 Good  ran_pars color    sd__(Intercept)        2686.          NA       NA  
#>  8 Good  ran_pars color    cor__(Intercept).carat    0.998       NA       NA  
#>  9 Good  ran_pars color    sd__carat              1609.          NA       NA  
#> 10 Good  ran_pars Residual sd__Observation        1373.          NA       NA  
#>    conf.low conf.high
#>       <dbl>     <dbl>
#>  1    3212.     4387.
#>  2      NA        NA 
#>  3      NA        NA 
#>  4      NA        NA 
#>  5      NA        NA 
#>  6    8946.     9488.
#>  7      NA        NA 
#>  8      NA        NA 
#>  9      NA        NA 
#> 10      NA        NA 
#> # ... with 15 more rows
```

## `grouped_glance`

``` r
# to speed up computation, let's use only 50% of the data
set.seed(123)

# linear model (model summaries across grouping combinations)
grouped_glance(
  data = sample_frac(ggplot2::diamonds, size = 0.5),
  grouping.vars = c(cut, color),
  formula = price ~ carat - 1,
  ..f = stats::lm,
  na.action = na.omit
)
#> # A tibble: 35 x 14
#>    cut   color r.squared adj.r.squared sigma statistic p.value    df logLik
#>    <ord> <ord>     <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>  <dbl>
#>  1 Fair  D         0.884         0.883 1857.        NA      NA    NA  -760.
#>  2 Fair  E         0.876         0.875 1370.        NA      NA    NA  -872.
#>  3 Fair  F         0.874         0.873 1989.        NA      NA    NA -1406.
#>  4 Fair  G         0.849         0.848 2138.        NA      NA    NA -1444.
#>  5 Fair  H         0.876         0.875 2412.        NA      NA    NA -1307.
#>  6 Fair  I         0.915         0.914 1499.        NA      NA    NA  -698.
#>  7 Fair  J         0.885         0.883 2189.        NA      NA    NA  -501.
#>  8 Good  D         0.860         0.860 1729.        NA      NA    NA -2981.
#>  9 Good  E         0.870         0.870 1674.        NA      NA    NA -4084.
#> 10 Good  F         0.873         0.873 1677.        NA      NA    NA -3997.
#>      AIC   BIC    deviance df.residual  nobs
#>    <dbl> <dbl>       <dbl>       <int> <int>
#>  1 1524. 1529.  289568733.          84    85
#>  2 1749. 1754.  187724139.         100   101
#>  3 2816. 2822.  613473518.         155   156
#>  4 2893. 2899.  722351124.         158   159
#>  5 2618. 2624.  820050299.         141   142
#>  6 1400. 1405.  177605917.          79    80
#>  7 1005. 1009.  258660541.          54    55
#>  8 5966. 5974. 1001144317.         335   336
#>  9 8173. 8181. 1291712250.         461   462
#> 10 7998. 8006. 1267954026.         451   452
#> # ... with 25 more rows

# linear mixed effects model (model summaries across grouping combinations)
grouped_glance(
  data = sample_frac(ggplot2::diamonds, size = 0.5),
  grouping.vars = cut,
  ..f = lme4::lmer,
  formula = price ~ carat + (carat | color) - 1,
  control = lme4::lmerControl(optimizer = "bobyqa")
)
#> # A tibble: 5 x 7
#>   cut       sigma  logLik     AIC     BIC REMLcrit df.residual
#>   <ord>     <dbl>   <dbl>   <dbl>   <dbl>    <dbl>       <int>
#> 1 Fair      1830.  -7257.  14525.  14548.   14515.         806
#> 2 Good      1373. -21027.  42064.  42093.   42054.        2425
#> 3 Very Good 1362. -51577. 103165. 103198.  103155.        5964
#> 4 Premium   1557. -60736. 121482. 121516.  121472.        6917
#> 5 Ideal     1257. -92766. 185542. 185579.  185532.       10833
```

## `grouped_augment`

``` r
# to speed up computation, let's use only 50% of the data
set.seed(123)

# linear model
grouped_augment(
  data = ggplot2::diamonds,
  grouping.vars = c(cut, color),
  ..f = stats::lm,
  formula = price ~ carat - 1
)
#> # A tibble: 53,940 x 10
#>    cut   color price carat .fitted .resid    .hat .sigma  .cooksd .std.resid
#>    <ord> <ord> <int> <dbl>   <dbl>  <dbl>   <dbl>  <dbl>    <dbl>      <dbl>
#>  1 Fair  D      2848  0.75   3795.  -947. 0.00342  1822. 0.000933     -0.522
#>  2 Fair  D      2858  0.71   3593.  -735. 0.00306  1823. 0.000503     -0.405
#>  3 Fair  D      2885  0.9    4554. -1669. 0.00492  1819. 0.00419      -0.920
#>  4 Fair  D      2974  1      5060. -2086. 0.00607  1816. 0.00809      -1.15 
#>  5 Fair  D      3003  1.01   5111. -2108. 0.00620  1816. 0.00843      -1.16 
#>  6 Fair  D      3047  0.73   3694.  -647. 0.00324  1823. 0.000412     -0.356
#>  7 Fair  D      3077  0.71   3593.  -516. 0.00306  1823. 0.000248     -0.284
#>  8 Fair  D      3079  0.91   4605. -1526. 0.00503  1820. 0.00358      -0.841
#>  9 Fair  D      3205  0.9    4554. -1349. 0.00492  1821. 0.00274      -0.744
#> 10 Fair  D      3205  0.9    4554. -1349. 0.00492  1821. 0.00274      -0.744
#> # ... with 53,930 more rows

# linear mixed-effects model
grouped_augment(
  data = sample_frac(ggplot2::diamonds, size = 0.5),
  grouping.vars = cut,
  ..f = lme4::lmer,
  formula = price ~ carat + (carat | color) - 1,
  control = lme4::lmerControl(optimizer = "bobyqa")
)
#> # A tibble: 26,970 x 15
#>    cut   price carat color .fitted .resid    .hat   .cooksd .fixed   .mu .offset
#>    <ord> <int> <dbl> <ord>   <dbl>  <dbl>   <dbl>     <dbl>  <dbl> <dbl>   <dbl>
#>  1 Fair   8818  1.52 H       7001.  1817. 0.00806 0.00837    3519. 7001.       0
#>  2 Fair   1881  0.65 F       2104.  -223. 0.00225 0.0000346  1505. 2104.       0
#>  3 Fair   2376  1.2  G       5439. -3063. 0.00651 0.0191     2778. 5439.       0
#>  4 Fair   1323  0.5  D       1069.   254. 0.00281 0.0000565  1158. 1069.       0
#>  5 Fair   3282  0.92 F       3935.  -653. 0.00338 0.000448   2130. 3935.       0
#>  6 Fair   2500  0.7  H       2259.   241. 0.00219 0.0000396  1621. 2259.       0
#>  7 Fair  13853  1.5  F       7868.  5985. 0.0149  0.170      3473. 7868.       0
#>  8 Fair   3869  1.01 H       4052.  -183. 0.00287 0.0000297  2338. 4052.       0
#>  9 Fair   1811  0.7  H       2259.  -448. 0.00219 0.000137   1621. 2259.       0
#> 10 Fair   2788  1.01 E       4406. -1618. 0.0135  0.0112     2338. 4406.       0
#>    .sqrtXwt .sqrtrwt .weights .wtres
#>       <dbl>    <dbl>    <dbl>  <dbl>
#>  1        1        1        1  1817.
#>  2        1        1        1  -223.
#>  3        1        1        1 -3063.
#>  4        1        1        1   254.
#>  5        1        1        1  -653.
#>  6        1        1        1   241.
#>  7        1        1        1  5985.
#>  8        1        1        1  -183.
#>  9        1        1        1  -448.
#> 10        1        1        1 -1618.
#> # ... with 26,960 more rows
```

# Acknowledgments

The hexsticker was generously designed by Sarah Otterstetter (Max Planck
Institute for Human Development, Berlin). Thanks are also due to the
maintainers and contributors to `{broom}`- and `{easystats}`-package
families who have indulged in all my feature requests. 😄
