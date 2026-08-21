capture_runjs_calls <- function(expr) {
  scripts <- character()

  testthat::with_mocked_bindings(
    {
      force(expr)
    },
    runjs = function(script) {
      scripts <<- c(scripts, script)
      invisible(NULL)
    },
    .package = "shinyjs"
  )

  scripts
}

test_that("updateBox() supports all non-update actions", {
  session <- list(ns = function(id) paste0("mod-", id))

  remove_calls <- capture_runjs_calls(
    updateBox("card_1", action = "remove", session = session)
  )
  expect_equal(length(remove_calls), 1)
  expect_true(grepl("#mod-card_1", remove_calls[[1]], fixed = TRUE))
  expect_true(grepl("addClass('d-none')", remove_calls[[1]], fixed = TRUE))

  restore_calls <- capture_runjs_calls(
    updateBox("card_1", action = "restore", session = session)
  )
  expect_equal(length(restore_calls), 1)
  expect_true(grepl("#mod-card_1", restore_calls[[1]], fixed = TRUE))
  expect_true(grepl("removeClass('d-none')", restore_calls[[1]], fixed = TRUE))

  toggle_calls <- capture_runjs_calls(
    updateBox("card_1", action = "toggle", session = session)
  )
  expect_equal(length(toggle_calls), 1)
  expect_true(grepl("#mod-card_1 .card-toggle-btn", toggle_calls[[1]], fixed = TRUE))
  expect_true(grepl("trigger('click')", toggle_calls[[1]], fixed = TRUE))

  maximize_calls <- capture_runjs_calls(
    updateBox("card_1", action = "toggleMaximize", session = session)
  )
  expect_equal(length(maximize_calls), 1)
  expect_true(grepl("#mod-card_1 .fullscreen-toggle", maximize_calls[[1]], fixed = TRUE))
  expect_true(grepl("trigger('click')", maximize_calls[[1]], fixed = TRUE))
})

test_that("updateBox() update action applies all supported options", {
  session <- list(ns = function(id) paste0("mod-", id))

  calls <- capture_runjs_calls(
    updateBox(
      id = "card_1",
      action = "update",
      options = list(
        status = "warning",
        background = "dark",
        title = "<Admin>",
        width = 6,
        height = 200
      ),
      session = session
    )
  )

  expect_equal(length(calls), 5)
  expect_true(any(grepl("#mod-card_1 \\.card-header", calls)))
  expect_true(any(grepl("addClass\\('bg-warning'\\)", calls)))
  expect_true(any(grepl("#mod-card_1'\\)\\.removeClass", calls)))
  expect_true(any(grepl("addClass\\('bg-dark'\\)", calls)))
  expect_true(any(grepl("\\.text\\('&lt;Admin&gt;'\\)", calls)))
  expect_true(any(grepl("\\.css\\('width', '50%'", calls)))
  expect_true(any(grepl("\\.css\\('height', '200px'", calls)))
})

test_that("updateBox() validates update status options", {
  session <- list(ns = function(id) id)

  expect_error(
    updateBox(
      id = "card_1",
      action = "update",
      options = list(status = "not-a-status"),
      session = session
    ),
    "Invalid status color",
    fixed = TRUE
  )

  expect_error(
    updateBox(
      id = "card_1",
      action = "update",
      options = list(background = "also-invalid"),
      session = session
    ),
    "Invalid status color",
    fixed = TRUE
  )
})
