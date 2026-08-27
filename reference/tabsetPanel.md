# bslibdash tabsetPanel

bslibdash tabsetPanel

## Usage

``` r
tabsetPanel(
  ...,
  id = NULL,
  selected = NULL,
  type = c("tabs", "pills", "hidden"),
  .list = NULL
)
```

## Arguments

- ...:

  [`tabPanel()`](https://rdrr.io/pkg/shiny/man/tabPanel.html) elements
  to include in the tabset

- id:

  If provided, you can use `input$`*`id`* in your server logic to
  determine which of the current tabs is active. The value will
  correspond to the `value` argument that is passed to
  [`tabPanel()`](https://rdrr.io/pkg/shiny/man/tabPanel.html).

- selected:

  The `value` (or, if none was supplied, the `title`) of the tab that
  should be selected by default. If `NULL`, the first tab will be
  selected.

- type:

  `"tabs"`

  :   Standard tab look

  `"pills"`

  :   Selected tabs use the background fill color

  `"hidden"`

  :   Hides the selectable tabs. Use `type = "hidden"` in conjunction
      with
      [`tabPanelBody()`](https://rdrr.io/pkg/shiny/man/tabPanel.html)
      and
      [`updateTabsetPanel()`](https://rdrr.io/pkg/shiny/man/updateTabsetPanel.html)
      to control the active tab via other input controls. (See example
      below)

- .list:

  Optional list of tab panels.

## Examples

``` r
tabsetPanel(
  id = "tabs",
  shiny::tabPanel("Overview", shiny::p("Overview content")),
  shiny::tabPanel("Details", shiny::p("Detail content"))
)
#> <div class="tabbable">
#>   <ul class="nav nav-tabs shiny-tab-input" id="tabs" data-tabsetid="3273">
#>     <li class="active">
#>       <a href="#tab-3273-1" data-toggle="tab" data-bs-toggle="tab" data-value="Overview">Overview</a>
#>     </li>
#>     <li>
#>       <a href="#tab-3273-2" data-toggle="tab" data-bs-toggle="tab" data-value="Details">Details</a>
#>     </li>
#>   </ul>
#>   <div class="tab-content" data-tabsetid="3273">
#>     <div class="tab-pane active" data-value="Overview" id="tab-3273-1">
#>       <p>Overview content</p>
#>     </div>
#>     <div class="tab-pane" data-value="Details" id="tab-3273-2">
#>       <p>Detail content</p>
#>     </div>
#>   </div>
#> </div>
```
