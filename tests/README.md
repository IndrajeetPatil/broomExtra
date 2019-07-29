Tests and Coverage
================
29 July, 2019 12:52:45

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

| file                                                          |  n | time | error | failed | skipped | warning |
| :------------------------------------------------------------ | -: | ---: | ----: | -----: | ------: | ------: |
| [test\_boot\_generics.R](testthat/test_boot_generics.R)       | 11 | 2.01 |     0 |      0 |       0 |       0 |
| [test\_generics.R](testthat/test_generics.R)                  |  9 | 0.17 |     0 |      0 |       0 |       0 |
| [test\_grouped\_generics.R](testthat/test_grouped_generics.R) |  6 | 6.09 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                              | context                 | test                      | status | n | time |
| :---------------------------------------------------------------- | :---------------------- | :------------------------ | :----- | -: | ---: |
| [test\_boot\_generics.R](testthat/test_boot_generics.R#L40)       | boot\_generics work     | `boot_tidy()` works       | PASS   | 4 | 1.10 |
| [test\_boot\_generics.R](testthat/test_boot_generics.R#L82)       | boot\_generics work     | `boot_glance()` works     | PASS   | 4 | 0.83 |
| [test\_boot\_generics.R](testthat/test_boot_generics.R#L118)      | boot\_generics work     | `boot_augment()` works    | PASS   | 3 | 0.08 |
| [test\_generics.R](testthat/test_generics.R#L13_L15)              | generics work           | `tidy()` works            | PASS   | 3 | 0.04 |
| [test\_generics.R](testthat/test_generics.R#L39_L41)              | generics work           | `glance()` works          | PASS   | 3 | 0.05 |
| [test\_generics.R](testthat/test_generics.R#L65_L67)              | generics work           | `augment()` works         | PASS   | 3 | 0.08 |
| [test\_grouped\_generics.R](testthat/test_grouped_generics.R#L20) | grouped\_generics works | `grouped_tidy()` works    | PASS   | 2 | 2.28 |
| [test\_grouped\_generics.R](testthat/test_grouped_generics.R#L50) | grouped\_generics works | `grouped_glance()` works  | PASS   | 2 | 1.70 |
| [test\_grouped\_generics.R](testthat/test_grouped_generics.R#L79) | grouped\_generics works | `grouped_augment()` works | PASS   | 2 | 2.11 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                            |
| :------- | :------------------------------- |
| Version  | R version 3.6.1 (2019-07-05)     |
| Platform | x86\_64-w64-mingw32/x64 (64-bit) |
| Running  | Windows 10 x64 (build 16299)     |
| Language | English\_United States           |
| Timezone | America/New\_York                |

| Package  | Version    |
| :------- | :--------- |
| testthat | 2.2.1      |
| covr     | 3.2.1.9000 |
| covrpage | 0.0.70     |

</details>

<!--- Final Status : pass --->
