# bslibdash: Bootstrap 5 dashboards for Shiny

Build Bootstrap 5 dashboards in Shiny, on
[bslib](https://rstudio.github.io/bslib/reference/bslib-package.html).
bslibdash provides a page shell
([`dashboardPage()`](https://novartis.github.io/bslibdash/reference/dashboardPage.md),
[`dashboardHeader()`](https://novartis.github.io/bslibdash/reference/dashboardHeader.md),
[`dashboardSidebar()`](https://novartis.github.io/bslibdash/reference/dashboardSidebar.md),
[`dashboardBody()`](https://novartis.github.io/bslibdash/reference/dashboardBody.md),
[`dashboardFooter()`](https://novartis.github.io/bslibdash/reference/dashboardFooter.md)),
sidebar navigation
([`sidebarMenu()`](https://novartis.github.io/bslibdash/reference/dashboardSidebar.md),
[`menuItem()`](https://novartis.github.io/bslibdash/reference/dashboardSidebar.md),
[`sidebarUserPanel()`](https://novartis.github.io/bslibdash/reference/sidebarUserPanel.md)),
cards ([`box()`](https://novartis.github.io/bslibdash/reference/box.md),
[`boxLayout()`](https://novartis.github.io/bslibdash/reference/boxLayout.md),
[`tabBox()`](https://novartis.github.io/bslibdash/reference/tabBox.md)),
KPI tiles
([`valueBox()`](https://novartis.github.io/bslibdash/reference/valueBox.md),
[`infoBox()`](https://novartis.github.io/bslibdash/reference/infoBox.md)),
header dropdowns
([`dropdownMenu()`](https://novartis.github.io/bslibdash/reference/dropdownMenu.md),
[`notificationItem()`](https://novartis.github.io/bslibdash/reference/dropdownMenu.md),
[`messageItem()`](https://novartis.github.io/bslibdash/reference/dropdownMenu.md),
[`taskItem()`](https://novartis.github.io/bslibdash/reference/dropdownMenu.md)),
and lightweight feedback helpers (accordions, badges, toasts).

## Details

Function names mirror
[shinydashboard](https://rstudio.github.io/shinydashboard/) wherever the
underlying concept is the same, so most apps port across as a
search-and-replace. bslibdash is *not* a drop-in clone: a small number
of legacy arguments and behaviours that no longer make sense on
Bootstrap 5 have been removed — see
[`vignette("getting-started", package = "bslibdash")`](https://novartis.github.io/bslibdash/articles/getting-started.md)
for the full migration story.

Every bslibdash component attaches its CSS via
[`bslib::bs_dependency_defer()`](https://rstudio.github.io/bslib/reference/bs_dependency.html),
so any
[`bslib::bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
(including the bundled
[`brand_bs_theme()`](https://novartis.github.io/bslibdash/reference/brand_bs_theme.md))
recompiles bslibdash styles against the active theme.

## Learn more

- [`vignette("getting-started", package = "bslibdash")`](https://novartis.github.io/bslibdash/articles/getting-started.md)
  — minimal skeleton and the migration guide from shinydashboard.

- [`vignette("components", package = "bslibdash")`](https://novartis.github.io/bslibdash/articles/components.md)
  — a tour of every component with copy-pasteable examples.

- [`vignette("theming", package = "bslibdash")`](https://novartis.github.io/bslibdash/articles/theming.md)
  — customising
  [`brand_bs_theme()`](https://novartis.github.io/bslibdash/reference/brand_bs_theme.md),
  swapping Bootswatch presets, and adding bespoke SCSS.

## See also

Useful links:

- <https://github.com/Novartis/bslibdash>

- <https://novartis.github.io/bslibdash/>

- Report bugs at <https://github.com/Novartis/bslibdash/issues>

## Author

**Maintainer**: Alexandros Kouretsis <alexandros@appsilon.com>

Authors:

- Alexandros Kouretsis <alexandros@appsilon.com>

- Ardalan Mirshani <ardalan.mirshani@novartis.com>

- Dominik Rafacz <dominik.rafacz_ext@novartis.com>

Other contributors:

- Novartis Open Source Initiative \[copyright holder\]
