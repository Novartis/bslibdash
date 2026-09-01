# Render a value box

Render a value box

## Usage

``` r
renderValueBox(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- expr:

  An expression that returns a value box tag.

- env:

  The parent environment for the reactive expression.

- quoted:

  Is `expr` a quoted expression.

## Examples

``` r
if (interactive()) {
shiny::shinyApp(
  ui = bslib::page_fluid(valueBoxOutput("tickets")),
  server = function(input, output, session) {
    output$tickets <- renderValueBox({
      valueBox("128", "Open tickets", icon = icon("inbox"), color = "primary")
    })
  }
)
}
```
