Tests and Coverage
================
01 January, 2020 17:36:46

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
| [R/generics.R](../R/generics.R)                  |     100      |
| [R/grouped\_generics.R](../R/grouped_generics.R) |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                         |  n | time | error | failed | skipped | warning |
| :----------------------------------------------------------- | -: | ---: | ----: | -----: | ------: | ------: |
| [test-generics.R](testthat/test-generics.R)                  | 11 | 0.25 |     0 |      0 |       0 |       0 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R) |  6 | 7.18 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                             | context                 |           test            | status | n | time |
| :--------------------------------------------------------------- | :---------------------- | :-----------------------: | :----- | -: | ---: |
| [test-generics.R](testthat/test-generics.R#L13_L15)              | generics work           |      `tidy()` works       | PASS   | 5 | 0.09 |
| [test-generics.R](testthat/test-generics.R#L50_L52)              | generics work           |     `glance()` works      | PASS   | 3 | 0.08 |
| [test-generics.R](testthat/test-generics.R#L76_L78)              | generics work           |     `augment()` works     | PASS   | 3 | 0.08 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L20) | grouped\_generics works |  `grouped_tidy()` works   | PASS   | 2 | 2.51 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L50) | grouped\_generics works | `grouped_glance()` works  | PASS   | 2 | 2.07 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L79) | grouped\_generics works | `grouped_augment()` works | PASS   | 2 | 2.60 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                            |
| :------- | :------------------------------- |
| Version  | R version 3.6.2 (2019-12-12)     |
| Platform | x86\_64-w64-mingw32/x64 (64-bit) |
| Running  | Windows 10 x64 (build 16299)     |
| Language | English\_United States           |
| Timezone | Europe/Berlin                    |

| Package  | Version |
| :------- | :------ |
| testthat | 2.3.1   |
| covr     | 3.4.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
