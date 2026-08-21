#' Create a toast
#'
#' Renders a notification through [shiny::showNotification()]. The default
#' Shiny / bslib notification chrome (background, border, position, status
#' color, dismiss button) is used as-is; `toast()` only adds support for the
#' extra parameters below — header (title + optional icon), body, and
#' subtitle footnote — emitted as flat blocks so they do not produce a
#' card-in-notification (box-in-box) look. The `type` option in `options`
#' controls the status color via Shiny's own notification statuses
#' (`"default"`, `"message"`, `"warning"`, `"error"`).
#'
#' @param title Toast title.
#' @param body Body content.
#' @param subtitle Toast subtitle. Rendered as an additional muted body block
#'   below `body` (footnote).
#' @param options Toast options. Supports `delay` (auto-hide duration in
#'   milliseconds), `autohide` (set `FALSE` to disable auto-hide), `icon`
#'   (optional header icon tag), `close` (show the close button, default
#'   `TRUE`), and `type` (Shiny notification status: one of `"default"`,
#'   `"message"`, `"warning"`, `"error"`).
#' @param session Shiny session object.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(
#'   ui = bslib::page_fluid(shiny::actionButton("show_toast", "Show toast")),
#'   server = function(input, output, session) {
#'     shiny::observeEvent(input$show_toast, {
#'       toast(
#'         title = "Heads up",
#'         body = "Background job finished with a warning.",
#'         options = list(type = "warning", delay = 3000),
#'         session = session
#'       )
#'     })
#'   }
#' )
#' }
#'
#' @export
toast <- function(title,
                  body = NULL,
                  subtitle = NULL,
                  options = NULL,
                  session = shiny::getDefaultReactiveDomain()) {
  options <- options %||% list()
  duration <- 5

  if (!is.null(options$delay)) {
    duration <- options$delay / 1000
  }
  if (isFALSE(options$autohide)) {
    duration <- NULL
  }

  type <- options$type %||% "default"

  shiny::showNotification(
    ui = toast_ui(
      title = title,
      body = body,
      subtitle = subtitle,
      icon = options$icon
    ),
    type = type,
    duration = duration,
    closeButton = options$close %||% TRUE,
    session = session
  )
}

toast_ui <- function(title, body = NULL, subtitle = NULL, icon = NULL) {
  icon_tag <- icon_or_tag(icon)

  header <- htmltools::tags$div(
    class = "bslibdash-toast-header",
    if (!is.null(icon_tag)) {
      htmltools::tags$span(class = "bslibdash-toast-icon", icon_tag)
    },
    htmltools::tags$strong(class = "bslibdash-toast-title", title)
  )

  body_tag <- if (!is.null(body)) {
    htmltools::tags$div(class = "bslibdash-toast-body", body)
  }

  subtitle_tag <- if (!is.null(subtitle)) {
    htmltools::tags$div(
      class = "bslibdash-toast-body bslibdash-toast-subtitle",
      subtitle
    )
  }

  htmltools::tags$div(
    class = "bslibdash-toast",
    role = "alert",
    `aria-live` = "polite",
    `aria-atomic` = "true",
    header,
    body_tag,
    subtitle_tag
  ) |>
    htmltools::attachDependencies(
      list(
        bslibdash_core_dependency(),
        bslibdash_component_dependency(
          name = "toast",
          scss = "toast.scss"
        )
      ),
      append = TRUE
    )
}
