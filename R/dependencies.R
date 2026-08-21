#' Internal: theme-aware component dependencies
#'
#' Helpers that emit `bslib::bs_dependency_defer()` so each component carries
#' its own SCSS (and optional JS), in line with the bslib
#' "Dynamically themeable component" pattern.
#'
#' bslibdash always assumes a `bslib::bs_theme()` is active. If a page is
#' rendered without one, we compile against a vanilla Bootstrap 5 theme so
#' components keep working, but consumers are expected to use
#' [brand_bs_theme()] or their own `bs_theme()`.
#'
#' @keywords internal
#' @noRd
NULL

# Shared core dependency: runtime CSS variables + body / icon-missing styles.
# Attach this alongside any component dependency that consumes --app-* tokens.
bslibdash_core_dependency <- function() {
  bslibdash_component_dependency(name = "core", scss = "core.scss")
}

# Build a deferred, theme-aware dependency for a single bslibdash component.
#
# @param name dependency suffix; final name is `bslibdash-<name>`
# @param scss SCSS entrypoint filename, relative to `inst/www/bslib/scss/`
# @param script optional JS filename, relative to `inst/www/bslib/`
bslibdash_component_dependency <- function(name, scss, script = NULL) {
  force(name)
  force(scss)
  force(script)

  build <- function(theme) {
    if (!bslib::is_bs_theme(theme)) theme <- bslib::bs_theme(version = 5)
    script_path <- if (!is.null(script)) bslibdash_www_path("bslib", script)
    bslib::bs_dependency(
      input     = sass::sass_file(bslibdash_www_path("bslib", "scss", scss)),
      theme     = theme,
      name      = paste0("bslibdash-", name),
      version   = as.character(utils::packageVersion("bslibdash")),
      .dep_args = if (!is.null(script_path)) list(script = script_path) else list()
    )
  }
  # Give the sole `theme` formal a per-component default so bslib's shared
  # memoise cache keys distinctly per component. `bs_dependency_defer()`
  # memoises `build` against a package-wide cache keyed on
  # `formals(f)` + `body(f)` + call args; factory-built closures share
  # body AST, so without this, every component after the first is served
  # the first component's compiled artefact. bslib always calls the
  # closure positionally so the default is never consulted, and arity
  # stays at 1 so `shiny::registerThemeDependency()`'s arity check passes.
  # See <bslib-issue-URL>.
  formals(build)$theme <- name

  bslib::bs_dependency_defer(build)
}
