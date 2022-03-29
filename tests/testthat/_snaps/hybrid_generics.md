# hybrid methods works

    Code
      lmm_tidy
    Output
      # A tibble: 2 x 10
        term        estimate std.error conf.level conf.low conf.high statistic
        <chr>          <dbl>     <dbl>      <dbl>    <dbl>     <dbl>     <dbl>
      1 (Intercept)    251.       6.82       0.95   238.       265.      36.8 
      2 Days            10.5      1.55       0.95     7.42      13.5      6.77
        df.error  p.value effect
           <int>    <dbl> <chr> 
      1      174 4.37e-84 fixed 
      2      174 1.88e-10 fixed 

---

    Code
      lmm_glance
    Output
      # A tibble: 1 x 12
         nobs sigma loglik   aic   bic remlcrit df.residual  aicc r2.conditional
        <int> <dbl>  <dbl> <dbl> <dbl>    <dbl>       <int> <dbl>          <dbl>
      1   180  25.6  -872. 1756. 1775.    1744.         174 1756.          0.799
        r2.marginal   icc  rmse
              <dbl> <dbl> <dbl>
      1       0.279 0.722  23.4

---

    Code
      lm_tidy
    Output
      # A tibble: 2 x 9
        term        estimate std.error conf.level conf.low conf.high statistic
        <chr>          <dbl>     <dbl>      <dbl>    <dbl>     <dbl>     <dbl>
      1 (Intercept)    251.       6.61       0.95   238.       264.      38.0 
      2 Days            10.5      1.24       0.95     8.02      12.9      8.45
        df.error  p.value
           <int>    <dbl>
      1      178 2.16e-87
      2      178 9.89e-15

---

    Code
      lm_glance
    Output
      # A tibble: 1 x 13
        r.squared adj.r.squared sigma statistic  p.value    df loglik   aic   bic
            <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
      1     0.286         0.282  47.7      71.5 9.89e-15     1  -950. 1906. 1916.
        deviance df.residual  nobs  rmse
           <dbl>       <int> <int> <dbl>
      1  405252.         178   180  47.4

---

    Code
      df_rlm
    Output
      # A tibble: 4 x 9
        term        estimate std.error conf.level conf.low conf.high statistic
        <chr>          <dbl>     <dbl>      <dbl>    <dbl>     <dbl>     <dbl>
      1 (Intercept)  -41.0       9.81        0.95  -61.7     -20.3      -4.18 
      2 Air.Flow       0.829     0.111       0.95    0.595     1.06      7.46 
      3 Water.Temp     0.926     0.303       0.95    0.286     1.57      3.05 
      4 Acid.Conc.    -0.128     0.129       0.95   -0.400     0.144    -0.992
        df.error     p.value
           <int>       <dbl>
      1       17 0.000624   
      2       17 0.000000933
      3       17 0.00720    
      4       17 0.335      

