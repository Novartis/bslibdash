# Dashboard navbar

Dashboard navbar

## Usage

``` r
dashboardHeader(
  ...,
  title = NULL,
  rightUi = NULL,
  sidebarIcon = icon("bars"),
  disable = FALSE,
  .list = NULL
)
```

## Arguments

- ...:

  Header UI elements rendered on the right side. For migration
  compatibility, a first unnamed scalar string is treated as `title`
  when `title` is `NULL`.

- title:

  Dashboard title.

- rightUi:

  Additional right-side UI content. This is equivalent to passing
  content through `...`, and is kept for bs4Dash-style compatibility.

- sidebarIcon:

  Icon of the main sidebar toggle.

- disable:

  Whether to disable and omit the header. When `TRUE`,
  [`dashboardPage()`](https://opensource.nibr.com/bslibdash/reference/dashboardPage.md)
  renders without a header bar and the body occupies the freed vertical
  space.

- .list:

  Optional list of right-side header UI elements, merged with `...`.

## Examples

``` r
dashboardHeader(
  title = "Operations",
  rightUi = dropdownMenu(
    type = "notifications",
    notificationItem("Server restarted", status = "info")
  )
)
#> <nav class="app-header">
#>   <div class="app-header-inner">
#>     <div class="app-header-content container-fluid d-flex align-items-center px-4">
#>       <div class="d-flex align-items-center gap-3">
#>         <button id="sidebarToggle" type="button" class="btn btn-link app-header-burger p-0" aria-label="Toggle sidebar"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-justify " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path fill-rule="evenodd" d="M2 12.5a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z"></path></svg></button>
#>         <div class="bslib-page-title navbar-brand d-flex p-0 mb-0 text-light">
#>           <h3 class="mb-0">Operations</h3>
#>         </div>
#>       </div>
#>       <div class="d-flex align-items-center ms-auto">
#>         <div>
#>           <div class="nav-item dropdown bslibdash-dropdown-menu bslibdash-dropdown-menu-notifications">
#>             <a class="nav-link px-2 py-1 bslibdash-dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
#>               <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-bell " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"></path></svg>
#>               <span class="badge rounded-pill bslibdash-dropdown-badge bg-primary">1</span>
#>             </a>
#>             <div class="dropdown-menu dropdown-menu-end shadow-sm bslibdash-dropdown-menu-panel">
#>               <span class="dropdown-item dropdown-header bslibdash-dropdown-header">You have 1 notifications</span>
#>               <div class="dropdown-divider"></div>
#>               <a class="dropdown-item bslibdash-dropdown-item d-flex align-items-center gap-2" href="#">
#>                 <span class="text-info"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-exclamation-triangle " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M7.938 2.016A.13.13 0 0 1 8.002 2a.13.13 0 0 1 .063.016.146.146 0 0 1 .054.057l6.857 11.667c.036.06.035.124.002.183a.163.163 0 0 1-.054.06.116.116 0 0 1-.066.017H1.146a.115.115 0 0 1-.066-.017.163.163 0 0 1-.054-.06.176.176 0 0 1 .002-.183L7.884 2.073a.147.147 0 0 1 .054-.057zm1.044-.45a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566z"></path>
#> <path d="M7.002 12a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 5.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995z"></path></svg></span>
#>                 <span>Server restarted</span>
#>               </a>
#>               <div class="dropdown-divider"></div>
#>             </div>
#>           </div>
#>         </div>
#>       </div>
#>     </div>
#>   </div>
#> </nav>
```
