# Render an info box

Render an info box

## Usage

``` r
renderInfoBox(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- expr:

  An expression that returns an info box tag.

- env:

  The parent environment for the reactive expression.

- quoted:

  Is `expr` a quoted expression.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::shinyApp(
  ui = bslib::page_fluid(infoBoxOutput("system_status")),
  server = function(input, output, session) {
    output$system_status <- renderInfoBox({
      infoBox("CPU", "42%", icon = icon("cpu"), color = "success")
    })
  }
)
} # }
```
