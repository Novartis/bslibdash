test_that("accordionItem() has the expected classes", {
  ui <- accordionItem(
    shiny::div("test"),
    id = "1234",
    title = "Test Title",
    status = "warning"
  ) |>
    htmltools::tagQuery()

  expect_true(
    ui$hasClass("accordion-item bslibdash-accordion-item bslibdash-accordion-item-warning")
  )
})

test_that("accordionItem() emits no status classes when status is NULL", {
  ui <- accordionItem(
    shiny::div("test"),
    id = "1234",
    title = "Test Title"
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("accordion-item"))
  expect_false(ui$hasClass("bslibdash-accordion-item"))
})

test_that("accordion() inherits bslib_fragment", {
  ui <- accordion(shiny::div("Test"), id = "foo_id")
  expect_s3_class(ui, "bslib_fragment")
})

test_that("accordion() converts bootstrap-style width units", {
  ui <- accordion(shiny::div("Test"), id = "foo_id", width = 6)
  expect_match(as.character(ui), "width:50%")
})

test_that("accordion() attaches the bslibdash-accordion dependency", {
  ui <- accordion(shiny::div("Test"), id = "foo_id")
  dep_names <- vapply(
    htmltools::renderTags(ui)$dependencies,
    function(d) d$name,
    character(1)
  )
  expect_true("bslibdash-accordion" %in% dep_names)
})

test_that("badge() smoke test", {
  ui <- badge(
    shiny::div("test"),
    position = "left",
    color = "warning"
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("start-0 badge text-bg-warning"))
  expect_true(grepl("test", as.character(ui$allTags()), fixed = TRUE))
})
