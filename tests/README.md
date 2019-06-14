Tests and Coverage
================
13 June, 2019 18:26:28

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                         | Coverage (%) |
| :--------------------------------------------- | :----------: |
| broomExtra                                     |     100      |
| [R/boot\_augment.R](../R/boot_augment.R)       |     100      |
| [R/boot\_glance.R](../R/boot_glance.R)         |     100      |
| [R/boot\_tidy.R](../R/boot_tidy.R)             |     100      |
| [R/generic\_augment.R](../R/generic_augment.R) |     100      |
| [R/generic\_glance.R](../R/generic_glance.R)   |     100      |
| [R/generic\_tidy.R](../R/generic_tidy.R)       |     100      |
| [R/grouped\_augment.R](../R/grouped_augment.R) |     100      |
| [R/grouped\_glance.R](../R/grouped_glance.R)   |     100      |
| [R/grouped\_tidy.R](../R/grouped_tidy.R)       |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                        | n | time | error | failed | skipped | warning |
| :---------------------------------------------------------- | -: | ---: | ----: | -----: | ------: | ------: |
| [test\_augment.R](testthat/test_augment.R)                  | 3 | 0.06 |     0 |      0 |       0 |       0 |
| [test\_boot\_augment.R](testthat/test_boot_augment.R)       | 3 | 0.06 |     0 |      0 |       0 |       0 |
| [test\_boot\_glance.R](testthat/test_boot_glance.R)         | 4 | 0.77 |     0 |      0 |       0 |       0 |
| [test\_boot\_tidy.R](testthat/test_boot_tidy.R)             | 4 | 0.95 |     0 |      0 |       0 |       0 |
| [test\_glance.R](testthat/test_glance.R)                    | 3 | 0.03 |     0 |      0 |       0 |       0 |
| [test\_grouped\_augment.R](testthat/test_grouped_augment.R) | 2 | 2.58 |     0 |      0 |       0 |       0 |
| [test\_grouped\_glance.R](testthat/test_grouped_glance.R)   | 2 | 1.81 |     0 |      0 |       0 |       0 |
| [test\_grouped\_tidy.R](testthat/test_grouped_tidy.R)       | 2 | 1.91 |     0 |      0 |       0 |       0 |
| [test\_tidy.R](testthat/test_tidy.R)                        | 3 | 0.06 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                            | context                | test                      | status | n | time |
| :-------------------------------------------------------------- | :--------------------- | :------------------------ | :----- | -: | ---: |
| [test\_augment.R](testthat/test_augment.R#L13_L15)              | augment works          | `augment()` works         | PASS   | 3 | 0.06 |
| [test\_boot\_augment.R](testthat/test_boot_augment.R#L32)       | boot\_augment works    | `boot_augment()` works    | PASS   | 3 | 0.06 |
| [test\_boot\_glance.R](testthat/test_boot_glance.R#L38)         | boot\_glance works     | `boot_glance()` works     | PASS   | 4 | 0.77 |
| [test\_boot\_tidy.R](testthat/test_boot_tidy.R#L40)             | boot\_tidy works       | `boot_tidy()` works       | PASS   | 4 | 0.95 |
| [test\_glance.R](testthat/test_glance.R#L13_L15)                | glance works           | `glance()` works          | PASS   | 3 | 0.03 |
| [test\_grouped\_augment.R](testthat/test_grouped_augment.R#L19) | grouped\_augment works | `grouped_augment()` works | PASS   | 2 | 2.58 |
| [test\_grouped\_glance.R](testthat/test_grouped_glance.R#L19)   | grouped\_glance works  | `grouped_glance()` works  | PASS   | 2 | 1.81 |
| [test\_grouped\_tidy.R](testthat/test_grouped_tidy.R#L20)       | grouped\_tidy works    | `grouped_tidy()` works    | PASS   | 2 | 1.91 |
| [test\_tidy.R](testthat/test_tidy.R#L13_L15)                    | tidy works             | `tidy()` works            | PASS   | 3 | 0.06 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                                     |
| :------- | :---------------------------------------- |
| Version  | R version 3.6.0 alpha (2019-03-29 r76300) |
| Platform | x86\_64-w64-mingw32/x64 (64-bit)          |
| Running  | Windows 10 x64 (build 16299)              |
| Language | English\_United States                    |
| Timezone | America/New\_York                         |

| Package  | Version |
| :------- | :------ |
| testthat | 2.1.1   |
| covr     | 3.2.1   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
