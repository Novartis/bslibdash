# Manual test: parent menuItem must auto-expand on first paint when one of
# its children is marked `selected = TRUE`.
#
# Expected on load:
#   - "Reports (selected child)" group is OPEN, with "Monthly" highlighted
#     as the active tab — the Monthly tab content is visible.
#   - "Admin (no selection)" group is CLOSED, caret pointing right.
#   - "Ops (startExpanded)" group is OPEN even with no selected child.
#   - "Mixed: startExpanded + selected" group is OPEN, "Logs" highlighted.
#
# Interaction checks:
#   - Clicking any caret toggles its own group only.
#   - Reload the page — the same groups should re-open exactly as above,
#     i.e. server doesn't have to send a message for the parent to open.
#   - Inspect the open parent's toggle button: aria-expanded="true",
#     and its sibling .sidebar-subnav has class "collapse show".
#   - Inspect the closed parent: aria-expanded="false", subnav class is
#     "sidebar-subnav collapse" (no "show").

library(shiny)
library(bslibdash)

ui <- dashboardPage(
  title = "bslibdash – sidebar auto-expand",
  header = dashboardHeader(title = "Sidebar auto-expand"),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      sidebarHeader("Auto-expand cases"),
      menuItem(
        "Reports (selected child)",
        icon = icon("bar-chart"),
        menuSubItem("Daily",   tabName = "reports_daily"),
        menuSubItem("Monthly", tabName = "reports_monthly"),
        menuSubItem("Yearly",  tabName = "reports_yearly")
      ),
      menuItem(
        "Admin (no selection)",
        icon = icon("gear"),
        menuSubItem("Users",   tabName = "admin_users"),
        menuSubItem("Roles",   tabName = "admin_roles")
      ),
      menuItem(
        "Ops (startExpanded)",
        icon = icon("server"),
        startExpanded = TRUE,
        menuSubItem("Status",  tabName = "ops_status"),
        menuSubItem("Alerts",  tabName = "ops_alerts")
      ),
      menuItem(
        "Mixed: startExpanded + selected",
        icon = icon("list"),
        startExpanded = TRUE,
        menuSubItem("Events", tabName = "mixed_events"),
        menuSubItem("Logs",   tabName = "mixed_logs", selected = TRUE)
      )
    )
  ),
  body = dashboardBody(
    tabItems(
      tabItem("reports_daily",   h2("Reports / Daily")),
      tabItem("reports_monthly", h2("Reports / Monthly (selected on load)")),
      tabItem("reports_yearly",  h2("Reports / Yearly")),
      tabItem("admin_users",     h2("Admin / Users")),
      tabItem("admin_roles",     h2("Admin / Roles")),
      tabItem("ops_status",      h2("Ops / Status")),
      tabItem("ops_alerts",      h2("Ops / Alerts")),
      tabItem("mixed_events",    h2("Mixed / Events")),
      tabItem("mixed_logs",      h2("Mixed / Logs (selected on load)"))
    )
  )
)

server <- function(input, output, session) {
  observe({
    message("input$sidebar = ", input$sidebar %||% "<null>")
  })
}

shinyApp(ui, server)
