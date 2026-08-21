library(shiny)
library(bslibdash)

ui <- dashboardPage(
  header = dashboardHeader("updateBox demo"),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Update Box", tabName = "update", icon = icon("gear"))
    )
  ),
  body = dashboardBody(
    shinyjs::useShinyjs(),
    tabItems(
      tabItem(
        tabName = "update",
        shiny::fluidRow(
          box(
            id = "demo_box",
            title = "A collapsible card",
            status = "primary",
            width = 6,
            collapsible = TRUE,
            closable = TRUE,
            maximizable = TRUE,
            "Use the buttons on the right to update this card from the server."
          ),
          box(
            title = "Controls",
            status = "secondary",
            width = 6,
            collapsible = FALSE,
            shiny::div(
              class = "d-flex flex-column gap-2",
              actionButton("btn_toggle",   "Toggle collapse",   status = "primary",   size = "sm"),
              actionButton("btn_maximize", "Toggle fullscreen", status = "info",      size = "sm"),
              actionButton("btn_hide",     "Hide card",         status = "warning",   size = "sm"),
              actionButton("btn_restore",  "Restore card",      status = "success",   size = "sm"),
              hr(),
              shiny::selectInput(
                "new_status", "Change header colour",
                choices = c("primary", "secondary", "success", "info", "warning", "danger"),
                selected = "primary"
              ),
              actionButton("btn_status", "Apply colour", status = "dark", size = "sm"),
              hr(),
              shiny::textInput("new_title", "Change title", value = "A collapsible card"),
              actionButton("btn_title", "Apply title", status = "dark", size = "sm")
            )
          )
        )
      )
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$btn_toggle,   updateBox("demo_box", action = "toggle"))
  observeEvent(input$btn_maximize, updateBox("demo_box", action = "toggleMaximize"))
  observeEvent(input$btn_hide,     updateBox("demo_box", action = "remove"))
  observeEvent(input$btn_restore,  updateBox("demo_box", action = "restore"))

  observeEvent(input$btn_status, {
    updateBox("demo_box", action = "update", options = list(status = input$new_status))
  })

  observeEvent(input$btn_title, {
    updateBox("demo_box", action = "update", options = list(title = input$new_title))
  })
}

shinyApp(ui, server)
