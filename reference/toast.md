# Create a toast

Renders a notification through
[`shiny::showNotification()`](https://rdrr.io/pkg/shiny/man/showNotification.html).
The default Shiny / bslib notification chrome (background, border,
position, status color, dismiss button) is used as-is; `toast()` only
adds support for the extra parameters below — header (title + optional
icon), body, and subtitle footnote — emitted as flat blocks so they do
not produce a card-in-notification (box-in-box) look. The `type` option
in `options` controls the status color via Shiny's own notification
statuses (`"default"`, `"message"`, `"warning"`, `"error"`).

## Usage

``` r
toast(
  title,
  body = NULL,
  subtitle = NULL,
  options = NULL,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- title:

  Toast title.

- body:

  Body content.

- subtitle:

  Toast subtitle. Rendered as an additional muted body block below
  `body` (footnote).

- options:

  Toast options. Supports `delay` (auto-hide duration in milliseconds),
  `autohide` (set `FALSE` to disable auto-hide), `icon` (optional header
  icon tag), `close` (show the close button, default `TRUE`), and `type`
  (Shiny notification status: one of `"default"`, `"message"`,
  `"warning"`, `"error"`).

- session:

  Shiny session object.

## Examples

``` r
if (interactive()) {
shiny::shinyApp(
  ui = bslib::page_fluid(shiny::actionButton("show_toast", "Show toast")),
  server = function(input, output, session) {
    shiny::observeEvent(input$show_toast, {
      toast(
        title = "Heads up",
        body = "Background job finished with a warning.",
        options = list(type = "warning", delay = 3000),
        session = session
      )
    })
  }
)
}
```
