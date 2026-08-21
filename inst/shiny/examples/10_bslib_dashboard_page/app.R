library(shiny)
library(bslib)
library(ggplot2)

ui <- bslibdash::dashboardPage(
  header = bslibdash::dashboardHeader("Test"),
  sidebar = bslibdash::dashboardSidebar(
    bslibdash::sidebarMenu(
      id = "sidebar",
      bslibdash::sidebarHeader("Shiny App"),
      bslibdash::menuItem("Test Card", tabName = "TestCard", icon = bslibdash::icon("database"))
    )
  ),
  body = bslibdash::dashboardBody(
    shinyjs::useShinyjs(),
    bslibdash::tabItems(
      bslibdash::tabItem(
        tabName = "TestCard",
        shiny::fluidRow(
          bslibdash::box(
            width = 12,
            title = "Test Card",
            collapsible = TRUE,
            status = "primary",
            maximizable = TRUE,
            id = "input_card",
            shiny::div(
              varSelectInput("var", "Select variable", mtcars),
              plotOutput("p")
            )
          )
        )
      )
    )
  )
)

server <- function(input, output) {
  output$p <- renderPlot({
    ggplot(mtcars) + geom_histogram(aes(!!input$var))
  })
}

shinyApp(ui, server)
