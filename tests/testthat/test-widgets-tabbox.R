test_that("tabBox() wraps output in Bootstrap column by default", {
  ui <- tabBox(
    shiny::tabPanel("Summary", "Summary content"),
    shiny::tabPanel("Details", "Details content")
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("col-sm-6"))
  expect_equal(length(ui$find(".bslibdash-tab-box")$selectedTags()), 1)
})

test_that("tabBox() supports width = NULL", {
  ui <- tabBox(
    shiny::tabPanel("Summary", "Summary content"),
    shiny::tabPanel("Details", "Details content"),
    width = NULL
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("bslibdash-tab-box"))
})

test_that("tabBox() forwards id and selected tab", {
  ui <- tabBox(
    shiny::tabPanel("Summary", value = "summary_tab", "Summary content"),
    shiny::tabPanel("Details", value = "details_tab", "Details content"),
    id = "demo_tabbox",
    selected = "details_tab",
    width = NULL
  )

  html <- as.character(htmltools::renderTags(ui)$html)
  expect_true(grepl('id="demo_tabbox"', html, fixed = TRUE))
  expect_true(
    grepl('<li class="active">\\s*<a[^>]*data-value="details_tab"', html, perl = TRUE)
  )
})

test_that("tabBox() applies right-side tab class", {
  ui <- tabBox(
    shiny::tabPanel("Summary", "Summary content"),
    shiny::tabPanel("Details", "Details content"),
    side = "right",
    width = NULL
  )

  query <- htmltools::tagQuery(ui)
  expect_true(query$hasClass("bslibdash-tab-box-right"))

  html <- as.character(htmltools::renderTags(ui)$html)
  expect_true(grepl("bslibdash-tab-box-nav-right", html, fixed = TRUE))
  expect_true(grepl("flex:0 0 auto !important", html, fixed = TRUE))
  expect_true(grepl("justify-content:flex-end", html, fixed = TRUE))
})

test_that("tabBox() rejects invalid side values", {
  expect_error(
    tabBox(shiny::tabPanel("Summary", "Summary content"), side = "top"),
    "should be one of"
  )
})
