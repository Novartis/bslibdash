# Theming

bslibdash ships a single brand theme,
\[[`brand_bs_theme()`](https://opensource.nibr.com/bslibdash/reference/brand_bs_theme.md)\],
that every page constructor applies by default. This vignette shows how
to use it as-is, tweak individual Bootstrap variables, add your own
SCSS, swap to a different Bootswatch preset, and tune the theme
interactively with
[`bslib::bs_themer()`](https://rstudio.github.io/bslib/reference/run_with_themer.html).

For the building blocks underneath, see the [bslib theming
articles](https://rstudio.github.io/bslib/articles/theming/).

## The default theme

[`brand_bs_theme()`](https://opensource.nibr.com/bslibdash/reference/brand_bs_theme.md)
returns a
[`bslib::bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
built on Bootstrap 5 (`bootswatch = "bootstrap"`) with the bslibdash
brand colour and typography defaults. Component CSS is not baked into
the theme - each bslibdash component attaches its own theme-aware SCSS
via
[`bslib::bs_dependency_defer()`](https://rstudio.github.io/bslib/reference/bs_dependency.html),
so swapping `theme` does not drop bslibdash styles. Key variable
defaults:

| Variable         | Value                    |
|------------------|--------------------------|
| `primary`        | `#0460A9`                |
| `body-color`     | `#111827`                |
| `border-radius`  | `.75rem`                 |
| `font-family`    | System UI stack          |
| `enable-shadows` | `TRUE` (subtle, layered) |

## Overriding theme variables

Use
[`bslib::bs_add_variables()`](https://rstudio.github.io/bslib/reference/bs_bundle.html)
to override individual Bootstrap Sass variables and pass the result to
any page constructor:

``` r

library(shiny)
library(bslibdash)

theme <- brand_bs_theme() |>
  bslib::bs_add_variables(
    primary       = "#8B0000",
    `body-color`  = "#1F2937",
    `font-size-base` = "0.95rem"
  )

ui <- dashboardPage(
  header  = dashboardHeader(title = "Maroon dashboard"),
  sidebar = dashboardSidebar(),
  body    = dashboardBody(),
  theme   = theme
)
```

Component status colours (`primary`, `success`, …) automatically pick up
the new variable values, so cards, buttons, badges and value boxes
re-skin together.

## Adding custom SCSS

Add bespoke rules with
[`bslib::bs_add_rules()`](https://rstudio.github.io/bslib/reference/bs_bundle.html):

``` r

theme <- brand_bs_theme() |>
  bslib::bs_add_rules("
    .app-header { background: linear-gradient(90deg, #0460A9, #003a6e); }
    .app-footer { font-size: 0.85rem; }
  ")
```

## Switching the Bootswatch preset

``` r

theme <- bslib::bs_theme(version = 5, bootswatch = "flatly") |>
  bslib::bs_add_variables(primary = "#0460A9")

dashboardPage(
  header = dashboardHeader(title = "Flatly + brand blue"),
  sidebar = dashboardSidebar(),
  body = dashboardBody(h2("Flatly + brand blue")),
  theme = theme
)
```

Note: bslibdash component CSS is attached by the components themselves,
so any
[`bslib::bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html) -
including a plain `bslib::bs_theme(version = 5)` - still renders the
package’s custom classes (`.bslibdash-value-box`, `.bslibdash-info-box`,
`.app-sidebar`, …). Use
[`brand_bs_theme()`](https://opensource.nibr.com/bslibdash/reference/brand_bs_theme.md)
when you want the bslibdash brand defaults; use your own
[`bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
when you do not.

## Real-time theming

[`bslib::bs_themer()`](https://rstudio.github.io/bslib/reference/run_with_themer.html)
works against bslibdash pages out of the box - call it once from your
server to interactively tune colours and typography during development:

``` r

server <- function(input, output, session) {
  bslib::bs_themer()
}
```

See the bslib [real-time theming
article](https://rstudio.github.io/bslib/articles/theming/index.html#real-time)
for the underlying widget.

## Dynamic theming

`session$setCurrentTheme()` swaps the active
[`bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
at runtime without a page reload, which makes it easy to let users flip
between light/dark variants or any other named presets. Because each
bslibdash component attaches its SCSS via
[`bslib::bs_dependency_defer()`](https://rstudio.github.io/bslib/reference/bs_dependency.html),
the components automatically recompile against the new theme:

``` r

library(shiny)
library(bslib)
library(bslibdash)

themes <- list(
  light = brand_bs_theme(),
  dark  = bs_theme(
    version = 5,
    bg      = "#0B0F19",
    fg      = "#E5E7EB",
    primary = "#60A5FA"
  )
)

ui <- dashboardPage(
  title  = "Theme switcher",
  header = dashboardHeader(
    rightUi = radioButtons(
      "mode", NULL,
      choices = c("light", "dark"),
      inline  = TRUE
    )
  ),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Overview", tabName = "overview", icon = icon("house"))
    )
  ),
  body = dashboardBody(
    fluidRow(
      valueBox(1200, "Total sales",     icon = icon("graph-up"),             color = "success"),
      valueBox(53,   "Open issues",     icon = icon("exclamation-triangle"), color = "warning"),
      valueBox(8,    "Critical alerts", icon = icon("bell"),                 color = "danger")
    ),
    fluidRow(
      infoBox(title = "CPU usage", value = "48%",
              subtitle = "Average over last 5 min",
              icon = icon("cpu"), color = "primary"),
      infoBox(title = "Queue length", value = 17,
              subtitle = "Waiting jobs",
              icon = icon("inboxes"), color = "warning")
    ),
    fluidRow(
      box(title = "Status", width = 6, status = "primary",
          "All systems nominal."),
      box(title = "Notes",  width = 6, status = "info",
          collapsible = TRUE,
          "Toggle between light and dark in the header to see the theme swap.")
    )
  ),
  theme = themes$light
)

server <- function(input, output, session) {
  observeEvent(input$mode, {
    session$setCurrentTheme(themes[[input$mode]])
  })
}

shinyApp(ui, server)
```

Use the same pattern to expose any other curated set of presets (for
example, a Bootswatch picker) - just build the
[`bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
objects ahead of time and hand the chosen one to `setCurrentTheme()`.
The dark variant above is built with
`bs_theme(bg = ..., fg = ..., primary = ...)` rather than
[`bs_add_variables()`](https://rstudio.github.io/bslib/reference/bs_bundle.html)
on the brand theme because the former makes bslib rederive a coherent
palette (greys, borders, link colours, secondary/tertiary backgrounds)
from `bg`/`fg`, while the latter only patches the named variables. For
the underlying mechanics, see
[`?bslib::bs_dependency_defer`](https://rstudio.github.io/bslib/reference/bs_dependency.html).
