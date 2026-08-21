test_that("toast() renders subtitle as body content", {
  captured_ui <- NULL

  testthat::with_mocked_bindings(
    {
      toast(
        title = "Title",
        body = "Body text",
        subtitle = "Subtitle text"
      )
    },
    showNotification = function(ui, type, duration, closeButton, session) {
      captured_ui <<- ui
      invisible(NULL)
    },
    .package = "shiny"
  )

  expect_false(is.null(captured_ui))

  html <- as.character(htmltools::renderTags(captured_ui)$html)
  body_matches <- gregexpr("bslibdash-toast-body", html, fixed = TRUE)[[1]]
  expect_equal(if (body_matches[1] < 0) 0 else length(body_matches), 2)
  expect_true(grepl("Subtitle text", html, fixed = TRUE))
  expect_true(grepl("bslibdash-toast-subtitle", html, fixed = TRUE))
  expect_false(grepl("card-body", html, fixed = TRUE))
})
