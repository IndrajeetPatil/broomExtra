
<!-- README.md is generated from README.Rmd. Please edit that file -->

# broomExtra

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/IndrajeetPatil/broomExtra?branch=master&svg=true)](https://ci.appveyor.com/project/IndrajeetPatil/broomExtra)
[![Travis build
status](https://travis-ci.org/IndrajeetPatil/broomExtra.svg?branch=master)](https://travis-ci.org/IndrajeetPatil/broomExtra)
[![Codecov test
coverage](https://codecov.io/gh/IndrajeetPatil/broomExtra/branch/master/graph/badge.svg)](https://codecov.io/gh/IndrajeetPatil/broomExtra?branch=master)
<!-- badges: end -->

The goal of `broomExtra` is to provide helper functions that assist in
data analysis workflows involving packages `broom` and `broom.mixed`.

## Installation

You can install the development version of `broomExtra` from GitHub:

``` r
remotes::install_github("IndrajeetPatil/broomExtra")
```

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
```
