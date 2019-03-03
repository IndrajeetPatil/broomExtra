## Test environments
* local Windows OS install, R 3.6.0
* ubuntu 14.04 (on travis-ci), R 3.6.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* New submission

## Comments

I have addressed the following concerns by Martina Schmirl:
- I have removed `\dontrun` from examples since none of the examples actually
take more than 5s.
- I have added more details to the `Description` section of the DESCRIPTION file.
- Despite your recommendation, I would like to retain the `LICENSE` file because
GitHub uses this file to attach the appropriate license label to my repository.
