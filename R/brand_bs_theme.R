#' Default bslibdash brand theme
#'
#' Builds a Bootstrap 5 theme via [bslib::bs_theme()] with the bslibdash brand
#' colour, typography and shape variables.
#'
#' Component CSS is no longer bundled into the theme: each bslibdash component
#' attaches its own theme-aware [bslib::bs_dependency_defer()] dependency, so
#' rendering a component with any `bslib::bs_theme()` produces the matching
#' bslibdash styles. `brand_bs_theme()` exists to set the Bootstrap-level
#' variables used as defaults by bslibdash page constructors.
#'
#' `dashboardPage()` applies this theme by default. To customise it, override
#' variables or rules via bslib and pass the result through the page `theme`
#' argument:
#'
#' \preformatted{
#' dashboardPage(
#'   header = dashboardHeader(),
#'   sidebar = dashboardSidebar(),
#'   body = dashboardBody(),
#'   theme = brand_bs_theme() |>
#'     bslib::bs_add_variables(primary = "#8B0000")
#' )
#' }
#'
#' @return A `bslib` theme object.
#' @examples
#' theme <- brand_bs_theme()
#' class(theme)
#' @export
brand_bs_theme <- function() {
  bslib::bs_theme(
    version = 5,
    bootswatch = "bootstrap",
    # Brand anchor
    primary = "#0460A9",

    # Body
    `body-color` = "#111827",

    # Typography
    `font-family-sans-serif` = 'system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue",
                              Arial, "Noto Sans", "Liberation Sans", sans-serif',
    `font-size-base` = "1rem",
    `line-height-base` = 1.45,
    `headings-font-weight` = 650,
    `headings-line-height` = 1.15,

    # Shape
    `border-radius`    = ".75rem",
    `border-radius-sm` = ".5rem",
    `border-radius-lg` = "1rem",

    # Borders (compile-time rgba needs Sass to compute)
    `border-width` = "1px",
    `border-color` = "rgba($body-color, 0.10)",

    # Focus ring
    `focus-ring-width`   = ".2rem",
    `focus-ring-opacity` = .22,
    `focus-ring-color`   = "rgba(var(--bs-primary-rgb), $focus-ring-opacity)",

    # Buttons
    `btn-font-weight`  = 600,
    `btn-padding-y`    = ".45rem",
    `btn-padding-x`    = ".75rem",
    `btn-border-radius` = "$border-radius-sm",
    `btn-hover-color` = "$body-color",

    # Cards
    `card-border-color`  = "$border-color",
    `card-border-radius` = "$border-radius",

    # Shadows
    `enable-shadows` = TRUE,
    `box-shadow-sm`  = "0 .25rem .75rem rgba($body-color, 0.06)",
    `box-shadow`     = "0 .50rem 1.25rem rgba($body-color, 0.08)",
    `box-shadow-lg`  = "0 1.00rem 2.50rem rgba($body-color, 0.10)",

    # transitions
    `transition-collapse` = "height 0.01s ease"
  )
}
