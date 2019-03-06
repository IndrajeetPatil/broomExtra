## Test environments
* local Windows OS install, R 3.6.0
* ubuntu 14.04 (on travis-ci; devel and release)
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* New submission

## Comments

I have addressed the following concerns (raised during prior submissions):
- I have removed `\dontrun` from examples since none of the examples actually
take more than 5s.
- I have added more details to the `Description` section of the DESCRIPTION file
and modified the text to reflect the stylistic recommendations on reporting
package names and functions names ( Swetlana Herbrandt and Martina Schmirl).
- Despite your recommendation, I would like to retain the `LICENSE` file because
GitHub uses this file to attach the appropriate license label to my repository.
- Added `generics` package to `Suggests` field.
- Added a new vignette that lists all available S3 methods across `broom`
packages.
