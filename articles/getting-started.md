# Getting started with bslibdash

bslibdash gives Shiny a Bootstrap 5 dashboard kit on top of
[bslib](https://rstudio.github.io/bslib/): a page shell, a sidebar menu,
and the cards, value boxes, dropdowns and toasts you reach for in a KPI
dashboard.

Because the kit is *just bslib*, a bslibdash app drops straight into the
modern Shiny ecosystem:
[teal](https://insightsengineering.github.io/teal/) modules, raw
`bslib::page_*` layouts and any other Bootstrap 5 component share its
theme, dark mode and `bs_themer()` controls — no second styling system
to reconcile.

This vignette walks through the smallest dashboard you can build and the
changes you’ll need to port an existing
[shinydashboard](https://rstudio.github.io/shinydashboard/) app. From
here, head to
[`vignette("components")`](https://opensource.nibr.com/bslibdash/articles/components.md)
for the component tour and
[`vignette("theming")`](https://opensource.nibr.com/bslibdash/articles/theming.md)
to restyle.

## Minimal dashboard skeleton

``` r

library(shiny)
library(bslibdash)

ui <- dashboardPage(
  header = dashboardHeader(title = "bslibdash demo"),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = "sidebarMenu",
      menuItem("Overview", tabName = "overview", icon = icon("house")),
      menuItem("Reports", tabName = "reports", icon = icon("bar-chart"))
    )
  ),
  body = dashboardBody(
    tabItems(
      tabItem(
        tabName = "overview",
        h2("Overview"),
        boxLayout(
          box("First card", title = "Status", width = 6),
          box("Second card", title = "Details", width = 6)
        )
      ),
      tabItem(
        tabName = "reports",
        h2("Reports"),
        box("Report content", title = "Quarterly")
      )
    )
  )
)

server <- function(input, output, session) {}
```

## Run the app

``` r

shinyApp(ui, server)
```

## Programmatic tab navigation

Use
[`updateTabItems()`](https://opensource.nibr.com/bslibdash/reference/updateTabItems.md)
from server logic when you need to move users to a different tab based
on an event:

``` r

observeEvent(input$go_reports, {
  updateTabItems(session, inputId = "sidebarMenu", selected = "reports")
})
```

## Migrating from shinydashboard

bslibdash deliberately mirrors **shinydashboard**’s function and
parameter names wherever the underlying concept is the same, so most
apps port over as a search-and-replace exercise. It is *not* a drop-in
clone: there are no deprecation shims or accepted-but-ignored arguments,
and a handful of legacy parameters that no longer make sense on
Bootstrap 5 have been removed. The sections below are the entire
migration story.

### Function-name parity

The following functions accept the same names as their `shinydashboard`
counterparts and can be called the same way:

    dashboardPage   dashboardHeader   dashboardSidebar   dashboardBody
    dashboardFooter sidebarMenu        menuItem            menuSubItem
    sidebarHeader   sidebarSearchForm  menuItemOutput      sidebarMenuOutput
    renderMenu      box                updateBox           tabBox
    tabItem         tabItems           updateTabItems      valueBox
    valueBoxOutput  renderValueBox     infoBox             infoBoxOutput
    renderInfoBox   dropdownMenu       dropdownMenuOutput  renderDropdownMenu
    messageItem     notificationItem   taskItem            icon

### Behavioural differences to know about

- **`appName` is gone.** Use `title` instead in
  [`dashboardPage()`](https://opensource.nibr.com/bslibdash/reference/dashboardPage.md)
  (matches `shiny`/`shinydashboard`).
- **`box(collapsible)` defaults to `FALSE`** (matches shinydashboard).
  Pass `collapsible = TRUE` explicitly to get a collapse toggle.
- **Colour palette is Bootstrap, not shinydashboard.** bslibdash uses
  Bootstrap status names (`primary`, `success`, `info`, `warning`,
  `danger`, `secondary`, `dark`). See the mapping table below.

### Removed shinydashboard parameters

These shinydashboard arguments don’t exist on the bslibdash equivalents
and will raise an `unused argument` error. The right-hand column shows
the recommended bslibdash approach.

| shinydashboard param | Where | bslibdash replacement |
|----|----|----|
| `solidHeader` | [`box()`](https://opensource.nibr.com/bslibdash/reference/box.md) | Use `status` + theming for visual emphasis. |
| `skin` | [`dashboardPage()`](https://opensource.nibr.com/bslibdash/reference/dashboardPage.md) | Set `theme = brand_bs_theme(...)`. |
| `options` | [`dashboardPage()`](https://opensource.nibr.com/bslibdash/reference/dashboardPage.md) | Not supported. |

### Accepted, but implemented differently

These shinydashboard arguments **are** accepted by bslibdash but their
implementation is bslib-native, so the visual result may differ slightly
from shinydashboard:

| shinydashboard param | Where | bslibdash behaviour |
|----|----|----|
| `disable` | [`dashboardSidebar()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md) | When `TRUE`, the sidebar is omitted entirely. |
| `width` | [`dashboardSidebar()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md) | Sets the `--app-sidebar-width` CSS variable. Prefer the bslib theme for global widths. |
| `collapsed` | [`dashboardSidebar()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md) | Starts the sidebar collapsed via a CSS class. |

### Silently ignored — use these instead

The following shinydashboard arguments are absorbed by `...` and will
**not** error, but they have no effect. Use the bslibdash approach
instead:

| shinydashboard param | Where | bslibdash approach |
|----|----|----|
| `minified`, `expandOnHover` | [`dashboardSidebar()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md) | Not supported. Style via `bs_theme()` if you need a similar effect. |
| `titleWidth` | [`dashboardHeader()`](https://opensource.nibr.com/bslibdash/reference/dashboardHeader.md) | Styled by the theme. |
| `href`, `newtab` | [`menuItem()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md) | Use `tags$a(href = ..., target = "_blank", text)` inside the sidebar instead of [`menuItem()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md). |

### Colour name mapping

shinydashboard ships its own palette (`aqua`, `green`, …). bslibdash
expects Bootstrap status names. Use this table when porting `status=`,
`color=`, or `background=` arguments:

| shinydashboard | bslibdash (Bootstrap status)    |
|----------------|---------------------------------|
| `aqua`         | `info`                          |
| `blue`         | `primary`                       |
| `green`        | `success`                       |
| `yellow`       | `warning`                       |
| `red`          | `danger`                        |
| `purple`       | `secondary` (or a theme accent) |
| `maroon`       | `danger` (closest)              |
| `navy`         | `primary` (closest)             |
| `teal`         | `info`                          |
| `olive`        | `success`                       |
| `lime`         | `success`                       |
| `orange`       | `warning`                       |
| `fuchsia`      | `secondary`                     |
| `black`        | `dark`                          |

Default-value differences worth calling out explicitly:

- `taskItem(color)`: shinydashboard `"aqua"` → bslibdash `"info"`.
- `menuItem(badgeColor)`: shinydashboard `"green"` → bslibdash
  `"success"`.
- `dropdownMenu(badgeStatus)`: matches (`"primary"`).

### Argument-ordering note

For functions shared with shinydashboard, bslibdash keeps the
shinydashboard parameters first (in shinydashboard’s order) and pushes
bslibdash-specific extras (`appTag`, `copyright`, `rightUi`, `closable`,
`maximizable`, `id`, …) to the end with sensible defaults, so positional
calls written for shinydashboard keep working.
