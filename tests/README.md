Tests and Coverage
================
10 August, 2019 11:15:13

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
| [test-boot\_generics.R](testthat/test-boot_generics.R)       | 10 | 3.28 |     0 |      0 |       0 |       0 |
| [test-generics.R](testthat/test-generics.R)                  |  9 | 0.17 |     0 |      0 |       0 |       0 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R) |  6 | 6.47 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                             | context                 | test                      | status | n | time |
| :--------------------------------------------------------------- | :---------------------- | :------------------------ | :----- | -: | ---: |
| [test-boot\_generics.R](testthat/test-boot_generics.R#L41)       | boot\_generics work     | `boot_tidy()` works       | PASS   | 3 | 1.48 |
| [test-boot\_generics.R](testthat/test-boot_generics.R#L83)       | boot\_generics work     | `boot_glance()` works     | PASS   | 4 | 1.75 |
| [test-boot\_generics.R](testthat/test-boot_generics.R#L120)      | boot\_generics work     | `boot_augment()` works    | PASS   | 3 | 0.05 |
| [test-generics.R](testthat/test-generics.R#L13_L15)              | generics work           | `tidy()` works            | PASS   | 3 | 0.06 |
| [test-generics.R](testthat/test-generics.R#L39_L41)              | generics work           | `glance()` works          | PASS   | 3 | 0.05 |
| [test-generics.R](testthat/test-generics.R#L65_L67)              | generics work           | `augment()` works         | PASS   | 3 | 0.06 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L20) | grouped\_generics works | `grouped_tidy()` works    | PASS   | 2 | 2.24 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L50) | grouped\_generics works | `grouped_glance()` works  | PASS   | 2 | 2.01 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L79) | grouped\_generics works | `grouped_augment()` works | PASS   | 2 | 2.22 |

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

| Package  | Version |
| :------- | :------ |
| testthat | 2.2.1   |
| covr     | 3.3.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
