test_that("dropdownMenu() renders menu container and defaults", {
  ui <- dropdownMenu(
    type = "notifications",
    notificationItem("Build warning")
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("nav-item dropdown bslibdash-dropdown-menu bslibdash-dropdown-menu-notifications"))

  html <- paste(as.character(htmltools::renderTags(ui$allTags())$html), collapse = "")
  expect_true(grepl("You have 1 notifications", html, fixed = TRUE))
  expect_true(grepl("bslibdash-dropdown-badge", html, fixed = TRUE))
})

test_that("messageItem() renders sender, message and time", {
  ui <- messageItem(
    from = "Admin",
    message = "Release notes updated.",
    time = "today",
    color = "danger"
  )

  html <- paste(as.character(htmltools::renderTags(ui)$html), collapse = "")
  expect_true(grepl("Admin", html, fixed = TRUE))
  expect_true(grepl("Release notes updated.", html, fixed = TRUE))
  expect_true(grepl("today", html, fixed = TRUE))
})

test_that("notificationItem() supports action-button mode", {
  ui <- notificationItem(
    text = "Open deployment logs",
    status = "info",
    inputId = "notif_action"
  )

  html <- paste(as.character(htmltools::renderTags(ui)$html), collapse = "")
  expect_true(grepl("action-button", html, fixed = TRUE))
  expect_true(grepl('id=\"notif_action\"', html, fixed = TRUE))
})

test_that("taskItem() renders progress bar and validates value", {
  ui <- taskItem(
    text = "Migration rollout",
    value = 72,
    color = "success"
  )

  html <- paste(as.character(htmltools::renderTags(ui)$html), collapse = "")
  expect_true(grepl("72%", html, fixed = TRUE))
  expect_true(grepl("bg-success", html, fixed = TRUE))
  expect_true(grepl("width:72%;", html, fixed = TRUE))

  expect_error(
    taskItem("Bad task", value = "invalid"),
    "`value` must be a single numeric percentage."
  )
})

test_that("dropdownMenuOutput() returns a uiOutput placeholder", {
  ui <- dropdownMenuOutput("menu_out")
  html <- paste(as.character(htmltools::renderTags(ui)$html), collapse = "")
  expect_true(grepl('id=\"menu_out\"', html, fixed = TRUE))
  expect_true(grepl("bslibdash-dropdown-menu-output", html, fixed = TRUE))
})

test_that("renderDropdownMenu() returns a Shiny render function", {
  render_fn <- renderDropdownMenu({
    dropdownMenu(
      type = "messages",
      messageItem("Admin", "Message body")
    )
  })

  expect_true(inherits(render_fn, "shiny.render.function"))
})


test_that("dropdownMenu() attaches bslibdash-core and bslibdash-dropdown-menu dependencies", {
  deps <- htmltools::renderTags(
    dropdownMenu(type = "notifications", notificationItem("hi"))
  )$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_true("bslibdash-core" %in% names)
  expect_true("bslibdash-dropdown-menu" %in% names)
})

test_that("dropdownMenu() dedupes dependencies across multiple instances", {
  ui <- htmltools::tagList(
    dropdownMenu(type = "messages", messageItem("a", "x")),
    dropdownMenu(type = "notifications", notificationItem("y")),
    dropdownMenu(type = "tasks", taskItem("z", 50))
  )
  deps <- htmltools::renderTags(ui)$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_equal(sum(names == "bslibdash-dropdown-menu"), 1)
  expect_equal(sum(names == "bslibdash-core"), 1)
})

test_that("dropdownMenu() renders with a custom bs_theme()", {
  expect_no_error(
    htmltools::renderTags(
      bslib::page_fluid(
        theme = bslib::bs_theme(version = 5),
        dropdownMenu(type = "notifications", notificationItem("hi"))
      )
    )
  )
})
