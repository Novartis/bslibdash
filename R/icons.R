#' Create an bslibdash icon
#'
#' @param name Name of icon.
#' @param class Additional classes.
#' @param style Optional inline style string or named CSS list.
#' @param size Icon size applied to a wrapping span.
#' @param color Icon color applied to a wrapping span.
#' @param css Named list of CSS properties applied to the icon tag.
#'
#' @return An icon `htmltools` tag.
#' @examples
#' icon("user")
#' icon("bar-chart", class = "text-primary", size = "1.25rem")
#' @export
icon <- function(name,
                 class = NULL,
                 style = NULL,
                 size = NULL,
                 color = NULL,
                 css = NULL) {
  css_tag <- function(x) {
    if (is.null(x) || length(x) == 0) return(NULL)
    do.call(htmltools::css, x)
  }

  resolved_style <- css_tag(css) %||% style

  wrap_size_color <- function(tag) {
    if (is.null(size) && is.null(color)) return(tag)
    htmltools::tags$span(
      tag,
      style = htmltools::css(color = color, fontSize = size)
    )
  }

  bs_name <- switch(
    name,
    "chart-line" = "graph-up",
    "bars" = "justify",
    name
  )

  icon_tag <- tryCatch(
    bsicons::bs_icon(
      bs_name,
      class = class,
      style = resolved_style
    ),
    error = function(e) NULL
  )

  if (is.null(icon_tag)) {
    icon_tag <- fontawesome_icon_or_null(
      name = name,
      class = class,
      style = resolved_style
    )
  }

  if (is.null(icon_tag)) {
    icon_tag <- unknown_icon_placeholder(
      name = name,
      class = class,
      style = resolved_style
    )
  }

  wrap_size_color(icon_tag)
}
