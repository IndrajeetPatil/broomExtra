Tests and Coverage
================
23 February, 2019 13:23:48

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                   | Coverage (%) |
| :--------------------------------------- | :----------: |
| broomExtra                               |    71.19     |
| [R/grouped\_tidy.R](../R/grouped_tidy.R) |     0.00     |
| [R/augment.R](../R/augment.R)            |    100.00    |
| [R/glance.R](../R/glance.R)              |    100.00    |
| [R/tidy.R](../R/tidy.R)                  |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                       | n | time | error | failed | skipped | warning |
| :----------------------------------------- | -: | ---: | ----: | -----: | ------: | ------: |
| [test\_augment.R](testthat/test_augment.R) | 3 | 0.08 |     0 |      0 |       0 |       0 |
| [test\_glance.R](testthat/test_glance.R)   | 3 | 0.05 |     0 |      0 |       0 |       0 |
| [test\_tidy.R](testthat/test_tidy.R)       | 3 | 0.04 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                               | context       | test              | status | n | time |
| :------------------------------------------------- | :------------ | :---------------- | :----- | -: | ---: |
| [test\_augment.R](testthat/test_augment.R#L13_L15) | augment works | `augment()` works | PASS   | 3 | 0.08 |
| [test\_glance.R](testthat/test_glance.R#L13_L15)   | glance works  | `glance()` works  | PASS   | 3 | 0.05 |
| [test\_tidy.R](testthat/test_tidy.R#L13_L15)       | tidy works    | `tidy()` works    | PASS   | 3 | 0.04 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                                              |
| :------- | :------------------------------------------------- |
| Version  | R Under development (unstable) (2018-11-30 r75724) |
| Platform | x86\_64-w64-mingw32/x64 (64-bit)                   |
| Running  | Windows 10 x64 (build 16299)                       |
| Language | English\_United States                             |
| Timezone | America/New\_York                                  |

| Package  | Version |
| :------- | :------ |
| testthat | 2.0.1   |
| covr     | 3.2.1   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
