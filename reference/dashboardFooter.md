# Dashboard footer

Dashboard footer

## Usage

``` r
dashboardFooter(left = NULL, right = NULL, fixed = FALSE)
```

## Arguments

- left:

  Left-side footer content.

- right:

  Right-side footer content.

- fixed:

  Whether to mark footer as fixed.

## Examples

``` r
dashboardFooter(
  left = "Copyright (c) 2026",
  right = "Contact: team@example.org"
)
#> <footer class="main-footer app-footer" data-fixed="false">
#>   <span class="me-auto">Copyright (c) 2026</span>
#>   Contact: team@example.org
#> </footer>
```
