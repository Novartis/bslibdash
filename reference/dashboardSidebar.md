# Create a dashboard main sidebar

Create a dashboard main sidebar

Dashboard main sidebar menu

Dashboard sidebar menu item

Dashboard sidebar menu sub-item

Dashboard sidebar menu header

## Usage

``` r
dashboardSidebar(..., disable = FALSE, width = NULL, collapsed = FALSE)

sidebarMenu(..., id = NULL, .list = NULL)

menuItem(
  text,
  ...,
  icon = NULL,
  badgeLabel = NULL,
  badgeColor = "success",
  tabName = NULL,
  selected = NULL,
  expandedName = NULL,
  startExpanded = FALSE,
  condition = NULL
)

menuSubItem(
  text,
  tabName = NULL,
  icon = bslibdash::icon("angle-double-right"),
  selected = NULL
)

sidebarHeader(title)
```

## Arguments

- ...:

  `menuSubItem()` children.

- disable:

  Whether to disable and omit the sidebar.

- width:

  Expanded sidebar width. Numeric values are interpreted as pixels; CSS
  strings such as `"18rem"` are passed through.

- collapsed:

  Whether the sidebar starts collapsed on desktop.

- id:

  Shared Shiny id for the sidebar menu and body tabset. Use the same
  value in `sidebarMenu(id)`, `tabItems(id)`, and
  `updateTabItems(inputId)`. Defaults to `"sidebarMenu"`.

- .list:

  Optional list of items.

- text:

  Item name.

- icon:

  Icon tag or icon name.

- badgeLabel:

  Optional badge label.

- badgeColor:

  Badge color.

- tabName:

  Matching
  [`tabItem()`](https://novartis.github.io/bslibdash/reference/dashboardBody.md)
  name.

- selected:

  Whether the item starts selected.

- expandedName:

  Optional unique name for the item's collapse panel. If omitted, a
  stable id is generated from the item text and children. Set explicitly
  for multiple items with the same text and children.

- startExpanded:

  Whether children start expanded.

- condition:

  Optional display condition stored as a data attribute.

- title:

  Header title.

## Examples

``` r
dashboardSidebar(
  sidebarMenu(
    id = "sidebarMenu",
    sidebarHeader("Main"),
    menuItem("Overview", tabName = "overview", icon = icon("house")),
    menuItem(
      "Reports",
      icon = icon("bar-chart"),
      menuSubItem("Daily", tabName = "reports_daily"),
      menuSubItem("Monthly", tabName = "reports_monthly")
    )
  )
)
#> <aside id="sidebar" class="app-sidebar flex-shrink-0 " role="navigation" aria-label="Primary" aria-hidden="false">
#>   <button id="sidebarClose" type="button" class="app-sidebar-close" aria-label="Close sidebar">&times;</button>
#>   <div class="sidebar-inner">
#>     <div class="sidebar-nav-sections" data-input-id="sidebarMenu" data-tabset-id="sidebarMenu">
#>       <div class="sidebar-title d-flex align-items-center gap-2 ">
#>         <span class="sidebar-title-text fw-semibold">Main</span>
#>       </div>
#>       <nav class="nav nav-pills flex-column">
#>         <button class="nav-link d-flex align-items-center gap-2  active" data-nav-to="overview" type="button">
#>           <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-house " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5ZM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5 5 5Z"></path></svg>
#>           <span class="nav-text">Overview</span>
#>         </button>
#>         <div class="ms-2">
#>           <div class="nav-item has-subnav">
#>             <button class="nav-link d-flex align-items-center gap-2" data-bs-toggle="collapse" data-bs-target="#collapse-Reports-f2ec7616" aria-expanded="false" aria-controls="collapse-Reports-f2ec7616">
#>               <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-bar-chart " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M4 11H2v3h2v-3zm5-4H7v7h2V7zm5-5v12h-2V2h2zm-2-1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1h-2zM6 7a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V7zm-5 4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1v-3z"></path></svg>
#>               <span class="nav-text">Reports</span>
#>               <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-chevron-right sidebar-caret ms-auto" style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path></svg>
#>             </button>
#>           </div>
#>           <div class="sidebar-subnav collapse " id="collapse-Reports-f2ec7616">
#>             <button class="nav-link d-flex align-items-center gap-2  nav-link-sub" data-nav-to="reports_daily" type="button">
#>               <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
#>               <span class="nav-text">Daily</span>
#>             </button>
#>             <button class="nav-link d-flex align-items-center gap-2  nav-link-sub" data-nav-to="reports_monthly" type="button">
#>               <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
#>               <span class="nav-text">Monthly</span>
#>             </button>
#>           </div>
#>         </div>
#>       </nav>
#>     </div>
#>   </div>
#> </aside>

sidebarMenu(
  id = "sidebarMenu",
  menuItem("Overview", tabName = "overview", icon = icon("house")),
  menuItem("Settings", tabName = "settings", icon = icon("gear"))
)
#> <div class="sidebar-nav-sections" data-input-id="sidebarMenu" data-tabset-id="sidebarMenu">
#>   <nav class="nav nav-pills flex-column">
#>     <button class="nav-link d-flex align-items-center gap-2  active" data-nav-to="overview" type="button">
#>       <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-house " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5ZM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5 5 5Z"></path></svg>
#>       <span class="nav-text">Overview</span>
#>     </button>
#>     <button type="button" class="nav-link d-flex align-items-center gap-2 " data-nav-to="settings">
#>       <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-gear " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z"></path>
#> <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115l.094-.319z"></path></svg>
#>       <span class="nav-text">Settings</span>
#>     </button>
#>   </nav>
#> </div>

menuItem(
  "Reports",
  icon = icon("bar-chart"),
  menuSubItem("Daily", tabName = "reports_daily"),
  menuSubItem("Monthly", tabName = "reports_monthly")
)
#> <div class="ms-2">
#>   <div class="nav-item has-subnav">
#>     <button class="nav-link d-flex align-items-center gap-2" data-bs-toggle="collapse" data-bs-target="#collapse-Reports-f2ec7616" aria-expanded="false" aria-controls="collapse-Reports-f2ec7616">
#>       <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-bar-chart " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M4 11H2v3h2v-3zm5-4H7v7h2V7zm5-5v12h-2V2h2zm-2-1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1h-2zM6 7a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V7zm-5 4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1v-3z"></path></svg>
#>       <span class="nav-text">Reports</span>
#>       <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-chevron-right sidebar-caret ms-auto" style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path></svg>
#>     </button>
#>   </div>
#>   <div class="sidebar-subnav collapse " id="collapse-Reports-f2ec7616">
#>     <button class="nav-link d-flex align-items-center gap-2  nav-link-sub" data-nav-to="reports_daily" type="button">
#>       <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
#>       <span class="nav-text">Daily</span>
#>     </button>
#>     <button class="nav-link d-flex align-items-center gap-2  nav-link-sub" data-nav-to="reports_monthly" type="button">
#>       <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
#>       <span class="nav-text">Monthly</span>
#>     </button>
#>   </div>
#> </div>

menuSubItem(
  "Daily report",
  tabName = "reports_daily",
  icon = bslibdash::icon("angle-double-right")
)
#> <button class="nav-link d-flex align-items-center gap-2  nav-link-sub" data-nav-to="reports_daily" type="button">
#>   <i class="fas fa-angles-right" role="presentation" aria-label="angles-right icon"></i>
#>   <span class="nav-text">Daily report</span>
#> </button>

sidebarHeader("Administration")
#> <div class="sidebar-title d-flex align-items-center gap-2 ">
#>   <span class="sidebar-title-text fw-semibold">Administration</span>
#> </div>
```
