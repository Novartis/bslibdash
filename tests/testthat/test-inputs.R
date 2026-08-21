test_that("actionButton() applies status, outline, size and flat classes", {
  ui <- bslibdash::actionButton(
    "test_id",
    label = "test label",
    icon = shiny::icon("check"),
    width = 1,
    status = "warning",
    outline = TRUE,
    size = "xl",
    flat = TRUE
  ) |>
    htmltools::tagQuery()

  expect_true(
    ui$hasClass("btn btn-default action-button btn-outline-warning btn-xl rounded-0")
  )

  expect_length(
    ui$find("i")$selectedTags(),
    1
  )
})

test_that("actionButton() converts icon names to shiny icons", {
  expect_no_warning(
    ui <- bslibdash::actionButton(
      "btn_icon_name",
      "Click me",
      icon = "check"
    ) |>
      htmltools::tagQuery()
  )

  expect_equal(
    length(ui$find("i")$selectedTags()),
    1
  )
})

test_that("actionButton() shows a placeholder for unknown icon names", {
  expect_no_message(
    ui <- bslibdash::actionButton(
      "btn_unknown_icon",
      "Click me",
      icon = "truly-unknown-xyz123"
    )
  )

  html <- as.character(htmltools::renderTags(ui)$html)
  expect_true(grepl("icon-missing", html, fixed = TRUE))
})

test_that("actionButton() keeps html icon tags without re-parsing", {
  expect_no_warning(
    ui <- bslibdash::actionButton(
      "btn_html_icon",
      "Click me",
      icon = bslibdash::icon("house")
    )
  )

  html <- as.character(htmltools::renderTags(ui)$html)
  expect_true(
    grepl("bi-house", html, fixed = TRUE)
  )
})

test_that("actionButton() without optional args adds no extra classes", {
  ui <- bslibdash::actionButton("btn", "Click me") |> htmltools::tagQuery()
  expect_true(ui$hasClass("btn"))
  expect_false(ui$hasClass("btn-outline-primary"))
  expect_false(ui$hasClass("rounded-0"))
})
