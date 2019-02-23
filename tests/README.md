Tests and Coverage
================
23 February, 2019 12:42:25

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                        | Coverage (%) |
| :---------------------------- | :----------: |
| broomExtra                    |     100      |
| [R/augment.R](../R/augment.R) |     100      |
| [R/glance.R](../R/glance.R)   |     100      |
| [R/tidy.R](../R/tidy.R)       |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                        | n | time | error | failed | skipped | warning |
| :---------------------------------------------------------- | -: | ---: | ----: | -----: | ------: | ------: |
| [test-augment-examples.R](testthat/test-augment-examples.R) | 3 | 0.07 |     0 |      0 |       0 |       0 |
| [test-glance-examples.R](testthat/test-glance-examples.R)   | 3 | 0.05 |     0 |      0 |       0 |       0 |
| [test-tidy-examples.R](testthat/test-tidy-examples.R)       | 3 | 0.06 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                                                | context       | test              | status | n | time |
| :------------------------------------------------------------------ | :------------ | :---------------- | :----- | -: | ---: |
| [test-augment-examples.R](testthat/test-augment-examples.R#L13_L15) | augment works | `augment()` works | PASS   | 3 | 0.07 |
| [test-glance-examples.R](testthat/test-glance-examples.R#L13_L15)   | glance works  | `glance()` works  | PASS   | 3 | 0.05 |
| [test-tidy-examples.R](testthat/test-tidy-examples.R#L13_L15)       | tidy works    | `tidy()` works    | PASS   | 3 | 0.06 |

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
