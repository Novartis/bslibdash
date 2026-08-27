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

## Examples

``` r
if (FALSE) { # \dontrun{
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
} # }
```
