test_that("dashboardPage() attaches both page and sidebar dependencies", {
  ui <- dashboardPage(
    header = dashboardHeader(title = "t"),
    sidebar = dashboardSidebar(sidebarMenu(menuItem("a", tabName = "a"))),
    body = dashboardBody(tabItems(tabItem("a", "x")))
  )
  deps <- htmltools::renderTags(ui)$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_true("bslibdash-core" %in% names)
  expect_true("bslibdash-page" %in% names)
  expect_true("bslibdash-sidebar" %in% names)
})

test_that("page dependencies dedupe across nested components", {
  ui <- dashboardPage(
    header = dashboardHeader(title = "t"),
    sidebar = dashboardSidebar(sidebarMenu(menuItem("a", tabName = "a"))),
    body = dashboardBody(tabItems(tabItem("a", valueBox(1, "a"), infoBox("b", 2))))
  )
  deps <- htmltools::renderTags(ui)$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_equal(sum(names == "bslibdash-page"), 1)
  expect_equal(sum(names == "bslibdash-core"), 1)
})

test_that("dashboardPage() renders with a custom bs_theme()", {
  expect_no_error(
    htmltools::renderTags(
      dashboardPage(
        header = dashboardHeader(title = "t"),
        sidebar = dashboardSidebar(sidebarMenu(menuItem("a", tabName = "a"))),
        body = dashboardBody(tabItems(tabItem("a", "x"))),
        theme = bslib::bs_theme(version = 5)
      )
    )
  )
})
