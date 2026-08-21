test_that("boxLayout() generates expected html", {
  # group and deck now return plain shiny.tag (div), not bslib_fragment
  ui_group <- boxLayout(box("A", width = NULL), box("B", width = NULL), type = "group")
  expect_s3_class(ui_group, "shiny.tag")
  expect_equal(ui_group$attribs$class, "card-group")

  ui_deck <- boxLayout(box("A", width = NULL), box("B", width = NULL), type = "deck")
  expect_s3_class(ui_deck, "shiny.tag")
  expect_match(ui_deck$attribs$class, "row")
  expect_match(ui_deck$attribs$class, "row-cols")

  # columns is deprecated — emits a warning but still renders
  expect_warning(
    ui_cols <- boxLayout(box("A", width = NULL), box("B", width = NULL), type = "columns"),
    "deprecated"
  )
  expect_s3_class(ui_cols, "bslib_fragment")
})

test_that("box() generates expected html", {
  # grid width → wrapped in shiny::column(), returns shiny.tag
  ui_grid <- box("Content", title = "Test", width = 6)
  expect_s3_class(ui_grid, "shiny.tag")
  expect_equal(ui_grid$name, "div")
  expect_match(ui_grid$attribs$class, "col-sm-6")

  # NULL width → raw card, returns bslib_fragment
  ui_raw <- box("Content", title = "Test", width = NULL)
  expect_s3_class(ui_raw, "bslib_fragment")
})

test_that("box() attaches deferred bslibdash-card + bslibdash-core dependencies", {
  ui <- box("hello")
  deps <- htmltools::renderTags(ui)$dependencies
  dep_names <- vapply(deps, `[[`, character(1), "name")

  expect_true("bslibdash-card" %in% dep_names)
  expect_true("bslibdash-core" %in% dep_names)
})

test_that("box() dependency carries bslib_card.js", {
  ui <- box("hello")
  deps <- htmltools::renderTags(ui)$dependencies
  card_dep <- deps[[which(vapply(deps, `[[`, character(1), "name") == "bslibdash-card")]]

  expect_equal(card_dep$script, "bslib_card.js")
})

test_that("multiple box() instances dedupe the bslibdash-card dependency", {
  ui <- htmltools::tagList(box("a"), box("b"), box("c"))
  deps <- htmltools::renderTags(ui)$dependencies
  dep_names <- vapply(deps, `[[`, character(1), "name")

  expect_equal(sum(dep_names == "bslibdash-card"), 1L)
  expect_equal(sum(dep_names == "bslibdash-core"), 1L)
})

test_that("box() renders with a custom bs_theme() (no brand_bs_theme())", {
  ui <- box("hello", title = "x")
  theme <- bslib::bs_theme(version = 5, primary = "#8B0000")
  page <- bslib::page_fluid(theme = theme, ui)

  expect_no_error(htmltools::renderTags(page))
})

test_that("box() assigns unique collapse classes for differing content", {
  ui <- boxLayout(
    box("same content", title = "A", collapsible = TRUE),
    box("same content", title = "B", collapsible = TRUE)
  )

  html <- as.character(htmltools::renderTags(ui)$html)
  collapse_classes <- unique(
    unlist(regmatches(html, gregexpr("card-collapse-[a-f0-9]+", html)))
  )

  expect_gte(length(collapse_classes), 2)
})

test_that("box() collapse classes are deterministic and hash-based (no global counters)", {
  ui_a <- box("hello", title = "Status", collapsible = TRUE)
  ui_b <- box("hello", title = "Status", collapsible = TRUE)

  html_a <- as.character(htmltools::renderTags(ui_a)$html)
  html_b <- as.character(htmltools::renderTags(ui_b)$html)

  key_a <- unique(unlist(regmatches(html_a, gregexpr("card-collapse-[a-f0-9]+", html_a))))
  key_b <- unique(unlist(regmatches(html_b, gregexpr("card-collapse-[a-f0-9]+", html_b))))

  expect_length(key_a, 1)
  expect_identical(key_a, key_b)
  expect_match(key_a, "^card-collapse-[a-f0-9]+$")
})

test_that("boxLayout() accepts cards through .list", {
  ui <- boxLayout(
    .list = list(
      box("one", title = "One"),
      box("two", title = "Two")
    )
  ) |>
    htmltools::tagQuery()

  expect_equal(length(ui$find(".card")$selectedTags()), 2)
})
