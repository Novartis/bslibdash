# Column system

Column system

## Usage

``` r
column(width, ..., offset = 0)
```

## Arguments

- width:

  The grid width of the column.

- ...:

  Elements to include within the column.

- offset:

  The number of columns to offset this column.

## Examples

``` r
shiny::fluidRow(
  column(8, shiny::p("Main content")),
  column(4, shiny::p("Side panel"))
)
#> <div class="row">
#>   <div class="col-sm-8">
#>     <p>Main content</p>
#>   </div>
#>   <div class="col-sm-4">
#>     <p>Side panel</p>
#>   </div>
#> </div>
```
