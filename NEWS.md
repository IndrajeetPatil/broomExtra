# broomExtra 0.0.5

  - In addition to trying to extract results using tidiers from `broom` and
    `broom.mixed`, `broomExtra::tidy` now also attempts to convert the entered
    object into a `tibble` dataframe. This is solely to deal with dataframes
    which are often encountered while writing wrapper functions around `tidy`.
    
  - Minor refactoring of `boot_` generic functions to make them compatible with
    upcoming release of `tidyr`.

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
