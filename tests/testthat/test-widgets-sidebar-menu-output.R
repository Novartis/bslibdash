test_that("menuItemOutput() returns a uiOutput placeholder", {
  ui <- menuItemOutput("menu_item_out")
  html <- paste(as.character(htmltools::renderTags(ui)$html), collapse = "")

  expect_true(grepl('id=\"menu_item_out\"', html, fixed = TRUE))
  expect_true(grepl("bslibdash-menu-item-output", html, fixed = TRUE))
})

test_that("sidebarMenuOutput() returns a uiOutput placeholder", {
  ui <- sidebarMenuOutput("sidebar_menu_out")
  html <- paste(as.character(htmltools::renderTags(ui)$html), collapse = "")

  expect_true(grepl('id=\"sidebar_menu_out\"', html, fixed = TRUE))
  expect_true(grepl("bslibdash-sidebar-menu-output", html, fixed = TRUE))
})

test_that("renderMenu() returns a Shiny render function", {
  render_fn <- renderMenu({
    menuItem("Dynamic item", tabName = "dynamic_item")
  })

  expect_true(inherits(render_fn, "shiny.render.function"))
})

test_that("updateTabItems() updates the tabset and sends sidebar sync message", {
  session <- shiny::MockShinySession$new()
  input_message <- NULL
  custom_message <- NULL

  session$sendInputMessage <- function(inputId, message) {
    input_message <<- list(inputId = inputId, message = message)
  }

  session$sendCustomMessage <- function(type, message) {
    custom_message <<- list(type = type, message = message)
  }

  expect_invisible(
    updateTabItems(session = session, inputId = "sidebar", selected = "info_boxes")
  )

  expect_equal(input_message$inputId, "sidebar")
  expect_equal(input_message$message, list(value = "info_boxes"))
  expect_equal(custom_message$type, "bslibdash-update-tab-items")
  expect_equal(
    custom_message$message,
    list(
      menuId = session$ns("sidebar"),
      tabsetId = session$ns("sidebar"),
      selected = "info_boxes"
    )
  )
})

test_that("updateTabItems() validates arguments", {
  session <- shiny::MockShinySession$new()

  expect_error(
    updateTabItems(session = session, inputId = "", selected = "cards"),
    "`inputId` must be a single non-empty string.",
    fixed = TRUE
  )

  expect_error(
    updateTabItems(session = session, inputId = "sidebar", selected = ""),
    "`selected` must be NULL or a single non-empty string.",
    fixed = TRUE
  )
})

test_that("updateTabItems() sends namespaced ids", {
  session <- shiny::MockShinySession$new()
  msg <- NULL

  session$sendCustomMessage <- function(type, message) {
    msg <<- list(type = type, message = message)
  }

  updateTabItems(session, "main_menu", selected = "reports")

  expect_equal(msg$type, "bslibdash-update-tab-items")
  expect_equal(msg$message$menuId, session$ns("main_menu"))
  expect_equal(msg$message$tabsetId, session$ns("main_menu"))
  expect_equal(msg$message$selected, "reports")

  expect_false(identical(msg$message$menuId, "main_menu"))
})
