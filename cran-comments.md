## Submission

This is a resubmission of bslibdash 0.7.5.

bslibdash provides a Bootstrap 5 dashboard framework for Shiny apps, built on
top of bslib. It packages a page shell, sidebar navigation, cards, KPI tiles,
header widgets and feedback components behind an API that mirrors
shinydashboard wherever the underlying concept is the same.

### Changes since the previous submission

The pretest run for this version reported one NOTE, "Possibly misspelled
words in DESCRIPTION" (bslib, shinydashboard, theming) and "Found the
following (possibly) invalid file URI: CONTRIBUTING.md". Fixed by:

* single-quoting the package names ('bslib', 'shinydashboard') in
  `Description` and rewording "theming" to "themes";
* pointing the README's CONTRIBUTING.md link to its absolute GitHub URL
  (CONTRIBUTING.md is intentionally excluded from the built package via
  `.Rbuildignore`).

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
