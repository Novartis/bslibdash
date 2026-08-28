# Branded dashboard page

A bslib sidebar layout that arranges the four standard dashboard slots.
The `title` argument, when set, replaces the title text inside `header`
if
[`dashboardHeader()`](https://opensource.nibr.com/bslibdash/reference/dashboardHeader.md)
was called without one.

## Usage

``` r
dashboardPage(
  header,
  sidebar,
  body,
  title = NULL,
  footer = NULL,
  theme = brand_bs_theme()
)
```

## Arguments

- header:

  Slot for
  [`dashboardHeader()`](https://opensource.nibr.com/bslibdash/reference/dashboardHeader.md).

- sidebar:

  Slot for
  [`dashboardSidebar()`](https://opensource.nibr.com/bslibdash/reference/dashboardSidebar.md).

- body:

  Slot for
  [`dashboardBody()`](https://opensource.nibr.com/bslibdash/reference/dashboardBody.md).

- title:

  Page/app title shown in the browser tab and dashboard header.

- footer:

  Optional slot for
  [`dashboardFooter()`](https://opensource.nibr.com/bslibdash/reference/dashboardFooter.md).

- theme:

  A `bslib` theme. Defaults to
  [`brand_bs_theme()`](https://opensource.nibr.com/bslibdash/reference/brand_bs_theme.md).

## Value

A Shiny UI definition.

## Examples

``` r
ui <- dashboardPage(
  header = dashboardHeader(title = "bslibdash dashboard"),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = "sidebarMenu",
      menuItem("Overview", tabName = "overview")
    )
  ),
  body = dashboardBody(
    tabItems(
      tabItem(
        tabName = "overview",
        box("Overview content", title = "Overview")
      )
    )
  )
)
```
