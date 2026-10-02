# Dashboard body

Containers for tab content placed inside `dashboardBody()`:

## Usage

``` r
dashboardBody(...)

tabItems(..., id = "sidebarMenu")

tabItem(tabName = NULL, ...)
```

## Arguments

- ...:

  Items to put in the container.

- id:

  Shared Shiny id for the sidebar menu and body tabset. Use the same
  value in `sidebarMenu(id)`, `tabItems(id)`, and
  `updateTabItems(inputId)`. Defaults to `"sidebarMenu"`.

- tabName:

  The name of a tab.

## Value

`dashboardBody()` returns an
[`htmltools::div()`](https://rstudio.github.io/htmltools/reference/builder.html)
tag that may be passed to
[`dashboardPage()`](https://opensource.nibr.com/bslibdash/dev/reference/dashboardPage.md).

`tabItems()` returns an
[`htmltools::div()`](https://rstudio.github.io/htmltools/reference/builder.html)
tag containing a hidden
[`shiny::tabsetPanel()`](https://rdrr.io/pkg/shiny/man/tabsetPanel.html).

`tabItem()` returns an
[`htmltools::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)
that may be passed to `tabItems()`.

## Details

- `tabItems()` is the parent container.

- `tabItem(tabName)` is one tab; `tabName` must match the corresponding
  [`menuItem()`](https://opensource.nibr.com/bslibdash/dev/reference/dashboardSidebar.md)
  `tabName`.

## Examples

``` r
dashboardBody(
  tabItems(
    tabItem(tabName = "overview", shiny::h2("Overview")),
    tabItem(tabName = "reports", shiny::h2("Reports"))
  )
)
#> <div class="app-main-inner">
#>   <div class="content-canvas flex-grow-1">
#>     <div class="tabbable">
#>       <ul class="nav nav-hidden shiny-tab-input" id="sidebarMenu" data-tabsetid="3412">
#>         <li class="active">
#>           <a href="#tab-3412-1" data-toggle="tab" data-bs-toggle="tab" data-value="overview">overview</a>
#>         </li>
#>         <li>
#>           <a href="#tab-3412-2" data-toggle="tab" data-bs-toggle="tab" data-value="reports">reports</a>
#>         </li>
#>       </ul>
#>       <div class="tab-content" data-tabsetid="3412">
#>         <div class="tab-pane active" data-value="overview" id="tab-3412-1">
#>           <h2>Overview</h2>
#>         </div>
#>         <div class="tab-pane" data-value="reports" id="tab-3412-2">
#>           <h2>Reports</h2>
#>         </div>
#>       </div>
#>     </div>
#>   </div>
#> </div>
tabItems(
  tabItem(tabName = "overview", shiny::p("Overview content")),
  tabItem(tabName = "reports", shiny::p("Reports content"))
)
#> <div class="content-canvas flex-grow-1">
#>   <div class="tabbable">
#>     <ul class="nav nav-hidden shiny-tab-input" id="sidebarMenu" data-tabsetid="1756">
#>       <li class="active">
#>         <a href="#tab-1756-1" data-toggle="tab" data-bs-toggle="tab" data-value="overview">overview</a>
#>       </li>
#>       <li>
#>         <a href="#tab-1756-2" data-toggle="tab" data-bs-toggle="tab" data-value="reports">reports</a>
#>       </li>
#>     </ul>
#>     <div class="tab-content" data-tabsetid="1756">
#>       <div class="tab-pane active" data-value="overview" id="tab-1756-1">
#>         <p>Overview content</p>
#>       </div>
#>       <div class="tab-pane" data-value="reports" id="tab-1756-2">
#>         <p>Reports content</p>
#>       </div>
#>     </div>
#>   </div>
#> </div>
tabItem(
  tabName = "overview",
  shiny::h2("Overview"),
  shiny::p("This is the overview tab.")
)
#> <h2>Overview</h2>
#> <p>This is the overview tab.</p>
```
