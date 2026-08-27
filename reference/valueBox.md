# Value box

Value box

## Usage

``` r
valueBox(value, subtitle, icon = NULL, color = "aqua", width = 4, href = NULL)
```

## Arguments

- value:

  The value to display in the box.

- subtitle:

  Subtitle text.

- icon:

  An icon tag, created by
  [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html) or
  [`icon()`](https://novartis.github.io/bslibdash/reference/icon.md).

- color:

  Box color. Supports both legacy `shinydashboard` color names (e.g.
  `"aqua"`, `"light-blue"`, `"fuchsia"`) and Bootstrap semantic names
  (`"primary"`, `"success"`, `"warning"`, etc.). Legacy names are mapped
  to fixed hex values; Bootstrap names reference CSS theme variables so
  they follow the active theme. A contrasting foreground color is
  computed automatically. Note:
  [`box()`](https://novartis.github.io/bslibdash/reference/box.md) uses
  a simpler `status` parameter that only accepts Bootstrap semantic
  names and applies them as utility classes.

- width:

  The width of the box in Bootstrap grid columns (`1`-`12`). Use `NULL`
  when placing the box inside an existing column.

- href:

  Optional URL to link to.

## Examples

``` r
valueBox(
  value = "128",
  subtitle = "Open tickets",
  icon = icon("inbox"),
  color = "primary"
)
#> <div class="col-sm-4">
#>   <div class="card bslib-card bslib-mb-spacing html-fill-item html-fill-container bslib-value-box bslibdash-value-box showcase-top-right" data-bslib-card-init data-require-bs-caller="card() value_box()" data-require-bs-version="5 5" style="color:#FFFFFF;background-color:var(--bs-primary);--bslib-color-fg:#FFFFFF;--bslib-color-bg:var(--bs-primary);">
#>     <div class="card-body bslib-gap-spacing html-fill-item html-fill-container" style="margin-top:auto;margin-bottom:auto;flex:1 1 auto; padding:0;">
#>       <div class="value-box-grid html-fill-item" style="--bslib-grid-height:auto;--bslib-grid-height-mobile:auto;---bslib-value-box-showcase-w:40%;---bslib-value-box-showcase-w-fs:1fr;---bslib-value-box-showcase-max-h:75px;---bslib-value-box-showcase-max-h-fs:67%;">
#>         <div class="value-box-showcase html-fill-item html-fill-container"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-inbox " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M4.98 4a.5.5 0 0 0-.39.188L1.54 8H6a.5.5 0 0 1 .5.5 1.5 1.5 0 1 0 3 0A.5.5 0 0 1 10 8h4.46l-3.05-3.812A.5.5 0 0 0 11.02 4H4.98zm9.954 5H10.45a2.5 2.5 0 0 1-4.9 0H1.066l.32 2.562a.5.5 0 0 0 .497.438h12.234a.5.5 0 0 0 .496-.438L14.933 9zM3.809 3.563A1.5 1.5 0 0 1 4.981 3h6.038a1.5 1.5 0 0 1 1.172.563l3.7 4.625a.5.5 0 0 1 .105.374l-.39 3.124A1.5 1.5 0 0 1 14.117 13H1.883a1.5 1.5 0 0 1-1.489-1.314l-.39-3.124a.5.5 0 0 1 .106-.374l3.7-4.625z"></path></svg></div>
#>         <div class="value-box-area html-fill-item html-fill-container">
#>           <p class="value-box-title">Open tickets</p>
#>           <p class="value-box-value">128</p>
#>         </div>
#>       </div>
#>     </div>
#>     <script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
#>   </div>
#> </div>
```
