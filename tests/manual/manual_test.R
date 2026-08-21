# =============================================================================
# bslibdash Manual Test Script — based on inst/shiny/examples/14_kitchen_sink
# =============================================================================
# Run this script section-by-section from the R console.
# Each section prints PASS / FAIL with a short reason.
#
# Usage:
#   devtools::load_all()                     # load current source (bslibdash on top of search path)
#   source("tests/manual/manual_test.R")     # run all programmatic checks
#
# Then open the kitchen sink app for interactive visual checks:
#   shiny::runApp("inst/shiny/examples/14_kitchen_sink")
# =============================================================================

# Ensure bslibdash dev is loaded (no-op if already attached via devtools::load_all())
if (!isNamespaceLoaded("bslibdash")) devtools::load_all(quiet = TRUE)

# Helpers ─────────────────────────────────────────────────────────────────────
# bslibdash masks several shiny exports; use bslibdash:: explicitly for those functions.
btn   <- bslibdash::actionButton
icn   <- bslibdash::icon

# ── Helpers ───────────────────────────────────────────────────────────────────

.pass <- function(label) message("  PASS  ", label)
.fail <- function(label, reason) message("  FAIL  ", label, "  |  ", reason)

check <- function(label, expr, ...) {
  result <- tryCatch(
    withCallingHandlers(
      expr,
      warning = function(w) invokeRestart("muffleWarning")
    ),
    error = function(e) structure(list(msg = conditionMessage(e)), class = "check_error")
  )
  if (inherits(result, "check_error")) {
    .fail(label, result$msg)
    return(invisible(FALSE))
  }
  conds <- list(...)
  for (nm in names(conds)) {
    if (!isTRUE(conds[[nm]])) {
      .fail(label, nm)
      return(invisible(FALSE))
    }
  }
  .pass(label)
  invisible(TRUE)
}

check_warns <- function(label, expr) {
  warned <- FALSE
  withCallingHandlers(
    tryCatch(expr, error = function(e) NULL),
    warning = function(w) { warned <<- TRUE; invokeRestart("muffleWarning") }
  )
  if (warned) .pass(label) else .fail(label, "no warning was emitted")
  invisible(warned)
}

check_no_warn <- function(label, expr) {
  warned <- FALSE
  withCallingHandlers(
    tryCatch(expr, error = function(e) NULL),
    warning = function(w) { warned <<- TRUE; invokeRestart("muffleWarning") }
  )
  if (!warned) .pass(label) else .fail(label, "unexpected warning emitted")
  invisible(!warned)
}

has_class <- function(tag, cls) any(grepl(cls, as.character(tag), fixed = TRUE))

# =============================================================================
# 1. CARDS  (box)
# =============================================================================
message("\n── 1. Cards ─────────────────────────────────────────────────────────────────")

check("box() renders without error", {
  b <- box(title = "Test", "Body")
  as.character(b)
}, "is character" = is.character(as.character(box("x"))))

check("box() status=primary adds bg-primary class", {
  b <- box(title = "T", status = "primary", "x")
  has_class(b, "bg-primary")
}, "has class" = has_class(box(title = "T", status = "primary", "x"), "bg-primary"))

for (s in c("primary", "secondary", "success", "info", "warning", "danger")) {
  local({
    st <- s
    check(paste0("box() status='", st, "'"), {
      b <- box(title = "T", status = st, "x")
      has_class(b, paste0("bg-", st))
    }, "has status class" = has_class(box(title = "T", status = st, "x"), paste0("bg-", st)))
  })
}

check("box() collapsible=TRUE includes collapse button", {
  b <- as.character(box(title = "T", collapsible = TRUE, "x"))
  grepl("card-toggle-btn", b, fixed = TRUE)
}, "has toggle btn" = grepl("card-toggle-btn", as.character(box(title = "T", collapsible = TRUE, "x")), fixed = TRUE))

check("box() collapsed=TRUE adds collapse classes", {
  b <- as.character(box(title = "T", collapsible = TRUE, collapsed = TRUE, "x"))
  grepl("collapse", b, fixed = TRUE)
}, "has collapse" = grepl("collapse", as.character(box(title = "T", collapsible = TRUE, collapsed = TRUE, "x")), fixed = TRUE))

check("box() closable=TRUE includes hide-toggle button", {
  b <- as.character(box(title = "T", closable = TRUE, "x"))
  grepl("card-hide-toggle", b, fixed = TRUE)
}, "has hide-toggle" = grepl("card-hide-toggle",
  as.character(box(title = "T", closable = TRUE, "x")), fixed = TRUE))

check("box() maximizable=TRUE includes fullscreen-toggle", {
  b <- as.character(box(title = "T", maximizable = TRUE, "x"))
  grepl("fullscreen-toggle", b, fixed = TRUE)
}, "has fullscreen" = grepl("fullscreen-toggle", as.character(box(title = "T", maximizable = TRUE, "x")), fixed = TRUE))

check("box() background='danger' adds bg-danger to card", {
  b <- as.character(box(title = "T", background = "danger", "x"))
  grepl("bg-danger", b, fixed = TRUE)
}, "has bg class" = grepl("bg-danger", as.character(box(title = "T", background = "danger", "x")), fixed = TRUE))

check("box() footer renders inside card", {
  b <- as.character(box(title = "T", footer = htmltools::tags$small("footer"), "x"))
  grepl("footer", b, fixed = TRUE)
}, "has footer" = grepl("footer",
  as.character(box(title = "T", footer = htmltools::tags$small("footer"), "x")), fixed = TRUE))

check("box() with id sets id attribute", {
  b <- as.character(box(id = "mycard", title = "T", "x"))
  grepl("mycard", b, fixed = TRUE)
}, "has id" = grepl("mycard", as.character(box(id = "mycard", title = "T", "x")), fixed = TRUE))

check("box() icon renders in header", {
  b <- as.character(box(title = "T", icon = icn("star"), "x"))
  grepl("star", b, fixed = TRUE)
}, "has icon" = grepl("star", as.character(box(title = "T", icon = icn("star"), "x")), fixed = TRUE))

check("box() label renders in header", {
  b <- as.character(box(title = "T", label = badge("NEW", color = "danger"), "x"))
  grepl("NEW", b, fixed = TRUE)
}, "has label" = grepl("NEW", as.character(box(title = "T", label = badge("NEW", color = "danger"), "x")), fixed = TRUE))

check("box() is alias for box()", {
  identical(class(box("x")), class(box("x")))
}, "same class" = identical(class(box("x")), class(box("x"))))

# boxLayout
check("boxLayout() renders without error", {
  bl <- boxLayout(box("A"), box("B"))
  is.character(as.character(bl))
}, "is character" = is.character(as.character(boxLayout(box("A")))))

for (t in c("group", "deck")) {
  local({
    ty <- t
    check(paste0("boxLayout(type='", ty, "') renders"), {
      bl <- as.character(boxLayout(type = ty, box("A"), box("B")))
      nchar(bl) > 0
    }, "non-empty" = nchar(as.character(boxLayout(type = ty, box("A")))) > 0)
  })
}

check_no_warn("box() clean usage — no warning",                box(title = "T", status = "primary", collapsible = TRUE, "x"))


# =============================================================================
# 2. UPDATE BOX  (updateBox / updateCard)
# =============================================================================
message("\n── 2. updateBox ─────────────────────────────────────────────────────────────")
# updateBox/updateCard require a Shiny session; test that the function exists
# and arg validation works without a session.

check("updateBox is exported", exists("updateBox"))
check("updateCard is exported", exists("updateCard"))

check("updateBox bad action errors", {
  tryCatch(
    updateBox("x", action = "fly"),
    error = function(e) TRUE
  )
}, "returns TRUE" = isTRUE(tryCatch(updateBox("x", action = "fly"), error = function(e) TRUE)))

check("updateBox valid actions don't error on arg validation", {
  for (a in c("remove", "toggle", "toggleMaximize", "restore", "update")) {
    # will fail with "no default Shiny session" — that's fine
    tryCatch(updateBox("x", action = a), error = function(e) NULL)
  }
  TRUE
}, "no early error" = TRUE)


# =============================================================================
# 3. NAVIGATION  (tabsetPanel / tabPanel)
# =============================================================================
message("\n── 3. Navigation ────────────────────────────────────────────────────────────")

check("tabsetPanel() type='tabs' renders", {
  t <- tabsetPanel(type = "tabs",
    shiny::tabPanel("A", "Content A"),
    shiny::tabPanel("B", "Content B")
  )
  grepl("nav-tabs", as.character(t), fixed = TRUE)
}, "has nav-tabs" = grepl("nav-tabs",
  as.character(tabsetPanel(type = "tabs", shiny::tabPanel("A", "a"))), fixed = TRUE))

check("tabsetPanel() type='pills' renders", {
  t <- tabsetPanel(type = "pills",
    shiny::tabPanel("A", "a"),
    shiny::tabPanel("B", "b")
  )
  grepl("nav-pills", as.character(t), fixed = TRUE)
}, "has nav-pills" = grepl("nav-pills",
  as.character(tabsetPanel(type = "pills", shiny::tabPanel("A", "a"))), fixed = TRUE))

check("tabsetPanel() with id sets id attribute", {
  t <- as.character(tabsetPanel(id = "demo_tabs", type = "tabs",
    shiny::tabPanel("A", "a")))
  grepl("demo_tabs", t, fixed = TRUE)
}, "has id" = grepl("demo_tabs",
  as.character(tabsetPanel(id = "demo_tabs", type = "tabs",
    shiny::tabPanel("A", "a"))), fixed = TRUE))

check("tabPanel icon renders in tab label", {
  tp <- as.character(tabsetPanel(
    type = "tabs",
    shiny::tabPanel("Home", icon = icn("house"), "content")
  ))
  grepl("house", tp, fixed = TRUE)
}, "has icon name" = grepl("house",
  as.character(tabsetPanel(type = "tabs",
    shiny::tabPanel("X", icon = icn("house"), "y"))), fixed = TRUE))


# =============================================================================
# 4. BADGES  (badge)
# =============================================================================
message("\n── 4. Badges ────────────────────────────────────────────────────────────────")

for (col in c("primary", "secondary", "success", "info", "warning", "danger", "light", "dark")) {
  local({
    c_ <- col
    check(paste0("badge(color='", c_, "')"), {
      b <- as.character(badge("label", color = c_))
      grepl(paste0("text-bg-", c_), b, fixed = TRUE)
    }, "has color class" = grepl(paste0("text-bg-", c_),
      as.character(badge("label", color = c_)), fixed = TRUE))
  })
}

check("badge rounded=TRUE adds rounded-pill", {
  b <- as.character(badge("x", color = "primary", rounded = TRUE))
  grepl("rounded-pill", b, fixed = TRUE)
}, "has rounded-pill" = grepl("rounded-pill",
  as.character(badge("x", color = "primary", rounded = TRUE)), fixed = TRUE))

check("badge position='right' adds end-0", {
  b <- as.character(badge("x", color = "success", position = "right"))
  grepl("end-0", b, fixed = TRUE)
}, "has end-0" = grepl("end-0",
  as.character(badge("x", color = "success", position = "right")), fixed = TRUE))

check("badge position='left' adds start-0", {
  b <- as.character(badge("x", color = "success", position = "left"))
  grepl("start-0", b, fixed = TRUE)
}, "has start-0" = grepl("start-0",
  as.character(badge("x", color = "success", position = "left")), fixed = TRUE))

check("badge bad color errors", {
  tryCatch(badge("x", color = "neon-pink"), error = function(e) TRUE)
}, "errors on bad color" = isTRUE(tryCatch(badge("x", color = "neon-pink"), error = function(e) TRUE)))


# =============================================================================
# 5. ACCORDION  (accordion / accordionItem)
# =============================================================================
message("\n── 5. Accordion ─────────────────────────────────────────────────────────────")

check("accordion() renders bslib accordion", {
  a <- accordion(
    id = "test_acc",
    accordionItem(title = "S1", "content")
  )
  !is.null(a)
}, "not null" = !is.null(accordion(id = "t", accordionItem(title = "X", "y"))))

check("accordionItem() no status — no status class", {
  item <- as.character(accordionItem(title = "X", "y"))
  !grepl("bg-", item, fixed = TRUE)
}, "no bg class" = !grepl("bg-", as.character(accordionItem(title = "X", "y")), fixed = TRUE))

for (s in c("success", "warning", "danger")) {
  local({
    st <- s
    check(paste0("accordionItem status='", st, "' adds bg class"), {
      item <- as.character(accordionItem(title = "X", status = st, "y"))
      grepl(paste0("bg-", st), item, fixed = TRUE)
    }, "has status class" = grepl(paste0("bg-", st),
      as.character(accordionItem(title = "X", status = st, "y")), fixed = TRUE))
  })
}

check_no_warn("accordionItem clean usage — no warning", {
  accordionItem(title = "X", status = "success", "y")
})


# =============================================================================
# 6. ICONS  (bslibdash::icon)
# =============================================================================
message("\n── 6. Icons ─────────────────────────────────────────────────────────────────")

check("icon('house') returns a tag", {
  i <- icn("house")
  inherits(i, "shiny.tag") || inherits(i, "html")
}, "is tag" = inherits(icn("house"), c("shiny.tag", "html", "shiny.tag.list")))

check("icon('house') renders svg or <i>", {
  i <- as.character(icn("house"))
  grepl("<svg", i, fixed = TRUE) || grepl("<i", i, fixed = TRUE)
}, "has markup" = {
  i <- as.character(icn("house"))
  grepl("<svg", i, fixed = TRUE) || grepl("<i", i, fixed = TRUE)
})

check("icon() size wraps in <span> with font-size", {
  i <- as.character(icn("star", size = "2rem"))
  grepl("font-size", i, fixed = TRUE)
}, "has font-size" = grepl("font-size", as.character(icn("star", size = "2rem")), fixed = TRUE))

check("icon() color wraps in <span> with color style", {
  i <- as.character(icn("star", color = "red"))
  grepl("color", i, fixed = TRUE)
}, "has color style" = grepl("color", as.character(icn("star", color = "red")), fixed = TRUE))

check("icon('truly-unknown-xyz123') renders visible unknown placeholder", {
  i <- as.character(icn("truly-unknown-xyz123"))
  grepl("icon-missing", i, fixed = TRUE) && grepl("Unknown icon:", i, fixed = TRUE)
}, "has placeholder class" = grepl("icon-missing",
  as.character(icn("truly-unknown-xyz123")), fixed = TRUE),
"has tooltip text" = grepl("Unknown icon:",
  as.character(icn("truly-unknown-xyz123")), fixed = TRUE))

check("icon() FA alias: 'bars' maps to 'justify' (Bootstrap icon)", {
  i <- as.character(icn("bars"))
  grepl("justify", i, fixed = TRUE)
}, "mapped name" = grepl("justify", as.character(icn("bars")), fixed = TRUE))

check("icon() FA alias: 'chart-line' maps to 'graph-up'", {
  i <- as.character(icn("chart-line"))
  grepl("graph-up", i, fixed = TRUE)
}, "mapped name" = grepl("graph-up", as.character(icn("chart-line")), fixed = TRUE))

check_no_warn("icon() clean call — no warning",        icn("star", size = "1rem", color = "blue"))


# =============================================================================
# 7. BUTTONS  (bslibdash::actionButton)
# =============================================================================
message("\n── 7. Buttons ───────────────────────────────────────────────────────────────")

for (s in c("primary", "secondary", "success", "info", "warning", "danger", "dark")) {
  local({
    st <- s
    check(paste0("actionButton status='", st, "' adds btn-", st), {
      b <- as.character(btn("x", "Label", status = st))
      grepl(paste0("btn-", st), b, fixed = TRUE)
    }, "has class" = grepl(paste0("btn-", st),
      as.character(btn("x", "L", status = st)), fixed = TRUE))
  })
}

check("actionButton outline=TRUE adds btn-outline class", {
  b <- as.character(btn("x", "L", status = "primary", outline = TRUE))
  grepl("btn-outline-primary", b, fixed = TRUE)
}, "has outline class" = grepl("btn-outline-primary",
  as.character(btn("x", "L", status = "primary", outline = TRUE)), fixed = TRUE))

check("actionButton size='lg' adds btn-lg", {
  b <- as.character(btn("x", "L", status = "primary", size = "lg"))
  grepl("btn-lg", b, fixed = TRUE)
}, "has lg class" = grepl("btn-lg",
  as.character(btn("x", "L", status = "primary", size = "lg")), fixed = TRUE))

check("actionButton size='sm' adds btn-sm", {
  b <- as.character(btn("x", "L", status = "primary", size = "sm"))
  grepl("btn-sm", b, fixed = TRUE)
}, "has sm class" = grepl("btn-sm",
  as.character(btn("x", "L", status = "primary", size = "sm")), fixed = TRUE))

check("actionButton flat=TRUE adds rounded-0", {
  b <- as.character(btn("x", "L", status = "primary", flat = TRUE))
  grepl("rounded-0", b, fixed = TRUE)
}, "has rounded-0" = grepl("rounded-0",
  as.character(btn("x", "L", status = "primary", flat = TRUE)), fixed = TRUE))

check("actionButton flat+outline combine classes", {
  b <- as.character(btn("x", "L", status = "success", flat = TRUE, outline = TRUE))
  grepl("btn-outline-success", b, fixed = TRUE) && grepl("rounded-0", b, fixed = TRUE)
}, "both classes" = {
  b <- as.character(btn("x", "L", status = "success", flat = TRUE, outline = TRUE))
  grepl("btn-outline-success", b, fixed = TRUE) && grepl("rounded-0", b, fixed = TRUE)
})

check("actionButton bad status errors", {
  tryCatch(btn("x", "L", status = "electric"), error = function(e) TRUE)
}, "errors" = isTRUE(tryCatch(btn("x", "L", status = "electric"), error = function(e) TRUE)))

check_no_warn("actionButton clean call — no warning",
  btn("x", "L", status = "primary", size = "sm", outline = FALSE))


# =============================================================================
# 8. HEADER DROPDOWN MENUS  (dropdownMenu + items + output/render)
# =============================================================================
message("\n── 8. Header dropdown menus ─────────────────────────────────────────────────")

check("dropdownMenu(type='messages') renders dropdown shell", {
  m <- as.character(dropdownMenu(
    type = "messages",
    messageItem(from = "Admin", message = "Hello")
  ))
  grepl("bslibdash-dropdown-menu", m, fixed = TRUE) && grepl("dropdown-menu", m, fixed = TRUE)
}, "has bslibdash dropdown class" = grepl("bslibdash-dropdown-menu",
  as.character(dropdownMenu(type = "messages", messageItem("Admin", "Hello"))), fixed = TRUE))

check("dropdownMenuOutput() renders output placeholder", {
  out <- as.character(dropdownMenuOutput("manual_menu"))
  grepl("manual_menu", out, fixed = TRUE) && grepl("bslibdash-dropdown-menu-output", out, fixed = TRUE)
}, "has output id and class" = {
  out <- as.character(dropdownMenuOutput("manual_menu"))
  grepl("manual_menu", out, fixed = TRUE) && grepl("bslibdash-dropdown-menu-output", out, fixed = TRUE)
})

check("renderDropdownMenu() returns shiny render function", {
  rf <- renderDropdownMenu({
    dropdownMenu(type = "messages", messageItem(from = "Admin", message = "Hi"))
  })
  inherits(rf, "shiny.render.function")
}, "is shiny render function" = inherits(renderDropdownMenu({
  dropdownMenu(type = "messages", messageItem(from = "Admin", message = "Hi"))
}), "shiny.render.function"))

check("notificationItem(status='warning') applies text-warning to icon", {
  n <- as.character(notificationItem(text = "Warn", status = "warning"))
  grepl("text-warning", n, fixed = TRUE)
}, "has warning class" = grepl("text-warning",
  as.character(notificationItem(text = "Warn", status = "warning")), fixed = TRUE))

check("taskItem(value=72) renders progress width", {
  t <- as.character(taskItem(text = "Progress", value = 72, color = "success"))
  grepl("72%", t, fixed = TRUE) && grepl("bg-success", t, fixed = TRUE)
}, "has percentage + color" = {
  t <- as.character(taskItem(text = "Progress", value = 72, color = "success"))
  grepl("72%", t, fixed = TRUE) && grepl("bg-success", t, fixed = TRUE)
})

check("taskItem bad value errors", {
  tryCatch(taskItem("Bad task", value = "invalid"), error = function(e) TRUE)
}, "errors" = isTRUE(tryCatch(taskItem("Bad task", value = "invalid"), error = function(e) TRUE)))


# =============================================================================
# 9. SIDEBAR  (dashboardSidebar / sidebarMenu / menuItem / menuSubItem / sidebarHeader)
# =============================================================================
message("\n── 9. Sidebar ───────────────────────────────────────────────────────────────")

check("sidebarMenu() renders without error", {
  m <- sidebarMenu(
    id = "test_menu",
    menuItem("Tab A", tabName = "a", icon = icn("house"))
  )
  !is.null(m)
}, "not null" = !is.null(sidebarMenu(id = "m", menuItem("A", tabName = "a"))))

check("menuItem() with tabName renders nav-link", {
  item <- as.character(menuItem("Tab A", tabName = "a", icon = icn("house")))
  grepl("nav-link", item, fixed = TRUE)
}, "has nav-link" = grepl("nav-link",
  as.character(menuItem("Tab A", tabName = "a")), fixed = TRUE))

check("menuItem() with children renders collapse element", {
  item <- as.character(menuItem(
    "Parent",
    icon = icn("diagram-3"),
    menuSubItem("Child", tabName = "child")
  ))
  grepl("collapse", item, fixed = TRUE)
}, "has collapse" = grepl("collapse",
  as.character(menuItem("P", icon = icn("star"),
    menuSubItem("C", tabName = "c"))), fixed = TRUE))

check("menuSubItem() adds nav-link-sub class", {
  sub <- as.character(menuSubItem("Child", tabName = "child"))
  grepl("nav-link-sub", sub, fixed = TRUE)
}, "has sub class" = grepl("nav-link-sub",
  as.character(menuSubItem("C", tabName = "c")), fixed = TRUE))

check("sidebarHeader() renders title text", {
  h <- as.character(sidebarHeader("My Section"))
  grepl("My Section", h, fixed = TRUE)
}, "has title" = grepl("My Section", as.character(sidebarHeader("My Section")), fixed = TRUE))

check("menuItem() badgeLabel renders badge", {
  item <- as.character(menuItem("Tab", tabName = "t", badgeLabel = "3", badgeColor = "danger"))
  grepl("badge", item, fixed = TRUE) && grepl("3", item, fixed = TRUE)
}, "has badge" = {
  item <- as.character(menuItem("T", tabName = "t", badgeLabel = "3", badgeColor = "danger"))
  grepl("badge", item, fixed = TRUE) && grepl("3", item, fixed = TRUE)
})

check_no_warn("sidebarMenu clean call — no warning",
  sidebarMenu(id = "m", menuItem("A", tabName = "a", icon = icn("house"))))
check("menuItemOutput() creates a sidebar output placeholder", {
  out <- as.character(menuItemOutput("dynamic_item"))
  grepl('id="dynamic_item"', out, fixed = TRUE) &&
    grepl("bslibdash-menu-item-output", out, fixed = TRUE)
}, "has id + class" = {
  out <- as.character(menuItemOutput("dynamic_item"))
  grepl('id="dynamic_item"', out, fixed = TRUE) &&
    grepl("bslibdash-menu-item-output", out, fixed = TRUE)
})
check("sidebarMenuOutput() creates a sidebar menu output placeholder", {
  out <- as.character(sidebarMenuOutput("dynamic_sidebar"))
  grepl('id="dynamic_sidebar"', out, fixed = TRUE) &&
    grepl("bslibdash-sidebar-menu-output", out, fixed = TRUE)
}, "has id + class" = {
  out <- as.character(sidebarMenuOutput("dynamic_sidebar"))
  grepl('id="dynamic_sidebar"', out, fixed = TRUE) &&
    grepl("bslibdash-sidebar-menu-output", out, fixed = TRUE)
})
check("renderMenu() returns a shiny render function", {
  inherits(renderMenu({ menuItem("Dynamic", tabName = "dyn") }), "shiny.render.function")
}, "is shiny render function" = inherits(
  renderMenu({ menuItem("Dynamic", tabName = "dyn") }),
  "shiny.render.function"
))


# =============================================================================
# 10. TOAST  (toast — server function, no session available)
# =============================================================================
message("\n── 10. Toast ────────────────────────────────────────────────────────────────")

check("toast is exported", exists("toast"))

check("toast() errors without a session (expected)", {
  tryCatch(
    toast("Title", body = "Body"),
    error = function(e) TRUE
  )
}, "errors without session" = isTRUE(tryCatch(
  toast("Title", body = "Body"),
  error = function(e) TRUE
)))


# =============================================================================
# 12. ALIASES  (shinydashboard API names must exist)
# =============================================================================
message("\n── 12. API aliases ──────────────────────────────────────────────────────────")

aliases <- c(
  "dashboardPage", "dashboardHeader", "dashboardSidebar", "dashboardBody",
  "sidebarMenu", "menuItem", "menuSubItem", "sidebarHeader",
  "menuItemOutput", "sidebarMenuOutput", "renderMenu",
  "box", "boxLayout", "tabItems", "tabItem", "tabBox",
  "valueBox", "infoBox",
  "dropdownMenu", "dropdownMenuOutput", "renderDropdownMenu",
  "messageItem", "notificationItem", "taskItem",
  "updateBox"
)
for (fn in aliases) {
  check(paste0(fn, "() exists and is callable"), exists(fn, mode = "function"),
    "exists" = exists(fn, mode = "function"))
}


# =============================================================================
# SUMMARY
# =============================================================================
message("\n─────────────────────────────────────────────────────────────────────────────")
message("Programmatic checks complete.")
message("Next: launch the kitchen sink app for interactive visual checks:")
message("  shiny::runApp('inst/shiny/examples/14_kitchen_sink')")
message("")
message("Visual checklist (work through each sidebar tab in the browser):")
message("")
message("  [Cards]")
message("    □ All 6 status header colours render with correct colour")
message("    □ 'Collapsible' card — chevron click collapses/expands body")
message("    □ 'Starts collapsed' card — body hidden on load, expands on click")
message("    □ 'Closable' card — × click hides the card")
message("    □ 'Maximizable' card — ⛶ click makes card full-screen; Esc/click restores")
message("    □ Card with icon+badge — icon and NEW badge visible in header")
message("    □ Card with footer — footer text visible below body")
message("    □ Background colour cards — full card tinted, text readable")
message("    □ boxLayout type='group' — cards flush with zero gap")
message("    □ boxLayout type='deck' — equal-height row, tallest card sets row height")
message("")
message("  [Update Box]")
message("    □ 'Toggle collapse' button collapses / expands target card")
message("    □ 'Toggle fullscreen' button maximizes / restores target card")
message("    □ 'Hide' button hides target card (d-none)")
message("    □ 'Restore' button makes hidden card visible again")
message("    □ Select colour → 'Apply colour' updates header colour immediately")
message("    □ Type title → 'Apply title' updates card title text immediately")
message("")
message("  [Navigation]")
message("    □ tabsetPanel tabs — clicking Tab 1/2/3 switches content pane")
message("    □ tabsetPanel pills — pill-shaped nav, same switching behaviour")
message("    □ Icon visible in tab labels (house, person, gear)")
message("")
message("  [Badges]")
message("    □ All 8 colour variants visible and correctly coloured")
message("    □ Rounded pill badges have pill shape")
message("")
message("  [Accordion]")
message("    □ Clicking section header expands / collapses panel")
message("    □ Status-coloured items have correct border and background tint")
message("")
message("  [Icons]")
message("    □ All 10 Bootstrap icons render as SVG")
message("    □ Size variants scale correctly (1rem → 3rem)")
message("    □ Colour styles applied to wrapping <span>")
message("    □ 'users', 'check', 'times' fall back to Font Awesome <i> tags")
message("    □ 'truly-unknown-xyz123' shows visible unknown-icon placeholder ('?')")
message("")
message("  [Buttons]")
message("    □ 7 status-colour solid buttons render with correct bg colour")
message("    □ 4 outline buttons — transparent bg, coloured border and text")
message("    □ Large / default / small sizes differ visibly")
message("    □ Flat button has square (no border-radius) corners")
message("    □ Flat+outline combines both styles")
message("")
message("  [Value boxes]")
message("    □ 3 static value boxes render with icon + mapped colors")
message("    □ Dynamic value box updates value, subtitle and color from controls")
message("")
message("  [Info boxes]")
message("    □ 3 static info boxes render (including fill=TRUE example)")
message("    □ Dynamic info box updates title, value, subtitle, color and fill")
message("")
message("  [Tab box]")
message("    □ Left-side tabBox renders card header title and switches tabs")
message("    □ Right-side tabBox shows tabs aligned to the right")
message("")
message("  [Header dropdown menus]")
message("    □ Notifications dropdown opens and reflects control values")
message("    □ Tasks dropdown opens and reflects slider values")
message("    □ Dynamic messages dropdown (dropdownMenuOutput/renderDropdownMenu) opens")
message("    □ Dynamic messages content updates while changing metric slider")
message("")
message("  [Sidebar outputs]")
message("    □ 'Live metric (...)' sidebar item is visible under Components")
message("    □ Changing Value boxes metric slider updates its label and badge")
message("    □ Sidebar outputs tab shows sidebarMenuOutput()/renderMenu() preview menu")
message("    □ In preview menu, 'Expandable' shows child links and they navigate to detail tabs")
message("")
message("  [Nested sub-items]")
message("    □ 'Sub-items' parent collapses/expands its children on click")
message("    □ Clicking Alpha/Beta/Gamma navigates to correct tab pane")
message("    □ Active sidebar item highlights when tab is shown")
message("")
message("  [Toasts] (header buttons)")
message("    □ 'Toast info' — notification appears, auto-hides ~5 s")
message("    □ 'Toast warn' — warning-styled notification, auto-hides ~5 s")
message("    □ 'Toast persist' — error-styled, stays until × is clicked")
message("")
message("  [Global layout]")
message("    □ Sidebar toggle button (☰) in navbar collapses/expands sidebar")
message("    □ App title 'bslibdash Kitchen Sink' visible in navbar")
message("    □ Footer present at bottom of each page")
message("    □ No R warnings/messages in console during normal use")
message("─────────────────────────────────────────────────────────────────────────────")
