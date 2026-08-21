test_that("icon() snapshot test", {
  ui <- bslibdash::icon(
    name = "user",
    class = "extra-class",
    style = "margin-right: 4px;",
    size = "2em",
    color = "red",
    css = list(margin_right = "4px")
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasAttrs("style"))
  expect_true(ui$children()$hasClass("bi-person") || ui$children()$hasClass("far fa-user"))
})

test_that("icon() shows a visible placeholder for unknown icon names", {
  expect_no_message(
    ui <- bslibdash::icon("truly-unknown-xyz123")
  )

  html <- as.character(htmltools::renderTags(ui)$html)
  expect_true(grepl("icon-missing", html, fixed = TRUE))
  expect_true(grepl("Unknown icon: truly-unknown-xyz123", html, fixed = TRUE))
})
