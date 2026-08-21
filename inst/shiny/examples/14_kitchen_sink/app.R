library(shiny)
library(bslibdash)

# ── UI ────────────────────────────────────────────────────────────────────────

ui <- dashboardPage(
  title = "bslibdash Kitchen Sink",

  header = dashboardHeader(
    rightUi = tagList(
      dropdownMenuOutput("ks_notifications_menu"),
      dropdownMenuOutput("ks_tasks_menu"),
      dropdownMenuOutput("ks_messages_menu"),
      actionButton("btn_toast_info",    "Toast info",    status = "info",    size = "sm"),
      actionButton("btn_toast_warn",    "Toast warn",    status = "warning", size = "sm"),
      actionButton("btn_toast_persist", "Toast persist", status = "danger",  size = "sm"),
      actionButton("btn_toast_full",    "Toast full",    status = "primary", size = "sm")
    )
  ),

  sidebar = dashboardSidebar(
    collapsed = TRUE,
    sidebarUserPanel(
      name = "Jane Doe",
      subtitle = "Administrator"
    ),
    sidebarMenu(
      id = "sidebar",
      sidebarSearchForm(
        textId = "ks_sidebar_search_text",
        buttonId = "ks_sidebar_search_button",
        label = "Search Kitchen Sink"
      ),
      sidebarHeader("Layout"),
      menuItem("Cards",       tabName = "cards",       icon = icon("credit-card",       size = "1.1rem")),
      menuItem("Update Box",  tabName = "updatebox",   icon = icon("arrow-repeat",      size = "1.1rem")),
      menuItem("Navigation",  tabName = "navigation",  icon = icon("list",              size = "1.1rem")),
      sidebarHeader("Components"),
      menuItem("Badges",      tabName = "badges",      icon = icon("tag",               size = "1.1rem")),
      menuItem("Value boxes", tabName = "value_boxes", icon = icon("graph-up",          size = "1.1rem")),
      menuItem("Info boxes",  tabName = "info_boxes",  icon = icon("bar-chart",         size = "1.1rem")),
      menuItem("Tab box",     tabName = "tab_box",     icon = icon("folder2-open",      size = "1.1rem")),
      menuItem("Dropdown menus", tabName = "dropdown_menus", icon = icon("chat-left-text", size = "1.1rem")),
      menuItem("Sidebar search", tabName = "sidebar_search", icon = icon("search", size = "1.1rem")),
      menuItem("Sidebar outputs", tabName = "sidebar_menu_outputs", icon = icon("list-nested", size = "1.1rem")),
      menuItem("Update tab items", tabName = "update_tab_items", icon = icon("cursor", size = "1.1rem")),
      menuItemOutput("ks_sidebar_dynamic_item"),
      menuItem("Accordion",   tabName = "accordion",   icon = icon("chevron-bar-down",  size = "1.1rem")),
      menuItem("Icons",       tabName = "icons",       icon = icon("star",              size = "1.1rem")),
      menuItem("Buttons",     tabName = "buttons",     icon = icon("hand-index",        size = "1.1rem")),
      sidebarHeader("Nested"),
      menuItem(
        "Sub-items",
        icon = icon("diagram-3", size = "1.1rem"),
        menuSubItem("Alpha",   tabName = "sub_alpha"),
        menuSubItem("Beta",    tabName = "sub_beta"),
        menuSubItem("Gamma",   tabName = "sub_gamma")
      )
    )
  ),

  body = dashboardBody(
    shinyjs::useShinyjs(),

    # ── Cards tab ──────────────────────────────────────────────────────────
    tabItems(
      tabItem(
        tabName = "cards",
        tags$h4("box() variants", class = "mb-3"),
        shiny::fluidRow(
          box(title = "Default box",     width = 4, "No status colour."),
          box(title = "Primary",         width = 4, status = "primary",   "Header: primary"),
          box(title = "Success",         width = 4, status = "success",   "Header: success"),
          box(title = "Warning",         width = 4, status = "warning",   "Header: warning"),
          box(title = "Danger",          width = 4, status = "danger",    "Header: danger"),
          box(title = "Info",            width = 4, status = "info",      "Header: info")
        ),
        tags$h4("Card interactivity", class = "mt-4 mb-3"),
        shiny::fluidRow(
          box(
            id = "collapsible_box",
            title = "Collapsible",
            width = 4,
            status = "primary",
            collapsible = TRUE,
            "Click the chevron ▾ to collapse this card."
          ),
          box(
            id = "starts_collapsed",
            title = "Starts collapsed",
            width = 4,
            status = "info",
            collapsible = TRUE,
            collapsed = TRUE,
            "You should not see this text on first load — card starts collapsed."
          ),
          box(
            id = "closable_box",
            title = "Closable",
            width = 4,
            status = "warning",
            closable = TRUE,
            "Click × to hide. Use 'Restore' button in the updateBox tab."
          ),
          box(
            id = "maximizable_box",
            title = "Maximizable",
            width = 4,
            status = "success",
            maximizable = TRUE,
            "Click the ⛶ icon to go full-screen."
          ),
          box(
            title = "With icon & label",
            width = 4,
            status = "secondary",
            icon = icon("star"),
            label = badge("NEW", color = "danger"),
            "Icon and badge label in the header."
          ),
          box(
            title = "With footer",
            width = 4,
            status = "dark",
            footer = tags$small(class = "text-muted", "This is the card footer."),
            "Card body above. Footer below."
          )
        ),
        tags$h4("Background colours", class = "mt-4 mb-3"),
        shiny::fluidRow(
          box(title = "bg-primary",   width = 3, background = "primary",   "primary bg"),
          box(title = "bg-success",   width = 3, background = "success",   "success bg"),
          box(title = "bg-warning",   width = 3, background = "warning",   "warning bg"),
          box(title = "bg-danger",    width = 3, background = "danger",    "danger bg")
        ),
        
        tags$h4("boxLayout() types", class = "mt-4 mb-3"),

        tags$p(class = "text-muted",
          tags$strong("group"), " — BS5 ", tags$code(".card-group"),
          ": flex row, merged borders, equal heights:"
        ),
        boxLayout(
          type = "group",
          box(title = "A", width = NULL, status = "primary",   "Group card A"),
          box(title = "B", width = NULL, status = "secondary", "Group card B"),
          box(title = "C", width = NULL, status = "success",   "Group card C")
        ),

        tags$p(class = "text-muted mt-4",
          tags$strong("deck"), " — BS5 grid cards (",
          tags$code(".row.row-cols-*"), " + ", tags$code(".h-100"),
          "): equal heights per row, responsive column count:"
        ),
        boxLayout(
          type = "deck",
          box(title = "Short",      width = NULL, status = "primary",   "Short content."),
          box(title = "Tall",       width = NULL, status = "info",
              "Tall content.", tags$br(), tags$br(), tags$br(), "More text at the bottom."),
          box(title = "Medium",     width = NULL, status = "success",   "Medium length content here."),
          box(title = "Also short", width = NULL, status = "warning",   "Row 2, card 1."),
          box(title = "Also tall",  width = NULL, status = "danger",
              "Row 2, card 2.", tags$br(), tags$br(), "Also extra content."),
          box(title = "Row 2 end",  width = NULL, status = "secondary", "Row 2, card 3.")
        ),

        tags$p(class = "text-muted mt-4",
          tags$strong("columns"), " — ", tags$span(class = "text-danger", "Deprecated."),
          " Bootstrap 5 removed ", tags$code(".card-columns"),
          " (see BS5 Masonry docs). Falls back to ",
          tags$code("bslib::layout_column_wrap()"), " with a deprecation warning:"
        ),
        tags$div(
          class = "alert alert-warning py-2",
          tags$code("boxLayout(type = \"columns\")"),
          " is deprecated. Use ",
          tags$code("bslib::layout_column_wrap()"), " directly."
        ),
        bslib::layout_column_wrap(
          width = "300px",
          fillable = FALSE,
          fill = FALSE,
          box(title = "Column card 1", width = NULL,                   "Short body."),
          box(title = "Column card 2", width = NULL, status = "primary",
              "A bit more content here to vary things."),
          box(title = "Column card 3", width = NULL, status = "success", "Short again."),
          box(title = "Column card 4", width = NULL, status = "warning",
              "Slightly longer body text — card heights are independent of neighbours,",
              " unlike deck."),
          box(title = "Column card 5", width = NULL, status = "info",   "Short."),
          box(title = "Column card 6", width = NULL, status = "danger", "Also short.")
        )
      ),

      # ── Update Box tab ───────────────────────────────────────────────────
      tabItem(
        tabName = "updatebox",
        tags$h4("updateBox() demo", class = "mb-3"),
        boxLayout(
          box(
            id = "target_box",
            title = "Target card",
            status = "primary",
            width = 7,
            collapsible = TRUE,
            closable = TRUE,
            maximizable = TRUE,
            tags$p("This card is controlled by the buttons in the panel on the right."),
            tags$p("Its title, status colour, and state can all be updated from the server.")
          ),
          box(
            title = "Controls",
            status = "secondary",
            width = 5,
            collapsible = FALSE,
            tags$div(
              class = "d-flex flex-column gap-2",
              tags$strong("State"),
              actionButton("ub_toggle",   "Toggle collapse",   status = "primary", size = "sm"),
              actionButton("ub_maximize", "Toggle fullscreen", status = "info",    size = "sm"),
              actionButton("ub_remove",   "Hide",              status = "warning", size = "sm"),
              actionButton("ub_restore",  "Restore",           status = "success", size = "sm"),
              tags$hr(),
              tags$strong("Update properties"),
              selectInput(
                "ub_status", "Header colour",
                choices = c("primary","secondary","success","info","warning","danger"),
                selected = "primary"
              ),
              actionButton("ub_apply_status", "Apply colour", status = "dark", size = "sm"),
              tags$br(),
              textInput("ub_title", "Title text", value = "Target card"),
              actionButton("ub_apply_title", "Apply title", status = "dark", size = "sm")
            )
          )
        )
      ),

      # ── Navigation tab ──────────────────────────────────────────────────
      tabItem(
        tabName = "navigation",
        tags$h4("tabsetPanel() types", class = "mb-3"),
        tabsetPanel(
          id = "demo_tabs",
          type = "tabs",
          tabPanel("Tab 1", icon = icon("house",  size = "1rem"), tags$p("Content of Tab 1.")),
          tabPanel("Tab 2", icon = icon("person", size = "1rem"), tags$p("Content of Tab 2.")),
          tabPanel("Tab 3", icon = icon("gear",   size = "1rem"), tags$p("Content of Tab 3."))
        ),
        tags$h4("Pills", class = "mt-4 mb-3"),
        tabsetPanel(
          type = "pills",
          tabPanel("Pill A", "Content A"),
          tabPanel("Pill B", "Content B"),
          tabPanel("Pill C", "Content C")
        )
      ),
      tabItem(
        tabName = "tab_box",
        tags$h4("tabBox() default (side = 'left')", class = "mb-3"),
        shiny::fluidRow(
          tabBox(
            width = 8,
            id = "demo_tab_box_left",
            title = "System panel",
            selected = "overview",
            tabPanel(
              title = "Overview",
              value = "overview",
              tags$p("Overview content in a tabBox card.")
            ),
            tabPanel(
              title = "Details",
              value = "details",
              tags$p("Detailed content goes here.")
            ),
            tabPanel(
              title = "Logs",
              value = "logs",
              tags$p("Log entries and diagnostics.")
            )
          ),
          box(
            width = 4,
            title = "Manual checks",
            status = "secondary",
            collapsible = FALSE,
            tags$ul(
              class = "mb-0",
              tags$li("Tabs render inside a card container."),
              tags$li("Selected tab defaults to 'Overview'."),
              tags$li("Header title is shown on the left.")
            )
          )
        ),
        tags$h4("tabBox(side = 'right')", class = "mt-4 mb-3"),
        tabBox(
          width = 12,
          title = "Right-aligned tabs",
          side = "right",
          tabPanel("Summary", tags$p("Summary tab content.")),
          tabPanel("History", tags$p("History tab content.")),
          tabPanel("Alerts", tags$p("Alerts tab content."))
        )
      ),
      tabItem(
        tabName = "dropdown_menus",
        tags$h4("Header dropdown menus (dynamic examples)", class = "mb-3"),
        shiny::fluidRow(
          box(
            width = 4,
            title = "Notifications dropdown",
            status = "secondary",
            collapsible = FALSE,
            textInput("ks_notif1_text", "Notification 1", value = "Build warning on staging"),
            selectInput(
              "ks_notif1_status",
              "Status 1",
              choices = c("primary", "success", "info", "warning", "danger"),
              selected = "warning"
            ),
            checkboxInput("ks_notif2_enable", "Enable notification 2", value = TRUE),
            textInput("ks_notif2_text", "Notification 2", value = "Three new signups"),
            selectInput(
              "ks_notif2_status",
              "Status 2",
              choices = c("primary", "success", "info", "warning", "danger"),
              selected = "success"
            )
          ),
          box(
            width = 4,
            title = "Tasks dropdown",
            status = "secondary",
            collapsible = FALSE,
            sliderInput("ks_task1_value", "Task 1 progress", min = 0, max = 100, value = 72),
            selectInput(
              "ks_task1_color",
              "Task 1 color",
              choices = c("primary", "success", "info", "warning", "danger"),
              selected = "info"
            ),
            sliderInput("ks_task2_value", "Task 2 progress", min = 0, max = 100, value = 88),
            selectInput(
              "ks_task2_color",
              "Task 2 color",
              choices = c("primary", "success", "info", "warning", "danger"),
              selected = "success"
            )
          ),
          box(
            width = 4,
            title = "Messages dropdown",
            status = "secondary",
            collapsible = FALSE,
            textInput("ks_msg_from", "Sender", value = "Admin"),
            textInput("ks_msg_text", "Message", value = "Release notes need final review."),
            textInput("ks_msg_time", "Time", value = "just now"),
            selectInput(
              "ks_msg_color",
              "Accent color",
              choices = c("primary", "success", "info", "warning", "danger"),
              selected = "danger"
            )
          )
        ),
        tags$h4("dropdownMenuOutput()/renderDropdownMenu() body preview", class = "mt-4 mb-3"),
        tags$p(
          "The top-right header menus are generated through dropdownMenuOutput() and renderDropdownMenu(). ",
          "This preview uses the same API in the body area."
        ),
        tags$div(
          class = "bg-dark rounded px-2 py-1 d-inline-flex",
          dropdownMenuOutput("ks_body_dropdown_preview")
        )
      ),
      tabItem(
        tabName = "sidebar_search",
        tags$h4("sidebarSearchForm() example", class = "mb-3"),
        tags$p(
          "The search form at the top of the sidebar is created with sidebarSearchForm(). ",
          "Type a term there and click the search button to submit it."
        ),
        shiny::fluidRow(
          box(
            width = 5,
            title = "What to try",
            status = "secondary",
            collapsible = FALSE,
            tags$ul(
              class = "mb-0",
              tags$li("Type in the sidebar search field and click the search icon"),
              tags$li("The current input value updates live below"),
              tags$li("Submitted queries are tracked with observeEvent()")
            )
          ),
          box(
            width = 7,
            title = "Search state",
            status = "secondary",
            collapsible = FALSE,
            tags$p(
              tags$strong("Current text: "),
              textOutput("ks_sidebar_search_current", inline = TRUE)
            ),
            tags$p(
              tags$strong("Last submitted: "),
              textOutput("ks_sidebar_search_last", inline = TRUE)
            ),
            tags$p(
              tags$strong("Submit count: "),
              textOutput("ks_sidebar_search_count", inline = TRUE)
            )
          )
        )
      ),
      tabItem(
        tabName = "sidebar_menu_outputs",
        tags$h4("menuItemOutput(), sidebarMenuOutput(), and renderMenu()", class = "mb-3"),
        tags$p(
          "A dynamic sidebar item is injected into the live sidebar via menuItemOutput()/renderMenu(). ",
          "Its label and badge follow the Value boxes metric slider."
        ),
        shiny::fluidRow(
          box(
            width = 5,
            title = "Live sidebar item",
            status = "secondary",
            collapsible = FALSE,
            tags$ul(
              class = "mb-0",
              tags$li("Open the live menu item in the sidebar: Live metric (...)"),
              tags$li("Move the Value boxes metric slider to update its badge and label"),
              tags$li("Click the live item to navigate to its tab content"),
              tags$li("In the preview menu, open 'Expandable' and click child links to navigate")
            )
          ),
          box(
            width = 7,
            title = "sidebarMenuOutput()/renderMenu() preview",
            status = "secondary",
            collapsible = FALSE,
            tags$div(
              class = "app-sidebar border rounded",
              style = "max-width: 340px;",
              tags$div(
                class = "sidebar-inner",
                sidebarMenuOutput("ks_sidebar_menu_preview")
              )
            )
          )
        )
      ),
      tabItem(
        tabName = "update_tab_items",
        tags$h4("updateTabItems() example", class = "mb-3"),
        tags$p(
          "Programmatically switch tabs from the server while keeping both the content tabset ",
          "and sidebar highlight synchronized."
        ),
        shiny::fluidRow(
          box(
            width = 5,
            title = "Controls",
            status = "secondary",
            collapsible = FALSE,
            selectInput(
              "ks_update_target_tab",
              "Target tab",
              choices = c(
                "Cards" = "cards",
                "Value boxes" = "value_boxes",
                "Info boxes" = "info_boxes",
                "Dropdown menus" = "dropdown_menus",
                "Sidebar search" = "sidebar_search",
                "Sidebar outputs" = "sidebar_menu_outputs",
                "Sub-items \u2192 Alpha (leaf inside collapsed parent)" = "sub_alpha"
              ),
              selected = "value_boxes"
            ),
            actionButton("ks_update_switch_tab", "Switch tab", status = "primary"),
            tags$hr(class = "my-3"),
            tags$p(
              tags$strong("Selected sidebar item (input$sidebar): "),
              textOutput("ks_sidebar_selected_item", inline = TRUE)
            )
          ),
          box(
            width = 7,
            title = "Live state",
            status = "secondary",
            collapsible = FALSE,
            tags$p(
              tags$strong("Selected body tabset value (input$sidebarMenu): "),
              textOutput("ks_tabset_selected_item", inline = TRUE)
            ),
            tags$p(
              class = "text-muted mb-0",
              "Click Switch tab to jump to a different section. The sidebar and body selection should update together."
            )
          )
        )
      ),

      # ── Badges tab ──────────────────────────────────────────────────────
      tabItem(
        tabName = "badges",
        tags$h4("badge() colours", class = "mb-3"),
        tags$div(
          class = "d-flex flex-wrap gap-3 mb-4",
          lapply(
            c("primary","secondary","success","info","warning","danger","light","dark"),
            function(s) badge(s, color = s)
          )
        ),
        tags$h4("Rounded (pill shape)", class = "mb-3"),
        tags$div(
          class = "d-flex flex-wrap gap-3",
          lapply(
            c("primary","success","danger"),
            function(s) badge(s, color = s, rounded = TRUE)
          )
        )
      ),

      # ── Value boxes tab ──────────────────────────────────────────────────
      tabItem(
        tabName = "value_boxes",
        tags$h4("valueBox() static examples", class = "mb-3"),
        shiny::fluidRow(
          valueBox(1200, "Total sales", icon = icon("graph-up"), color = "success"),
          valueBox(53, "Open issues", icon = icon("exclamation-triangle"), color = "warning"),
          valueBox(8, "Critical alerts", icon = icon("bell"), color = "danger")
        ),
        tags$h4("valueBoxOutput()/renderValueBox()", class = "mt-4 mb-3"),
        shiny::fluidRow(
          box(
            width = 4,
            title = "Controls",
            status = "secondary",
            collapsible = FALSE,
            sliderInput("vbox_input", "Metric value", min = 0, max = 200, value = 75),
            textInput("vbox_subtitle", "Subtitle", value = "Dynamic metric"),
            selectInput(
              "vbox_color",
              "Color",
              choices = c("aqua", "blue", "green", "yellow", "orange", "red", "primary", "success", "warning", "danger"),
              selected = "aqua"
            )
          ),
          valueBoxOutput("vbox_dynamic", width = 8)
        )
      ),
      tabItem(
        tabName = "info_boxes",
        tags$h4("infoBox() static examples", class = "mb-3"),
        shiny::fluidRow(
          infoBox(
            title = "CPU usage",
            value = "48%",
            subtitle = "Average over last 5 min",
            icon = icon("cpu"),
            color = "primary"
          ),
          infoBox(
            title = "Queue length",
            value = 17,
            subtitle = "Waiting jobs",
            icon = icon("inboxes"),
            color = "warning"
          ),
          infoBox(
            title = "Incidents",
            value = 2,
            subtitle = "Open severity-1",
            icon = icon("exclamation-triangle"),
            color = "danger",
            fill = TRUE
          )
        ),
        tags$h4("infoBoxOutput()/renderInfoBox()", class = "mt-4 mb-3"),
        shiny::fluidRow(
          box(
            width = 4,
            title = "Controls",
            status = "secondary",
            collapsible = FALSE,
            textInput("ibox_title", "Title", value = "Dynamic info"),
            sliderInput("ibox_value", "Value", min = 0, max = 100, value = 42),
            textInput("ibox_subtitle", "Subtitle", value = "Reactive metric"),
            selectInput(
              "ibox_color",
              "Color",
              choices = c("aqua", "blue", "green", "yellow", "orange", "red", "primary", "success", "warning", "danger"),
              selected = "primary"
            ),
            checkboxInput("ibox_fill", "Fill background", value = FALSE)
          ),
          infoBoxOutput("ibox_dynamic", width = 8)
        )
      ),

      # ── Accordion tab ───────────────────────────────────────────────────
      tabItem(
        tabName = "accordion",
        tags$h4("accordion()", class = "mb-3"),
        accordion(
          id = "demo_accordion",
          accordionItem(
            title = "Section 1 (default)",
            tags$p("Default accordion item — no status colour.")
          ),
          accordionItem(
            title = "Section 2 (success)",
            status = "success",
            tags$p("Accordion item with status = 'success'.")
          ),
          accordionItem(
            title = "Section 3 (warning)",
            status = "warning",
            tags$p("Accordion item with status = 'warning'.")
          ),
          accordionItem(
            title = "Section 4 (danger)",
            status = "danger",
            tags$p("Accordion item with status = 'danger'.")
          )
        )
      ),

      # ── Icons tab ───────────────────────────────────────────────────────
      tabItem(
        tabName = "icons",
        tags$h4("Bootstrap icons (primary lookup)", class = "mb-3"),
        tags$div(
          class = "d-flex flex-wrap gap-4",
          lapply(
            c("house", "star", "gear", "person", "bell", "envelope",
              "database", "cloud", "shield-check", "graph-up"),
            function(n) tags$div(class = "text-center", icon(n), tags$br(), tags$small(n))
          )
        ),
        tags$h4("Size and colour wrappers", class = "mt-4 mb-3"),
        tags$div(
          class = "d-flex align-items-center gap-4",
          icon("star", size = "1rem",  color = "gray"),
          icon("star", size = "1.5rem",color = "#0460A9"),
          icon("star", size = "2rem",  color = "green"),
          icon("star", size = "3rem",  color = "red")
        ),
        tags$h4("Font Awesome fallback + unknown placeholder", class = "mt-4 mb-3"),
        tags$div(
          class = "d-flex gap-4",
          tags$div(class = "text-center", icon("users"),      tags$br(), tags$small("users (FA)")),
          tags$div(class = "text-center", icon("check"),      tags$br(), tags$small("check (FA)")),
          tags$div(class = "text-center", icon("times"),      tags$br(), tags$small("times (FA)")),
          tags$div(class = "text-center", icon("truly-unknown-xyz123"),
                   tags$br(), tags$small("missing → placeholder"))
        )
      ),

      # ── Buttons tab ─────────────────────────────────────────────────────
      tabItem(
        tabName = "buttons",
        tags$h4("actionButton() status colours", class = "mb-3"),
        tags$div(
          class = "d-flex flex-wrap gap-2 mb-4",
          lapply(
            c("primary","secondary","success","info","warning","danger","dark"),
            function(s) actionButton(paste0("btn_", s), s, status = s)
          )
        ),
        tags$h4("Outline variants", class = "mb-3"),
        tags$div(
          class = "d-flex flex-wrap gap-2 mb-4",
          lapply(
            c("primary","success","warning","danger"),
            function(s) actionButton(paste0("btn_out_", s), s, status = s, outline = TRUE)
          )
        ),
        tags$h4("Sizes", class = "mb-3"),
        tags$div(
          class = "d-flex align-items-center flex-wrap gap-2 mb-4",
          actionButton("btn_lg",   "Large",   status = "primary", size = "lg"),
          actionButton("btn_md",   "Default", status = "primary"),
          actionButton("btn_sm",   "Small",   status = "primary", size = "sm")
        ),
        tags$h4("Flat (no border-radius)", class = "mb-3"),
        tags$div(
          class = "d-flex gap-2",
          actionButton("btn_flat",        "Flat",             status = "primary", flat = TRUE),
          actionButton("btn_flat_out",    "Flat + outline",   status = "primary", flat = TRUE, outline = TRUE)
        )
      ),
      tabItem(
        tabName = "sidebar_dynamic_metric",
        tags$h4("Dynamic sidebar menu item"),
        tags$p("This tab is linked from menuItemOutput()/renderMenu() in the live sidebar."),
        tags$p("Adjust the Value boxes slider to update the menu label and badge in real time.")
      ),
      tabItem(
        tabName = "sidebar_preview_metric",
        tags$h4("Sidebar preview: Metric details"),
        tags$p("Opened from the sidebarMenuOutput()/renderMenu() preview menu."),
        tags$p("The metric value shown in preview labels follows the Value boxes slider.")
      ),
      tabItem(
        tabName = "sidebar_preview_queue",
        tags$h4("Sidebar preview: Queue details"),
        tags$p("Opened from the sidebarMenuOutput()/renderMenu() preview menu."),
        tags$p("The queue value shown in preview labels follows the Info boxes value control.")
      ),

      # ── Sub-item tabs ────────────────────────────────────────────────────
      tabItem(tabName = "sub_alpha", tags$h4("Sub-item: Alpha"),
              tags$p("Navigated via a nested menuSubItem(). Sidebar item should highlight.")),
      tabItem(tabName = "sub_beta",  tags$h4("Sub-item: Beta"),
              tags$p("Sub-item Beta content.")),
      tabItem(tabName = "sub_gamma", tags$h4("Sub-item: Gamma"),
              tags$p("Sub-item Gamma content."))
    ),
    footer = dashboardFooter(
      left = "bslibdash Kitchen Sink",
      right = tagList(
        "Dashboard footer API",
        tags$span(class = "ms-2 text-muted", sprintf("v%s", utils::packageVersion("bslibdash")))
      ),
      fixed = FALSE
    )
  )
)

# ── Server ────────────────────────────────────────────────────────────────────

server <- function(input, output, session) {
  safe_text <- function(x, default) {
    if (is.null(x) || is.na(x) || !nzchar(trimws(as.character(x)))) {
      return(default)
    }
    as.character(x)
  }

  sidebar_search_last <- reactiveVal("No search submitted yet.")
  sidebar_search_count <- reactiveVal(0)

  output$ks_sidebar_search_current <- renderText({
    safe_text(input$ks_sidebar_search_text, "Type in the sidebar search box.")
  })

  output$ks_sidebar_search_last <- renderText({
    sidebar_search_last()
  })

  output$ks_sidebar_search_count <- renderText({
    as.character(sidebar_search_count())
  })

  observeEvent(input$ks_sidebar_search_button, {
    query <- trimws(safe_text(input$ks_sidebar_search_text, ""))
    if (!nzchar(query)) {
      shiny::showNotification("Enter a term in the sidebar search box.", type = "message")
      return()
    }

    sidebar_search_last(query)
    sidebar_search_count(sidebar_search_count() + 1)

    shiny::showNotification(sprintf("Sidebar search submitted: %s", query), type = "message")
  })

  output$ks_sidebar_dynamic_item <- renderMenu({
    current_metric <- input$vbox_input
    if (is.null(current_metric)) {
      current_metric <- 75
    }

    menuItem(
      text = sprintf("Live metric (%s)", current_metric),
      tabName = "sidebar_dynamic_metric",
      icon = icon("speedometer2", size = "1.1rem"),
      badgeLabel = as.character(current_metric),
      badgeColor = if (current_metric >= 80) "danger" else "info"
    )
  })

  output$ks_sidebar_menu_preview <- renderMenu({
    current_metric <- input$vbox_input
    if (is.null(current_metric)) {
      current_metric <- 75
    }

    current_info <- input$ibox_value
    if (is.null(current_info)) {
      current_info <- 42
    }

    sidebarMenu(
      id = "ks_sidebar_preview",
      sidebarHeader("Preview"),
      menuItem(
        "Live metric",
        tabName = "sidebar_preview_metric",
        icon = icon("speedometer2"),
        badgeLabel = as.character(current_metric),
        badgeColor = if (current_metric >= 80) "danger" else "info"
      ),
      menuItem(
        "Queue depth",
        tabName = "sidebar_preview_queue",
        icon = icon("inboxes"),
        badgeLabel = as.character(current_info),
        badgeColor = if (current_info >= 70) "warning" else "success"
      ),
      menuItem(
        "Expandable",
        icon = icon("diagram-3"),
        startExpanded = TRUE,
        menuSubItem(
          sprintf("Metric details (%s)", current_metric),
          tabName = "sidebar_preview_metric"
        ),
        menuSubItem(
          sprintf("Queue details (%s)", current_info),
          tabName = "sidebar_preview_queue"
        )
      )
    )
  })

  output$ks_sidebar_selected_item <- renderText({
    safe_text(input$sidebar, "No tab selected yet.")
  })

  output$ks_tabset_selected_item <- renderText({
    safe_text(input$sidebarMenu, "No tab selected yet.")
  })

  output$ks_notifications_menu <- renderDropdownMenu({
    notif1_status <- if (is.null(input$ks_notif1_status)) "warning" else input$ks_notif1_status
    notif2_status <- if (is.null(input$ks_notif2_status)) "success" else input$ks_notif2_status

    items <- list(
      notificationItem(
        text = safe_text(input$ks_notif1_text, "Build warning on staging"),
        icon = icon("exclamation-triangle"),
        status = notif1_status
      )
    )

    if (isTRUE(input$ks_notif2_enable)) {
      items <- c(
        items,
        list(
          notificationItem(
            text = safe_text(input$ks_notif2_text, "Three new signups"),
            icon = icon("person-plus"),
            status = notif2_status
          )
        )
      )
    }

    dropdownMenu(
      type = "notifications",
      badgeStatus = "warning",
      .list = items
    )
  })

  output$ks_tasks_menu <- renderDropdownMenu({
    task1_value <- if (is.null(input$ks_task1_value)) 72 else input$ks_task1_value
    task2_value <- if (is.null(input$ks_task2_value)) 88 else input$ks_task2_value
    task1_color <- if (is.null(input$ks_task1_color)) "info" else input$ks_task1_color
    task2_color <- if (is.null(input$ks_task2_color)) "success" else input$ks_task2_color

    dropdownMenu(
      type = "tasks",
      badgeStatus = "info",
      taskItem("Migration rollout", value = task1_value, color = task1_color),
      taskItem("Unit test coverage", value = task2_value, color = task2_color)
    )
  })

  output$ks_messages_menu <- renderDropdownMenu({
    current_metric <- input$vbox_input
    if (is.null(current_metric)) {
      current_metric <- 75
    }

    message_color <- if (is.null(input$ks_msg_color)) "danger" else input$ks_msg_color

    dropdownMenu(
      type = "messages",
      badgeStatus = "danger",
      messageItem(
        from = safe_text(input$ks_msg_from, "Admin"),
        message = safe_text(input$ks_msg_text, "Release notes need final review."),
        icon = icon("exclamation-circle"),
        time = safe_text(input$ks_msg_time, "just now"),
        color = message_color
      ),
      messageItem(
        from = "QA",
        message = sprintf("Current dynamic metric: %s", current_metric),
        icon = icon("graph-up"),
        time = "live",
        color = "info"
      )
    )
  })

  output$ks_body_dropdown_preview <- renderDropdownMenu({
    current_metric <- input$vbox_input
    if (is.null(current_metric)) {
      current_metric <- 75
    }

    message_color <- if (is.null(input$ks_msg_color)) "danger" else input$ks_msg_color

    dropdownMenu(
      type = "messages",
      badgeStatus = "primary",
      headerText = "Body preview menu",
      messageItem(
        from = safe_text(input$ks_msg_from, "Admin"),
        message = safe_text(input$ks_msg_text, "Release notes need final review."),
        icon = icon("chat-left-text"),
        time = safe_text(input$ks_msg_time, "just now"),
        color = message_color
      ),
      messageItem(
        from = "QA",
        message = sprintf("Current dynamic metric: %s", current_metric),
        icon = icon("graph-up"),
        time = "live",
        color = "info"
      )
    )
  })

  observeEvent(input$ks_update_switch_tab, {
    updateTabItems(
      session = session,
      inputId = "sidebar",
      selected = input$ks_update_target_tab
    )
  })

  output$vbox_dynamic <- renderValueBox({
    valueBox(
      value = input$vbox_input,
      subtitle = input$vbox_subtitle,
      icon = icon("speedometer2"),
      color = input$vbox_color,
      width = NULL
    )
  })
  output$ibox_dynamic <- renderInfoBox({
    infoBox(
      title = input$ibox_title,
      value = input$ibox_value,
      subtitle = input$ibox_subtitle,
      icon = icon("speedometer2"),
      color = input$ibox_color,
      fill = isTRUE(input$ibox_fill),
      width = NULL
    )
  })

  # Toast buttons
  observeEvent(input$btn_toast_info, {
    toast("Info toast", body = "Auto-hides after 5 seconds.", options = list(type = "message"))
  })
  observeEvent(input$btn_toast_warn, {
    toast("Warning toast", body = "Auto-hides after 5 seconds.", options = list(type = "warning"))
  })
  observeEvent(input$btn_toast_persist, {
    toast(
      "Persistent toast",
      body = "This stays until manually closed.",
      options = list(autohide = FALSE, type = "error")
    )
  })
  observeEvent(input$btn_toast_full, {
    toast(
      title    = "Deployment finished",
      body     = "All services are healthy and traffic is being routed.",
      subtitle = "Reviewed by ops \u00b7 2 mins ago",
      options  = list(type = "message", icon = bslibdash::icon("check-circle"))
    )
  })

  # updateBox controls
  observeEvent(input$ub_toggle,   updateBox("target_box", action = "toggle"))
  observeEvent(input$ub_maximize, updateBox("target_box", action = "toggleMaximize"))
  observeEvent(input$ub_remove,   updateBox("target_box", action = "remove"))
  observeEvent(input$ub_restore,  updateBox("target_box", action = "restore"))

  observeEvent(input$ub_apply_status, {
    updateBox("target_box", action = "update", options = list(status = input$ub_status))
  })
  observeEvent(input$ub_apply_title, {
    updateBox("target_box", action = "update", options = list(title = input$ub_title))
  })
}

shinyApp(ui, server)
