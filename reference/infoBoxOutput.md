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

## Examples

``` r
infoBoxOutput("system_status")
#> <div class="col-sm-4">
#>   <div id="system_status" class="shiny-html-output"></div>
#> </div>
```
