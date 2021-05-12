# `grouped_tidy()` works

    Code
      list(lmer_df, lm_df)
    Output
      [[1]]
      # A tibble: 8 x 9
        sex   effect   group    term            estimate std.error statistic conf.low
        <fct> <chr>    <chr>    <chr>              <dbl>     <dbl>     <dbl>    <dbl>
      1 F     fixed    <NA>     (Intercept)       623.     161.         3.88   209.  
      2 F     fixed    <NA>     age                -4.34     2.61      -1.66   -11.1 
      3 F     ran_pars status   sd__(Intercept)   169.      NA         NA       NA   
      4 F     ran_pars Residual sd__Observation   415.      NA         NA       NA   
      5 M     fixed    <NA>     (Intercept)       553.      62.5        8.84   392.  
      6 M     fixed    <NA>     age                -3.60     0.696     -5.17    -5.39
      7 M     ran_pars status   sd__(Intercept)    79.8     NA         NA       NA   
      8 M     ran_pars Residual sd__Observation   355.      NA         NA       NA   
        conf.high
            <dbl>
      1   1037.  
      2      2.38
      3     NA   
      4     NA   
      5    714.  
      6     -1.80
      7     NA   
      8     NA   
      
      [[2]]
      # A tibble: 4 x 8
        sex   term        estimate std.error statistic  p.value conf.low conf.high
        <fct> <chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
      1 F     (Intercept)   668.     110.         6.08 3.09e- 8   379.     957.   
      2 F     age            -6.06     2.61      -2.32 2.26e- 2   -12.9      0.815
      3 M     (Intercept)   547.      27.2       20.1  4.68e-84   477.     617.   
      4 M     age            -3.80     0.704     -5.40 7.38e- 8    -5.61    -1.98 
      

# `grouped_glance()` works

    Code
      list(lmer_df, lm_df)
    Output
      [[1]]
      # A tibble: 2 x 7
        sex   sigma  logLik    AIC    BIC REMLcrit df.residual
        <fct> <dbl>   <dbl>  <dbl>  <dbl>    <dbl>       <int>
      1 F      415.   -656.  1321.  1331.    1313.          85
      2 M      355. -20079. 40165. 40189.   40157.        2750
      
      [[2]]
      # A tibble: 2 x 13
        sex   r.squared adj.r.squared sigma statistic      p.value    df  logLik
        <fct>     <dbl>         <dbl> <dbl>     <dbl>        <dbl> <dbl>   <dbl>
      1 F        0.0583        0.0475  431.      5.39 0.0226           1   -665.
      2 M        0.0105        0.0101  359.     29.1  0.0000000738     1 -20112.
           AIC    BIC   deviance df.residual  nobs
         <dbl>  <dbl>      <dbl>       <int> <int>
      1  1336.  1344.  16139909.          87    89
      2 40231. 40249. 355441032.        2752  2754
      

