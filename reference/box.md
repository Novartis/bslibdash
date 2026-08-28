# Create a card

Create a card

Update a card from the server side

Backwards-compatible alias to `updateBox()`

## Usage

``` r
box(
  ...,
  title = NULL,
  footer = NULL,
  status = NULL,
  background = NULL,
  width = 6,
  height = NULL,
  collapsible = FALSE,
  collapsed = FALSE,
  closable = FALSE,
  maximizable = FALSE,
  icon = NULL,
  label = NULL,
  id = NULL
)

updateBox(
  id,
  action = c("remove", "toggle", "update", "restore", "toggleMaximize"),
  options = NULL,
  session = shiny::getDefaultReactiveDomain()
)

updateCard(
  id,
  action = c("remove", "toggle", "update", "restore", "toggleMaximize"),
  options = NULL,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- ...:

  Contents of the card.

- title:

  Optional title.

- footer:

  Optional footer.

- status:

  Bootstrap status color applied to the **card header** background.
  Accepted values are Bootstrap semantic names: `"primary"`,
  `"secondary"`, `"success"`, `"info"`, `"warning"`, `"danger"`,
  `"light"`, `"dark"`. Unlike
  [`valueBox()`](https://opensource.nibr.com/bslibdash/reference/valueBox.md)
  and
  [`infoBox()`](https://opensource.nibr.com/bslibdash/reference/infoBox.md),
  legacy `shinydashboard` color names (e.g. `"aqua"`, `"blue"`) are
  **not** supported here.

- background:

  Bootstrap status color applied to the **entire card** background.
  Accepts the same values as `status`. When set, the full card surface
  is coloured rather than just the header.

- width:

  Width of the card. An integer `1`–`12` is treated as Bootstrap grid
  columns and the card is automatically wrapped in
  [`shiny::column()`](https://rdrr.io/pkg/shiny/man/column.html),
  consistent with
  [`valueBox()`](https://opensource.nibr.com/bslibdash/reference/valueBox.md)
  and
  [`infoBox()`](https://opensource.nibr.com/bslibdash/reference/infoBox.md).
  Any other value (e.g. `"300px"`) is applied as an inline CSS `width`.
  Use `NULL` when placing the card inside an existing column or a
  [`boxLayout()`](https://opensource.nibr.com/bslibdash/reference/boxLayout.md).

- height:

  Card height.

- collapsible:

  Whether the card body can collapse.

- collapsed:

  Whether the card starts collapsed.

- closable:

  Whether the card can be hidden.

- maximizable:

  Whether the card can be displayed full-screen.

- icon:

  Header icon tag or icon name.

- label:

  Header label content.

- id:

  Id of the card created with `box()`.

- action:

  Action to trigger.

- options:

  List of new options for `action = "update"`.

- session:

  Shiny session.

## See also

Other cards:
[`boxLayout()`](https://opensource.nibr.com/bslibdash/reference/boxLayout.md)

## Examples

``` r
box(
  "Card body",
  title = "Status",
  status = "primary",
  id = "status_box"
)
#> <div class="col-sm-6">
#>   <div class="card bslib-card bslib-mb-spacing bslib-card-input html-fill-container  " data-bslib-card-init data-require-bs-caller="card()" data-require-bs-version="5" id="status_box">
#>     <div class="card-header bslib-gap-spacing bg-primary">
#>       <div class="d-flex align-items-center gap-2">
#>         <span>Status</span>
#>       </div>
#>       <div class="ms-auto d-flex align-items-center"></div>
#>     </div>
#>     <div class="card-body" style="margin-top:auto;margin-bottom:auto;flex:0 0 auto;" id="card-collapse-273a39720f7c-body">Card body</div>
#>     <script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
#>   </div>
#> </div>

boxLayout(
  box("A", title = "Card A"),
  box("B", title = "Card B"),
  type = "deck"
)
#> <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
#>   <div class="col">
#>     <div class="col-sm-6 h-100">
#>       <div class="card bslib-card bslib-mb-spacing html-fill-container  " data-bslib-card-init data-require-bs-caller="card()" data-require-bs-version="5">
#>         <div class="card-header bslib-gap-spacing">
#>           <div class="d-flex align-items-center gap-2">
#>             <span>Card A</span>
#>           </div>
#>           <div class="ms-auto d-flex align-items-center"></div>
#>         </div>
#>         <div class="card-body" style="margin-top:auto;margin-bottom:auto;flex:0 0 auto;" id="card-collapse-05bddf321666-body">A</div>
#>         <script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
#>       </div>
#>     </div>
#>   </div>
#>   <div class="col">
#>     <div class="col-sm-6 h-100">
#>       <div class="card bslib-card bslib-mb-spacing html-fill-container  " data-bslib-card-init data-require-bs-caller="card()" data-require-bs-version="5">
#>         <div class="card-header bslib-gap-spacing">
#>           <div class="d-flex align-items-center gap-2">
#>             <span>Card B</span>
#>           </div>
#>           <div class="ms-auto d-flex align-items-center"></div>
#>         </div>
#>         <div class="card-body" style="margin-top:auto;margin-bottom:auto;flex:0 0 auto;" id="card-collapse-5617eccc57e1-body">B</div>
#>         <script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
#>       </div>
#>     </div>
#>   </div>
#> </div>

if (FALSE) { # \dontrun{
shiny::shinyApp(
  ui = bslib::page_fluid(
    shiny::actionButton("toggle", "Toggle card"),
    box("Card body", title = "Status", id = "status_box")
  ),
  server = function(input, output, session) {
    shiny::observeEvent(input$toggle, {
      updateBox("status_box", action = "toggle", session = session)
    })
  }
)
} # }
```
