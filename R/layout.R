dashboard_header_set_title <- function(tag, title) {
  if (!inherits(tag, "shiny.tag")) {
    return(tag)
  }

  classes <- strsplit(tag$attribs$class %||% "", "\\s+", perl = TRUE)[[1]]
  is_title_container <- identical(tag$name, "div") && "bslib-page-title" %in% classes

  if (is_title_container) {
    for (i in seq_along(tag$children)) {
      child <- tag$children[[i]]
      if (inherits(child, "shiny.tag") && identical(child$name, "h3")) {
        child$children <- list(title)
        tag$children[[i]] <- child
        return(tag)
      }
    }
    return(tag)
  }

  if (length(tag$children) > 0) {
    tag$children <- lapply(tag$children, dashboard_header_set_title, title = title)
  }

  tag
}

#' Branded dashboard page
#'
#' A bslib sidebar layout that arranges the four standard dashboard slots.
#' The `title` argument, when set, replaces the title text inside `header`
#' if `dashboardHeader()` was called without one.
#'
#' @param header Slot for [dashboardHeader()].
#' @param sidebar Slot for [dashboardSidebar()].
#' @param body Slot for [dashboardBody()].
#' @param title Page/app title shown in the browser tab and dashboard header.
#' @param footer Optional slot for [dashboardFooter()].
#' @param theme A `bslib` theme. Defaults to [brand_bs_theme()].
#'
#' @return A Shiny UI definition.
#' @examples
#' ui <- dashboardPage(
#'   header = dashboardHeader(title = "bslibdash dashboard"),
#'   sidebar = dashboardSidebar(
#'     sidebarMenu(
#'       id = "sidebarMenu",
#'       menuItem("Overview", tabName = "overview")
#'     )
#'   ),
#'   body = dashboardBody(
#'     tabItems(
#'       tabItem(
#'         tabName = "overview",
#'         box("Overview content", title = "Overview")
#'       )
#'     )
#'   )
#' )
#' @rdname dashboardPage
#' @export
dashboardPage <- function(header,
                          sidebar,
                          body,
                          title = NULL,
                          footer = NULL,
                          theme = brand_bs_theme()) {
  header_uses_default_title <- isTRUE(attr(header, "bslibdash_header_title_default"))
  if (header_uses_default_title && !is.null(title)) {
    header <- dashboard_header_set_title(header, title)
  }
  attr(header, "bslibdash_header_title_default") <- NULL

  page_sidebar(
    header = header,
    sidebar = sidebar,
    theme = theme,
    main = body,
    footer = footer
  )
}

#' bslibdash tabsetPanel
#'
#' @inheritParams shiny::tabsetPanel
#' @param .list Optional list of tab panels.
#' @examples
#' tabsetPanel(
#'   id = "tabs",
#'   shiny::tabPanel("Overview", shiny::p("Overview content")),
#'   shiny::tabPanel("Details", shiny::p("Detail content"))
#' )
#' @export
tabsetPanel <- function(...,
                        id = NULL,
                        selected = NULL,
                        type = c("tabs", "pills", "hidden"),
                        .list = NULL) {
  dots <- rlang::list2(...)
  tabset_items <- .list %||% dots

  shiny::tabsetPanel(
    !!!tabset_items,
    id = id,
    selected = selected,
    type = match.arg(type)
  )
}

#' Dashboard footer
#'
#' @param left Left-side footer content.
#' @param right Right-side footer content.
#' @param fixed Whether to mark footer as fixed.
#'
#' @examples
#' dashboardFooter(
#'   left = "Copyright (c) 2026",
#'   right = "Contact: team@example.org"
#' )
#'
#' @rdname dashboardFooter
#' @export
dashboardFooter <- function(left = NULL, right = NULL, fixed = FALSE) {
  footer <- app_footer(
    copyright = left,
    contact = right,
    class = "main-footer app-footer"
  )
  if (is.null(footer)) {
    return(NULL)
  }
  htmltools::tagAppendAttributes(
    footer,
    `data-fixed` = tolower(as.character(isTRUE(fixed)))
  )
}

#' Dashboard navbar
#'
#' @rdname dashboardHeader
#' @param ... Header UI elements rendered on the right side. For migration
#'   compatibility, a first unnamed scalar string is treated as `title` when
#'   `title` is `NULL`.
#' @param title Dashboard title.
#' @param rightUi Additional right-side UI content. This is equivalent to
#'   passing content through `...`, and is kept for bs4Dash-style compatibility.
#' @param sidebarIcon Icon of the main sidebar toggle.
#' @param disable Whether to disable and omit the header. When `TRUE`,
#'   [dashboardPage()] renders without a header bar and the body occupies
#'   the freed vertical space.
#' @param .list Optional list of right-side header UI elements, merged with
#'   `...`.
#'
#' @examples
#' dashboardHeader(
#'   title = "Operations",
#'   rightUi = dropdownMenu(
#'     type = "notifications",
#'     notificationItem("Server restarted", status = "info")
#'   )
#' )
#'
#' @export
dashboardHeader <- function(...,
                            title = NULL,
                            rightUi = NULL,
                            sidebarIcon = icon("bars"),
                            disable = FALSE,
                            .list = NULL) {
  if (isTRUE(disable)) {
    return(NULL)
  }

  dots <- c(rlang::list2(...), .list)
  dot_names <- names(dots) %||% rep("", length(dots))
  first_unnamed <- which(!nzchar(dot_names))[1]

  if (is.null(title) && length(dots) > 0 && !is.na(first_unnamed)) {
    title_candidate <- dots[[first_unnamed]]
    if (is.character(title_candidate) && length(title_candidate) == 1 && !is.na(title_candidate)) {
      title <- title_candidate
      dots <- dots[-first_unnamed]
    }
  }

  title_text <- title %||% "bslibdash"
  right_items <- Filter(Negate(is.null), c(dots, list(rightUi)))

  header_tag <- htmltools::tags$nav(
    class = "app-header",
    htmltools::tags$div(
      class = "app-header-inner",
      htmltools::tags$div(
        class = "app-header-content container-fluid d-flex align-items-center px-4",
        htmltools::tags$div(
          class = "d-flex align-items-center gap-3",
          htmltools::tags$button(
            id = "sidebarToggle",
            type = "button",
            class = "btn btn-link app-header-burger p-0",
            `aria-label` = "Toggle sidebar",
            sidebarIcon
          ),
          htmltools::tags$div(
            class = "bslib-page-title navbar-brand d-flex p-0 mb-0 text-light",
            htmltools::tags$h3(class = "mb-0", title_text)
          )
        ),
        htmltools::tags$div(
          class = "d-flex align-items-center ms-auto",
          htmltools::tags$div(do.call(htmltools::tagList, right_items))
        )
      )
    )
  )

  attr(header_tag, "bslibdash_header_title_default") <- is.null(title)
  header_tag
}
