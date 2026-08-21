test_that("sidebarSearchForm() renders sidebar search structure", {
  ui <- sidebarSearchForm("search_text", "search_button") |>
    htmltools::tagQuery()

  form_tag <- ui$selectedTags()
  expect_equal(length(form_tag), 1)
  expect_true(ui$hasClass("bslibdash-sidebar-search-form"))
  expect_equal(form_tag[[1]]$attribs$role, "search")
  expect_equal(form_tag[[1]]$attribs$onsubmit, "return false;")
  expect_true(grepl("sidebar-form", form_tag[[1]]$attribs$class, fixed = TRUE))

  input_tag <- ui$find("input#search_text")$selectedTags()
  expect_equal(length(input_tag), 1)
  expect_equal(input_tag[[1]]$attribs$placeholder, "Search...")
  expect_equal(input_tag[[1]]$attribs$`aria-label`, "Search...")

  button_tag <- ui$find("button#search_button")$selectedTags()
  expect_equal(length(button_tag), 1)
  expect_equal(button_tag[[1]]$attribs$`aria-label`, "Search...")
  expect_true(grepl("action-button", button_tag[[1]]$attribs$class, fixed = TRUE))
})

test_that("sidebarSearchForm() supports custom label and icon", {
  ui <- sidebarSearchForm(
    textId = "query",
    buttonId = "query_submit",
    label = "Find records",
    icon = bslibdash::icon("house")
  )

  html <- paste(as.character(htmltools::renderTags(ui)$html), collapse = "")
  expect_true(grepl('placeholder="Find records"', html, fixed = TRUE))
  expect_true(grepl('aria-label="Find records"', html, fixed = TRUE))
  expect_true(grepl("house", html, fixed = TRUE))
})

test_that("sidebarSearchForm() omits the icon when icon = NULL", {
  ui <- sidebarSearchForm("t", "b", icon = NULL) |> htmltools::tagQuery()

  button_tag <- ui$find("button#b")$selectedTags()
  expect_equal(length(button_tag), 1)
  expect_equal(button_tag[[1]]$attribs$`aria-label`, "Search...")

  html <- paste(as.character(htmltools::renderTags(ui$allTags())$html), collapse = "")
  expect_false(grepl("<i ",  html, fixed = TRUE))
  expect_false(grepl("<svg", html, fixed = TRUE))
  expect_true(grepl('id="b" type="button"></button>', html, fixed = TRUE))
})
