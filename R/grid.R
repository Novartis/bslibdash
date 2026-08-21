#' Column system
#'
#' @param width The grid width of the column.
#' @param ... Elements to include within the column.
#' @param offset The number of columns to offset this column.
#'
#' @examples
#' shiny::fluidRow(
#'   column(8, shiny::p("Main content")),
#'   column(4, shiny::p("Side panel"))
#' )
#'
#' @export
column <- function(width, ..., offset = 0) {
  shiny::column(width = width, ..., offset = offset)
}
