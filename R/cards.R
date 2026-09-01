#' Create a card
#'
#' @param ... Contents of the card.
#' @param title Optional title.
#' @param footer Optional footer.
#' @param status Bootstrap status color applied to the **card header** background.
#'   Accepted values are Bootstrap semantic names: `"primary"`, `"secondary"`,
#'   `"success"`, `"info"`, `"warning"`, `"danger"`, `"light"`, `"dark"`.
#'   Unlike [valueBox()] and [infoBox()], legacy `shinydashboard` color names
#'   (e.g. `"aqua"`, `"blue"`) are **not** supported here.
#' @param background Bootstrap status color applied to the **entire card**
#'   background. Accepts the same values as `status`. When set, the full card
#'   surface is coloured rather than just the header.
#' @param width Width of the card. An integer `1`–`12` is treated as Bootstrap
#'   grid columns and the card is automatically wrapped in `shiny::column()`,
#'   consistent with [valueBox()] and [infoBox()]. Any other value (e.g.
#'   `"300px"`) is applied as an inline CSS `width`. Use `NULL` when placing
#'   the card inside an existing column or a `boxLayout()`.
#' @param height Card height.
#' @param collapsible Whether the card body can collapse.
#' @param collapsed Whether the card starts collapsed.
#' @param closable Whether the card can be hidden.
#' @param maximizable Whether the card can be displayed full-screen.
#' @param icon Header icon tag or icon name.
#' @param label Header label content.
#' @param id Optional card id. Use to target the card with [updateBox()].
#'   Provide distinct ids when rendering otherwise-identical cards on the same page.
#'
#' @examples
#' box(
#'   "Card body",
#'   title = "Status",
#'   status = "primary",
#'   id = "status_box"
#' )
#'
#' boxLayout(
#'   box("A", title = "Card A"),
#'   box("B", title = "Card B"),
#'   type = "deck"
#' )
#'
#' if (interactive()) {
#' shiny::shinyApp(
#'   ui = bslib::page_fluid(
#'     shiny::actionButton("toggle", "Toggle card"),
#'     box("Card body", title = "Status", id = "status_box")
#'   ),
#'   server = function(input, output, session) {
#'     shiny::observeEvent(input$toggle, {
#'       updateBox("status_box", action = "toggle", session = session)
#'     })
#'   }
#' )
#' }
#'
#' @rdname box
#' @family cards
#' @export
box <- function(...,
                title = NULL,
                footer = NULL,
                status = NULL,
                background = NULL,
                width = 6,
                height = NULL,
                collapsible = FALSE,
                collapsed = FALSE,
                closable = FALSE,
                maximizable = FALSE,
                icon = NULL,
                label = NULL,
                id = NULL) {
  if (!is.null(status)) validateStatus(status)
  if (!is.null(background)) validateStatus(background)

  # Determine if width is a Bootstrap grid integer (1–12)
  is_grid_width <- is.numeric(width) && isTRUE(width %in% 1:12)

  main_body <- shiny::tagList(...)
  collapse_key <- hash_id(
    title = title,
    footer = footer,
    status = status,
    background = background,
    width = width,
    height = height,
    collapsible = collapsible,
    collapsed = collapsed,
    closable = closable,
    maximizable = maximizable,
    icon = icon,
    label = label,
    id = id,
    body = main_body
  )
  card_class <- glue::glue("card-collapse-{collapse_key}")
  body_id <- glue::glue("{card_class}-body")
  footer_id <- if (!is.null(footer)) glue::glue("{card_class}-footer") else NULL
  show_class <- if (isTRUE(collapsed)) "" else "show"
  collapse_class <- if (isTRUE(collapsible)) glue::glue("collapse {card_class} {show_class}")
  aria_controls <- paste(c(body_id, footer_id), collapse = " ")

  card_content <- shiny::tagList(
    bslib::card_header(
      htmltools::tags$div(
        class = "d-flex align-items-center gap-2",
        icon_or_tag(icon),
        htmltools::tags$span(title),
        label
      ),
      htmltools::tags$div(
        class = "ms-auto d-flex align-items-center",
        if (isTRUE(closable)) {
          htmltools::tags$button(
            class = "btn btn-tool btn-primary card-hide-toggle",
            type = "button",
            bslibdash::icon("xmark", class = "btn-tool-icon")
          )
        },
        if (isTRUE(collapsible)) {
          htmltools::tags$button(
            bslibdash::icon("chevron-down", class = "card-toggle-icon btn-tool-icon"),
            type = "button",
            class = "btn btn-tool btn-primary card-toggle-btn",
            class = if (isTRUE(collapsed)) "collapsed",
            `data-bs-target` = glue::glue(".{card_class}"),
            `aria-expanded` = if (isTRUE(collapsed)) "false" else "true",
            `aria-controls` = aria_controls,
            `data-bs-toggle` = "collapse"
          )
        },
        if (isTRUE(maximizable)) {
          htmltools::tags$button(
            class = "btn btn-tool btn-primary fullscreen-toggle",
            type = "button",
            bslibdash::icon("fullscreen", class = "btn-tool-icon")
          )
        }
      ),
      class = if (!is.null(status)) glue::glue("bg-{status}")
    ),
    bslib::card_body(
      class = collapse_class,
      id = body_id,
      fill = FALSE,
      fillable = FALSE,
      !!!main_body
    ),
    if (!is.null(footer)) {
      bslib::card_footer(
        class = collapse_class,
        id = footer_id,
        footer
      )
    }
  )

  ui_card <- bslib::card(
    !!!card_content,
    fill = FALSE,
    full_screen = maximizable,
    height = css_unit(height),
    id = id,
    style = if (!is_grid_width) htmltools::css(width = width_unit(width)),
    class = paste(
      if (!is.null(background)) glue::glue("bg-{background}") else "",
      if (isTRUE(maximizable)) "fullscreen-card" else ""
    )
  )

  result <- htmltools::attachDependencies(
    ui_card,
    list(
      bslibdash_core_dependency(),
      bslibdash_component_dependency(
        name   = "card",
        scss   = "card.scss",
        script = "bslib_card.js"
      )
    ),
    append = TRUE
  )

  # Wrap in Bootstrap column when width is a grid integer — mirrors shinydashboard
  # behaviour and aligns with infoBox()/valueBox().
  if (is_grid_width) {
    shiny::column(width, result)
  } else {
    result
  }
}

#' Container for cards
#'
#' @param ... Slot for `box()`.
#' @param .list Optional list of cards.
#' @param type Layout type. One of:
#'   - `"group"`: Bootstrap `.card-group` — flex row with no gaps, merged borders,
#'     and equal-height columns.
#'   - `"deck"`: Bootstrap 5 grid cards — responsive row with gutters and equal
#'     heights per row (`.row.row-cols-*` + `.h-100`). Replaces the removed
#'     `.card-deck` from Bootstrap 4.
#'   - `"columns"`: **Deprecated.** Bootstrap 5 removed `.card-columns`. A
#'     `bslib::layout_column_wrap()` fallback is used, but prefer calling
#'     `bslib::layout_column_wrap()` directly for new code.
#'
#' @examples
#' boxLayout(
#'   box("Revenue", title = "KPI"),
#'   box("Trend", title = "Chart"),
#'   type = "deck"
#' )
#' @family cards
#' @export
#' @rdname boxLayout
boxLayout <- function(..., .list = NULL, type = c("group", "deck", "columns")) {
  type <- rlang::arg_match(type)
  cards <- c(list(...), .list)

  switch(type,
    group = {
      # Bootstrap 5 .card-group: flex row, zero gaps, merged borders, equal heights.
      htmltools::div(class = "card-group", !!!cards)
    },
    deck = {
      # Bootstrap 5 "Grid cards" pattern — replaces the removed .card-deck.
      # Each card is wrapped in a .col and gets .h-100 so all cards in a row
      # share the height of the tallest one. Footers line up automatically.
      # Responsive: 1 col → 2 cols (md) → 3 cols (lg).
      col_cards <- lapply(cards, function(card) {
        htmltools::div(
          class = "col",
          htmltools::tagAppendAttributes(card, class = "h-100")
        )
      })
      htmltools::div(
        class = "row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4",
        !!!col_cards
      )
    },
    columns = {
      # Deprecated: Bootstrap 5 removed .card-columns entirely.
      # The recommended replacement (Masonry plugin) requires JavaScript.
      # We fall back to layout_column_wrap() as a no-JS CSS Grid approximation,
      # but users should migrate to bslib::layout_column_wrap() directly.
      warning(
        "boxLayout(type = \"columns\") is deprecated. ",
        "Bootstrap 5 removed .card-columns (see https://getbootstrap.com/docs/5.2/components/card/#masonry). ",
        "Use bslib::layout_column_wrap() directly instead.",
        call. = FALSE
      )
      bslib::layout_column_wrap(
        width = "300px",
        fillable = FALSE,
        fill = FALSE,
        !!!cards
      )
    }
  )
}

#' Update a card from the server side
#'
#' @param id Id of the card created with [box()].
#' @param action Action to trigger.
#' @param options List of new options for `action = "update"`.
#' @param session Shiny session.
#' @rdname box
#' @export
updateBox <- function(id,
                      action = c("remove", "toggle", "update", "restore", "toggleMaximize"),
                      options = NULL,
                      session = shiny::getDefaultReactiveDomain()) {
  action <- rlang::arg_match(action)
  ns_id <- session$ns(id)
  card_selector <- glue::glue("#{ns_id}")

  if (identical(action, "remove")) {
    shinyjs::runjs(glue::glue("$('{card_selector}').addClass('d-none');"))
    return(invisible())
  }

  if (identical(action, "restore")) {
    shinyjs::runjs(glue::glue("$('{card_selector}').removeClass('d-none');"))
    return(invisible())
  }

  if (identical(action, "toggle")) {
    shinyjs::runjs(glue::glue("$('{card_selector} .card-toggle-btn').first().trigger('click');"))
    return(invisible())
  }

  if (identical(action, "toggleMaximize")) {
    shinyjs::runjs(glue::glue("$('{card_selector} .fullscreen-toggle').first().trigger('click');"))
    return(invisible())
  }

  options <- options %||% list()
  title_selector <- glue::glue("#{ns_id} .card-header")

  if (!is.null(options$status)) {
    validateStatus(options$status)
    shinyjs::runjs(glue::glue("
      $('{title_selector}').removeClass(function (_, className) {{
        return className.split(' ').filter(c => c.startsWith('bg-')).join(' ');
      }}).addClass('bg-{options$status}');
    "))
  }

  if (!is.null(options$background)) {
    validateStatus(options$background)
    shinyjs::runjs(glue::glue("
      $('{card_selector}').removeClass(function (_, className) {{
        return className.split(' ').filter(c => c.startsWith('bg-')).join(' ');
      }}).addClass('bg-{options$background}');
    "))
  }

  if (!is.null(options$title)) {
    title <- htmltools::htmlEscape(as.character(options$title))
    shinyjs::runjs(glue::glue("$('{title_selector} .card-title, {title_selector} span').first().text('{title}');"))
  }

  if (!is.null(options$width)) {
    shinyjs::runjs(glue::glue("$('{card_selector}').css('width', '{width_unit(options$width)}');"))
  }

  if (!is.null(options$height)) {
    shinyjs::runjs(glue::glue("$('{card_selector}').css('height', '{css_unit(options$height)}');"))
  }

  invisible()
}
