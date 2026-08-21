#' bslibdash: Bootstrap 5 dashboards for Shiny
#'
#' @description
#' Build Bootstrap 5 dashboards in Shiny, on [bslib]. bslibdash provides
#' a page shell ([dashboardPage()], [dashboardHeader()],
#' [dashboardSidebar()], [dashboardBody()], [dashboardFooter()]),
#' sidebar navigation ([sidebarMenu()], [menuItem()],
#' [sidebarUserPanel()]), cards ([box()], [boxLayout()], [tabBox()]),
#' KPI tiles ([valueBox()], [infoBox()]), header dropdowns
#' ([dropdownMenu()], [notificationItem()], [messageItem()],
#' [taskItem()]), and lightweight feedback helpers (accordions, badges,
#' toasts).
#'
#' @details
#' Function names mirror
#' [shinydashboard](https://rstudio.github.io/shinydashboard/) wherever
#' the underlying concept is the same, so most apps port across as a
#' search-and-replace. bslibdash is *not* a drop-in clone: a small
#' number of legacy arguments and behaviours that no longer make sense
#' on Bootstrap 5 have been removed — see
#' `vignette("getting-started", package = "bslibdash")` for the full
#' migration story.
#'
#' Every bslibdash component attaches its CSS via
#' [bslib::bs_dependency_defer()], so any [bslib::bs_theme()] (including
#' the bundled [brand_bs_theme()]) recompiles bslibdash styles against
#' the active theme.
#'
#' @section Learn more:
#' * `vignette("getting-started", package = "bslibdash")` — minimal
#'   skeleton and the migration guide from shinydashboard.
#' * `vignette("components",      package = "bslibdash")` — a tour of
#'   every component with copy-pasteable examples.
#' * `vignette("theming",         package = "bslibdash")` — customising
#'   [brand_bs_theme()], swapping Bootswatch presets, and adding
#'   bespoke SCSS.
#'
#' @keywords internal
#' @importFrom rlang !!! %||%
"_PACKAGE"
