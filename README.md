
<!-- README.md is generated from README.Rmd. Please edit that file -->

# broomExtra

<!-- badges: start -->

<!-- badges: end -->

The goal of `broomExtra` is to provide helper functions that assist in
data analysis workflows involving packages `broom` and `broom.mixed`.

## Installation

You can install the development version of `broomExtra` from GitHub:

``` r
remotes::install_github("IndrajeetPatil/broomExtra")
```

## model summaries

``` r
library(lme4)
#> Loading required package: Matrix

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
