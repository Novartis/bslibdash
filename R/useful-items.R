#' Create dashboard badge item
#'
#' @param ... Badge content.
#' @param position Badge position: `"left"` or `"right"`.
#' @param color Bootstrap status color.
#' @param rounded Whether the badge is rounded.
#'
#' @examples
#' badge("NEW", color = "success", position = "right", rounded = TRUE)
#'
#' @rdname badge
#' @export
badge <- function(..., position = c("left", "right"), color, rounded = FALSE) {
  position <- rlang::arg_match(position)
  validateStatus(color)

  position_class <- switch(
    position,
    left = "start-0",
    right = "end-0"
  )

  htmltools::tags$span(
    class = paste0(position_class, " badge text-bg-", color),
    class = if (rounded) "rounded-pill",
    ...
  )
}

#' Accordion container
#'
#' @param ... Slot for `accordionItem()`. Named arguments are passed to `bslib::accordion()`.
#' @param id Unique accordion id.
#' @param width The width of the accordion.
#' @param .list Optional list of accordion items.
#'
#' @examples
#' accordion(
#'   id = "filters",
#'   accordionItem(title = "Date range", shiny::p("Last 30 days")),
#'   accordionItem(title = "Region", shiny::p("All regions"))
#' )
#'
#' @rdname accordion
#' @export
accordion <- function(..., id, width = 12, .list = NULL) {
  items <- c(list(...), .list)

  ui <- bslib::accordion(
    !!!items,
    id = id,
    width = width_unit(width)
  )

  htmltools::attachDependencies(
    ui,
    list(
      bslibdash_core_dependency(),
      bslibdash_component_dependency(
        name = "accordion",
        scss = "accordion.scss"
      )
    ),
    append = TRUE
  )
}

#' Accordion item
#'
#' @param ... Item content.
#' @param title Item title.
#' @param status Optional Bootstrap status color. When set, the item border
#'   and header are tinted with the matching subtle status hue, aligned with
#'   `box(status = ...)`.
#'
#' @examples
#' accordionItem(
#'   title = "Advanced settings",
#'   status = "info",
#'   shiny::p("Optional controls")
#' )
#'
#' @rdname accordion
#' @export
accordionItem <- function(..., title, status = NULL) {
  if (!is.null(status)) {
    validateStatus(status)
  }

  bslib::accordion_panel(
    ...,
    title = title
  ) |>
    htmltools::tagAppendAttributes(
      class = glue::glue("bslibdash-accordion-item bslibdash-accordion-item-{status}")
    )
}
