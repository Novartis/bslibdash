# Render a sidebar menu element

Render a sidebar menu element

## Usage

``` r
renderMenu(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- expr:

  An expression that returns a
  [`menuItem()`](https://novartis.github.io/bslibdash/reference/dashboardSidebar.md)
  or
  [`sidebarMenu()`](https://novartis.github.io/bslibdash/reference/dashboardSidebar.md)
  tag.

- env:

  The parent environment for the reactive expression.

- quoted:

  Is `expr` a quoted expression.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::shinyApp(
  ui = bslib::page_fluid(menuItemOutput("dynamic_menu_item")),
  server = function(input, output, session) {
    output$dynamic_menu_item <- renderMenu({
      menuItem("Overview", tabName = "overview", icon = icon("house"))
    })
  }
)
} # }
```
