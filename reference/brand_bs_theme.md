# Default bslibdash brand theme

Builds a Bootstrap 5 theme via
[`bslib::bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
with the bslibdash brand colour, typography and shape variables.

## Usage

``` r
brand_bs_theme()
```

## Value

A `bslib` theme object.

## Details

Component CSS is no longer bundled into the theme: each bslibdash
component attaches its own theme-aware
[`bslib::bs_dependency_defer()`](https://rstudio.github.io/bslib/reference/bs_dependency.html)
dependency, so rendering a component with any
[`bslib::bs_theme()`](https://rstudio.github.io/bslib/reference/bs_theme.html)
produces the matching bslibdash styles. `brand_bs_theme()` exists to set
the Bootstrap-level variables used as defaults by bslibdash page
constructors.

[`dashboardPage()`](https://novartis.github.io/bslibdash/reference/dashboardPage.md)
applies this theme by default. To customise it, override variables or
rules via bslib and pass the result through the page `theme` argument:


    dashboardPage(
      header = dashboardHeader(),
      sidebar = dashboardSidebar(),
      body = dashboardBody(),
      theme = brand_bs_theme() |>
        bslib::bs_add_variables(primary = "#8B0000")
    )

## Examples

``` r
theme <- brand_bs_theme()
class(theme)
#> [1] "bs_version_5" "bs_theme"     "sass_bundle" 
```
