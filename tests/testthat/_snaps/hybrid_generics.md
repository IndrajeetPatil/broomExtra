# hybrid methods works

    Code
      df_lm
    Output
      # A tibble: 2 x 9
        term        estimate std.error conf.level conf.low conf.high statistic
        <chr>          <dbl>     <dbl>      <dbl>    <dbl>     <dbl>     <dbl>
      1 (Intercept)    251.       5.18       0.95   241.       262.      48.5 
      2 Days            10.5      1.28       0.95     7.94      13.0      8.17
        df.error   p.value
           <int>     <dbl>
      1      178 1.55e-104
      2      178 5.63e- 14

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

