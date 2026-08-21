test_that("column() smoke test", {
  ui <- column(
    width = 6,
    offset = 1,
    "content"
  ) |>
    htmltools::tagQuery()

  expect_true(ui$hasClass("col-sm-6"))
  expect_true(grepl("content", as.character(ui$allTags()), fixed = TRUE))
})
