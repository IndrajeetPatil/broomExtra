
<!-- README.md is generated from README.Rmd. Please edit that file -->

# broomExtra

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/IndrajeetPatil/broomExtra?branch=master&svg=true)](https://ci.appveyor.com/project/IndrajeetPatil/broomExtra)
[![Travis build
status](https://travis-ci.org/IndrajeetPatil/broomExtra.svg?branch=master)](https://travis-ci.org/IndrajeetPatil/broomExtra)
[![Codecov test
coverage](https://codecov.io/gh/IndrajeetPatil/broomExtra/branch/master/graph/badge.svg)](https://codecov.io/gh/IndrajeetPatil/broomExtra?branch=master)
[![Coverage
Status](https://coveralls.io/repos/github/IndrajeetPatil/broomExtra/badge.svg?branch=master)](https://coveralls.io/github/IndrajeetPatil/broomExtra?branch=master)
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Last-changedate](https://img.shields.io/badge/last%20change-2019--02--23-yellowgreen.svg)](/commits/master)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-red.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.5.0-6666ff.svg)](https://cran.r-project.org/)
<!-- badges: end -->

The goal of `broomExtra` is to provide helper functions that assist in
data analysis workflows involving packages `broom` and `broom.mixed`.

# Installation

You can install the development version of `broomExtra` from GitHub:

``` r
remotes::install_github("IndrajeetPatil/broomExtra")
```

Although all the examples below use only `stats::lm` and `lme4::lmer`
for consistency, these functions will work with any function that is
currently supported in `broom` and/or `broom.mixed` packages.

# generic functions

## tidy dataframe

``` r
library(lme4)
#> Loading required package: Matrix

# mixed-effects models (`broom.mixed` will be used)
lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
broomExtra::tidy(lmm.mod, effects = "fixed")
#> # A tibble: 2 x 5
#>   effect term        estimate std.error statistic
#>   <chr>  <chr>          <dbl>     <dbl>     <dbl>
#> 1 fixed  (Intercept)    251.       6.82     36.8 
#> 2 fixed  Days            10.5      1.55      6.77

# linear model (`broom` will be used)
lm.mod <- lm(Reaction ~ Days, sleepstudy)
broomExtra::tidy(lm.mod, exponentiate = TRUE, conf.int = TRUE)
#> Warning in process_lm(ret, x, conf.int = conf.int, conf.level =
#> conf.level, : Exponentiating coefficients, but model did not use a log or
#> logit link function.
#> # A tibble: 2 x 7
#>   term        estimate std.error statistic  p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 (Intercept) 1.53e109      6.61     38.0  2.16e-87 3.30e103  7.06e114
#> 2 Days        3.51e  4      1.24      8.45 9.89e-15 3.05e  3  4.05e  5

# another example with `broom`
broomExtra::tidy(stats::anova(stats::lm(wt ~ am, mtcars)))
#> # A tibble: 2 x 6
#>   term         df sumsq meansq statistic    p.value
#>   <chr>     <int> <dbl>  <dbl>     <dbl>      <dbl>
#> 1 am            1  14.2 14.2        27.6  0.0000113
#> 2 Residuals    30  15.4  0.515      NA   NA

# unsupported object (will return `NULL`)
x <- c(2, 2:4, 4, 4, 5, 5, 7, 7, 7)
y <- c(1:6, 5:4, 3:1)
appr <- stats::approx(x, y, xout = x)
broomExtra::tidy(appr)
#> NULL
```

## model summaries

``` r
library(lme4)

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
#> # A tibble: 1 x 11
#>   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <int>  <dbl> <dbl> <dbl>
#> 1     0.286         0.282  47.7      71.5 9.89e-15     2  -950. 1906. 1916.
#> # ... with 2 more variables: deviance <dbl>, df.residual <int>

# in case no glance method is available (`NULL` will be returned)
broomExtra::glance(stats::anova(stats::lm(wt ~ am, mtcars)))
#> NULL
```

## augmented dataframe

``` r
library(lme4)

# mixed-effects model
lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
broomExtra::augment(lmm.mod)
#> # A tibble: 180 x 14
#>    Reaction  Days Subject .fitted  .resid   .hat .cooksd .fixed   .mu
#>       <dbl> <dbl> <fct>     <dbl>   <dbl>  <dbl>   <dbl>  <dbl> <dbl>
#>  1     250.     0 308        254.   -4.10 0.229  0.00496   251.  254.
#>  2     259.     1 308        273.  -14.6  0.170  0.0402    262.  273.
#>  3     251.     2 308        293.  -42.2  0.127  0.226     272.  293.
#>  4     321.     3 308        313.    8.78 0.101  0.00731   283.  313.
#>  5     357.     4 308        332.   24.5  0.0910 0.0506    293.  332.
#>  6     415.     5 308        352.   62.7  0.0981 0.362     304.  352.
#>  7     382.     6 308        372.   10.5  0.122  0.0134    314.  372.
#>  8     290.     7 308        391. -101.   0.162  1.81      325.  391.
#>  9     431.     8 308        411.   19.6  0.219  0.106     335.  411.
#> 10     466.     9 308        431.   35.7  0.293  0.571     346.  431.
#> # ... with 170 more rows, and 5 more variables: .offset <dbl>,
#> #   .sqrtXwt <dbl>, .sqrtrwt <dbl>, .weights <dbl>, .wtres <dbl>

# linear model
lm.mod <- lm(Reaction ~ Days, sleepstudy)
broomExtra::augment(lm.mod)
#> # A tibble: 180 x 8
#>    Reaction  Days .fitted  .resid .std.resid    .hat .sigma   .cooksd
#>       <dbl> <dbl>   <dbl>   <dbl>      <dbl>   <dbl>  <dbl>     <dbl>
#>  1     250.     0    251.    1.85    -0.0390 0.0192    47.8 0.0000149
#>  2     259.     1    262.    3.17    -0.0669 0.0138    47.8 0.0000313
#>  3     251.     2    272.   21.5     -0.454  0.00976   47.8 0.00101  
#>  4     321.     3    283.  -38.6      0.813  0.00707   47.8 0.00235  
#>  5     357.     4    293.  -63.6      1.34   0.00572   47.6 0.00514  
#>  6     415.     5    304. -111.       2.33   0.00572   47.1 0.0157   
#>  7     382.     6    314.  -68.0      1.43   0.00707   47.6 0.00728  
#>  8     290.     7    325.   34.5     -0.727  0.00976   47.8 0.00261  
#>  9     431.     8    335.  -95.4      2.01   0.0138    47.3 0.0284   
#> 10     466.     9    346. -121.       2.56   0.0192    47.0 0.0639   
#> # ... with 170 more rows

# in case no augment method is available (`NULL` will be returned)
broomExtra::augment(stats::anova(stats::lm(wt ~ am, mtcars)))
#> NULL
```

# `grouped_` version of variant functions

## `grouped_tidy`

``` r
# to speed up computation, let's use only 50% of the data
set.seed(123)
library(lme4)
library(ggplot2)

# linear model (tidy analysis across grouping combinations)
broomExtra::grouped_tidy(
  data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
  grouping.vars = c(cut, color),
  formula = price ~ carat - 1,
  ..f = stats::lm,
  na.action = na.omit,
  tidy.args = list(quick = TRUE)
)
#> # A tibble: 35 x 4
#>    cut   color term  estimate
#>    <ord> <ord> <chr>    <dbl>
#>  1 Fair  D     carat    5162.
#>  2 Fair  E     carat    5020.
#>  3 Fair  F     carat    4780.
#>  4 Fair  G     carat    4370.
#>  5 Fair  H     carat    4329.
#>  6 Fair  I     carat    4196.
#>  7 Fair  J     carat    3934.
#>  8 Good  D     carat    5213.
#>  9 Good  E     carat    5114.
#> 10 Good  F     carat    5165.
#> # ... with 25 more rows

# linear mixed effects model (tidy analysis across grouping combinations)
broomExtra::grouped_tidy(
  data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
  grouping.vars = cut,
  ..f = lme4::lmer,
  formula = price ~ carat + (carat | color) - 1,
  control = lme4::lmerControl(optimizer = "bobyqa"),
  tidy.args = list(conf.int = TRUE, conf.level = 0.99)
)
#> # A tibble: 25 x 9
#>    cut   effect group term  estimate std.error statistic conf.low conf.high
#>    <ord> <chr>  <chr> <chr>    <dbl>     <dbl>     <dbl>    <dbl>     <dbl>
#>  1 Fair  fixed  <NA>  carat  2.78e+3      228.      12.2    2194.     3370.
#>  2 Fair  ran_p~ color sd__~  2.32e+3       NA       NA        NA        NA 
#>  3 Fair  ran_p~ color sd__~  3.75e+3       NA       NA        NA        NA 
#>  4 Fair  ran_p~ color cor_~ -9.91e-1       NA       NA        NA        NA 
#>  5 Fair  ran_p~ Resi~ sd__~  1.54e+3       NA       NA        NA        NA 
#>  6 Good  fixed  <NA>  carat  5.70e+3      214.      26.6    5146.     6249.
#>  7 Good  ran_p~ color sd__~  2.61e+3       NA       NA        NA        NA 
#>  8 Good  ran_p~ color sd__~  1.94e+3       NA       NA        NA        NA 
#>  9 Good  ran_p~ color cor_~ -9.58e-1       NA       NA        NA        NA 
#> 10 Good  ran_p~ Resi~ sd__~  1.36e+3       NA       NA        NA        NA 
#> # ... with 15 more rows
```

## `grouped_glance`

``` r
# to speed up computation, let's use only 50% of the data
set.seed(123)

# linear model (model summaries across grouping combinations)
broomExtra::grouped_glance(
  data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
  grouping.vars = c(cut, color),
  formula = price ~ carat - 1,
  ..f = stats::lm,
  na.action = na.omit
)
#> # A tibble: 35 x 13
#>    cut   color r.squared adj.r.squared sigma statistic   p.value    df
#>    <ord> <ord>     <dbl>         <dbl> <dbl>     <dbl>     <dbl> <int>
#>  1 Fair  D         0.893         0.892 1913.      654. 1.16e- 39     1
#>  2 Fair  E         0.877         0.876 1761.      786. 6.59e- 52     1
#>  3 Fair  F         0.873         0.872 1888.     1084. 1.20e- 72     1
#>  4 Fair  G         0.857         0.857 1976.     1011. 5.70e- 73     1
#>  5 Fair  H         0.885         0.884 2065.     1108. 1.66e- 69     1
#>  6 Fair  I         0.886         0.885 2010.      724. 1.14e- 45     1
#>  7 Fair  J         0.910         0.909 1996.      689. 2.59e- 37     1
#>  8 Good  D         0.848         0.847 1827.     1817. 2.47e-135     1
#>  9 Good  E         0.869         0.869 1636.     3365. 1.00e-225     1
#> 10 Good  F         0.873         0.872 1700.     3054. 1.24e-201     1
#> # ... with 25 more rows, and 5 more variables: logLik <dbl>, AIC <dbl>,
#> #   BIC <dbl>, deviance <dbl>, df.residual <int>

# linear mixed effects model (model summaries across grouping combinations)
broomExtra::grouped_glance(
  data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
  grouping.vars = cut,
  ..f = lme4::lmer,
  formula = price ~ carat + (carat | color) - 1,
  control = lme4::lmerControl(optimizer = "bobyqa")
)
#> # A tibble: 5 x 7
#>   cut       sigma  logLik     AIC     BIC REMLcrit df.residual
#>   <ord>     <dbl>   <dbl>   <dbl>   <dbl>    <dbl>       <int>
#> 1 Fair      1541.  -6945.  13901.  13924.   13891.         786
#> 2 Good      1361. -21622.  43254.  43283.   43244.        2496
#> 3 Very Good 1372. -52554. 105117. 105151.  105107.        6072
#> 4 Premium   1574. -60379. 120767. 120801.  120757.        6868
#> 5 Ideal     1294. -92129. 184268. 184304.  184258.       10723
```

## `grouped_augment`

``` r
# to speed up computation, let's use only 50% of the data
set.seed(123)

# linear model
broomExtra::grouped_augment(
  data = ggplot2::diamonds,
  grouping.vars = c(cut, color),
  ..f = stats::lm,
  formula = price ~ carat - 1
)
#> # A tibble: 53,940 x 10
#>    cut   color price carat .fitted .resid .std.resid    .hat .sigma .cooksd
#>    <ord> <ord> <int> <dbl>   <dbl>  <dbl>      <dbl>   <dbl>  <dbl>   <dbl>
#>  1 Fair  D      2848  0.75   3795.   947.     -0.522 0.00342  1822. 9.33e-4
#>  2 Fair  D      2858  0.71   3593.   735.     -0.405 0.00306  1823. 5.03e-4
#>  3 Fair  D      2885  0.9    4554.  1669.     -0.920 0.00492  1819. 4.19e-3
#>  4 Fair  D      2974  1      5060.  2086.     -1.15  0.00607  1816. 8.09e-3
#>  5 Fair  D      3003  1.01   5111.  2108.     -1.16  0.00620  1816. 8.43e-3
#>  6 Fair  D      3047  0.73   3694.   647.     -0.356 0.00324  1823. 4.12e-4
#>  7 Fair  D      3077  0.71   3593.   516.     -0.284 0.00306  1823. 2.48e-4
#>  8 Fair  D      3079  0.91   4605.  1526.     -0.841 0.00503  1820. 3.58e-3
#>  9 Fair  D      3205  0.9    4554.  1349.     -0.744 0.00492  1821. 2.74e-3
#> 10 Fair  D      3205  0.9    4554.  1349.     -0.744 0.00492  1821. 2.74e-3
#> # ... with 53,930 more rows

# linear mixed-effects model
broomExtra::grouped_augment(
  data = dplyr::sample_frac(tbl = ggplot2::diamonds, size = 0.5),
  grouping.vars = cut,
  ..f = lme4::lmer,
  formula = price ~ carat + (carat | color) - 1,
  control = lme4::lmerControl(optimizer = "bobyqa")
)
#> singular fit
#> # A tibble: 26,970 x 15
#>    cut   price carat color .fitted .resid    .hat .cooksd .fixed   .mu
#>    <ord> <int> <dbl> <ord>   <dbl>  <dbl>   <dbl>   <dbl>  <dbl> <dbl>
#>  1 Fair   1323  0.5  D        975.   348. 0.00263 1.10e-4  1136.  975.
#>  2 Fair   1939  0.9  G       3409. -1470. 0.00272 2.04e-3  2044. 3409.
#>  3 Fair   5484  1    G       4006.  1478. 0.00356 2.70e-3  2271. 4006.
#>  4 Fair   4939  1.5  H       6599. -1660. 0.00879 8.49e-3  3407. 6599.
#>  5 Fair   3855  0.91 D       3990.  -135. 0.00542 3.43e-5  2067. 3990.
#>  6 Fair   5096  1    D       4652.   444. 0.00759 5.24e-4  2271. 4652.
#>  7 Fair    659  0.41 H        531.   128. 0.00314 1.79e-5   931.  531.
#>  8 Fair   2724  0.84 G       3050.  -326. 0.00237 8.75e-5  1908. 3050.
#>  9 Fair   4368  1.2  I       4830.  -462. 0.00667 4.98e-4  2726. 4830.
#> 10 Fair   5350  1.02 E       5061.   289. 0.00893 2.61e-4  2317. 5061.
#> # ... with 26,960 more rows, and 5 more variables: .offset <dbl>,
#> #   .sqrtXwt <dbl>, .sqrtrwt <dbl>, .weights <dbl>, .wtres <dbl>
```

# Code coverage

As the code stands right now, here is the code coverage for all primary
functions involved:
<https://codecov.io/gh/IndrajeetPatil/broomExtra/tree/master/R>

# Contributing

I’m happy to receive bug reports, suggestions, questions, and (most of
all) contributions to fix problems and add features. I personally prefer
using the GitHub issues system over trying to reach out to me in other
ways (personal e-mail, Twitter, etc.). Pull requests for contributions
are encouraged.

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
