#' Value box
#'
#' @param value The value to display in the box.
#' @param subtitle Subtitle text.
#' @param icon An icon tag, created by [shiny::icon()] or [icon()].
#' @param color Box color. Supports both legacy `shinydashboard` color names
#'   (e.g. `"aqua"`, `"light-blue"`, `"fuchsia"`) and Bootstrap semantic names
#'   (`"primary"`, `"success"`, `"warning"`, etc.). Legacy names are mapped to
#'   fixed hex values; Bootstrap names reference CSS theme variables so they
#'   follow the active theme. A contrasting foreground color is computed
#'   automatically. Note: [box()] uses a simpler `status` parameter that only
#'   accepts Bootstrap semantic names and applies them as utility classes.
#' @param width The width of the box in Bootstrap grid columns (`1`-`12`).
#'   Use `NULL` when placing the box inside an existing column.
#' @param href Optional URL to link to.
#'
#' @examples
#' valueBox(
#'   value = "128",
#'   subtitle = "Open tickets",
#'   icon = icon("inbox"),
#'   color = "primary"
#' )
#'
#' @rdname valueBox
#' @export
valueBox <- function(value,
                     subtitle,
                     icon = NULL,
                     color = "aqua",
                     width = 4,
                     href = NULL) {
  color_info <- resolve_value_box_color(color)
  showcase <- icon_or_tag(icon)
  showcase_layout <- if (is.null(showcase)) "left center" else "top right"

  box <- bslib::value_box(
    title = subtitle,
    value = value,
    showcase = showcase,
    showcase_layout = showcase_layout,
    theme = bslib::value_box_theme(
      bg = color_info$bg,
      fg = color_info$fg
    ),
    class = "bslibdash-value-box"
  )

  box <- htmltools::attachDependencies(
    box,
    list(
      bslibdash_core_dependency(),
      bslibdash_component_dependency(
        name = "value-box",
        scss = "value-box.scss"
      )
    ),
    append = TRUE
  )

  if (!is.null(href)) {
    box <- htmltools::tags$a(
      href = href,
      class = "text-decoration-none d-block bslibdash-value-box-link",
      box
    )
  }

  if (is.null(width)) {
    box
  } else {
    shiny::column(width = width, box)
  }
}

#' Value box output
#'
#' @param outputId Output variable name.
#' @param width The width of the box in Bootstrap grid columns (`1`-`12`).
#'   Use `NULL` when placing the output inside an existing column.
#'
#' @examples
#' valueBoxOutput("tickets")
#'
#' @rdname valueBoxOutput
#' @export
valueBoxOutput <- function(outputId, width = 4) {
  output_ui <- shiny::uiOutput(outputId)

  if (is.null(width)) {
    output_ui
  } else {
    shiny::column(width = width, output_ui)
  }
}

#' Render a value box
#'
#' @param expr An expression that returns a value box tag.
#' @param env The parent environment for the reactive expression.
#' @param quoted Is `expr` a quoted expression.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(
#'   ui = bslib::page_fluid(valueBoxOutput("tickets")),
#'   server = function(input, output, session) {
#'     output$tickets <- renderValueBox({
#'       valueBox("128", "Open tickets", icon = icon("inbox"), color = "primary")
#'     })
#'   }
#' )
#' }
#'
#' @rdname renderValueBox
#' @export
renderValueBox <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }

  shiny::renderUI(expr, env = env, quoted = TRUE)
}

#' Info box
#'
#' @param title Box title.
#' @param value Value text.
#' @param subtitle Optional subtitle text.
#' @param icon An icon tag, created by [shiny::icon()] or [icon()].
#' @param color Box color. Supports both legacy `shinydashboard` color names
#'   (e.g. `"aqua"`, `"light-blue"`, `"fuchsia"`) and Bootstrap semantic names
#'   (`"primary"`, `"success"`, `"warning"`, etc.). Legacy names are mapped to
#'   fixed hex values; Bootstrap names reference CSS theme variables so they
#'   follow the active theme. A contrasting foreground color is computed
#'   automatically. Note: [box()] uses a simpler `status` parameter that only
#'   accepts Bootstrap semantic names and applies them as utility classes.
#' @param width The width of the box in Bootstrap grid columns (`1`-`12`).
#'   Use `NULL` when placing the box inside an existing column.
#' @param href Optional URL to link to.
#' @param fill Whether to fill the entire box background with `color`.
#'
#' @examples
#' infoBox(
#'   title = "CPU",
#'   value = "42%",
#'   subtitle = "Current usage",
#'   icon = icon("cpu"),
#'   color = "success"
#' )
#'
#' @rdname infoBox
#' @export
infoBox <- function(title,
                    value = NULL,
                    subtitle = NULL,
                    icon = shiny::icon("bar-chart"),
                    color = "aqua",
                    width = 4,
                    href = NULL,
                    fill = FALSE) {
  color_info <- resolve_value_box_color(color)
  icon_tag <- icon_or_tag(icon)

  box <- htmltools::tags$div(
    class = "card bslib-card bslibdash-info-box mb-3",
    class = if (isTRUE(fill)) "bslibdash-info-box-fill",
    style = htmltools::css(
      `--bslibdash-info-box-accent` = color_info$bg,
      `--bslibdash-info-box-accent-fg` = color_info$fg
    ),
    htmltools::tags$div(
      class = "card-body",
      htmltools::tags$div(
        class = "bslibdash-info-box-inner",
        class = if (is.null(icon_tag)) "bslibdash-info-box-no-icon",
        if (!is.null(icon_tag)) {
          htmltools::tags$div(class = "bslibdash-info-box-icon", icon_tag)
        },
        htmltools::tags$div(
          class = "bslibdash-info-box-content",
          htmltools::tags$p(class = "bslibdash-info-box-text", title),
          if (!is.null(value)) htmltools::tags$p(class = "bslibdash-info-box-number", value),
          if (!is.null(subtitle)) htmltools::tags$p(class = "bslibdash-info-box-subtitle", subtitle)
        )
      )
    )
  )

  box <- htmltools::attachDependencies(
    box,
    list(
      bslibdash_core_dependency(),
      bslibdash_component_dependency(
        name = "info-box",
        scss = "info-box.scss"
      )
    ),
    append = TRUE
  )

  if (!is.null(href)) {
    box <- htmltools::tags$a(
      href = href,
      class = "text-decoration-none d-block bslibdash-info-box-link",
      box
    )
  }

  if (is.null(width)) {
    box
  } else {
    shiny::column(width = width, box)
  }
}

#' Info box output
#'
#' @param outputId Output variable name.
#' @param width The width of the box in Bootstrap grid columns (`1`-`12`).
#'   Use `NULL` when placing the output inside an existing column.
#'
#' @examples
#' infoBoxOutput("system_status")
#'
#' @rdname infoBoxOutput
#' @export
infoBoxOutput <- function(outputId, width = 4) {
  output_ui <- shiny::uiOutput(outputId)

  if (is.null(width)) {
    output_ui
  } else {
    shiny::column(width = width, output_ui)
  }
}

#' Render an info box
#'
#' @param expr An expression that returns an info box tag.
#' @param env The parent environment for the reactive expression.
#' @param quoted Is `expr` a quoted expression.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(
#'   ui = bslib::page_fluid(infoBoxOutput("system_status")),
#'   server = function(input, output, session) {
#'     output$system_status <- renderInfoBox({
#'       infoBox("CPU", "42%", icon = icon("cpu"), color = "success")
#'     })
#'   }
#' )
#' }
#'
#' @rdname renderInfoBox
#' @export
renderInfoBox <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }

  shiny::renderUI(expr, env = env, quoted = TRUE)
}

#' Tab box
#'
#' @param ... [shiny::tabPanel()] elements to include in the tab box.
#' @param id Input id for the tabset.
#' @param selected The tab value selected on initial load.
#' @param title Optional title shown in the tab box header.
#' @param width The width of the box in Bootstrap grid columns (`1`-`12`).
#'   Use `NULL` when placing the box inside an existing column.
#' @param height Optional CSS height value passed to
#'   [bslib::navset_card_tab()].
#' @param side Whether to place tabs on the `"left"` or `"right"` side of the
#'   header.
#'
#' @examples
#' # Basic tab box with a title in the card header
#' tabBox(
#'   id = "quarterly",
#'   title = "Quarterly summary",
#'   shiny::tabPanel("Q1", shiny::p("Q1 content")),
#'   shiny::tabPanel("Q2", shiny::p("Q2 content"))
#' )
#'
#' # Pre-select a tab and fix the card height (content scrolls inside)
#' tabBox(
#'   selected = "Q2",
#'   height   = "200px",
#'   shiny::tabPanel("Q1", shiny::p("Q1 content")),
#'   shiny::tabPanel("Q2", shiny::p("Q2 content"))
#' )
#'
#' @export
tabBox <- function(...,
                   id = NULL,
                   selected = NULL,
                   title = NULL,
                   width = 6,
                   height = NULL,
                   side = c("left", "right")) {
  side <- match.arg(side)

  tab_box <- bslib::navset_card_tab(
    ...,
    id = id,
    selected = selected,
    title = title,
    height = height
  )

  if (identical(side, "right")) {
    tab_query <- htmltools::tagQuery(tab_box)
    tab_query$find(".card-header > .nav")$addClass("bslibdash-tab-box-nav-right")$addAttrs(
      style = paste(
        "flex:0 0 auto !important",
        "min-width:auto !important",
        "margin-left:auto !important",
        "justify-content:flex-end",
        sep = ";"
      )
    )
    tab_box <- tab_query$allTags()
  }

  tab_box <- htmltools::tagAppendAttributes(
    tab_box,
    class = paste(c("bslibdash-tab-box", if (identical(side, "right")) "bslibdash-tab-box-right"), collapse = " ")
  )

  tab_box <- htmltools::attachDependencies(
    tab_box,
    list(
      bslibdash_core_dependency(),
      bslibdash_component_dependency(
        name = "tab-box",
        scss = "tab-box.scss"
      )
    ),
    append = TRUE
  )

  if (is.null(width)) {
    tab_box
  } else {
    shiny::column(width = width, tab_box)
  }
}

resolve_value_box_color <- function(color = "aqua") {
  color <- as.character(color %||% "aqua")

  color_map <- c(
    aqua = "#00c0ef",
    blue = "#0073b7",
    `light-blue` = "#3c8dbc",
    green = "#00a65a",
    navy = "#001f3f",
    teal = "#39cccc",
    olive = "#3d9970",
    lime = "#01ff70",
    yellow = "#f39c12",
    orange = "#ff851b",
    red = "#dd4b39",
    fuchsia = "#f012be",
    purple = "#605ca8",
    maroon = "#d81b60",
    black = "#111111",
    gray = "#d2d6de",
    silver = "#f4f4f4",
    primary = "var(--bs-primary)",
    secondary = "var(--bs-secondary)",
    success = "var(--bs-success)",
    info = "var(--bs-info)",
    warning = "var(--bs-warning)",
    danger = "var(--bs-danger)",
    light = "var(--bs-light)",
    dark = "var(--bs-dark)"
  )

  bg <- if (color %in% names(color_map)) color_map[[color]] else color
  fg <- resolve_value_box_fg(bg)

  list(bg = bg, fg = fg)
}

resolve_value_box_fg <- function(bg) {
  rgb <- tryCatch(
    grDevices::col2rgb(bg),
    error = function(e) NULL
  )

  if (is.null(rgb)) {
    if (identical(bg, "var(--bs-warning)") || identical(bg, "var(--bs-light)")) {
      return("#111827")
    }

    return("#FFFFFF")
  }

  brightness <- as.numeric(0.299 * rgb[1, 1] + 0.587 * rgb[2, 1] + 0.114 * rgb[3, 1])
  if (brightness > 170) "#111827" else "#FFFFFF"
}
