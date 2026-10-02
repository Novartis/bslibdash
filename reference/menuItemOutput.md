# Sidebar menu item output

Sidebar menu item output

## Usage

``` r
menuItemOutput(outputId)
```

## Arguments

- outputId:

  Output variable name.

## Value

A [`shiny::uiOutput()`](https://rdrr.io/pkg/shiny/man/htmlOutput.html)
container to be filled by
[`renderMenu()`](https://opensource.nibr.com/bslibdash/reference/renderMenu.md).

## Examples

``` r
menuItemOutput("dynamic_menu_item")
#> <div class="shiny-html-output bslibdash-menu-item-output" id="dynamic_menu_item"></div>
```
