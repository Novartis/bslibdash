validStatuses <- c(
  "primary",
  "secondary",
  "success",
  "info",
  "warning",
  "danger",
  "light",
  "dark"
)

validateStatus <- function(status) {
  if (is.null(status)) {
    return(invisible(TRUE))
  }

  invalid <- setdiff(status, validStatuses)
  if (length(invalid) > 0) {
    stop(
      "Invalid status color: ",
      paste(invalid, collapse = ", "),
      ". Valid values are: ",
      paste(validStatuses, collapse = ", "),
      ".",
      call. = FALSE
    )
  }

  invisible(TRUE)
}

generate_color_documentation <- function(colors) {
  paste(colors, collapse = ", ")
}

dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

css_unit <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }

  if (is.numeric(x)) {
    return(paste0(x, "px"))
  }

  x
}

width_unit <- function(width) {
  if (is.null(width)) {
    return(NULL)
  }

  if (is.numeric(width) && length(width) == 1 && width <= 12) {
    return(sprintf("%s%%", round(width / 12 * 100, 6)))
  }

  css_unit(width)
}

bslibdash_www_path <- function(..., mustWork = TRUE) {
  installed_path <- system.file("www", ..., package = "bslibdash")
  if (nzchar(installed_path)) {
    return(installed_path)
  }

  normalizePath(file.path("inst", "www", ...), mustWork = mustWork)
}

icon_or_tag <- function(icon) {
  if (is.null(icon)) {
    return(NULL)
  }

  if (inherits(icon, "shiny.tag") || inherits(icon, "shiny.tag.list") || inherits(icon, "html")) {
    return(icon)
  }

  bslibdash::icon(icon)
}

is_unknown_fontawesome_message <- function(message_text) {
  grepl("does not correspond to a known icon", message_text, fixed = TRUE)
}

fontawesome_icon_or_null <- function(name, class = NULL, style = NULL) {
  unknown_icon <- FALSE
  icon_tag <- tryCatch(
    withCallingHandlers(
      shiny::icon(
        name = name,
        class = class,
        lib = "font-awesome",
        style = style
      ),
      message = function(m) {
        if (is_unknown_fontawesome_message(conditionMessage(m))) {
          unknown_icon <<- TRUE
          invokeRestart("muffleMessage")
        }
      }
    ),
    error = function(e) NULL
  )

  if (isTRUE(unknown_icon)) {
    return(NULL)
  }

  icon_tag
}

unknown_icon_placeholder <- function(name, class = NULL, style = NULL) {
  label <- paste(as.character(name), collapse = "")
  if (is.na(label) || !nzchar(label)) {
    label <- "unknown"
  }

  htmltools::tags$span(
    class = paste(c("icon-missing", class), collapse = " "),
    style = style,
    title = sprintf("Unknown icon: %s", label),
    role = "img",
    `aria-label` = sprintf("Unknown icon: %s", label),
    "?"
  )
}

fontawesome_icon_or_missing <- function(name, class = NULL, style = NULL) {
  fontawesome_icon_or_null(
    name = name,
    class = class,
    style = style
  ) %||% unknown_icon_placeholder(
    name = name,
    class = class,
    style = style
  )
}

hash_id <- function(...) {
  substr(rlang::hash(list(...)), 1, 12)
}

sanitize_html_id_fragment <- function(value, fallback = "item") {
  cleaned <- gsub("[^[:alnum:]_-]", "", paste(as.character(value), collapse = ""))
  if (nzchar(cleaned)) {
    cleaned
  } else {
    fallback
  }
}
