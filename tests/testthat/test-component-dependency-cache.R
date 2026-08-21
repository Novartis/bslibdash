test_that("bslibdash_component_dependency() distinct components are NOT collapsed by bslib's shared memoise cache", {
  # Regression guard for a bslib memoise-cache collision:
  # `bs_dependency_defer()` wraps its argument with
  # `memoise::memoise(func, cache = .dependency_cache)`. memoise keys the
  # shared cache on `list(formals(f), as.character(body(f)))` + call args
  # only — the closure environment is *not* part of the key. Without
  # deliberate disambiguation, every helper-built closure produced by
  # `bslibdash_component_dependency()` hashes identically and every
  # component after the first is served the first component's compiled
  # dependency. We work around this by giving the sole `theme` formal a
  # per-component default (`formals(build)$theme <- name`), which changes
  # `formals(f)` per component without touching arity. This test pins
  # the workaround.
  # Track upstream at <https://github.com/rstudio/bslib/issues/TBD>.

  d_card <- bslibdash_component_dependency("card",    "card.scss",    "bslib_card.js")
  d_sbar <- bslibdash_component_dependency("sidebar", "sidebar.scss", "dash.js")

  dep_card <- d_card()
  dep_sbar <- d_sbar()

  expect_s3_class(dep_card, "html_dependency")
  expect_s3_class(dep_sbar, "html_dependency")
  expect_identical(dep_card$name, "bslibdash-card")
  expect_identical(dep_sbar$name, "bslibdash-sidebar")
})

test_that("bslibdash_component_dependency() closure has exactly one formal (shiny::registerThemeDependency arity check)", {
  # `shiny::registerThemeDependency()` is called by bslib at render time
  # and hard-errors when `length(formals(func)) != 1`. Any workaround
  # that adds an *extra* formal to the closure — a natural instinct for
  # beating memoise's cache-key collision — breaks Shiny rendering:
  #
  #   Error in shiny::registerThemeDependency:
  #     `func` must be a function with one argument (the current theme)
  #
  # Our workaround gives the sole `theme` formal a per-component default
  # instead, keeping arity at 1. This test pins that invariant so anyone
  # who reaches for the extra-formal trick again fails in unit tests
  # instead of at first render.
  dep_tagfun <- bslibdash_component_dependency("core", "core.scss")
  env <- environment(dep_tagfun)
  func <- env[["func"]]
  if (is.null(func)) {
    skip("bslib::bs_dependency_defer no longer exposes an internal `func`")
  }
  expect_length(formals(func), 1L)
})

test_that("bslibdash_component_dependency() reuses the memoise cache on repeat resolutions with a stable theme", {
  # In a running Shiny app, `bs_dependency_defer()`'s internal `mfunc`
  # is called with `get_current_theme()`, which returns the same theme
  # object across renders. Bypass the tagFunction wrapper (which
  # otherwise synthesises a fresh `bs_theme()` each time in the
  # non-Shiny path) and call the memoised inner function directly with
  # a stable theme; memoise should return byte-identical results.
  dep_tagfun <- bslibdash_component_dependency("core", "core.scss")
  env <- environment(dep_tagfun)
  mfunc <- env[["mfunc"]]
  if (is.null(mfunc)) {
    skip("bslib::bs_dependency_defer no longer exposes an internal `mfunc`")
  }
  theme <- bslib::bs_theme(version = 5)

  first  <- mfunc(theme)
  second <- mfunc(theme)

  expect_s3_class(first,  "html_dependency")
  expect_identical(first, second)
})

test_that("bslibdash_component_dependency() resolves to a valid html_dependency", {
  dep <- bslibdash_component_dependency("core", "core.scss")()

  expect_s3_class(dep, "html_dependency")
  expect_identical(dep$name, "bslibdash-core")
  expect_identical(dep$version, as.character(utils::packageVersion("bslibdash")))
})

test_that("bslibdash_component_dependency() attaches script when supplied", {
  dep <- bslibdash_component_dependency("card", "card.scss", "bslib_card.js")()

  expect_s3_class(dep, "html_dependency")
  expect_true(any(grepl("bslib_card.js", dep$script, fixed = TRUE)))
})
