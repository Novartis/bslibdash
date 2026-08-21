test_that("dashboardHeader() smoke test", {
  ui <- dashboardHeader(title = "Test") |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("app-header"))
  expect_equal(length(ui$find("#header-user-badge")$selectedTags()), 0)
})

test_that("dashboardHeader() accepts positional title for migration compatibility", {
  html <- as.character(
    htmltools::renderTags(
      dashboardHeader("Positional title")
    )$html
  )

  expect_true(grepl("<h3 class=\"mb-0\">Positional title</h3>", html, fixed = TRUE))
  expect_false(grepl("<h3 class=\"mb-0\">bslibdash</h3>", html, fixed = TRUE))
})

test_that("dashboardHeader() renders additional header content from dots", {
  html <- as.character(
    htmltools::renderTags(
      dashboardHeader(
        "Title",
        htmltools::tags$span(id = "header-extra", "Extra"),
        rightUi = htmltools::tags$button(id = "header-action", "Action")
      )
    )$html
  )

  expect_true(grepl("<h3 class=\"mb-0\">Title</h3>", html, fixed = TRUE))
  expect_true(grepl('id="header-extra"', html, fixed = TRUE))
  expect_true(grepl('id="header-action"', html, fixed = TRUE))
})

test_that("dashboardHeader() accepts header content through .list", {
  html <- as.character(
    htmltools::renderTags(
      dashboardHeader(
        title = "List title",
        .list = list(
          htmltools::tags$span(id = "header-list-a", "A"),
          htmltools::tags$span(id = "header-list-b", "B")
        )
      )
    )$html
  )

  expect_true(grepl("<h3 class=\"mb-0\">List title</h3>", html, fixed = TRUE))
  expect_true(grepl('id="header-list-a"', html, fixed = TRUE))
  expect_true(grepl('id="header-list-b"', html, fixed = TRUE))
})

test_that("dashboardHeader() explicit title takes precedence over string dots", {
  html <- as.character(
    htmltools::renderTags(
      dashboardHeader("Header content", title = "Explicit title")
    )$html
  )

  expect_true(grepl("<h3 class=\"mb-0\">Explicit title</h3>", html, fixed = TRUE))
  expect_true(grepl("Header content", html, fixed = TRUE))
})

test_that("dashboardHeader() no longer renders a legacy user badge", {
  html <- as.character(
    htmltools::renderTags(
      dashboardHeader(
        title = "Test",
        rightUi = htmltools::tags$span("Actions")
      )
    )$html
  )

  expect_false(grepl("header-user-badge", html, fixed = TRUE))
  expect_true(grepl("Actions", html, fixed = TRUE))
})

test_that("dashboardHeader() can be disabled", {
  expect_null(dashboardHeader(disable = TRUE))
  expect_null(dashboardHeader(title = "Ignored", disable = TRUE))
})

test_that("dashboardPage() zeros the header height when header is disabled", {
  html <- as.character(
    htmltools::renderTags(
      dashboardPage(
        header = dashboardHeader(disable = TRUE),
        sidebar = dashboardSidebar(
          sidebarMenu(menuItem("Overview", tabName = "overview"))
        ),
        body = dashboardBody(
          tabItems(tabItem("overview", "x"))
        )
      )
    )$html
  )

  expect_false(grepl("class=\"app-header\"", html, fixed = TRUE))
  expect_true(grepl("--app-header-height:0px", html, fixed = TRUE))
})

test_that("legacy profile script dependency is not attached", {
  rendered <- htmltools::renderTags(
    dashboardPage(
      header = dashboardHeader(title = "t"),
      sidebar = dashboardSidebar(sidebarMenu(menuItem("a", tabName = "a"))),
      body = dashboardBody(tabItems(tabItem("a", shiny::div("test body"))))
    )
  )
  deps <- rendered$dependencies
  if (is.null(deps)) {
    deps <- list()
  }

  dep_names <- vapply(deps, function(dep) dep$name, character(1))
  expect_false("avabslib-nibriam" %in% dep_names)
})
