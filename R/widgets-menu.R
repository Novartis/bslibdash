#' Dropdown menu
#'
#' @param ... Menu item tags such as `messageItem()`, `notificationItem()`, or
#'   `taskItem()`.
#' @param type Dropdown menu type. One of `"messages"`, `"notifications"`, or
#'   `"tasks"`.
#' @param badgeStatus Bootstrap status color used for the badge count.
#' @param icon Optional custom icon tag.
#' @param headerText Optional text shown at the top of the dropdown panel.
#' @param .list Optional list of menu item tags.
#' @param href Optional URL for the "More" footer link.
#'
#' @examples
#' dropdownMenu(
#'   type = "notifications",
#'   badgeStatus = "warning",
#'   notificationItem("Backup completed", status = "success"),
#'   notificationItem("New deployment", status = "info")
#' )
#'
#' @rdname dropdownMenu
#' @export
dropdownMenu <- function(...,
                         type = c("messages", "notifications", "tasks"),
                         badgeStatus = "primary",
                         icon = NULL,
                         headerText = NULL,
                         .list = NULL,
                         href = NULL) {
  type <- match.arg(type)
  if (!is.null(badgeStatus)) {
    validateStatus(badgeStatus)
  }

  items <- c(list(...), .list)
  num_items <- length(items)

  if (is.null(icon)) {
    icon <- switch(
      type,
      messages = bslibdash::icon("comments"),
      notifications = bslibdash::icon("bell"),
      tasks = bslibdash::icon("tasks")
    )
  }

  if (is.null(headerText)) {
    headerText <- sprintf("You have %s %s", num_items, type)
  }

  badge <- if (is.null(badgeStatus)) {
    NULL
  } else {
    htmltools::tags$span(
      class = paste("badge rounded-pill bslibdash-dropdown-badge", paste0("bg-", badgeStatus)),
      num_items
    )
  }

  htmltools::tags$div(
    class = paste("nav-item dropdown bslibdash-dropdown-menu", paste0("bslibdash-dropdown-menu-", type)),
    htmltools::tags$a(
      class = "nav-link px-2 py-1 bslibdash-dropdown-toggle",
      href = "#",
      role = "button",
      `data-bs-toggle` = "dropdown",
      `aria-expanded` = "false",
      icon_or_tag(icon),
      badge
    ),
    htmltools::tags$div(
      class = "dropdown-menu dropdown-menu-end shadow-sm bslibdash-dropdown-menu-panel",
      htmltools::tags$span(
        class = "dropdown-item dropdown-header bslibdash-dropdown-header",
        headerText
      ),
      htmltools::tags$div(class = "dropdown-divider"),
      items,
      if (!is.null(href)) {
        htmltools::tags$a(
          class = "dropdown-item dropdown-footer text-center",
          href = href,
          target = "_blank",
          rel = "noopener noreferrer",
          "More"
        )
      }
    )
  ) |>
    htmltools::attachDependencies(
      list(
        bslibdash_core_dependency(),
        bslibdash_component_dependency(
          name = "dropdown-menu",
          scss = "dropdown-menu.scss"
        )
      ),
      append = TRUE
    )
}

#' Message item
#'
#' @param from Who the message is from.
#' @param message Text of the message.
#' @param time Optional message timestamp text.
#' @param image Optional user image URL.
#' @param color Bootstrap status color used for item accents.
#' @param inputId Optional id to make the item behave like an action button.
#'
#' @examples
#' messageItem(
#'   from = "Ops bot",
#'   message = "Deployment finished successfully.",
#'   time = "5 mins ago",
#'   color = "success"
#' )
#'
#' @rdname dropdownMenu
#' @export
messageItem <- function(from,
                        message,
                        icon = shiny::icon("user"),
                        time = NULL,
                        href = NULL,
                        image = NULL,
                        color = "secondary",
                        inputId = NULL) {
  if (!is.null(color)) {
    validateStatus(color)
  }

  link_class <- "dropdown-item bslibdash-dropdown-item"
  if (!is.null(inputId)) {
    link_class <- paste(link_class, "action-button")
  }

  htmltools::tagList(
    htmltools::tags$a(
      class = link_class,
      id = inputId,
      href = dropdown_menu_link_href(href, inputId),
      target = dropdown_menu_link_target(href, inputId),
      rel = dropdown_menu_link_rel(href, inputId),
      htmltools::tags$div(
        class = "d-flex align-items-start gap-2 bslibdash-dropdown-message",
        if (!is.null(image)) {
          htmltools::tags$img(
            src = image,
            alt = "User avatar",
            class = "rounded-circle flex-shrink-0 bslibdash-dropdown-message-image"
          )
        },
        htmltools::tags$div(
          class = "flex-grow-1",
          htmltools::tags$div(
            class = "d-flex align-items-center justify-content-between gap-2",
            htmltools::tags$span(class = "fw-semibold bslibdash-dropdown-item-title", from),
            htmltools::tags$span(
              class = if (!is.null(color)) paste("text-", color, sep = "") else NULL,
              icon_or_tag(icon)
            )
          ),
          htmltools::tags$p(class = "mb-1 small text-body-secondary", message),
          if (!is.null(time)) {
            htmltools::tags$p(
              class = "mb-0 small text-muted",
              bslibdash::icon("clock"),
              htmltools::tags$span(class = "ms-1", time)
            )
          }
        )
      )
    ),
    htmltools::tags$div(class = "dropdown-divider")
  )
}

#' Notification item
#'
#' @param text Item text.
#' @param status Bootstrap status color used for the icon.
#'
#' @examples
#' notificationItem(
#'   text = "3 new alerts",
#'   status = "danger"
#' )
#'
#' @rdname dropdownMenu
#' @export
notificationItem <- function(text,
                             icon = bslibdash::icon("exclamation-triangle"),
                             status = "success",
                             href = NULL,
                             inputId = NULL) {
  if (!is.null(status)) {
    validateStatus(status)
  }

  link_class <- "dropdown-item bslibdash-dropdown-item d-flex align-items-center gap-2"
  if (!is.null(inputId)) {
    link_class <- paste(link_class, "action-button")
  }

  htmltools::tagList(
    htmltools::tags$a(
      class = link_class,
      id = inputId,
      href = dropdown_menu_link_href(href, inputId),
      target = dropdown_menu_link_target(href, inputId),
      rel = dropdown_menu_link_rel(href, inputId),
      htmltools::tags$span(
        class = if (!is.null(status)) paste("text-", status, sep = "") else NULL,
        icon_or_tag(icon)
      ),
      htmltools::tags$span(text)
    ),
    htmltools::tags$div(class = "dropdown-divider")
  )
}

#' Task item
#'
#' @param text Item text.
#' @param value Percent completion value.
#' @param color Bootstrap status color used for item accents.
#'
#' @examples
#' taskItem(
#'   text = "Data refresh",
#'   value = 75,
#'   color = "info"
#' )
#'
#' @rdname dropdownMenu
#' @export
taskItem <- function(text, value = 0, color = "info", href = NULL, inputId = NULL) {
  validateStatus(color)
  if (!is.numeric(value) || length(value) != 1 || is.na(value)) {
    stop("`value` must be a single numeric percentage.", call. = FALSE)
  }

  link_class <- "dropdown-item bslibdash-dropdown-item"
  if (!is.null(inputId)) {
    link_class <- paste(link_class, "action-button")
  }

  htmltools::tagList(
    htmltools::tags$a(
      class = link_class,
      id = inputId,
      href = dropdown_menu_link_href(href, inputId),
      target = dropdown_menu_link_target(href, inputId),
      rel = dropdown_menu_link_rel(href, inputId),
      htmltools::tags$div(
        class = "d-flex justify-content-between align-items-center small mb-1",
        htmltools::tags$span(text),
        htmltools::tags$span(sprintf("%s%%", value))
      ),
      htmltools::tags$div(
        class = "progress bslibdash-dropdown-task-progress",
        role = "progressbar",
        `aria-valuenow` = value,
        `aria-valuemin` = "0",
        `aria-valuemax` = "100",
        htmltools::tags$div(
          class = paste("progress-bar", paste0("bg-", color)),
          style = htmltools::css(width = sprintf("%s%%", value))
        )
      )
    ),
    htmltools::tags$div(class = "dropdown-divider")
  )
}

#' Dropdown menu output
#'
#' @param outputId Output variable name.
#'
#' @examples
#' dropdownMenuOutput("alerts_menu")
#'
#' @rdname dropdownMenuOutput
#' @export
dropdownMenuOutput <- function(outputId) {
  shiny::uiOutput(
    outputId = outputId,
    container = htmltools::tags$div,
    class = "d-inline-block bslibdash-dropdown-menu-output"
  )
}

#' Render a dropdown menu
#'
#' @param expr An expression that returns a dropdown menu tag.
#' @param env The parent environment for the reactive expression.
#' @param quoted Is `expr` a quoted expression.
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(
#'   ui = bslib::page_fluid(dropdownMenuOutput("alerts_menu")),
#'   server = function(input, output, session) {
#'     output$alerts_menu <- renderDropdownMenu({
#'       dropdownMenu(
#'         type = "notifications",
#'         notificationItem("Job finished", status = "success")
#'       )
#'     })
#'   }
#' )
#' }
#'
#' @rdname renderDropdownMenu
#' @export
renderDropdownMenu <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }

  shiny::renderUI(expr, env = env, quoted = TRUE)
}

dropdown_menu_link_href <- function(href, inputId) {
  if (!is.null(inputId)) {
    return("#")
  }

  href %||% "#"
}

dropdown_menu_link_target <- function(href, inputId) {
  if (!is.null(inputId) || is.null(href)) {
    return(NULL)
  }

  "_blank"
}

dropdown_menu_link_rel <- function(href, inputId) {
  if (!is.null(inputId) || is.null(href)) {
    return(NULL)
  }

  "noopener noreferrer"
}
