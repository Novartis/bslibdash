#' Dashboard body
#'
#' @param ... Body content, usually `tabItems()`.
#' @return `dashboardBody()` returns a `shiny.tag` `<div>` wrapping the main
#'   content area of the dashboard.
#' @examples
#' dashboardBody(
#'   tabItems(
#'     tabItem(tabName = "overview", shiny::h2("Overview")),
#'     tabItem(tabName = "reports", shiny::h2("Reports"))
#'   )
#' )
#' @rdname dashboardBody
#' @export
dashboardBody <- function(...) {
  sidebar_main(...)
}

#' Body items
#'
#' Containers for tab content placed inside [dashboardBody()]:
#'
#' - `tabItems()` is the parent container.
#' - `tabItem(tabName)` is one tab; `tabName` must match the
#'   corresponding `menuItem()` `tabName`.
#'
#' @param ... Items to put in the container.
#' @param id Shared Shiny id for the sidebar menu and body tabset. Use the same
#'   value in `sidebarMenu(id)`, `tabItems(id)`, and
#'   `updateTabItems(inputId)`. Defaults to `"sidebarMenu"`.
#' @return `tabItems()` returns a `shiny.tag` `<div>` containing a hidden
#'   [shiny::tabsetPanel()] whose panels are switched by the sidebar menu.
#' @examples
#' tabItems(
#'   tabItem(tabName = "overview", shiny::p("Overview content")),
#'   tabItem(tabName = "reports", shiny::p("Reports content"))
#' )
#' @rdname dashboardBody
#' @export
tabItems <- function(..., id = "sidebarMenu") {
  sidebar_pages(..., id = id)
}

#' @param tabName The name of a tab.
#' @return `tabItem()` returns a `shiny.tag.list` holding the tab content, with
#'   the tab name recorded in its `tabName` attribute so that `tabItems()` can
#'   place it in the matching panel.
#' @examples
#' tabItem(
#'   tabName = "overview",
#'   shiny::h2("Overview"),
#'   shiny::p("This is the overview tab.")
#' )
#' @rdname dashboardBody
#' @export
tabItem <- function(tabName = NULL, ...) {
  sidebar_page(tabName = tabName, ...)
}
