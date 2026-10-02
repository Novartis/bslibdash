# Sidebar menu output

Sidebar menu output

## Usage

``` r
sidebarMenuOutput(outputId)
```

## Arguments

- outputId:

  Output variable name.

## Value

A [`shiny::uiOutput()`](https://rdrr.io/pkg/shiny/man/htmlOutput.html)
container to be filled by
[`renderMenu()`](https://opensource.nibr.com/bslibdash/dev/reference/renderMenu.md).

## Examples

``` r
sidebarMenuOutput("dynamic_sidebar_menu")
#> <div class="shiny-html-output bslibdash-sidebar-menu-output" id="dynamic_sidebar_menu"></div>
```
