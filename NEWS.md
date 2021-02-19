# broomExtra 4.2.0.9000

# broomExtra 4.2.0

  - The tests are no longer skipped on `CRAN`.

# broomExtra 4.1.0

  - `...` are now passed to individual methods in `glance_performance`.
  
  - Removes `ipmisc` from dependencies.

# broomExtra 4.0.6

  - Minor tweak to the documentation.
  
  - `easystats_to_tidy_names` is now reexported from `ipmisc`.

# broomExtra 4.0.5

  - More comprehensive coverage of terms from `easystats` packages.

# broomExtra 4.0.4

  - Adapts tests to changes made to `parameters` package. 

# broomExtra 4.0.3

  - Minor release to fix `NOTE` produced in new `R`-devel checks.

# broomExtra 4.0.2

  - Minor changes made to fix warnings caused by `dplyr 1.0.0`.
  
  - Retired vignette. Check out respective packages to see what methods are
    supported.

# broomExtra 4.0.0

  - The `broom` package is not being actively maintained, which had become a
    bottleneck for both development and testing the current package. So, now the
    `tidy_parameters` function defaults to `parameters::model_parameters` and
    uses `broom` packages only if that doesn't work. This also has some other
    benefits (#21).

# broomExtra 3.0.0

  - Slight modification to `easystats_to_tidy_names` to cover naming patterns
    from a few more `easystats` packages.
    
  - Minimum R version bumped to `3.6.0`.
  
  - Relies on `ipmisc` package for re-exports.

# broomExtra 2.5.0

  - The `glance_performance` function now returns a combined summary dataframe
    from `broom` and `performance` packages, if both are available. This was
    done to include some unique performance measures that only the `performance`
    package contains (e.g., Nagelkerke's $R^2$, Tjur's $R^2$, etc.).
    
  - Thanks to Sarah, the package now has a hexsticker.

# broomExtra 2.0.0

  - New functions that make it easy to access tidy dataframes from both
    `broom`-family and `easystats`-family packages with the following functions:
    `tidy_parameters` and `glance_performance`.
    
  - `tidy` method no longer attempt to convert entered objects to a tibble as a
    last resort as this was converting model objects in case the tidiers failed
    for some reason.
 
# broomExtra 1.0.1

  - Minor internal refactoring of code.

# broomExtra 1.0.0

  - Deprecated `boot_` functions as they added nothing over and above `rsample`.
 
# broomExtra 0.0.6
 
  - Maintenance release to make package compatible with `dplyr 0.8.4`.

# broomExtra 0.0.5

  - In addition to trying to extract results using tidiers from `broom` and
    `broom.mixed`, `broomExtra::tidy` now also attempts to convert the entered
    object into a `tibble` dataframe. This is solely to deal with dataframes
    which are often encountered while writing wrapper functions around `tidy`.
    
  - Minor refactoring of `boot_` generic functions to make them compatible with
    upcoming release of `tidyr`.
    
  - More operators from `tidyverse` added to reexports.

# broomExtra 0.0.4

  - Adds new functions for bootstrapping: `boot_tidy`, `boot_glance`,
    `boot_augment`.

# broomExtra 0.0.3

  - This is maintenance release to make the package compatible with `R 3.6.0`.

# broomExtra 0.0.2

  - This is maintenance release to make the package compatible with
    `dplyr 0.8.1`.

# broomExtra 0.0.1

  - Initial release.
