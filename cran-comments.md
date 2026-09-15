## Submission

This is a resubmission of bslibdash 0.7.5, addressing the manual inspection
comments received on 2026-09-12.

bslibdash provides a Bootstrap 5 dashboard framework for Shiny apps, built on
top of bslib. It packages a page shell, sidebar navigation, cards, KPI tiles,
header widgets and feedback components behind an interface that mirrors
shinydashboard wherever the underlying concept is the same.

### Changes since the previous submission

**1. Package, software and API names in single quotes in Title and
Description.**

Both fields now quote every software name, using each package's own
capitalisation:

* `Title: 'Bootstrap' 5 Dashboard Framework for 'shiny' Apps`
* `Description` quotes 'Bootstrap', 'shiny', 'bslib' and 'shinydashboard'.

While revising the field we also removed an unsupported comparative claim and
named the components the package actually provides, rather than referring to
them as "reusable components".

**2. References describing the methods in the package.**

bslibdash is a user-interface component framework and does not implement a
published method or algorithm, so there are no corresponding references to cite
in the Description field. The software it builds on ('bslib', 'Bootstrap' 5) is
declared in `Imports` and referenced in the package documentation and vignettes.

**3. Missing `\value` tags.**

`\value` has been added for every exported function. Each entry names the class
or the constructor of the returned object and explains what the object is used
for; functions that exist only for their side effects are documented as such,
for example `updateTabItems()`: "nothing. This function is called for its
side-effects."

All 31 function `.Rd` files now carry a `\value` section. The remaining file,
`bslibdash-package.Rd`, is the package-level `\docType{package}` overview, which
conventionally has none.

Four pre-existing `\value` entries that named no class (`dashboardPage()`,
`brand_bs_theme()`, `icon()`, `sidebarUserPanel()`) were expanded at the same
time, so that the documentation is consistent throughout. Wording and level of
detail follow the conventions used by 'bslib'.

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

The local run reports a single NOTE, "checking for future file timestamps ...
unable to verify current time", which is an artefact of this machine having no
outbound internet access rather than a property of the package.

## Downstream dependencies

This is a new package, so there are no reverse dependencies to check.
