test_that("sidebarUserPanel() wraps the panel with expected structural classes", {
  ui <- sidebarUserPanel("Jane Doe") |> htmltools::tagQuery()

  panel <- ui$selectedTags()
  expect_equal(length(panel), 1)
  expect_true(ui$hasClass("sidebar-user-panel"))
  expect_true(ui$hasClass("d-flex"))
  expect_true(ui$hasClass("align-items-center"))
  expect_true(ui$hasClass("gap-2"))
  expect_true(ui$hasClass("mb-3"))

  expect_equal(length(ui$find(".sidebar-user-image")$selectedTags()), 1)
  expect_equal(length(ui$find(".sidebar-user-info")$selectedTags()), 1)
})

test_that("sidebarUserPanel() renders the name and optional subtitle", {
  with_subtitle <- sidebarUserPanel("Jane", subtitle = "Administrator") |>
    htmltools::tagQuery()

  name_tag <- with_subtitle$find(".sidebar-user-name")$selectedTags()
  expect_equal(length(name_tag), 1)
  expect_equal(name_tag[[1]]$children[[1]], "Jane")

  subtitle_tag <- with_subtitle$find(".sidebar-user-subtitle")$selectedTags()
  expect_equal(length(subtitle_tag), 1)
  expect_equal(subtitle_tag[[1]]$children[[1]], "Administrator")

  without_subtitle <- sidebarUserPanel("Jane") |> htmltools::tagQuery()
  expect_equal(
    length(without_subtitle$find(".sidebar-user-subtitle")$selectedTags()),
    0
  )
})

test_that("sidebarUserPanel() default avatar (image = NULL) renders the bi-person-circle SVG", {
  html <- paste(
    as.character(htmltools::renderTags(sidebarUserPanel("Jane"))$html),
    collapse = ""
  )

  expect_true(grepl("bi-person-circle", html, fixed = TRUE))
  expect_true(grepl("sidebar-user-default-icon", html, fixed = TRUE))
  expect_false(grepl("<img ", html, fixed = TRUE))
})

test_that("sidebarUserPanel() URL image renders an <img> with rounded-circle class", {
  ui <- sidebarUserPanel("Jane", image = "https://example.com/a.png") |>
    htmltools::tagQuery()

  img_tag <- ui$find(".sidebar-user-image img")$selectedTags()
  expect_equal(length(img_tag), 1)
  expect_equal(img_tag[[1]]$attribs$src, "https://example.com/a.png")
  expect_equal(img_tag[[1]]$attribs$alt, "")
  expect_true(grepl("rounded-circle", img_tag[[1]]$attribs$class, fixed = TRUE))

  html <- paste(as.character(htmltools::renderTags(ui$allTags())$html), collapse = "")
  expect_false(grepl("sidebar-user-default-icon", html, fixed = TRUE))
})

test_that("sidebarUserPanel() icon image passes the tag through without wrapping in <img>", {
  html <- paste(
    as.character(
      htmltools::renderTags(
        sidebarUserPanel("Jane", image = bslibdash::icon("house"))
      )$html
    ),
    collapse = ""
  )

  expect_true(grepl("bi-house", html, fixed = TRUE))
  expect_false(grepl("<img ", html, fixed = TRUE))
  expect_false(grepl("sidebar-user-default-icon", html, fixed = TRUE))
})

test_that("sidebarUserPanel() raw htmltools tag is passed through verbatim", {
  custom_avatar <- htmltools::tags$svg(
    class = "custom-avatar", width = "24", height = "24"
  )

  ui <- sidebarUserPanel("Jane", image = custom_avatar) |>
    htmltools::tagQuery()

  svg_tag <- ui$find(".sidebar-user-image svg.custom-avatar")$selectedTags()
  expect_equal(length(svg_tag), 1)

  html <- paste(as.character(htmltools::renderTags(ui$allTags())$html), collapse = "")
  expect_false(grepl("<img ", html, fixed = TRUE))
  expect_false(grepl("sidebar-user-default-icon", html, fixed = TRUE))
})

test_that("sidebarUserPanel() rejects missing or empty name", {
  expect_error(sidebarUserPanel(), "non-empty string")
  expect_error(sidebarUserPanel(NULL), "non-empty string")
  expect_error(sidebarUserPanel(""), "non-empty string")
})

test_that("sidebarUserPanel() rejects unsupported image types", {
  expect_error(
    sidebarUserPanel("Jane", image = 42),
    "URL string, or an htmltools tag"
  )
  expect_error(
    sidebarUserPanel("Jane", image = NA),
    "URL string, or an htmltools tag"
  )
})
