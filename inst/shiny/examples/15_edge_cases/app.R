library(shiny)
library(bslibdash)

ui <- dashboardPage(
  title = "bslibdash Edge Cases",
  theme = brand_bs_theme() |>
    bslib::bs_add_variables(primary = "#8B0000"),
  header = dashboardHeader(
    title = "Edge cases",
    rightUi = tagList(
      actionButton(
        "btn_toast_header",
        "Toast from header",
        icon = "bell",
        status = "info",
        size = "sm"
      )
    )
  ),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      sidebarHeader("Phase 4 checks"),
      menuItem("ActionButton icon", tabName = "action_icon", icon = icon("check")),
      menuItem("Card collapse IDs", tabName = "card_collapse", icon = icon("chevron-bar-down")),
      menuItem("Toast subtitle", tabName = "toast_subtitle", icon = icon("bell")),
      menuItem("Focus ring theme", tabName = "focus_ring", icon = icon("gear")),
      sidebarHeader("Expanded ID sanitization"),
      menuItem(
        "Parent @ 123",
        icon = icon("house"),
        startExpanded = TRUE,
        menuSubItem("Nested Alpha", tabName = "nested_alpha"),
        menuSubItem("Nested Beta", tabName = "nested_beta")
      ),
      sidebarHeader("Duplicate parent text — Group A"),
      menuItem(
        "Reports",
        icon = icon("bar-chart"),
        menuSubItem("Group A daily", tabName = "dup_reports_a")
      ),
      sidebarHeader("Duplicate parent text — Group B"),
      menuItem(
        "Reports",
        icon = icon("bar-chart"),
        menuSubItem("Group B daily", tabName = "dup_reports_b")
      ),
      sidebarHeader("Initial active selection"),
      menuItem(
        "Default first (not selected)",
        tabName = "active_default_first",
        icon = icon("flag")
      ),
      menuItem(
        "Explicit selected = TRUE",
        tabName = "active_explicit_selected",
        icon = icon("hand-index"),
        selected = TRUE
      ),
      menuItem(
        "Reports (nested selection)",
        icon = icon("bar-chart"),
        menuSubItem("Daily",   tabName = "active_nested_daily"),
        menuSubItem(
          "Monthly",
          tabName = "active_nested_monthly",
          selected = TRUE
        )
      )
    )
  ),
  body = dashboardBody(
    shinyjs::useShinyjs(),
    tabItems(
      tabItem(
        tabName = "action_icon",
        shiny::fluidRow(
          box(
            width = 12,
            title = "String icon in actionButton()",
            status = "primary",
            'This button uses icon = "check" (string).',
            actionButton("btn_icon_string", "String icon button", icon = "check", status = "success"),
            tags$div(
              class = "mt-3",
              tags$strong("Click count: "),
              textOutput("icon_clicks", inline = TRUE)
            )
          )
        )
      ),
      tabItem(
        tabName = "card_collapse",
        tags$p(
          class = "mb-3",
          "Manual check: both cards have identical content (same title, ",
          "status, and body). They are distinguished only by their ",
          tags$code("id"),
          " parameter, which is folded into the internal hash-based ",
          "collapse target. Collapsing one card must leave the other ",
          "fully independent."
        ),
        shiny::fluidRow(
          box(
            id = "same_content_a",
            title = "Identical card",
            width = 6,
            status = "primary",
            collapsible = TRUE,
            "Same body content used in both cards."
          ),
          box(
            id = "same_content_b",
            title = "Identical card",
            width = 6,
            status = "primary",
            collapsible = TRUE,
            "Same body content used in both cards."
          )
        )
      ),
      tabItem(
        tabName = "toast_subtitle",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Toast subtitle rendering",
            status = "warning",
            "Trigger a toast and verify subtitle appears as body content.",
            actionButton("btn_toast_local", "Show toast", icon = "bell", status = "warning"),
            tags$div(
              class = "mt-3",
              tags$strong("Toasts shown: "),
              textOutput("toast_count", inline = TRUE)
            )
          )
        )
      ),
      tabItem(
        tabName = "focus_ring",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Focus ring color",
            status = "danger",
            "Theme primary is overridden to #8B0000 in this app.",
            "Manual check: use Tab to move focus across controls below.",
            textInput("focus_text", "Text input", "Try tabbing here"),
            selectInput("focus_select", "Select input", choices = c("first", "second", "third")),
            actionButton("focus_button", "Focusable actionButton", icon = "check", status = "primary")
          )
        )
      ),
      tabItem(
        tabName = "nested_alpha",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Nested Alpha",
            status = "secondary",
            "Manual check: sidebar parent label contains '@' and spaces, and still expands/collapses normally."
          )
        )
      ),
      tabItem(
        tabName = "nested_beta",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Nested Beta",
            status = "secondary",
            "Second nested tab for submenu navigation checks."
          )
        )
      ),
      tabItem(
        tabName = "dup_reports_a",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Duplicate parent text — Group A",
            status = "secondary",
            tags$p(
              "Two sidebar parents both labelled 'Reports' live under separate ",
              tags$code("sidebarHeader()"), " sections."
            ),
            tags$p(
              tags$strong("Manual check: "),
              "expand 'Reports' under Group A — Group B's 'Reports' must stay ",
              "collapsed. With the previous default ", tags$code("expandedName"),
              " (text-only), both panels shared ", tags$code("id=\"collapse-Reports\""),
              " and Bootstrap toggled them together."
            ),
            tags$p(
              tags$strong("DOM check: "),
              "in DevTools, locate the two ", tags$code('id="collapse-Reports-…"'),
              " divs and confirm their 8-hex suffixes differ."
            )
          )
        )
      ),
      tabItem(
        tabName = "dup_reports_b",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Duplicate parent text — Group B",
            status = "secondary",
            tags$p(
              "Sibling to ", tags$code("dup_reports_a"), ". Used to verify that ",
              "two identical-text parents collapse independently."
            )
          )
        )
      ),
      tabItem(
        tabName = "active_default_first",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Default first selection — should NOT be the initial tab",
            status = "secondary",
            tags$p(
              "This is the first item in the ",
              tags$code("Initial active selection"), " section but it has no ",
              tags$code("selected = TRUE"), ". A sibling lower down sets ",
              tags$code("selected = TRUE"),
              ", so on initial load the highlight and visible tab belong to ",
              tags$em("that"), " sibling, not to this one."
            ),
            tags$p(
              tags$strong("Manual check: "),
              "after reload, only one sidebar item should carry the ",
              tags$code(".active"), " class (the explicit one)."
            )
          )
        )
      ),
      tabItem(
        tabName = "active_explicit_selected",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Explicit selected = TRUE — should be the initial tab",
            status = "primary",
            tags$p(
              "Reload the app: this tab should be active on first paint, ",
              "not ", tags$code("Default first"), "."
            ),
            tags$p(
              tags$strong("DOM check: "),
              "in DevTools count nodes matching ",
              tags$code(".sidebar-nav-sections .nav-link.active"),
              " — should be exactly 1."
            ),
            tags$p(
              tags$strong("Bug being fixed: "),
              "previously ", tags$code("sidebar_menu()"),
              " always marked the first ", tags$code("data-nav-to"),
              " item active too, so two items carried ", tags$code(".active"),
              " and the JS picked the first one — silently overriding ",
              tags$code("selected = TRUE"), "."
            )
          )
        )
      ),
      tabItem(
        tabName = "active_nested_daily",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Reports (nested) — Daily",
            status = "secondary",
            "Sibling of 'Monthly'. The parent should auto-expand because ",
            "'Monthly' is the explicitly-selected child."
          )
        )
      ),
      tabItem(
        tabName = "active_nested_monthly",
        shiny::fluidRow(
          box(
            width = 12,
            title = "Reports (nested) — Monthly",
            status = "primary",
            tags$p(
              "This sub-item has ", tags$code("selected = TRUE"),
              ". On reload, expect:"
            ),
            tags$ul(
              tags$li("'Monthly' carries the .active class."),
              tags$li("Parent 'Reports (nested selection)' starts expanded."),
              tags$li(
                "No other sidebar item carries .active (in particular, the ",
                "first menu item, 'ActionButton icon', is no longer ",
                "auto-activated)."
              )
            )
          )
        )
      )
    ),
    footer = dashboardFooter(
      left = "Edge-case example app",
      right = "Phase 4 manual verification"
    )
  )
)

server <- function(input, output, session) {
  toast_counter <- reactiveVal(0L)

  output$icon_clicks <- renderText({
    input$btn_icon_string
  })

  show_edge_toast <- function(source) {
    toast(
      title = sprintf("Edge-case toast (%s)", source),
      body = "Body text for notification rendering.",
      subtitle = "Subtitle should render as body content.",
      options = list(type = "message")
    )
    toast_counter(toast_counter() + 1L)
  }

  observeEvent(input$btn_toast_header, {
    show_edge_toast("header")
  })

  observeEvent(input$btn_toast_local, {
    show_edge_toast("tab")
  })

  output$toast_count <- renderText({
    toast_counter()
  })
}

shinyApp(ui, server)
