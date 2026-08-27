# Create a search form to place in a sidebar

A search form consists of a text input field and a search button.

## Usage

``` r
sidebarSearchForm(
  textId,
  buttonId,
  label = "Search...",
  icon = shiny::icon("search")
)
```

## Arguments

- textId:

  Shiny input ID for the text input box.

- buttonId:

  Shiny input ID for the search button.

- label:

  Text label to display inside the search box.

- icon:

  An icon tag, created by
  [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html) or
  [`icon()`](https://novartis.github.io/bslibdash/reference/icon.md).

## Examples

``` r
sidebarSearchForm(
  textId = "sidebar_search",
  buttonId = "sidebar_search_btn",
  label = "Search records..."
)
#> <form class="sidebar-form bslibdash-sidebar-search-form" role="search" onsubmit="return false;">
#>   <div class="input-group input-group-sm">
#>     <input id="sidebar_search" type="text" class="form-control bslibdash-sidebar-search-input" placeholder="Search records..." aria-label="Search records..."/>
#>     <button aria-label="Search records..." class="btn btn-default action-button btn-outline-secondary bslibdash-sidebar-search-button" id="sidebar_search_btn" type="button"><i class="fas fa-magnifying-glass" role="presentation" aria-label="magnifying-glass icon"></i></button>
#>   </div>
#> </form>
```
