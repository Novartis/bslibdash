# Value box output

Value box output

## Usage

``` r
valueBoxOutput(outputId, width = 4)
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
[`renderValueBox()`](https://opensource.nibr.com/bslibdash/dev/reference/renderValueBox.md).

## Examples

``` r
valueBoxOutput("tickets")
#> <div class="col-sm-4">
#>   <div id="tickets" class="shiny-html-output"></div>
#> </div>
```
