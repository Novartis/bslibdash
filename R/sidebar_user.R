#' Sidebar user panel
#'
#' Displays a user identity block (avatar, name, optional subtitle) at the
#' top of the dashboard sidebar. Mirrors `shinydashboard::sidebarUserPanel()`.
#'
#' When the sidebar is collapsed on desktop, the name and subtitle are
#' hidden and only the circular avatar remains, centered.
#'
#' @param name User name. Required.
#' @param image Optional avatar. Either a URL string (rendered as `<img>`)
#'   or an icon/htmltools tag. If `NULL`, a default `bi-person-circle`
#'   icon is used.
#' @param subtitle Optional secondary text shown beneath the name.
#'
#' @return An htmltools `<div>` tag intended to be passed into
#'   `dashboardSidebar()`.
#' @examples
#' dashboardSidebar(
#'   sidebarUserPanel(
#'     name = "Jane Doe",
#'     subtitle = "Administrator"
#'   ),
#'   sidebarMenu(
#'     menuItem("Overview", tabName = "overview")
#'   )
#' )
#' @export
sidebarUserPanel <- function(name, image = NULL, subtitle = NULL) {
  if (missing(name) || is.null(name) || !nzchar(as.character(name))) {
    stop("`name` must be a non-empty string.", call. = FALSE)
  }

  avatar <- sidebar_user_avatar(image)

  info <- htmltools::tags$div(
    class = "sidebar-user-info",
    htmltools::tags$p(class = "sidebar-user-name mb-0", name),
    if (!is.null(subtitle)) {
      htmltools::tags$p(class = "sidebar-user-subtitle mb-0", subtitle)
    }
  )

  htmltools::tags$div(
    class = "sidebar-user-panel d-flex align-items-center gap-2 mb-3",
    htmltools::tags$div(class = "sidebar-user-image", avatar),
    info
  )
}

sidebar_user_avatar <- function(image) {
  if (is.null(image)) {
    return(bslibdash::icon("person-circle", class = "sidebar-user-default-icon"))
  }

  if (inherits(image, "shiny.tag") || inherits(image, "shiny.tag.list") ||
        inherits(image, "html")) {
    return(image)
  }

  if (is.character(image) && length(image) == 1L && nzchar(image)) {
    return(htmltools::tags$img(src = image, alt = "", class = "rounded-circle"))
  }

  stop(
    "`image` must be NULL, a URL string, or an htmltools tag.",
    call. = FALSE
  )
}
