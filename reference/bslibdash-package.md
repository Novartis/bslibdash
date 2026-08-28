# bslibdash: Bootstrap 5 dashboards for Shiny

Build Bootstrap 5 dashboards in Shiny, on
[bslib](https://rstudio.github.io/bslib/reference/bslib-package.html).
bslibdash provides a page shell
([`dashboardPage()`](https://opensource.nibr.com/bslibdash/reference/dashboardPage.md),
[`dashboardHeader()`](https://opensource.nibr.com/bslibdash/reference/dashboardHeader.md),
[`dashboardSidebar()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md),
[`dashboardBody()`](https://opensource.nibr.com/bslibdash/reference/dashboardBody.md),
[`dashboardFooter()`](https://opensource.nibr.com/bslibdash/reference/dashboardFooter.md)),
sidebar navigation
([`sidebarMenu()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md),
[`menuItem()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md),
[`sidebarUserPanel()`](https://opensource.nibr.com/bslibdash/reference/sidebarUserPanel.md)),
cards
([`box()`](https://opensource.nibr.com/bslibdash/reference/box.md),
[`boxLayout()`](https://opensource.nibr.com/bslibdash/reference/boxLayout.md),
[`tabBox()`](https://opensource.nibr.com/bslibdash/reference/tabBox.md)),
KPI tiles
([`valueBox()`](https://opensource.nibr.com/bslibdash/reference/valueBox.md),
[`infoBox()`](https://opensource.nibr.com/bslibdash/reference/infoBox.md)),
header dropdowns
([`dropdownMenu()`](https://opensource.nibr.com/bslibdash/reference/dropdownMenu.md),
[`notificationItem()`](https://opensource.nibr.com/bslibdash/reference/dropdownMenu.md),
[`messageItem()`](https://opensource.nibr.com/bslibdash/reference/dropdownMenu.md),
[`taskItem()`](https://opensource.nibr.com/bslibdash/reference/dropdownMenu.md)),
and lightweight feedback helpers (accordions, badges, toasts).

## Details

Function names mirror
[shinydashboard](https://rstudio.github.io/shinydashboard/) wherever the
underlying concept is the same, so most apps port across as a
search-and-replace. bslibdash is *not* a drop-in clone: a small number
of legacy arguments and behaviours that no longer make sense on
Bootstrap 5 have been removed — see
[`vignette("getting-started", package = "bslibdash")`](https://opensource.nibr.com/bslibdash/articles/getting-started.md)
for the full migration story.

Every bslibdash component attaches its CSS via
[`bslib::bs_dependency_defer()`](https://rstudio.github.io/bslib/reference/bs_dependency.html),
so any
[`bslib::bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
(including the bundled
[`brand_bs_theme()`](https://opensource.nibr.com/bslibdash/reference/brand_bs_theme.md))
recompiles bslibdash styles against the active theme.

## Learn more

- [`vignette("getting-started", package = "bslibdash")`](https://opensource.nibr.com/bslibdash/articles/getting-started.md)
  — minimal skeleton and the migration guide from shinydashboard.

- [`vignette("components", package = "bslibdash")`](https://opensource.nibr.com/bslibdash/articles/components.md)
  — a tour of every component with copy-pasteable examples.

- [`vignette("theming", package = "bslibdash")`](https://opensource.nibr.com/bslibdash/articles/theming.md)
  — customising
  [`brand_bs_theme()`](https://opensource.nibr.com/bslibdash/reference/brand_bs_theme.md),
  swapping Bootswatch presets, and adding bespoke SCSS.

## See also

Useful links:

- <https://github.com/Novartis/bslibdash>

- <https://opensource.nibr.com/bslibdash/>

- Report bugs at <https://github.com/Novartis/bslibdash/issues>

## Author

**Maintainer**: Alexandros Kouretsis <alexandros@appsilon.com>

Authors:

- Alexandros Kouretsis <alexandros@appsilon.com>

- Ardalan Mirshani <ardalan.mirshani@novartis.com>

- Dominik Rafacz <dominik.rafacz_ext@novartis.com>

Other contributors:

- Novartis Open Source Initiative \[copyright holder\]
