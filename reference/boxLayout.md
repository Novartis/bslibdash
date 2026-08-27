# Container for cards

Container for cards

## Usage

``` r
boxLayout(..., .list = NULL, type = c("group", "deck", "columns"))
```

## Arguments

- ...:

  Slot for
  [`box()`](https://novartis.github.io/bslibdash/reference/box.md).

- .list:

  Optional list of cards.

- type:

  Layout type. One of:

  - `"group"`: Bootstrap `.card-group` — flex row with no gaps, merged
    borders, and equal-height columns.

  - `"deck"`: Bootstrap 5 grid cards — responsive row with gutters and
    equal heights per row (`.row.row-cols-*` + `.h-100`). Replaces the
    removed `.card-deck` from Bootstrap 4.

  - `"columns"`: **Deprecated.** Bootstrap 5 removed `.card-columns`. A
    [`bslib::layout_column_wrap()`](https://rstudio.github.io/bslib/reference/layout_column_wrap.html)
    fallback is used, but prefer calling
    [`bslib::layout_column_wrap()`](https://rstudio.github.io/bslib/reference/layout_column_wrap.html)
    directly for new code.

## See also

Other cards:
[`box()`](https://novartis.github.io/bslibdash/reference/box.md)

## Examples

``` r
boxLayout(
  box("Revenue", title = "KPI"),
  box("Trend", title = "Chart"),
  type = "deck"
)
#> <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
#>   <div class="col">
#>     <div class="col-sm-6 h-100">
#>       <div class="card bslib-card bslib-mb-spacing html-fill-container  " data-bslib-card-init data-require-bs-caller="card()" data-require-bs-version="5">
#>         <div class="card-header bslib-gap-spacing">
#>           <div class="d-flex align-items-center gap-2">
#>             <span>KPI</span>
#>           </div>
#>           <div class="ms-auto d-flex align-items-center"></div>
#>         </div>
#>         <div class="card-body" style="margin-top:auto;margin-bottom:auto;flex:0 0 auto;" id="card-collapse-721954472feb-body">Revenue</div>
#>         <script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
#>       </div>
#>     </div>
#>   </div>
#>   <div class="col">
#>     <div class="col-sm-6 h-100">
#>       <div class="card bslib-card bslib-mb-spacing html-fill-container  " data-bslib-card-init data-require-bs-caller="card()" data-require-bs-version="5">
#>         <div class="card-header bslib-gap-spacing">
#>           <div class="d-flex align-items-center gap-2">
#>             <span>Chart</span>
#>           </div>
#>           <div class="ms-auto d-flex align-items-center"></div>
#>         </div>
#>         <div class="card-body" style="margin-top:auto;margin-bottom:auto;flex:0 0 auto;" id="card-collapse-eefb1f2d1890-body">Trend</div>
#>         <script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
#>       </div>
#>     </div>
#>   </div>
#> </div>
```
