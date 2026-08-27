sidebar_test_collect_ids <- function(x) {
  ids <- character()

  walk <- function(tag) {
    if (inherits(tag, "shiny.tag")) {
      id <- tag$attribs$id
      if (!is.null(id)) {
        ids <<- c(ids, id)
      }
      invisible(lapply(tag$children, walk))
      return()
    }

    if (inherits(tag, "shiny.tag.list") || is.list(tag)) {
      invisible(lapply(tag, walk))
    }
  }

  walk(x)
  ids
}

test_that("sidebarHeader() smoke test", {
  ui <- sidebarHeader("Test") |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("sidebar-title d-flex align-items-center gap-2"))
  expect_true(grepl("Test", as.character(ui$allTags()), fixed = TRUE))
})

test_that("menuItem() smoke test", {
  ui <- menuItem(text = "Test", tabName = "tab_test") |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("nav-link d-flex align-items-center gap-2"))
  expect_true(ui$hasAttrs("data-nav-to"))
  expect_true(grepl('data-nav-to="tab_test"', as.character(ui$allTags()), fixed = TRUE))
})

test_that("menuItem() uses ellipsis icon by default for nested items", {
  result <- menuItem(
    text = "Parent",
    menuSubItem(text = "Child", tabName = "child")
  )

  html <- as.character(htmltools::renderTags(result)$html)

  expect_true(
    grepl("ellipsis", html, fixed = TRUE),
    info = "Expected default ellipsis icon when no icon is supplied to a nested menuItem"
  )
})

test_that("menuItem() uses provided icon for nested items", {
  custom_icon <- bslibdash::icon("house")

  result <- menuItem(
    text = "Parent",
    icon = custom_icon,
    menuSubItem(text = "Child", tabName = "child")
  )

  html <- as.character(htmltools::renderTags(result)$html)

  expect_true(
    grepl("house", html, fixed = TRUE),
    info = "Expected the custom icon to be rendered for a nested menuItem"
  )
  expect_false(
    grepl("ellipsis", html, fixed = TRUE),
    info = "Ellipsis fallback icon should NOT appear when a custom icon is supplied"
  )
})

test_that("menuSubItem() ships a default chevron icon", {
  html <- as.character(htmltools::renderTags(
    menuSubItem("Daily", tabName = "reports_daily")
  )$html)

  # bslibdash::icon() maps the historical "angle-double-right" name to the
  # modern Font Awesome 6 class "fa-angles-right".
  expect_true(grepl("fa-angles-right", html, fixed = TRUE))
})

test_that("menuSubItem() honours a caller-supplied icon", {
  html <- as.character(htmltools::renderTags(
    menuSubItem("Daily", tabName = "reports_daily", icon = bslibdash::icon("star"))
  )$html)

  expect_true(grepl("bi-star", html, fixed = TRUE))
  expect_false(grepl("fa-angles-right", html, fixed = TRUE))
})

test_that("menuItem() leaf renders the supplied icon", {
  html <- as.character(htmltools::renderTags(
    menuItem("Overview", tabName = "overview", icon = bslibdash::icon("house"))
  )$html)

  expect_true(grepl("bi-house", html, fixed = TRUE))
  expect_true(grepl('data-nav-to="overview"', html, fixed = TRUE))
})

test_that("menuItem() sanitizes expanded ids", {
  result <- menuItem(
    text = "Parent @ 123",
    menuSubItem(text = "Child", tabName = "child")
  ) |>
    htmltools::tagQuery()

  subnav <- result$find(".sidebar-subnav")$selectedTags()
  expect_equal(length(subnav), 1)
  # Sanitized prefix is stable; suffix is a deterministic 8-hex content hash.
  expect_match(subnav[[1]]$attribs$id, "^collapse-Parent123-[a-f0-9]{8}$")
})

test_that("menuItem() gives identical-text parents distinct collapse ids", {
  result <- sidebarMenu(
    sidebarHeader("Group A"),
    menuItem(
      "Reports",
      menuSubItem("Daily A", tabName = "reports_daily_a")
    ),
    sidebarHeader("Group B"),
    menuItem(
      "Reports",
      menuSubItem("Daily B", tabName = "reports_daily_b")
    )
  )

  html <- as.character(htmltools::renderTags(result)$html)
  ids     <- regmatches(html, gregexpr('id="collapse-Reports-[a-f0-9]{8}"',              html))[[1]]
  targets <- regmatches(html, gregexpr('data-bs-target="#collapse-Reports-[a-f0-9]{8}"', html))[[1]]

  expect_equal(length(ids), 2)
  expect_equal(length(unique(ids)), 2)
  expect_equal(length(unique(targets)), 2)
})

test_that("menuItem() emits a stable collapse id across re-renders", {
  build <- function() {
    menuItem(
      "Reports",
      menuSubItem("Daily",   tabName = "reports_daily"),
      menuSubItem("Monthly", tabName = "reports_monthly")
    )
  }

  extract_id <- function(item) {
    htmltools::tagQuery(item)$find(".sidebar-subnav")$selectedTags()[[1]]$attribs$id
  }

  id_first  <- extract_id(build())
  id_second <- extract_id(build())

  expect_identical(id_first, id_second)
})

test_that("menuItem() auto-expands when a child is selected", {
  result <- menuItem(
    text = "Reports",
    menuSubItem(text = "Monthly", tabName = "monthly", selected = TRUE)
  ) |>
    htmltools::tagQuery()

  toggle <- result$find(".nav-item.has-subnav")$children()$selectedTags()
  subnav <- result$find(".sidebar-subnav")$selectedTags()

  expect_equal(toggle[[1]]$attribs[["aria-expanded"]], "true")
  expect_true(grepl("\\bshow\\b", subnav[[1]]$attribs$class))
})

test_that("menuItem() stays collapsed when no child is selected", {
  result <- menuItem(
    text = "Reports",
    menuSubItem(text = "Monthly", tabName = "monthly")
  ) |>
    htmltools::tagQuery()

  toggle <- result$find(".nav-item.has-subnav")$children()$selectedTags()
  subnav <- result$find(".sidebar-subnav")$selectedTags()

  expect_equal(toggle[[1]]$attribs[["aria-expanded"]], "false")
  expect_false(grepl("\\bshow\\b", subnav[[1]]$attribs$class %||% ""))
})

test_that("menuItem() wires data-bs-target and aria-controls to the collapse panel id", {
  result <- menuItem(
    "Reports",
    menuSubItem("Daily",   tabName = "reports_daily"),
    menuSubItem("Monthly", tabName = "reports_monthly")
  ) |>
    htmltools::tagQuery()

  toggle <- result$find(".nav-item.has-subnav")$children()$selectedTags()
  panel  <- result$find(".sidebar-subnav")$selectedTags()

  expect_equal(length(toggle), 1)
  expect_equal(length(panel),  1)

  panel_id <- panel[[1]]$attribs$id
  expect_true(nzchar(panel_id))
  expect_equal(toggle[[1]]$attribs[["data-bs-toggle"]], "collapse")
  expect_equal(toggle[[1]]$attribs[["data-bs-target"]], paste0("#", panel_id))
  expect_equal(toggle[[1]]$attribs[["aria-controls"]],  panel_id)
})

test_that("sidebarMenu() smoke test", {
  ui <- sidebarMenu(shiny::div("test")) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("sidebar-nav-sections"))
  expect_true(ui$hasAttrs("data-input-id"))
  expect_true(ui$hasAttrs("data-tabset-id"))
  expect_false(ui$hasAttrs("id"))
  expect_equal(length(ui$find("nav.nav-pills")$selectedTags()), 1)
})

test_that("sidebarMenu() auto-activates the first item when none is selected", {
  ui <- sidebarMenu(
    menuItem("Overview", tabName = "overview"),
    menuItem("Reports",  tabName = "reports")
  )

  active_buttons <- htmltools::tagQuery(ui)$find("button.nav-link.active")$selectedTags()

  expect_equal(length(active_buttons), 1)

  active_button <- active_buttons[[1]]
  expect_equal(
    htmltools::tagGetAttribute(active_button, "data-nav-to"),
    "overview"
  )
})

test_that("sidebarMenu() respects an explicit selected = TRUE on a non-first item", {
  ui <- sidebarMenu(
    menuItem("Overview", tabName = "overview"),
    menuItem("Reports",  tabName = "reports", selected = TRUE)
  )
  html <- as.character(htmltools::renderTags(ui)$html)

  active_buttons <- regmatches(
    html,
    gregexpr("<button[^>]*\\bnav-link\\b[^>]*\\bactive\\b[^>]*>", html)
  )[[1]]

  expect_equal(length(active_buttons), 1)
  expect_true(any(grepl('data-nav-to="reports"', active_buttons, fixed = TRUE)))
})

test_that("sidebarMenu() respects selected = TRUE on a nested menuSubItem()", {
  ui <- sidebarMenu(
    menuItem("Overview", tabName = "overview"),
    menuItem(
      "Reports",
      menuSubItem("Daily",   tabName = "reports_daily"),
      menuSubItem("Monthly", tabName = "reports_monthly", selected = TRUE)
    )
  )
  html <- as.character(htmltools::renderTags(ui)$html)

  active_buttons <- regmatches(
    html,
    gregexpr("<button[^>]*\\bnav-link\\b[^>]*\\bactive\\b[^>]*>", html)
  )[[1]]

  expect_equal(length(active_buttons), 1)
  expect_true(any(grepl('data-nav-to="reports_monthly"', active_buttons, fixed = TRUE)))
})

test_that("sidebarMenu() separates Shiny input id from DOM id", {
  ui <- sidebarMenu(
    id = "sidebar",
    menuItem("Overview", tabName = "overview")
  ) |>
    htmltools::tagQuery()

  sidebar_menu_tag <- ui$selectedTags()[[1]]

  expect_equal(sidebar_menu_tag$attribs[["data-input-id"]], "sidebar")
  expect_equal(sidebar_menu_tag$attribs[["data-tabset-id"]], "sidebar")
  expect_null(sidebar_menu_tag$attribs$id)
})

test_that("default sidebar menu and tabItems markup does not duplicate ids", {
  ids <- sidebar_test_collect_ids(
    htmltools::tagList(
      sidebarMenu(menuItem("Overview", tabName = "overview")),
      tabItems(tabItem(tabName = "overview", "Overview"))
    )
  )

  duplicate_ids <- unique(ids[duplicated(ids)])

  expect_equal(duplicate_ids, character())
  expect_equal(sum(ids == "sidebarMenu"), 1)
})

test_that("dashboardSidebar() inherits bslib_sidebar for bslib engine", {
  bslib_sidebar <- dashboardSidebar() |> htmltools::tagQuery()
  expect_true(bslib_sidebar$hasClass("app-sidebar flex-shrink-0"))
})

test_that("dashboardSidebar() supports shinydashboard-compatible options", {
  ui <- dashboardSidebar(
    sidebarMenu(menuItem("Overview", tabName = "overview")),
    width = 280,
    collapsed = TRUE
  ) |>
    htmltools::tagQuery()

  sidebar_tag <- ui$selectedTags()[[1]]

  expect_true(ui$hasClass("is-collapsed"))
  expect_true(grepl("--app-sidebar-width:280px", sidebar_tag$attribs$style, fixed = TRUE))
})

test_that("dashboardSidebar() can be disabled", {
  expect_null(dashboardSidebar(disable = TRUE))
})


test_that("dashboardSidebar() attaches bslibdash-core and bslibdash-sidebar dependencies", {
  deps <- htmltools::renderTags(
    dashboardSidebar(sidebarMenu(menuItem("Overview", tabName = "overview")))
  )$dependencies
  names <- vapply(deps, `[[`, character(1), "name")
  sidebar_dep <- deps[[which(names == "bslibdash-sidebar")[1]]]

  expect_true("bslibdash-core" %in% names)
  expect_true("bslibdash-sidebar" %in% names)
  expect_true(any(grepl("dash.js", unlist(sidebar_dep$script), fixed = TRUE)))
})

test_that("sidebarMenu() attaches sidebar dependency for dynamic outputs", {
  deps <- htmltools::renderTags(
    sidebarMenu(id = "sm", menuItem("Overview", tabName = "overview"))
  )$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_true("bslibdash-core" %in% names)
  expect_true("bslibdash-sidebar" %in% names)
})

test_that("dashboardSidebar() dedupes dependencies across nested usage", {
  ui <- dashboardSidebar(
    sidebarMenu(menuItem("a", tabName = "a"), menuItem("b", tabName = "b"))
  )
  deps <- htmltools::renderTags(ui)$dependencies
  names <- vapply(deps, `[[`, character(1), "name")

  expect_equal(sum(names == "bslibdash-sidebar"), 1)
  expect_equal(sum(names == "bslibdash-core"), 1)
})

test_that("dashboardSidebar() renders with a custom bs_theme()", {
  expect_no_error(
    htmltools::renderTags(
      bslib::page_fluid(
        theme = bslib::bs_theme(version = 5),
        dashboardSidebar(sidebarMenu(menuItem("Overview", tabName = "overview")))
      )
    )
  )
})

test_that("dashboardSidebar() renders accessible overlay close button and landmarks", {
  html <- as.character(
    htmltools::renderTags(
      dashboardSidebar(sidebarMenu(menuItem("Overview", tabName = "overview")))
    )$html
  )

  expect_true(grepl('id="sidebar"', html, fixed = TRUE))
  expect_true(grepl('id="sidebarClose"', html, fixed = TRUE))
  expect_true(grepl('class="app-sidebar-close"', html, fixed = TRUE))
  expect_true(grepl('aria-label="Close sidebar"', html, fixed = TRUE))
  expect_true(grepl('role="navigation"', html, fixed = TRUE))
  expect_true(grepl('aria-label="Primary"', html, fixed = TRUE))
})
