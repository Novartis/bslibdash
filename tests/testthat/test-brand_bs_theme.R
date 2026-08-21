test_that("brand_bs_theme() sets the BrandLab primary color", {
  theme <- brand_bs_theme()
  
  expect_s3_class(theme, "bs_theme")
  var <- bslib::bs_get_variables(theme, "primary")
  expect_identical(var, c(primary = "#0460A9"))
})

test_that("brand_bs_theme() can be extended via bslib API", {
  theme2 <- brand_bs_theme() |>
    bslib::bs_add_variables(primary = "#8B0000")
  
  expect_s3_class(theme2, "bs_theme")
  expect_identical(
    bslib::bs_get_variables(theme2, "primary"),
    c(primary = "#8B0000")
  )
})
