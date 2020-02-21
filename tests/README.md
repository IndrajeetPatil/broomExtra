Tests and Coverage
================
21 February, 2020 22:02:53

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                                           | Coverage (%) |
| :--------------------------------------------------------------- | :----------: |
| broomExtra                                                       |     100      |
| [R/easystats\_to\_tidy\_names.R](../R/easystats_to_tidy_names.R) |     100      |
| [R/generics.R](../R/generics.R)                                  |     100      |
| [R/generics\_easystats.R](../R/generics_easystats.R)             |     100      |
| [R/grouped\_generics.R](../R/grouped_generics.R)                 |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                                         |  n | time | error | failed | skipped | warning |
| :--------------------------------------------------------------------------- | -: | ---: | ----: | -----: | ------: | ------: |
| [test-easystats\_to\_tidy\_names.R](testthat/test-easystats_to_tidy_names.R) |  3 | 0.16 |     0 |      0 |       0 |       0 |
| [test-generics.R](testthat/test-generics.R)                                  | 11 | 0.75 |     0 |      0 |       0 |       0 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R)                 |  6 | 6.20 |     0 |      0 |       0 |       0 |
| [test-hybrid\_generics.R](testthat/test-hybrid_generics.R)                   |  9 | 0.95 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                                             | context                    |                     test                     | status | n | time |
| :------------------------------------------------------------------------------- | :------------------------- | :------------------------------------------: | :----- | -: | ---: |
| [test-easystats\_to\_tidy\_names.R](testthat/test-easystats_to_tidy_names.R#L12) | easystats\_to\_tidy\_names | easystats\_to\_tidy\_names works as expected | PASS   | 3 | 0.16 |
| [test-generics.R](testthat/test-generics.R#L13_L15)                              | generics work              |                `tidy()` works                | PASS   | 5 | 0.60 |
| [test-generics.R](testthat/test-generics.R#L50_L52)                              | generics work              |               `glance()` works               | PASS   | 3 | 0.06 |
| [test-generics.R](testthat/test-generics.R#L76_L78)                              | generics work              |              `augment()` works               | PASS   | 3 | 0.09 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L20)                 | grouped\_generics works    |            `grouped_tidy()` works            | PASS   | 2 | 2.33 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L50)                 | grouped\_generics works    |           `grouped_glance()` works           | PASS   | 2 | 1.84 |
| [test-grouped\_generics.R](testthat/test-grouped_generics.R#L79)                 | grouped\_generics works    |          `grouped_augment()` works           | PASS   | 2 | 2.03 |
| [test-hybrid\_generics.R](testthat/test-hybrid_generics.R#L12_L13)               | hybrid\_generics           |             hybrid methods works             | PASS   | 9 | 0.95 |

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
