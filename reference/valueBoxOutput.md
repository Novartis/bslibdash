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

## Examples

``` r
valueBoxOutput("tickets")
#> <div class="col-sm-4">
#>   <div id="tickets" class="shiny-html-output"></div>
#> </div>
```
