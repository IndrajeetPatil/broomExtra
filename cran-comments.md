## Test environments
* local Windows OS install, R 3.6.0
* ubuntu 14.04 (on travis-ci; devel and release)
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* New submission

## Comments

This is maintenance release to make the package compatible with upcoming release
of `dplyr 0.8.1`. This is what the `NOTE` corresponds to. The `group_modify`
function is currently not imported because it is being introduced in this new
release.