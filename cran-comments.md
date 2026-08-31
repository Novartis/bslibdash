## Submission

This is a resubmission of bslibdash 0.7.5.

bslibdash provides a Bootstrap 5 dashboard framework for Shiny apps, built on
top of bslib. It packages a page shell, sidebar navigation, cards, KPI tiles,
header widgets and feedback components behind an API that mirrors
shinydashboard wherever the underlying concept is the same.

### Changes since the previous submission

The pretest run for this version reported one NOTE on both platforms and one
additional Debian-only NOTE:

* "Possibly misspelled words in DESCRIPTION" (bslib, shinydashboard, theming)
  and "Found the following (possibly) invalid file URI: CONTRIBUTING.md" —
  fixed by single-quoting the package names in `Description`, rewording
  "theming" to "themes", and pointing the README's CONTRIBUTING.md link to
  its absolute GitHub URL (CONTRIBUTING.md is intentionally excluded from the
  built package via `.Rbuildignore`).

* "checking for detritus in the temp directory ... NOTE" (Debian only,
  `calibre-mrsylpa8`) — we audited the package's R code, examples, tests and
  vignettes and found no call to `browseURL()`, `shell.exec()`, or any other
  function that opens an external viewer/browser; all `shinyApp()` examples
  are wrapped in `\dontrun{}`, the one test file that launches an app is
  `skip()`ped, and every vignette code chunk is `eval = FALSE`. The
  corresponding Windows pretest run completed with no detritus NOTE at all.
  We were unable to reproduce this locally and believe it is unrelated to
  this package's code, but please let us know if further investigation is
  needed.

## Test environments

* Local: Windows 11 x64, R 4.5.2
* GitHub Actions (via `r-lib/actions`), on every push/PR:
  * macOS-latest, R release
  * Windows-latest, R release
  * Ubuntu-latest, R devel
  * Ubuntu-latest, R release
  * Ubuntu-latest, R oldrel-1
* win-builder: release, devel, oldrelease (to be run before final submission)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Downstream dependencies

This is a new package, so there are no reverse dependencies to check.
