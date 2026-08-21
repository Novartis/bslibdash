capture_toast_notification <- function(...) {
  captured <- list()

  testthat::with_mocked_bindings(
    {
      toast(...)
    },
    showNotification = function(ui, type, duration, closeButton, session) {
      captured <<- list(
        ui = ui,
        type = type,
        duration = duration,
        closeButton = closeButton,
        session = session
      )
      invisible(NULL)
    },
    .package = "shiny"
  )

  captured
}

test_that("toast() uses default option values", {
  result <- capture_toast_notification(
    title = "Default title",
    body = "Default body"
  )

  expect_equal(result$type, "default")
  expect_equal(result$duration, 5)
  expect_true(isTRUE(result$closeButton))

  html <- as.character(htmltools::renderTags(result$ui)$html)
  expect_true(grepl("Default title", html, fixed = TRUE))
  expect_true(grepl("Default body", html, fixed = TRUE))
  expect_true(grepl("bslibdash-toast", html, fixed = TRUE))
})

test_that("toast() maps delay/type/close options", {
  result <- capture_toast_notification(
    title = "Configured title",
    body = "Configured body",
    options = list(
      delay = 2500,
      type = "warning",
      close = FALSE
    )
  )

  expect_equal(result$type, "warning")
  expect_equal(result$duration, 2.5)
  expect_false(result$closeButton)
})

test_that("toast() autohide FALSE overrides delay", {
  result <- capture_toast_notification(
    title = "Persistent title",
    body = "Persistent body",
    options = list(
      delay = 1000,
      autohide = FALSE
    )
  )

  expect_null(result$duration)
})

test_that("toast() renders subtitle and icon", {
  result <- capture_toast_notification(
    title = "Icon title",
    body = "Main body",
    subtitle = "Extra details",
    options = list(icon = icon("bell"))
  )

  html <- as.character(htmltools::renderTags(result$ui)$html)
  body_matches <- gregexpr("bslibdash-toast-body", html, fixed = TRUE)[[1]]
  expect_equal(if (body_matches[1] < 0) 0 else length(body_matches), 2)
  expect_true(grepl("bslibdash-toast-subtitle", html, fixed = TRUE))
  expect_true(grepl("Extra details", html, fixed = TRUE))
  expect_true(grepl("bell", html, fixed = TRUE))
  expect_true(grepl("bslibdash-toast-icon", html, fixed = TRUE))
})

test_that("toast() forwards explicit session", {
  session <- shiny::MockShinySession$new()
  result <- capture_toast_notification(
    title = "Session title",
    body = "Session body",
    session = session
  )

  expect_identical(result$session, session)
})

test_that("toast() attaches the bslibdash-toast component dependency", {
  result <- capture_toast_notification(
    title = "Dep title",
    body = "Dep body"
  )

  rendered <- htmltools::renderTags(result$ui)
  dep_names <- vapply(rendered$dependencies, `[[`, character(1), "name")
  expect_true("bslibdash-toast" %in% dep_names)
  expect_true("bslibdash-core" %in% dep_names)
})

test_that("toast() renders a flat structure with no nested bslib card", {
  result <- capture_toast_notification(
    title = "Flat title",
    body = "Flat body",
    subtitle = "Flat subtitle"
  )

  html <- as.character(htmltools::renderTags(result$ui)$html)
  expect_false(grepl("bslib-card", html, fixed = TRUE))
  expect_false(grepl("card-header", html, fixed = TRUE))
  expect_false(grepl("card-body", html, fixed = TRUE))
  expect_true(grepl("bslibdash-toast-header", html, fixed = TRUE))
})
