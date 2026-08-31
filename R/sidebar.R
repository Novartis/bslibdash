#' Create a dashboard main sidebar
#'
#' The dashboard's sidebar navigation panel. Pair it with [sidebarMenu()] to
#' render a dashboard-style sidebar menu of [menuItem()]s (and nested
#' [menuSubItem()]s) alongside the current [bslib::sidebar()] layout.
#'
#' @param ... Slot for `sidebarMenu()`.
#' @param disable Whether to disable and omit the sidebar.
#' @param width Expanded sidebar width. Numeric values are interpreted as
#'   pixels; CSS strings such as `"18rem"` are passed through.
#' @param collapsed Whether the sidebar starts collapsed on desktop.
#'
#' @examples
#' dashboardSidebar(
#'   sidebarMenu(
#'     id = "sidebarMenu",
#'     sidebarHeader("Main"),
#'     menuItem("Overview", tabName = "overview", icon = icon("house")),
#'     menuItem(
#'       "Reports",
#'       icon = icon("bar-chart"),
#'       menuSubItem("Daily", tabName = "reports_daily"),
#'       menuSubItem("Monthly", tabName = "reports_monthly")
#'     )
#'   )
#' )
#'
#' @rdname dashboardSidebar
#' @export
dashboardSidebar <- function(...,
                             disable = FALSE,
                             width = NULL,
                             collapsed = FALSE) {
  if (isTRUE(disable)) {
    return(NULL)
  }

  style <- if (is.null(width)) {
    NULL
  } else {
    htmltools::css(`--app-sidebar-width` = css_unit(width))
  }

  sidebar(
    ...,
    class = if (isTRUE(collapsed)) "is-collapsed",
    style = style
  )
}

#' Dashboard main sidebar menu
#'
#' The sidebar navigation menu itself: an ordered list of [menuItem()]s (and
#' optional nested [menuSubItem()]s) rendered inside [dashboardSidebar()].
#' `id` ties the menu's selected item to the matching [tabItem()] in
#' [dashboardBody()], so clicking a menu item switches the visible dashboard
#' tab; see `vignette("sidebar-navigation")` for the full navigation model.
#'
#' @param ... Slot for `menuItem()` or `sidebarHeader()`.
#' @param id Shared Shiny id for the sidebar menu and body tabset. Use the same
#'   value in `sidebarMenu(id)`, `tabItems(id)`, and
#'   `updateTabItems(inputId)`. Defaults to `"sidebarMenu"`.
#' @param .list Optional list of items.
#'
#' @examples
#' sidebarMenu(
#'   id = "sidebarMenu",
#'   menuItem("Overview", tabName = "overview", icon = icon("house")),
#'   menuItem("Settings", tabName = "settings", icon = icon("gear"))
#' )
#'
#' @rdname dashboardSidebar
#' @export
sidebarMenu <- function(...,
                        id = NULL,
                        .list = NULL) {
  sidebar_menu(
    id = id %||% "sidebarMenu",
    ...,
    .list = .list
  )
}

#' Dashboard sidebar menu item
#'
#' One entry in a [sidebarMenu()]. A plain `menuItem()` is a navigation link
#' to the [tabItem()] with a matching `tabName`; passing one or more
#' [menuSubItem()]s turns it into an expandable nested-navigation group
#' instead.
#'
#' @param text Item name.
#' @param ... `menuSubItem()` children.
#' @param icon Icon tag or icon name.
#' @param badgeLabel Optional badge label.
#' @param badgeColor Badge color.
#' @param tabName Matching `tabItem()` name.
#' @param selected Whether the item starts selected.
#' @param expandedName Optional unique name for the item's collapse panel.
#'   If omitted, a stable id is generated from the item text and children.
#'   Set explicitly for multiple items with the same text and children.
#' @param startExpanded Whether children start expanded.
#' @param condition Optional display condition stored as a data attribute.
#'
#' @examples
#' menuItem(
#'   "Reports",
#'   icon = icon("bar-chart"),
#'   menuSubItem("Daily", tabName = "reports_daily"),
#'   menuSubItem("Monthly", tabName = "reports_monthly")
#' )
#'
#' @rdname dashboardSidebar
#' @export
menuItem <- function(text,
                     ...,
                     icon = NULL,
                     badgeLabel = NULL,
                     badgeColor = "success",
                     tabName = NULL,
                     selected = NULL,
                     expandedName = NULL,
                     startExpanded = FALSE,
                     condition = NULL) {
  subItems <- list(...)
  badgeTag <- NULL

  if (is.null(expandedName)) {
    expandedName <- paste0(
      as.character(text),
      "-",
      substr(rlang::hash(list(as.character(text), subItems)), 1, 8)
    )
  }
  expandedName <- sanitize_html_id_fragment(
    expandedName,
    fallback = paste0(
      "item-",
      hash_id(
        text = text,
        tabName = tabName,
        icon = icon,
        badgeLabel = badgeLabel,
        subItems = subItems
      )
    )
  )

  if (!is.null(badgeLabel)) {
    badgeTag <- badge(badgeLabel, color = badgeColor, position = "right")
  }

  if (rlang::is_empty(subItems)) {
    return(
      sidebar_menu_item(
        text = htmltools::tagList(text, badgeTag),
        tabName = tabName,
        icon = icon_or_tag(icon),
        active = isTRUE(selected)
      )
    )
  }

  hasSelectedChild <- any(vapply(
    subItems,
    function(x) {
      cls <- tryCatch(x$attribs$class, error = function(e) NULL)
      isTRUE(is.character(cls) && grepl("(^|\\s)active(\\s|$)", cls))
    },
    logical(1)
  ))
  expandOpen <- isTRUE(startExpanded) || hasSelectedChild

  collapseId <- paste0("collapse-", expandedName)
  htmltools::tags$div(
    class = "ms-2",
    `data-display-if` = condition,
    htmltools::tags$div(
      class = "nav-item has-subnav",
      htmltools::tags$button(
        class = "nav-link d-flex align-items-center gap-2",
        `data-bs-toggle` = "collapse",
        `data-bs-target` = sprintf("#%s", collapseId),
        `aria-expanded` = if (expandOpen) "true" else "false",
        `aria-controls` = collapseId,
        `data-start-selected` = if (isTRUE(selected)) 1 else NULL,
        icon_or_tag(icon) %||% bslibdash::icon("ellipsis"),
        htmltools::tags$span(class = "nav-text", text, badgeTag),
        bslibdash::icon("chevron-right", class = "sidebar-caret ms-auto")
      )
    ),
    htmltools::tags$div(
      class = paste("sidebar-subnav collapse", if (expandOpen) "show"),
      id = collapseId,
      shiny::tagList(!!!subItems)
    )
  )
}

#' Dashboard sidebar menu sub-item
#'
#' A nested navigation link inside an expandable [menuItem()], for
#' second-level dashboard navigation. Like a top-level `menuItem()`, it
#' links to the [tabItem()] with a matching `tabName`.
#'
#' @param text Item name.
#' @param tabName Matching `tabItem()` name.
#' @param icon Icon tag or icon name.
#' @param selected Whether the item starts selected.
#'
#' @examples
#' menuSubItem(
#'   "Daily report",
#'   tabName = "reports_daily",
#'   icon = bslibdash::icon("angle-double-right")
#' )
#'
#' @rdname dashboardSidebar
#' @export
menuSubItem <- function(text,
                        tabName = NULL,
                        icon = bslibdash::icon("angle-double-right"),
                        selected = NULL) {
  sidebar_menu_item(
    text = text,
    tabName = tabName,
    icon = icon_or_tag(icon),
    active = isTRUE(selected)
  ) |>
    htmltools::tagAppendAttributes(class = "nav-link-sub")
}

#' Dashboard sidebar menu header
#'
#' @param title Header title.
#' @examples
#' sidebarHeader("Administration")
#' @rdname dashboardSidebar
#' @export
sidebarHeader <- function(title) {
  sidebar_title(text = title)
}
