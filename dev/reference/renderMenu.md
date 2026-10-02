# Render a sidebar menu element

Render a sidebar menu element

## Usage

``` r
renderMenu(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- expr:

  An expression that returns a
  [`menuItem()`](https://opensource.nibr.com/bslibdash/dev/reference/dashboardSidebar.md)
  or
  [`sidebarMenu()`](https://opensource.nibr.com/bslibdash/dev/reference/dashboardSidebar.md)
  tag.

- env:

  The parent environment for the reactive expression.

- quoted:

  Is `expr` a quoted expression.

## Value

A [`shiny::renderUI()`](https://rdrr.io/pkg/shiny/man/renderUI.html)
function that may be assigned to an `output` slot paired with
[`menuItemOutput()`](https://opensource.nibr.com/bslibdash/dev/reference/menuItemOutput.md)
or
[`sidebarMenuOutput()`](https://opensource.nibr.com/bslibdash/dev/reference/sidebarMenuOutput.md).

## Examples

``` r
if (interactive()) {
shiny::shinyApp(
  ui = bslib::page_fluid(menuItemOutput("dynamic_menu_item")),
  server = function(input, output, session) {
    output$dynamic_menu_item <- renderMenu({
      menuItem("Overview", tabName = "overview", icon = icon("house"))
    })
  }
)
}
```
