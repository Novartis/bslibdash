# Dropdown menu output

Dropdown menu output

## Usage

``` r
dropdownMenuOutput(outputId)
```

## Arguments

- outputId:

  Output variable name.

## Value

A [`shiny::uiOutput()`](https://rdrr.io/pkg/shiny/man/htmlOutput.html)
container to be filled by
[`renderDropdownMenu()`](https://opensource.nibr.com/bslibdash/reference/renderDropdownMenu.md).

## Examples

``` r
dropdownMenuOutput("alerts_menu")
#> <div class="shiny-html-output d-inline-block bslibdash-dropdown-menu-output" id="alerts_menu"></div>
```
