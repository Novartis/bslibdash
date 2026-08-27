# Components

A guided tour of the UI components in bslibdash. New here? Start with
[`vignette("getting-started")`](https://novartis.github.io/bslibdash/articles/getting-started.md)
for an end-to-end app; for restyling see
[`vignette("theming")`](https://novartis.github.io/bslibdash/articles/theming.md).

All examples assume:

``` r

library(shiny)
library(bslibdash)
```

## Cards

[`box()`](https://novartis.github.io/bslibdash/reference/box.md) is the
primary card.
[`boxLayout()`](https://novartis.github.io/bslibdash/reference/boxLayout.md)
arranges several cards in a responsive grid, and
[`updateBox()`](https://novartis.github.io/bslibdash/reference/box.md)
controls a card from the server.

``` r

boxLayout(
  box("First card",  title = "Status",  status = "primary"),
  box("Second card", title = "Details", status = "info",
      collapsible = TRUE),
  type = "deck"
)

# server side
updateBox("status", action = "toggle")          # collapse/expand
updateBox("status", action = "update",
          options = list(title = "Updated", status = "success"))
```

Valid `status`/`background` values are the eight Bootstrap status names
(`primary`, `secondary`, `success`, `info`, `warning`, `danger`,
`light`, `dark`).

## Value & info boxes

``` r

fluidRow(
  valueBox("128", "Open tickets", icon = icon("inbox"),    color = "primary"),
  valueBox("42%", "CPU",          icon = icon("cpu"),      color = "warning"),
  infoBox(title = "Status",       value = "Healthy",       color = "success")
)
```

Both accept Bootstrap status names (`primary`, `success`, …) **and** the
legacy `shinydashboard` palette (`aqua`, `green`, `red`, …), which is
mapped automatically.

## Tab box

``` r

tabBox(
  id = "summary", title = "Q4",
  tabPanel("Overview", p("Overview content")),
  tabPanel("Details",  p("Detail content"))
)
```

## Sidebar navigation

``` r

dashboardSidebar(
  sidebarUserPanel("Jane Doe", subtitle = "Administrator"),
  sidebarSearchForm("q", "go", label = "Search records..."),
  sidebarMenu(
    id = "sidebarMenu",
    sidebarHeader("Main"),
    menuItem("Overview", tabName = "overview", icon = icon("house")),
    menuItem("Reports",  icon = icon("bar-chart"),
      menuSubItem("Daily",   tabName = "reports_daily"),
      menuSubItem("Monthly", tabName = "reports_monthly")
    )
  )
)
```

Navigate from the server with
[`updateTabItems()`](https://novartis.github.io/bslibdash/reference/updateTabItems.md):

``` r

observeEvent(input$go_reports, {
  updateTabItems(session, inputId = "sidebarMenu", selected = "reports")
})
```

## Header dropdown menus

``` r

dashboardHeader(
  title = "Operations",
  rightUi = dropdownMenu(
    type = "notifications", badgeStatus = "warning",
    notificationItem("Backup completed",  status = "success"),
    notificationItem("New deployment",    status = "info"),
    messageItem(from = "Ops bot", message = "Pipeline finished",
                color = "success"),
    taskItem(text = "Data refresh", value = 75, color = "info")
  )
)
```

Use
[`dropdownMenuOutput()`](https://novartis.github.io/bslibdash/reference/dropdownMenuOutput.md) +
[`renderDropdownMenu()`](https://novartis.github.io/bslibdash/reference/renderDropdownMenu.md)
to drive the panel reactively. See the next section for the full set of
output/render pairs.

## Reactive outputs and renderers

Most dynamic bslibdash components follow the familiar Shiny
`*Output()` + `render*()` pattern. Place the `*Output()` in the UI where
the component should appear, then build it from the server with the
matching `render*()`:

| UI side | Server side | Re-renders |
|----|----|----|
| [`valueBoxOutput()`](https://novartis.github.io/bslibdash/reference/valueBoxOutput.md) | [`renderValueBox()`](https://novartis.github.io/bslibdash/reference/renderValueBox.md) | A single [`valueBox()`](https://novartis.github.io/bslibdash/reference/valueBox.md) |
| [`infoBoxOutput()`](https://novartis.github.io/bslibdash/reference/infoBoxOutput.md) | [`renderInfoBox()`](https://novartis.github.io/bslibdash/reference/renderInfoBox.md) | A single [`infoBox()`](https://novartis.github.io/bslibdash/reference/infoBox.md) |
| [`dropdownMenuOutput()`](https://novartis.github.io/bslibdash/reference/dropdownMenuOutput.md) | [`renderDropdownMenu()`](https://novartis.github.io/bslibdash/reference/renderDropdownMenu.md) | A header [`dropdownMenu()`](https://novartis.github.io/bslibdash/reference/dropdownMenu.md) |
| [`sidebarMenuOutput()`](https://novartis.github.io/bslibdash/reference/sidebarMenuOutput.md) | [`renderMenu()`](https://novartis.github.io/bslibdash/reference/renderMenu.md) | A [`sidebarMenu()`](https://novartis.github.io/bslibdash/reference/dashboardSidebar.md) |

## Accordion, badges, buttons, icons

``` r

accordion(
  id = "filters",
  accordionItem(title = "Date range", p("Last 30 days")),
  accordionItem(title = "Region",     p("All regions"), status = "info")
)

badge("NEW", color = "success", position = "right", rounded = TRUE)

actionButton("refresh", "Refresh", icon = "arrow-clockwise",
             status = "primary")

icon("user")                       # Bootstrap Icons via {bsicons}
icon("bar-chart", size = "1.25rem", class = "text-primary")
```

## Toasts

[`toast()`](https://novartis.github.io/bslibdash/reference/toast.md) is
a thin wrapper over
[`shiny::showNotification()`](https://rdrr.io/pkg/shiny/man/showNotification.html)
that uses a
[`bslib::card()`](https://rstudio.github.io/bslib/reference/card.html)
as the notification body:

``` r

observeEvent(input$save, {
  toast(
    title    = "Saved",
    body     = "Settings were updated.",
    options  = list(type = "message", delay = 3000),
    session  = session
  )
})
```
