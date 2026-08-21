test_that("valueBox() wraps output in Bootstrap column by default", {
  ui <- valueBox(
    value = 42,
    subtitle = "Active users",
    icon = icon("person"),
    color = "success"
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("col-sm-4"))
  expect_equal(length(ui$find(".bslib-value-box")$selectedTags()), 1)
})

test_that("valueBox() supports width = NULL", {
  ui <- valueBox(
    value = 42,
    subtitle = "Active users",
    width = NULL
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("bslib-value-box"))
})

test_that("valueBox() uses top-right showcase layout when icon is provided", {
  expect_no_warning(
    ui <- valueBox(
      value = 42,
      subtitle = "Active users",
      icon = icon("star"),
      width = NULL
    ) |>
      htmltools::tagQuery()
  )

  expect_true(ui$hasClass("showcase-top-right"))
})

test_that("valueBox() shows a placeholder for unknown icon names", {
  expect_no_message(
    ui <- valueBox(
      value = 42,
      subtitle = "Active users",
      icon = "truly-unknown-xyz123",
      width = NULL
    )
  )

  html <- as.character(htmltools::renderTags(ui)$html)
  expect_true(grepl("icon-missing", html, fixed = TRUE))
})

test_that("valueBox() supports href links", {
  html <- as.character(
    htmltools::renderTags(
      valueBox(value = 42, subtitle = "Active users", href = "https://example.com")
    )$html
  )

  expect_true(grepl('href="https://example.com"', html, fixed = TRUE))
})

test_that("valueBoxOutput() returns uiOutput with column wrapper", {
  ui <- valueBoxOutput("vbox") |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("col-sm-4"))
  expect_equal(length(ui$find("#vbox")$selectedTags()), 1)
})

test_that("renderValueBox() returns a Shiny render function", {
  render_fn <- renderValueBox({
    valueBox(
      value = 99,
      subtitle = "Rendered"
    )
  })

  expect_true(inherits(render_fn, "shiny.render.function"))
})


test_that("valueBox() attaches bslibdash-core and bslibdash-value-box dependencies", {
  deps <- htmltools::renderTags(valueBox(42, "Active users"))$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_true("bslibdash-core" %in% names)
  expect_true("bslibdash-value-box" %in% names)
})

test_that("valueBox() dedupes dependencies across multiple instances", {
  ui <- htmltools::tagList(
    valueBox(1, "a"),
    valueBox(2, "b"),
    valueBox(3, "c")
  )
  deps <- htmltools::renderTags(ui)$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_equal(sum(names == "bslibdash-value-box"), 1)
  expect_equal(sum(names == "bslibdash-core"), 1)
})

test_that("valueBox() renders with a custom bs_theme()", {
  expect_no_error(
    htmltools::renderTags(
      bslib::page_fluid(theme = bslib::bs_theme(version = 5), valueBox(42, "x"))
    )
  )
})


test_that("infoBox() attaches bslibdash-core and bslibdash-info-box dependencies", {
  deps <- htmltools::renderTags(infoBox("CPU", "42%"))$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_true("bslibdash-core" %in% names)
  expect_true("bslibdash-info-box" %in% names)
})

test_that("infoBox() dedupes dependencies across multiple instances", {
  ui <- htmltools::tagList(
    infoBox("a", 1),
    infoBox("b", 2),
    infoBox("c", 3)
  )
  deps <- htmltools::renderTags(ui)$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_equal(sum(names == "bslibdash-info-box"), 1)
  expect_equal(sum(names == "bslibdash-core"), 1)
})

test_that("infoBox() renders with a custom bs_theme()", {
  expect_no_error(
    htmltools::renderTags(
      bslib::page_fluid(theme = bslib::bs_theme(version = 5), infoBox("CPU", "42%"))
    )
  )
})


test_that("tabBox() attaches bslibdash-core and bslibdash-tab-box dependencies", {
  deps <- htmltools::renderTags(
    tabBox(shiny::tabPanel("a", "x"), id = "t1")
  )$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_true("bslibdash-core" %in% names)
  expect_true("bslibdash-tab-box" %in% names)
})

test_that("tabBox() dedupes dependencies across multiple instances", {
  ui <- htmltools::tagList(
    tabBox(shiny::tabPanel("a", "x"), id = "t1"),
    tabBox(shiny::tabPanel("b", "y"), id = "t2"),
    tabBox(shiny::tabPanel("c", "z"), id = "t3")
  )
  deps <- htmltools::renderTags(ui)$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_equal(sum(names == "bslibdash-tab-box"), 1)
  expect_equal(sum(names == "bslibdash-core"), 1)
})

test_that("tabBox() renders with a custom bs_theme()", {
  expect_no_error(
    htmltools::renderTags(
      bslib::page_fluid(
        theme = bslib::bs_theme(version = 5),
        tabBox(shiny::tabPanel("a", "x"), id = "t1")
      )
    )
  )
})
