# bslibdash

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

bslibdash is a toolkit for building modern dashboards in
[shiny](https://shiny.posit.co/). It sits on top of
[bslib](https://rstudio.github.io/bslib/) and Bootstrap 5, and packages
the building blocks of a typical dashboard — page shells, sidebars,
cards, KPI tiles, header widgets and feedback components — behind a
small, consistent API.

Because most of the components are a thin layer over `bslib`, dashboards built
with `bslibdash` share theming, dark mode and the wider Bootstrap 5
ecosystem (including [teal](https://insightsengineering.github.io/teal/)
and other modern bslib-based Shiny modules) out of the box. The API also
mirrors [shinydashboard](https://rstudio.github.io/shinydashboard/) wherever
the underlying concept is the same, so porting an existing app is
mostly search-and-replace — see `vignette("getting-started")` for the
full migration story.

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

* **vs raw [bslib](https://rstudio.github.io/bslib/)** — bslib gives you
  the building blocks (themes, cards, sidebars). bslibdash gives you the
  dashboard *vocabulary* on top: a page shell, a sidebar menu with
  sub-items and badges, header dropdowns, info/value tiles — so you
  don't write them in every app.
* **vs [shinydashboard](https://rstudio.github.io/shinydashboard/)** —
  same names, same mental model, but rendered with Bootstrap 5 and
  themed through bslib. Dynamic theming, dark mode and `bs_themer()`
  work out of the box.
* **vs [bs4Dash](https://rinterface.github.io/bs4Dash/)** — bslibdash
  stays close to vanilla bslib, so dashboards inherit your bslib theme
  rather than carrying a bespoke AdminLTE one.
* **Fits the modern Shiny ecosystem.** Because
  bslibdash is a thin bslib layer, it slots into apps built with
  [teal](https://insightsengineering.github.io/teal/), raw
  `bslib::page_*` layouts,
  [shinyuieditor](https://rstudio.github.io/shinyuieditor/),
  [bsicons](https://github.com/rstudio/bsicons) and any other
  Bootstrap 5 / bslib component — all sharing the same theme, dark
  mode and `bs_themer()` machinery as your dashboard shell.

## What's in the box

At a glance, bslibdash covers the pieces a typical KPI dashboard needs:

* a responsive **page shell** (header, collapsible/overlay sidebar, body, footer),
* **sidebar navigation** with menus, sub-items, badges and a user panel,
* **cards and tab-cards** that can collapse, close and go full-screen,
* **KPI tiles** (value boxes, info boxes) on the Bootstrap status palette,
* **header widgets** for messages, notifications and tasks,
* **feedback bits** — accordions, badges, buttons, icons and toasts, and
* **theming** through any `bslib::bs_theme()`, with components recompiling
  their CSS via `bslib::bs_dependency_defer()` so custom themes never
  drop bslibdash styles.

See `vignette("components")` or the package reference (`?bslibdash`) for
the live list of functions.

## Learn more

* `vignette("getting-started", package = "bslibdash")` — minimal
  skeleton and the **migration guide from shinydashboard**.
* `vignette("components",      package = "bslibdash")` — copy-pasteable
  tour of every component.
* `vignette("theming",         package = "bslibdash")` — customise
  `brand_bs_theme()`, swap Bootswatch presets, add bespoke SCSS, and
  use `bslib::bs_themer()`.
* Example apps live in [`inst/shiny/examples/`](inst/shiny/examples).

## Code of Conduct

Please note that this project is released with a
[Contributor Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).
By contributing to this project, you agree to abide by its terms.
