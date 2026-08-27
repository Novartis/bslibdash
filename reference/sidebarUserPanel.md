# Sidebar user panel

Displays a user identity block (avatar, name, optional subtitle) at the
top of the dashboard sidebar. Mirrors
`shinydashboard::sidebarUserPanel()`.

## Usage

``` r
sidebarUserPanel(name, image = NULL, subtitle = NULL)
```

## Arguments

- name:

  User name. Required.

- image:

  Optional avatar. Either a URL string (rendered as `<img>`) or an
  icon/htmltools tag. If `NULL`, a default `bi-person-circle` icon is
  used.

- subtitle:

  Optional secondary text shown beneath the name.

## Value

An htmltools `<div>` tag intended to be passed into
[`dashboardSidebar()`](https://novartis.github.io/bslibdash/reference/dashboardSidebar.md).

## Details

When the sidebar is collapsed on desktop, the name and subtitle are
hidden and only the circular avatar remains, centered.

## Examples

``` r
dashboardSidebar(
  sidebarUserPanel(
    name = "Jane Doe",
    subtitle = "Administrator"
  ),
  sidebarMenu(
    menuItem("Overview", tabName = "overview")
  )
)
#> <aside id="sidebar" class="app-sidebar flex-shrink-0 " role="navigation" aria-label="Primary" aria-hidden="false">
#>   <button id="sidebarClose" type="button" class="app-sidebar-close" aria-label="Close sidebar">&times;</button>
#>   <div class="sidebar-inner">
#>     <div class="sidebar-user-panel d-flex align-items-center gap-2 mb-3">
#>       <div class="sidebar-user-image"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-person-circle sidebar-user-default-icon" style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
#> <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path></svg></div>
#>       <div class="sidebar-user-info">
#>         <p class="sidebar-user-name mb-0">Jane Doe</p>
#>         <p class="sidebar-user-subtitle mb-0">Administrator</p>
#>       </div>
#>     </div>
#>     <div class="sidebar-nav-sections" data-input-id="sidebarMenu" data-tabset-id="sidebarMenu">
#>       <nav class="nav nav-pills flex-column">
#>         <button class="nav-link d-flex align-items-center gap-2  active" data-nav-to="overview" type="button">
#>           <span class="nav-text">Overview</span>
#>         </button>
#>       </nav>
#>     </div>
#>   </div>
#> </aside>
```
