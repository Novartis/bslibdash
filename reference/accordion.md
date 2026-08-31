# Accordion container

Accordion container

Accordion item

## Usage

``` r
accordion(..., id, width = 12, .list = NULL)

accordionItem(..., title, status = NULL)
```

## Arguments

- ...:

  Item content.

- id:

  Unique accordion id.

- width:

  The width of the accordion.

- .list:

  Optional list of accordion items.

- title:

  Item title.

- status:

  Optional Bootstrap status color. When set, the item border and header
  are tinted with the matching subtle status hue, aligned with
  `box(status = ...)`.

## Examples

``` r
accordion(
  id = "filters",
  accordionItem(title = "Date range", shiny::p("Last 30 days")),
  accordionItem(title = "Region", shiny::p("All regions"))
)
#> <div class="container-fluid">
#>   <div class="accordion bslib-accordion-input" data-require-bs-caller="accordion()" data-require-bs-version="5" id="filters" style="width:100%;">
#>     <div class="accordion-item" data-value="Date range">
#>       <div class="accordion-header">
#>         <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#bslib-accordion-panel-6181" aria-controls="bslib-accordion-panel-6181" aria-expanded="true">
#>           <div class="accordion-icon"></div>
#>           <div class="accordion-title">Date range</div>
#>         </button>
#>       </div>
#>       <div id="bslib-accordion-panel-6181" class="accordion-collapse collapse show">
#>         <div class="accordion-body">
#>           <p>Last 30 days</p>
#>         </div>
#>       </div>
#>     </div>
#>     <div class="accordion-item" data-value="Region">
#>       <div class="accordion-header">
#>         <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#bslib-accordion-panel-7983" aria-expanded="false" aria-controls="bslib-accordion-panel-7983">
#>           <div class="accordion-icon"></div>
#>           <div class="accordion-title">Region</div>
#>         </button>
#>       </div>
#>       <div id="bslib-accordion-panel-7983" class="accordion-collapse collapse">
#>         <div class="accordion-body">
#>           <p>All regions</p>
#>         </div>
#>       </div>
#>     </div>
#>   </div>
#> </div>

accordionItem(
  title = "Advanced settings",
  status = "info",
  shiny::p("Optional controls")
)
#> <div class="accordion-item bslibdash-accordion-item bslibdash-accordion-item-info" data-value="Advanced settings">
#>   <div class="accordion-header">
#>     <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#bslib-accordion-panel-6237" aria-expanded="false" aria-controls="bslib-accordion-panel-6237">
#>       <div class="accordion-icon"></div>
#>       <div class="accordion-title">Advanced settings</div>
#>     </button>
#>   </div>
#>   <div id="bslib-accordion-panel-6237" class="accordion-collapse collapse">
#>     <div class="accordion-body">
#>       <p>Optional controls</p>
#>     </div>
#>   </div>
#> </div>
```
