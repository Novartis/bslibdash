dashboard_body_test_html <- function(tags) {
  paste(vapply(tags, as.character, character(1)), collapse = "")
}

test_that("tabItem() generates expected html", {
  ui <- tabItem("Example Tab", shiny::div("test")) |> htmltools::tagQuery()

  expect_equal(ui$length(), 1)
})

test_that("tabItems() generates expected html", {
  ui <- bslibdash::tabItems(
    bslibdash::tabItem(
      tabName = "Wiki",
      bslibdash::tabsetPanel(
        id = "tabset_wiki"
      )
    )
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("content-canvas"))
})

test_that("dashboardBody() generates expected html", {
  ui <- dashboardBody("Test") |> htmltools::tagQuery()

  expect_equal(names(formals(dashboardBody)), "...")
  expect_true(
    ui$hasClass("app-main-inner") 
  )
  
  expect_equal(
    ui$children(cssSelector = ".app-footer")$length(),
    0
  )
})

test_that("dashboardFooter() provides left/right footer slots", {
  ui <- dashboardFooter(left = "Left", right = "Right", fixed = TRUE) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("main-footer app-footer"))
  expect_true(ui$hasAttrs("data-fixed"))

  html <- as.character(ui$allTags())
  expect_true(grepl('data-fixed="true"', html, fixed = TRUE))
  expect_true(grepl("Left", html, fixed = TRUE))
  expect_true(grepl("Right", html, fixed = TRUE))
})

test_that("dashboardPage() accepts an explicit footer slot", {
  ui <- dashboardPage(
    header = dashboardHeader(title = "Test"),
    sidebar = dashboardSidebar(sidebarMenu(id = "menu")),
    body = dashboardBody("Body"),
    footer = dashboardFooter(left = "L", right = "R")
  ) |>
    htmltools::tagQuery()

  expect_equal(length(ui$find("footer.main-footer")$selectedTags()), 1)
  expect_equal(length(ui$find("footer.app-footer")$selectedTags()), 1)
})

test_that("dashboardPage() without footer renders no dashboard footer", {
  ui <- dashboardPage(
    header = dashboardHeader(title = "Test"),
    sidebar = dashboardSidebar(sidebarMenu(id = "menu")),
    body = dashboardBody("Body")
  ) |>
    htmltools::tagQuery()

  expect_equal(length(ui$find("footer.app-footer")$selectedTags()), 0)
})

test_that("dashboardPage() footer slot is the dashboard footer API", {
  ui <- dashboardPage(
    header = dashboardHeader(title = "Test"),
    sidebar = dashboardSidebar(sidebarMenu(id = "menu")),
    body = dashboardBody("Body"),
    footer = dashboardFooter(left = "Page footer")
  ) |>
    htmltools::tagQuery()

  footer <- ui$find("footer.app-footer")
  expect_equal(length(footer$selectedTags()), 1)

  html <- dashboard_body_test_html(footer$selectedTags())
  expect_true(grepl("Page footer", html, fixed = TRUE))
})

test_that("dashboardPage() applies title to default dashboard header title", {
  ui <- dashboardPage(
    header = dashboardHeader(),
    sidebar = dashboardSidebar(sidebarMenu(id = "menu")),
    body = dashboardBody("Body"),
    title = "bslibdash Kitchen Sink"
  ) |>
    htmltools::tagQuery()

  title_node <- ui$find(".bslib-page-title h3")
  expect_equal(length(title_node$selectedTags()), 1)
  title_html <- dashboard_body_test_html(title_node$selectedTags())
  expect_true(grepl("bslibdash Kitchen Sink", title_html, fixed = TRUE))
})

test_that("dashboardPage() preserves explicit dashboardHeader() title", {
  ui <- dashboardPage(
    header = dashboardHeader(title = "Edge cases"),
    sidebar = dashboardSidebar(sidebarMenu(id = "menu")),
    body = dashboardBody("Body"),
    title = "bslibdash Kitchen Sink"
  ) |>
    htmltools::tagQuery()

  title_node <- ui$find(".bslib-page-title h3")
  expect_equal(length(title_node$selectedTags()), 1)
  title_html <- dashboard_body_test_html(title_node$selectedTags())
  expect_true(grepl("Edge cases", title_html, fixed = TRUE))
  expect_false(grepl("bslibdash Kitchen Sink", title_html, fixed = TRUE))
})
