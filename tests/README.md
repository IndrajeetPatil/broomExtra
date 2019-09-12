Tests and Coverage
================
12 September, 2019 10:43:53

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                           | Coverage (%) |
| :----------------------------------------------- | :----------: |
| broomExtra                                       |     100      |
| [R/boot\_generics.R](../R/boot_generics.R)       |     100      |
| [R/generics.R](../R/generics.R)                  |     100      |
| [R/grouped\_generics.R](../R/grouped_generics.R) |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                         |  n | time | error | failed | skipped | warning |
| :----------------------------------------------------------- | -: | ---: | ----: | -----: | ------: | ------: |
| [test-boot\_generics.R](testthat/test-boot_generics.R)       | 10 | 2.36 |     0 |      0 |       0 |       0 |
| [test-generics.R](testthat/test-generics.R)                  | 11 | 0.37 |     0 |      0 |       0 |       0 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R) |  6 | 7.38 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                             | context                 | test                      | status | n | time |
| :--------------------------------------------------------------- | :---------------------- | :------------------------ | :----- | -: | ---: |
| [test-boot\_generics.R](testthat/test-boot_generics.R#L40)       | boot\_generics work     | `boot_tidy()` works       | PASS   | 3 | 1.26 |
| [test-boot\_generics.R](testthat/test-boot_generics.R#L81)       | boot\_generics work     | `boot_glance()` works     | PASS   | 4 | 1.00 |
| [test-boot\_generics.R](testthat/test-boot_generics.R#L117)      | boot\_generics work     | `boot_augment()` works    | PASS   | 3 | 0.10 |
| [test-generics.R](testthat/test-generics.R#L13_L15)              | generics work           | `tidy()` works            | PASS   | 5 | 0.23 |
| [test-generics.R](testthat/test-generics.R#L50_L52)              | generics work           | `glance()` works          | PASS   | 3 | 0.07 |
| [test-generics.R](testthat/test-generics.R#L76_L78)              | generics work           | `augment()` works         | PASS   | 3 | 0.07 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L20) | grouped\_generics works | `grouped_tidy()` works    | PASS   | 2 | 2.57 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L50) | grouped\_generics works | `grouped_glance()` works  | PASS   | 2 | 2.56 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L79) | grouped\_generics works | `grouped_augment()` works | PASS   | 2 | 2.25 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                            |
| :------- | :------------------------------- |
| Version  | R version 3.6.1 (2019-07-05)     |
| Platform | x86\_64-w64-mingw32/x64 (64-bit) |
| Running  | Windows 10 x64 (build 16299)     |
| Language | English\_United States           |
| Timezone | Europe/Berlin                    |

| Package  | Version |
| :------- | :------ |
| testthat | 2.2.1   |
| covr     | 3.3.1   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
