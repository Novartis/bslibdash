# Tab box

Tab box

## Usage

``` r
tabBox(
  ...,
  id = NULL,
  selected = NULL,
  title = NULL,
  width = 6,
  height = NULL,
  side = c("left", "right")
)
```

## Arguments

- ...:

  [`shiny::tabPanel()`](https://rdrr.io/pkg/shiny/man/tabPanel.html)
  elements to include in the tab box.

- id:

  Input id for the tabset.

- selected:

  The tab value selected on initial load.

- title:

  Optional title shown in the tab box header.

- width:

  The width of the box in Bootstrap grid columns (`1`-`12`). Use `NULL`
  when placing the box inside an existing column.

- height:

  Optional CSS height value passed to
  [`bslib::navset_card_tab()`](https://rstudio.github.io/bslib/reference/navset.html).

- side:

  Whether to place tabs on the `"left"` or `"right"` side of the header.

## Examples

``` r
# Basic tab box with a title in the card header
tabBox(
  id = "quarterly",
  title = "Quarterly summary",
  shiny::tabPanel("Q1", shiny::p("Q1 content")),
  shiny::tabPanel("Q2", shiny::p("Q2 content"))
)
#> <div class="col-sm-6">
#>   <div class="card bslib-card bslib-mb-spacing html-fill-item html-fill-container bslibdash-tab-box" data-bslib-card-init data-require-bs-caller="card()" data-require-bs-version="5">
#>     <div class="card-header bslib-gap-spacing bslib-navs-card-title">
#>       <span>Quarterly summary</span>
#>       <ul class="nav nav-tabs shiny-tab-input card-header-tabs" id="quarterly" data-tabsetid="1588">
#>         <li class="active">
#>           <a href="#tab-1588-1" data-toggle="tab" data-bs-toggle="tab" data-value="Q1">Q1</a>
#>         </li>
#>         <li>
#>           <a href="#tab-1588-2" data-toggle="tab" data-bs-toggle="tab" data-value="Q2">Q2</a>
#>         </li>
#>       </ul>
#>     </div>
#>     <div class="tab-content html-fill-item html-fill-container" data-tabsetid="1588">
#>       <div class="tab-pane active html-fill-item html-fill-container bslib-gap-spacing" data-value="Q1" id="tab-1588-1" style="gap:0;padding:0;">
#>         <div class="card-body bslib-gap-spacing html-fill-item html-fill-container" style="margin-top:auto;margin-bottom:auto;flex:1 1 auto;">
#>           <p>Q1 content</p>
#>         </div>
#>       </div>
#>       <div class="tab-pane html-fill-item html-fill-container bslib-gap-spacing" data-value="Q2" id="tab-1588-2" style="gap:0;padding:0;">
#>         <div class="card-body bslib-gap-spacing html-fill-item html-fill-container" style="margin-top:auto;margin-bottom:auto;flex:1 1 auto;">
#>           <p>Q2 content</p>
#>         </div>
#>       </div>
#>     </div>
#>     <script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
#>   </div>
#> </div>

# Pre-select a tab and fix the card height (content scrolls inside)
tabBox(
  selected = "Q2",
  height   = "200px",
  shiny::tabPanel("Q1", shiny::p("Q1 content")),
  shiny::tabPanel("Q2", shiny::p("Q2 content"))
)
#> <div class="col-sm-6">
#>   <div class="card bslib-card bslib-mb-spacing html-fill-item html-fill-container bslibdash-tab-box" data-bslib-card-init data-require-bs-caller="card()" data-require-bs-version="5" style="height:200px;">
#>     <div class="card-header bslib-gap-spacing">
#>       <ul class="nav nav-tabs card-header-tabs" data-tabsetid="5513">
#>         <li>
#>           <a href="#tab-5513-1" data-toggle="tab" data-bs-toggle="tab" data-value="Q1">Q1</a>
#>         </li>
#>         <li class="active">
#>           <a href="#tab-5513-2" data-toggle="tab" data-bs-toggle="tab" data-value="Q2">Q2</a>
#>         </li>
#>       </ul>
#>     </div>
#>     <div class="tab-content html-fill-item html-fill-container" data-tabsetid="5513">
#>       <div class="tab-pane html-fill-item html-fill-container bslib-gap-spacing" data-value="Q1" id="tab-5513-1" style="gap:0;padding:0;">
#>         <div class="card-body bslib-gap-spacing html-fill-item html-fill-container" style="margin-top:auto;margin-bottom:auto;flex:1 1 auto;">
#>           <p>Q1 content</p>
#>         </div>
#>       </div>
#>       <div class="tab-pane active html-fill-item html-fill-container bslib-gap-spacing" data-value="Q2" id="tab-5513-2" style="gap:0;padding:0;">
#>         <div class="card-body bslib-gap-spacing html-fill-item html-fill-container" style="margin-top:auto;margin-bottom:auto;flex:1 1 auto;">
#>           <p>Q2 content</p>
#>         </div>
#>       </div>
#>     </div>
#>     <script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
#>   </div>
#> </div>
```
