# Create dashboard badge item

Create dashboard badge item

Backwards-compatible alias to `badge()`

## Usage

``` r
badge(..., position = c("left", "right"), color, rounded = FALSE)

dashboardBadge(..., position = c("left", "right"), color, rounded = FALSE)
```

## Arguments

- ...:

  Badge content.

- position:

  Badge position: `"left"` or `"right"`.

- color:

  Bootstrap status color.

- rounded:

  Whether the badge is rounded.

## Examples

``` r
badge("NEW", color = "success", position = "right", rounded = TRUE)
#> <span class="end-0 badge text-bg-success rounded-pill">NEW</span>
```
