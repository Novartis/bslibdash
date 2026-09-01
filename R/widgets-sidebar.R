#' Create a search form to place in a sidebar
#'
#' A search form consists of a text input field and a search button.
#'
#' @param textId Shiny input ID for the text input box.
#' @param buttonId Shiny input ID for the search button.
#' @param label Text label to display inside the search box.
#' @param icon An icon tag, created by [shiny::icon()] or [icon()].
#'
#' @examples
#' sidebarSearchForm(
#'   textId = "sidebar_search",
#'   buttonId = "sidebar_search_btn",
#'   label = "Search records..."
#' )
#'
#' @rdname sidebarSearchForm
#' @export
sidebarSearchForm <- function(textId,
                              buttonId,
                              label = "Search...",
                              icon = shiny::icon("search")) {
  icon_tag <- icon_or_tag(icon)
  button <- shiny::actionButton(
    inputId = buttonId,
    label = NULL,
    icon = NULL,
    class = "btn-outline-secondary bslibdash-sidebar-search-button"
  ) |>
    htmltools::tagAppendAttributes(`aria-label` = label)

  if (!is.null(icon_tag)) {
    button <- htmltools::tagInsertChildren(button, icon_tag, after = 0)
  }

  htmltools::tags$form(
    class = "sidebar-form bslibdash-sidebar-search-form",
    role = "search",
    onsubmit = "return false;",
    htmltools::tags$div(
      class = "input-group input-group-sm",
      htmltools::tags$input(
        id = textId,
        type = "text",
        class = "form-control bslibdash-sidebar-search-input",
        placeholder = label,
        `aria-label` = label
      ),
      button
    )
  )
}

#' Sidebar menu item output
#'
#' @param outputId Output variable name.
#'
#' @examples
#' menuItemOutput("dynamic_menu_item")
#'
#' @rdname menuItemOutput
#' @export
menuItemOutput <- function(outputId) {
  shiny::uiOutput(
    outputId = outputId,
    container = htmltools::tags$div,
    class = "bslibdash-menu-item-output"
  )
}

#' Sidebar menu output
#'
#' @param outputId Output variable name.
#'
#' @examples
#' sidebarMenuOutput("dynamic_sidebar_menu")
#'
#' @rdname sidebarMenuOutput
#' @export
sidebarMenuOutput <- function(outputId) {
  shiny::uiOutput(
    outputId = outputId,
    container = htmltools::tags$div,
    class = "bslibdash-sidebar-menu-output"
  )
}

#' Render a sidebar menu element
#'
#' @param expr An expression that returns a `menuItem()` or `sidebarMenu()` tag.
#' @param env The parent environment for the reactive expression.
#' @param quoted Is `expr` a quoted expression.
#'
#' @examples
#' if (interactive()) {
#' shiny::shinyApp(
#'   ui = bslib::page_fluid(menuItemOutput("dynamic_menu_item")),
#'   server = function(input, output, session) {
#'     output$dynamic_menu_item <- renderMenu({
#'       menuItem("Overview", tabName = "overview", icon = icon("house"))
#'     })
#'   }
#' )
#' }
#'
#' @rdname renderMenu
#' @export
renderMenu <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }

  shiny::renderUI(expr, env = env, quoted = TRUE)
}

#' Update the selected sidebar tab item
#'
#' This updates the hidden body tabset used by [tabItems()] and keeps the
#' sidebar active item synchronized with the selected tab.
#'
#' @param session Shiny session.
#' @param inputId The shared `id` used for `sidebarMenu(id)`, `tabItems(id)`,
#'   and `updateTabItems(inputId)`. All three must use the same value.
#' @param selected Name of the tab to select.
#'
#' @examples
#' if (interactive()) {
#' shiny::shinyApp(
#'   ui = dashboardPage(
#'     header = dashboardHeader(title = "Demo"),
#'     sidebar = dashboardSidebar(
#'       sidebarMenu(
#'         id = "sidebarMenu",
#'         menuItem("Overview", tabName = "overview"),
#'         menuItem("Reports", tabName = "reports")
#'       )
#'     ),
#'     body = dashboardBody(
#'       shiny::actionButton("go_reports", "Go to reports"),
#'       tabItems(
#'         tabItem(tabName = "overview", shiny::h2("Overview")),
#'         tabItem(tabName = "reports", shiny::h2("Reports"))
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     shiny::observeEvent(input$go_reports, {
#'       updateTabItems(session, inputId = "sidebarMenu", selected = "reports")
#'     })
#'   }
#' )
#' }
#'
#' @rdname updateTabItems
#' @export
updateTabItems <- function(session = shiny::getDefaultReactiveDomain(),
                           inputId,
                           selected = NULL) {
  if (is.null(session)) {
    stop("updateTabItems() must be called from within a Shiny session.", call. = FALSE)
  }

  inputId <- as.character(inputId)
  if (length(inputId) != 1 || !nzchar(inputId)) {
    stop("`inputId` must be a single non-empty string.", call. = FALSE)
  }

  if (!is.null(selected)) {
    selected <- as.character(selected)
    if (length(selected) != 1 || !nzchar(selected)) {
      stop("`selected` must be NULL or a single non-empty string.", call. = FALSE)
    }
  }

  shiny::updateTabsetPanel(session = session, inputId = inputId, selected = selected)

  session$sendCustomMessage(
    type = "bslibdash-update-tab-items",
    message = list(
      menuId = session$ns(inputId),
      tabsetId = session$ns(inputId),
      selected = selected
    )
  )

  invisible()
}
