# bslibdash <img src="man/figures/logo.png" align="right" height="139" alt="bslibdash hex logo" />

<!-- badges: start -->
[![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![R-CMD-check](https://github.com/Novartis/bslibdash/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Novartis/bslibdash/actions/workflows/R-CMD-check.yaml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

bslibdash provides modern dashboard-style sidebar navigation for Shiny
applications built with [bslib](https://rstudio.github.io/bslib/) and
Bootstrap 5. bslib already gives Shiny a sidebar *layout*; bslibdash adds
the dashboard-oriented navigation primitives on top of it — a sidebar
menu, menu items, nested/sub-items, badges, and the matching tab content
a click reveals — plus the page shell, cards, KPI tiles and header
widgets around it. Because it's a thin layer over bslib, dashboards
built with bslibdash inherit your theme, dark mode and
`bslib::bs_themer()` for free, and play nicely with other bslib-based
Shiny packages like [teal](https://insightsengineering.github.io/teal/).

If you know [shinydashboard](https://rstudio.github.io/shinydashboard/)
or [bs4Dash](https://bs4dash.rinterface.com/), you already know most of
the bslibdash API: sidebar menu function names and arguments mirror
theirs wherever the underlying concept is the same, so porting an
existing dashboard's navigation is mostly search-and-replace — see
`vignette("sidebar-navigation")` for the details of migrating from
either package.

`bslibdash` is an open-source R package developed by Novartis.

## Features

* A responsive **page shell**: header, collapsible/overlay sidebar,
  body and footer.
* **Sidebar navigation** with menus, sub-items, badges and a user
  panel.
* **Cards** that collapse, close and go full-screen, plus tabbed
  cards.
* **KPI tiles** — value boxes and info boxes on the Bootstrap status
  palette.
* **Header widgets** for messages, notifications and tasks.
* Full **theming** through `bslib::bs_theme()`: components recompile
  their CSS automatically, so custom themes never lose bslibdash
  styles.

## Installation

bslibdash isn't on CRAN yet. Install the development version from
GitHub:

``` r
# install.packages("pak")
pak::pak("Novartis/bslibdash")
```

## Usage

```r
library(shiny)
library(bslibdash)

ui <- dashboardPage(
  header = dashboardHeader(title = "bslibdash demo"),
  sidebar = dashboardSidebar(
    sidebarUserPanel("Jane Doe", subtitle = "Administrator"),
    sidebarMenu(
      id = "sidebarMenu",
      menuItem("Overview", tabName = "overview", icon = icon("house")),
      menuItem("Reports",  tabName = "reports",  icon = icon("bar-chart"))
    )
  ),
  body = dashboardBody(
    tabItems(
      tabItem(
        "overview",
        boxLayout(
          valueBox("128", "Open tickets", icon = icon("inbox"),
                   color = "primary"),
          valueBox("42%", "CPU load",     icon = icon("cpu"),
                   color = "warning"),
          infoBox("Status", "Healthy",    icon = icon("heart-pulse"),
                  color = "success")
        ),
        box("Hello, world!", title = "Welcome",
            status = "primary", collapsible = TRUE)
      ),
      tabItem("reports", box("Report body", title = "Quarterly"))
    )
  )
)

shinyApp(ui, server = function(input, output, session) {})
```

For a full walk-through of every component, run the kitchen-sink demo:

``` r
shiny::runApp(
  system.file("shiny/examples/14_kitchen_sink", package = "bslibdash")
)
```

## Why bslibdash?

* **vs raw [bslib](https://rstudio.github.io/bslib/)** — bslib gives
  you the building blocks (themes, cards, sidebar layouts). bslibdash
  adds the dashboard sidebar-navigation model on top: a sidebar menu
  with nested sub-items and badges, header dropdowns, KPI tiles — so
  you don't rebuild that navigation plumbing in every app.
* **vs [shinydashboard](https://rstudio.github.io/shinydashboard/)** —
  same sidebar menu names (`sidebarMenu()`, `menuItem()`, ...), same
  mental model, but rendered on `bslib`/Bootstrap 5 instead of AdminLTE
  2/Bootstrap 3. Dynamic theming, dark mode and `bs_themer()` work out
  of the box.
* **vs [bs4Dash](https://bs4dash.rinterface.com/)** — bs4Dash also
  mirrors the shinydashboard sidebar API on AdminLTE 3/Bootstrap 4.
  bslibdash keeps that familiar navigation model but renders it as a
  native `bslib` sidebar on Bootstrap 5, so dashboards inherit your
  `bslib` theme rather than a separate AdminLTE one.

| Package | UI foundation | Sidebar navigation | bslib / Bootstrap 5 integration |
|---|---|---|---|
| shinydashboard | AdminLTE 2 / Bootstrap 3 | Yes | No native Bootstrap 5 architecture |
| bs4Dash | AdminLTE 3 / Bootstrap 4 | Yes | Different dashboard architecture |
| bslib | Modern Bootstrap | Sidebar layouts | Native |
| **bslibdash** | `bslib` / Bootstrap 5 | Dashboard-style sidebar navigation | Native |

Because bslibdash is just bslib underneath, it also slots into apps
built with [teal](https://insightsengineering.github.io/teal/), raw
`bslib::page_*()` layouts,
[shinyuieditor](https://rstudio.github.io/shinyuieditor/) and
[bsicons](https://github.com/rstudio/bsicons) — all sharing the same
theme, dark mode and `bs_themer()` machinery as your dashboard shell.

## Learn more

* [Sidebar navigation](https://opensource.nibr.com/bslibdash/articles/sidebar-navigation.html) —
  building dashboard sidebar menus, nested navigation, and migrating
  from shinydashboard or bs4Dash.
* [Get started](https://opensource.nibr.com/bslibdash/articles/getting-started.html) —
  a minimal skeleton and the full shinydashboard migration reference.
* [Components](https://opensource.nibr.com/bslibdash/articles/components.html) —
  a copy-pasteable tour of every component.
* [Theming](https://opensource.nibr.com/bslibdash/articles/theming.html) —
  customise `brand_bs_theme()`, swap Bootswatch presets, add your own
  SCSS, and use `bslib::bs_themer()`.
* [Function reference](https://opensource.nibr.com/bslibdash/reference/index.html) —
  every exported function, organised by topic.
* More example apps live in [`inst/shiny/examples/`](inst/shiny/examples).

## Getting help

If you find a bug, please open an
[issue](https://github.com/Novartis/bslibdash/issues) with a minimal
reproducible example. To propose a change, see
[CONTRIBUTING.md](CONTRIBUTING.md).

## Code of Conduct

Please note that this project is released with a
[Contributor Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).
By contributing to this project, you agree to abide by its terms.
