page_sidebar <- function(..., theme = NULL, header, sidebar, main, footer = NULL) {
  layout_style <- if (is.null(header)) {
    htmltools::css(`--app-header-height` = "0px")
  } else {
    NULL
  }

  bslib::page(
    theme = theme,
    shiny::tagList(
      header,
      htmltools::tags$div(
        class = "d-flex app-layout",
        style = layout_style,
        sidebar,
        htmltools::tags$main(
          class = "flex-grow-1 app-main d-flex flex-column",
          main,
          footer
        )
      )
    ),
    ...
  ) |>
    htmltools::attachDependencies(bslibdash_page_dependencies(), append = TRUE)
}

sidebar <- function(..., class = NULL, style = NULL) {
  htmltools::tags$aside(
    id = "sidebar",
    class = paste("app-sidebar flex-shrink-0", class),
    style = style,
    role = "navigation",
    `aria-label` = "Primary",
    `aria-hidden` = "false",
    htmltools::tags$button(
      id = "sidebarClose",
      type = "button",
      class = "app-sidebar-close",
      `aria-label` = "Close sidebar",
      htmltools::HTML("&times;")
    ),
    htmltools::tags$div(
      class = "sidebar-inner",
      ...
    )
  ) |>
    htmltools::attachDependencies(bslibdash_sidebar_dependencies(), append = TRUE)
}

sidebar_title <- function(text, icon = NULL, class = NULL) {
  htmltools::tags$div(
    class = paste("sidebar-title d-flex align-items-center gap-2", class),
    if (!is.null(icon)) icon,
    htmltools::tags$span(class = "sidebar-title-text fw-semibold", text)
  )
}

sidebar_pages <- function(..., id = "sidebarMenu", class = "content-canvas flex-grow-1") {
  pages <- list(...)

  panels <- lapply(pages, function(page) {
    tabName <- attr(page, "tabName")
    shiny::tabPanel(title = tabName, value = tabName, page)
  })

  htmltools::tags$div(
    class = class,
    do.call(
      tabsetPanel,
      c(list(id = id, type = "hidden"), panels)
    )
  )
}

sidebar_page <- function(tabName, ...) {
  stopifnot(is.character(tabName), length(tabName) == 1, nzchar(tabName))
  ui <- shiny::tagList(...)
  attr(ui, "tabName") <- tabName

  ui
}

sidebar_menu <- function(id = "sidebarMenu", ..., .list = NULL) {
  items <- c(list(...), .list)

  # Auto-mark the first nav item as active only when no item already carries
  # the active class. This preserves an explicit selected = TRUE coming from
  # menuItem() / menuSubItem() and avoids emitting two `active` items
  # (activateInitialSelections() in dash.js picks the first one and would
  # otherwise silently override the caller's choice).
  nav_to_items_index <- which(vapply(
    items,
    htmltools::tagHasAttribute,
    FUN.VALUE = logical(1),
    "data-nav-to"
  ))

  has_active_item <- function(item) {
    cls <- tryCatch(
      htmltools::tagGetAttribute(item, "class"),
      error = function(e) NULL
    )
    if (isTRUE(is.character(cls) && grepl("(^|\\s)active(\\s|$)", cls))) {
      return(TRUE)
    }
    # A nested menuItem() parent renders the active state on its
    # menuSubItem() child, not on the wrapping <div>; descend so we don't
    # auto-activate the first top-level item when the user explicitly
    # selected a deeper sub-item.
    children <- tryCatch(item$children, error = function(e) NULL)
    if (length(children) == 0L) {
      return(FALSE)
    }
    any(vapply(children, function(child) {
      if (is.list(child) && !inherits(child, "shiny.tag")) {
        any(vapply(child, has_active_item, logical(1)))
      } else {
        has_active_item(child)
      }
    }, logical(1)))
  }

  already_active <- any(vapply(items, has_active_item, logical(1)))

  if (!already_active && length(nav_to_items_index) > 0) {
    active_item_index <- min(nav_to_items_index)
    items[[active_item_index]] <- htmltools::tagAppendAttributes(
      items[[active_item_index]],
      class = "active"
    )
  }

  # Detect sidebar-title (header) items vs regular nav items.
  # Headers must live outside any <nav> so Bootstrap collapse and CSS work
  # correctly when multiple headers are present.
  is_title <- vapply(items, function(x) {
    cls <- tryCatch(htmltools::tagGetAttribute(x, "class"), error = function(e) "")
    grepl("sidebar-title", cls %||% "", fixed = TRUE)
  }, logical(1))

  # Interleave sidebar-title divs and <nav> sections so each run of nav
  # buttons sits in its own <nav>, separated by the header divs.
  result  <- list()
  nav_buf <- list()

  for (i in seq_along(items)) {
    if (is_title[[i]]) {
      if (length(nav_buf) > 0L) {
        result[[length(result) + 1L]] <- htmltools::tags$nav(
          class = "nav nav-pills flex-column",
          nav_buf
        )
        nav_buf <- list()
      }
      result[[length(result) + 1L]] <- items[[i]]
    } else {
      nav_buf[[length(nav_buf) + 1L]] <- items[[i]]
    }
  }
  if (length(nav_buf) > 0L) {
    result[[length(result) + 1L]] <- htmltools::tags$nav(
      class = "nav nav-pills flex-column",
      nav_buf
    )
  }

  htmltools::tags$div(
    class = "sidebar-nav-sections",
    `data-input-id` = id,
    `data-tabset-id` = id,
    result
  ) |>
    htmltools::attachDependencies(bslibdash_sidebar_dependencies(), append = TRUE)
}

sidebar_menu_item <- function(text, tabName, icon = NULL, active = FALSE) {
  htmltools::tags$button(
    type = "button",
    class = paste("nav-link d-flex align-items-center gap-2", if (active) "active"),
    `data-nav-to` = tabName,
    icon,
    htmltools::tags$span(class = "nav-text", text)
  )
}

sidebar_main <- function(..., footer = NULL, class = "app-main-inner") {
  htmltools::tags$div(
    class = class,
    ...,
    footer
  )
}

app_footer_copyright <- function(copyright = NULL) {
  if (is.null(copyright) || !nzchar(as.character(copyright))) {
    return(NULL)
  }

  htmltools::tags$div(
    class = "copyright",
    htmltools::HTML("<i class='far fa-copyright'></i>"),
    copyright
  )
}

app_footer_contact <- function(author = NULL,
                               email = "firstname.lastname@somewhere.com",
                               appTag = NULL) {
  if (length(author) != 1 || is.na(author) || !nzchar(author)) {
    return(NULL)
  }

  htmltools::tags$div(
    class = "contact",
    "Contact ",
    htmltools::tags$a(href = paste0("mailto:", email), author),
    " for more information. ",
    appTag
  )
}

app_footer <- function(copyright = NULL,
                       contact = NULL,
                       class = "app-footer") {
  if (is.null(copyright) && is.null(contact)) {
    return(NULL)
  }

  htmltools::tags$footer(
    class = class,
    htmltools::tags$span(class = "me-auto", copyright),
    contact
  )
}

bslibdash_sidebar_dependencies <- function() {
  list(
    bslibdash_core_dependency(),
    bslibdash_component_dependency(
      name = "sidebar",
      scss = "sidebar.scss",
      script = "dash.js"
    )
  )
}

bslibdash_page_dependencies <- function() {
  list(
    bslibdash_core_dependency(),
    bslibdash_component_dependency(
      name = "page",
      scss = "page.scss"
    )
  )
}
