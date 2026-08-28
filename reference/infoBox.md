# Info box

Info box

## Usage

``` r
infoBox(
  title,
  value = NULL,
  subtitle = NULL,
  icon = shiny::icon("bar-chart"),
  color = "aqua",
  width = 4,
  href = NULL,
  fill = FALSE
)
```

## Arguments

- title:

  Box title.

- value:

  Value text.

- subtitle:

  Optional subtitle text.

- icon:

  An icon tag, created by
  [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html) or
  [`icon()`](https://opensource.nibr.com/bslibdash/reference/icon.md).

- color:

  Box color. Supports both legacy `shinydashboard` color names (e.g.
  `"aqua"`, `"light-blue"`, `"fuchsia"`) and Bootstrap semantic names
  (`"primary"`, `"success"`, `"warning"`, etc.). Legacy names are mapped
  to fixed hex values; Bootstrap names reference CSS theme variables so
  they follow the active theme. A contrasting foreground color is
  computed automatically. Note:
  [`box()`](https://opensource.nibr.com/bslibdash/reference/box.md) uses
  a simpler `status` parameter that only accepts Bootstrap semantic
  names and applies them as utility classes.

- width:

  The width of the box in Bootstrap grid columns (`1`-`12`). Use `NULL`
  when placing the box inside an existing column.

- href:

  Optional URL to link to.

- fill:

  Whether to fill the entire box background with `color`.

## Examples

``` r
infoBox(
  title = "CPU",
  value = "42%",
  subtitle = "Current usage",
  icon = icon("cpu"),
  color = "success"
)
#> <div class="col-sm-4">
#>   <div class="card bslib-card bslibdash-info-box mb-3" style="--bslibdash-info-box-accent:var(--bs-success);--bslibdash-info-box-accent-fg:#FFFFFF;">
#>     <div class="card-body">
#>       <div class="bslibdash-info-box-inner">
#>         <div class="bslibdash-info-box-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-cpu " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M5 0a.5.5 0 0 1 .5.5V2h1V.5a.5.5 0 0 1 1 0V2h1V.5a.5.5 0 0 1 1 0V2h1V.5a.5.5 0 0 1 1 0V2A2.5 2.5 0 0 1 14 4.5h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14a2.5 2.5 0 0 1-2.5 2.5v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14A2.5 2.5 0 0 1 2 11.5H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2A2.5 2.5 0 0 1 4.5 2V.5A.5.5 0 0 1 5 0zm-.5 3A1.5 1.5 0 0 0 3 4.5v7A1.5 1.5 0 0 0 4.5 13h7a1.5 1.5 0 0 0 1.5-1.5v-7A1.5 1.5 0 0 0 11.5 3h-7zM5 6.5A1.5 1.5 0 0 1 6.5 5h3A1.5 1.5 0 0 1 11 6.5v3A1.5 1.5 0 0 1 9.5 11h-3A1.5 1.5 0 0 1 5 9.5v-3zM6.5 6a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"></path></svg></div>
#>         <div class="bslibdash-info-box-content">
#>           <p class="bslibdash-info-box-text">CPU</p>
#>           <p class="bslibdash-info-box-number">42%</p>
#>           <p class="bslibdash-info-box-subtitle">Current usage</p>
#>         </div>
#>       </div>
#>     </div>
#>   </div>
#> </div>
```
