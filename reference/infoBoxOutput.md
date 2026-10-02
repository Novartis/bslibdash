# Info box output

Info box output

## Usage

``` r
infoBoxOutput(outputId, width = 4)
```

## Arguments

- outputId:

  Output variable name.

- width:

  The width of the box in Bootstrap grid columns (`1`-`12`). Use `NULL`
  when placing the output inside an existing column.

## Value

A [`shiny::uiOutput()`](https://rdrr.io/pkg/shiny/man/htmlOutput.html)
container to be filled by
[`renderInfoBox()`](https://opensource.nibr.com/bslibdash/reference/renderInfoBox.md).

## Examples

``` r
infoBoxOutput("system_status")
#> <div class="col-sm-4">
#>   <div id="system_status" class="shiny-html-output"></div>
#> </div>
```
