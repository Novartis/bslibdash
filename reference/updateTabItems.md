# Update the selected sidebar tab item

This updates the hidden body tabset used by
[`tabItems()`](https://opensource.nibr.com/bslibdash/reference/dashboardBody.md)
and keeps the sidebar active item synchronized with the selected tab.

## Usage

``` r
updateTabItems(
  session = shiny::getDefaultReactiveDomain(),
  inputId,
  selected = NULL
)
```

## Arguments

- session:

  Shiny session.

- inputId:

  The shared `id` used for `sidebarMenu(id)`, `tabItems(id)`, and
  `updateTabItems(inputId)`. All three must use the same value.

- selected:

  Name of the tab to select.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::shinyApp(
  ui = dashboardPage(
    header = dashboardHeader(title = "Demo"),
    sidebar = dashboardSidebar(
      sidebarMenu(
        id = "sidebarMenu",
        menuItem("Overview", tabName = "overview"),
        menuItem("Reports", tabName = "reports")
      )
    ),
    body = dashboardBody(
      shiny::actionButton("go_reports", "Go to reports"),
      tabItems(
        tabItem(tabName = "overview", shiny::h2("Overview")),
        tabItem(tabName = "reports", shiny::h2("Reports"))
      )
    )
  ),
  server = function(input, output, session) {
    shiny::observeEvent(input$go_reports, {
      updateTabItems(session, inputId = "sidebarMenu", selected = "reports")
    })
  }
)
} # }
```
