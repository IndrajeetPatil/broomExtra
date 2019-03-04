
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
[![Last-changedate](https://img.shields.io/badge/last%20change-2019--03--04-yellowgreen.svg)](/commits/master)
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

# generic functions

Currently, `S3` methods for mixed-effects model objects are included in
the `broom.mixed` package, while the rest of the object classes are
included in the `broom` package. This means that you constantly need to
keep track of the class of the object (e.g., “if it is `merMod` object,
use
`broom.mixed::tidy()`/`broom.mixed::glance()`/`broom.mixed::augment()`,
but if it is `polr` object, use
`broom::tidy()`/`broom::glance()`/`broom::augment()`”). Using generics
from `broomExtra` means you no longer have to worry about this, as
calling
`broomExtra::tidy()`/`broomExtra::glance()`/`broomExtra::augment()` will
search the appropriate method from these two packages and return the
results.

## tidy dataframe

Let’s get a tidy tibble back containing results from various regression
models.

``` r
set.seed(123)
library(lme4)
#> Loading required package: Matrix
library(ordinal)
#> 
#> Attaching package: 'ordinal'
#> The following objects are masked from 'package:lme4':
#> 
#>     ranef, VarCorr

# mixed-effects models (`broom.mixed` will be used)
lmm.mod <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
broomExtra::tidy(x = lmm.mod, effects = "fixed")
#> # A tibble: 2 x 5
#>   effect term        estimate std.error statistic
#>   <chr>  <chr>          <dbl>     <dbl>     <dbl>
#> 1 fixed  (Intercept)    251.       6.82     36.8 
#> 2 fixed  Days            10.5      1.55      6.77

# linear model (`broom` will be used)
lm.mod <- lm(Reaction ~ Days, sleepstudy)
broomExtra::tidy(x = lm.mod, conf.int = TRUE)
#> # A tibble: 2 x 7
#>   term        estimate std.error statistic  p.value conf.low conf.high
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 (Intercept)    251.       6.61     38.0  2.16e-87   238.       264. 
#> 2 Days            10.5      1.24      8.45 9.89e-15     8.02      12.9

# another example with `broom`
# cumulative Link Models
clm.mod <- clm(rating ~ temp * contact, data = wine)
broomExtra::tidy(
  x = clm.mod,
  exponentiate = TRUE,
  conf.int = TRUE,
  conf.type = "Wald"
)
#> # A tibble: 7 x 8
#>   term  estimate std.error statistic  p.value conf.low conf.high
#>   <chr>    <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#> 1 1|2      0.244     0.545    -2.59  9.66e- 3   0.0837     0.710
#> 2 2|3      3.14      0.510     2.24  2.48e- 2   1.16       8.52 
#> 3 3|4     29.3       0.638     5.29  1.21e- 7   8.38     102.   
#> 4 4|5    140.        0.751     6.58  4.66e-11  32.1      610.   
#> 5 temp~   10.2       0.701     3.31  9.28e- 4   2.58      40.2  
#> 6 cont~    3.85      0.660     2.04  4.13e- 2   1.05      14.0  
#> 7 temp~    1.43      0.924     0.389 6.97e- 1   0.234      8.76 
#> # ... with 1 more variable: coefficient_type <chr>

# unsupported object (the function will return `NULL` in such cases)
x <- c(2, 2:4, 4, 4, 5, 5, 7, 7, 7)
y <- c(1:6, 5:4, 3:1)
appr <- stats::approx(x, y, xout = x)
#> Warning in regularize.values(x, y, ties, missing(ties)): collapsing to
#> unique 'x' values
broomExtra::tidy(appr)
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
#> # A tibble: 1 x 11
#>   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <int>  <dbl> <dbl> <dbl>
#> 1     0.286         0.282  47.7      71.5 9.89e-15     2  -950. 1906. 1916.
#> # ... with 2 more variables: deviance <dbl>, df.residual <int>

# another example with `broom`
# cumulative Link Models
clm.mod <- clm(rating ~ temp * contact, data = wine)
broomExtra::glance(clm.mod)
#> # A tibble: 1 x 5
#>     edf logLik   AIC   BIC df.residual
#>   <int>  <dbl> <dbl> <dbl>       <dbl>
#> 1     7  -86.4  187.  203.          65

# in case no glance method is available (`NULL` will be returned)
broomExtra::glance(stats::anova(stats::lm(wt ~ am, mtcars)))
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

# another example with `broom`
# cumulative Link Models
clm.mod <- clm(rating ~ temp * contact, data = wine)
broomExtra::augment(x = clm.mod, newdata = wine, type.predict = "prob")
#> # A tibble: 72 x 8
#>    response rating temp  contact bottle judge .fitted .se.fit
#>       <dbl> <ord>  <fct> <fct>   <fct>  <fct>   <dbl>   <dbl>
#>  1       36 2      cold  no      1      1      0.562   0.0885
#>  2       48 3      cold  no      2      1      0.209   0.0788
#>  3       47 3      cold  yes     3      1      0.435   0.0837
#>  4       67 4      cold  yes     4      1      0.0894  0.0436
#>  5       77 4      warm  no      5      1      0.190   0.0711
#>  6       60 4      warm  no      6      1      0.190   0.0711
#>  7       83 5      warm  yes     7      1      0.286   0.0993
#>  8       90 5      warm  yes     8      1      0.286   0.0993
#>  9       17 1      cold  no      1      2      0.196   0.0860
#> 10       22 2      cold  no      2      2      0.562   0.0885
#> # ... with 62 more rows

# in case no augment method is available (`NULL` will be returned)
broomExtra::augment(stats::anova(stats::lm(wt ~ am, mtcars)))
#> NULL
```

# `grouped_` version of variant functions

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
#>  1 Fair  D     carat    5246.
#>  2 Fair  E     carat    4202.
#>  3 Fair  F     carat    4877.
#>  4 Fair  G     carat    4538.
#>  5 Fair  H     carat    4620.
#>  6 Fair  I     carat    3969.
#>  7 Fair  J     carat    4024.
#>  8 Good  D     carat    5207.
#>  9 Good  E     carat    5102.
#> 10 Good  F     carat    5151.
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
#>  1 Fair  fixed  <NA>  carat  3.80e+3      228.      16.7    3212.     4387.
#>  2 Fair  ran_p~ color sd__~  2.16e+3       NA       NA        NA        NA 
#>  3 Fair  ran_p~ color sd__~  2.54e+3       NA       NA        NA        NA 
#>  4 Fair  ran_p~ color cor_~ -9.75e-1       NA       NA        NA        NA 
#>  5 Fair  ran_p~ Resi~ sd__~  1.83e+3       NA       NA        NA        NA 
#>  6 Good  fixed  <NA>  carat  9.22e+3      105.      87.6    8946.     9488.
#>  7 Good  ran_p~ color sd__~  2.69e+3       NA       NA        NA        NA 
#>  8 Good  ran_p~ color sd__~  1.61e+3       NA       NA        NA        NA 
#>  9 Good  ran_p~ color cor_~  9.98e-1       NA       NA        NA        NA 
#> 10 Good  ran_p~ Resi~ sd__~  1.37e+3       NA       NA        NA        NA 
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
#>  1 Fair  D         0.884         0.883 1857.      641. 4.45e- 41     1
#>  2 Fair  E         0.876         0.875 1370.      708. 3.52e- 47     1
#>  3 Fair  F         0.874         0.873 1989.     1071. 1.68e- 71     1
#>  4 Fair  G         0.849         0.848 2138.      887. 1.03e- 66     1
#>  5 Fair  H         0.876         0.875 2412.      998. 7.68e- 66     1
#>  6 Fair  I         0.915         0.914 1499.      850. 4.86e- 44     1
#>  7 Fair  J         0.885         0.883 2189.      416. 4.80e- 27     1
#>  8 Good  D         0.860         0.860 1729.     2065. 2.66e-145     1
#>  9 Good  E         0.870         0.870 1674.     3084. 2.50e-206     1
#> 10 Good  F         0.873         0.873 1677.     3110. 1.76e-204     1
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
#>  1 Fair   8818  1.52 H       7001.  1817. 0.00806 8.37e-3  3519. 7001.
#>  2 Fair   1881  0.65 F       2104.  -223. 0.00225 3.46e-5  1505. 2104.
#>  3 Fair   2376  1.2  G       5439. -3063. 0.00651 1.91e-2  2778. 5439.
#>  4 Fair   1323  0.5  D       1069.   254. 0.00281 5.65e-5  1158. 1069.
#>  5 Fair   3282  0.92 F       3935.  -653. 0.00338 4.48e-4  2130. 3935.
#>  6 Fair   2500  0.7  H       2259.   241. 0.00219 3.96e-5  1621. 2259.
#>  7 Fair  13853  1.5  F       7868.  5985. 0.0149  1.70e-1  3473. 7868.
#>  8 Fair   3869  1.01 H       4052.  -183. 0.00287 2.97e-5  2338. 4052.
#>  9 Fair   1811  0.7  H       2259.  -448. 0.00219 1.37e-4  1621. 2259.
#> 10 Fair   2788  1.01 E       4406. -1618. 0.0135  1.12e-2  2338. 4406.
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
