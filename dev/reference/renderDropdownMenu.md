# Render a dropdown menu

Render a dropdown menu

## Usage

``` r
renderDropdownMenu(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- expr:

  An expression that returns a dropdown menu tag.

- env:

  The parent environment for the reactive expression.

- quoted:

  Is `expr` a quoted expression.

## Value

A [`shiny::renderUI()`](https://rdrr.io/pkg/shiny/man/renderUI.html)
function that may be assigned to an `output` slot paired with
[`dropdownMenuOutput()`](https://opensource.nibr.com/bslibdash/dev/reference/dropdownMenuOutput.md).

## Examples

``` r
if (interactive()) {
shiny::shinyApp(
  ui = bslib::page_fluid(dropdownMenuOutput("alerts_menu")),
  server = function(input, output, session) {
    output$alerts_menu <- renderDropdownMenu({
      dropdownMenu(
        type = "notifications",
        notificationItem("Job finished", status = "success")
      )
    })
  }
)
}
```
