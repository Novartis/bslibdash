test_that("infoBox() wraps output in Bootstrap column by default", {
  ui <- infoBox(
    title = "CPU usage",
    value = "48%",
    subtitle = "Average over last 5 min",
    icon = icon("cpu"),
    color = "primary"
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("col-sm-4"))
  expect_equal(length(ui$find(".bslibdash-info-box")$selectedTags()), 1)
})

test_that("infoBox() supports width = NULL", {
  ui <- infoBox(
    title = "CPU usage",
    value = "48%",
    width = NULL
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("bslibdash-info-box"))
})

test_that("infoBox() supports fill = TRUE", {
  ui <- infoBox(
    title = "CPU usage",
    value = "48%",
    color = "danger",
    fill = TRUE,
    width = NULL
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("bslibdash-info-box-fill"))
})

test_that("infoBox() supports href links", {
  html <- as.character(
    htmltools::renderTags(
      infoBox(
        title = "CPU usage",
        value = "48%",
        href = "https://example.com"
      )
    )$html
  )

  expect_true(grepl('href="https://example.com"', html, fixed = TRUE))
})

test_that("infoBox() shows a placeholder for unknown icon names", {
  expect_no_message(
    ui <- infoBox(
      title = "CPU usage",
      value = "48%",
      icon = "truly-unknown-xyz123",
      width = NULL
    )
  )

  html <- as.character(htmltools::renderTags(ui)$html)
  expect_true(grepl("icon-missing", html, fixed = TRUE))
})

test_that("infoBoxOutput() returns uiOutput with column wrapper", {
  ui <- infoBoxOutput("ibox") |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("col-sm-4"))
  expect_equal(length(ui$find("#ibox")$selectedTags()), 1)
})

test_that("renderInfoBox() returns a Shiny render function", {
  render_fn <- renderInfoBox({
    infoBox(
      title = "CPU usage",
      value = "48%"
    )
  })

  expect_true(inherits(render_fn, "shiny.render.function"))
})
