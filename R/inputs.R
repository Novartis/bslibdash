#' Action button/link
#'
#' @param inputId The input slot used to access the value.
#' @param label Button label.
#' @param icon Optional icon.
#' @param width Button width.
#' @param ... Named attributes applied to the button.
#' @param status Bootstrap status color.
#' @param outline Whether to display an outline style.
#' @param size Button size.
#' @param flat Whether to apply a flat style.
#'
#' @examples
#' actionButton(
#'   inputId = "refresh",
#'   label = "Refresh",
#'   icon = "arrow-clockwise",
#'   status = "primary"
#' )
#'
#' @family input elements
#' @export
actionButton <- function(inputId,
                         label,
                         icon = NULL,
                         width = NULL,
                         ...,
                         status = NULL,
                         outline = FALSE,
                         size = NULL,
                         flat = FALSE) {
  if (!is.null(status)) {
    validateStatus(status)
  }

  extra_classes <- character(0)
  if (!is.null(status)) {
    extra_classes <- c(
      extra_classes,
      if (isTRUE(outline)) glue::glue("btn-outline-{status}") else glue::glue("btn-{status}")
    )
  }
  if (!is.null(size)) {
    extra_classes <- c(extra_classes, glue::glue("btn-{size}"))
  }
  if (isTRUE(flat)) {
    extra_classes <- c(extra_classes, "rounded-0")
  }

  resolved_icon <- icon
  if (is.character(icon) && !inherits(icon, "html") && length(icon) == 1 && !is.na(icon) && nzchar(icon)) {
    resolved_icon <- fontawesome_icon_or_missing(icon)
  }

  btn <- shiny::actionButton(
    inputId = inputId,
    label = label,
    icon = NULL,
    width = width,
    ...
  ) |>
    htmltools::tagAppendAttributes(
      class = if (length(extra_classes) > 0) paste(extra_classes, collapse = " ")
    )

  if (!is.null(resolved_icon)) {
    btn <- htmltools::tagInsertChildren(btn, resolved_icon, after = 0)
  }
  btn
}
