test_that("status_is_expected returns `TRUE`", {
  path_stem_dir <- test_path("private/fgeo/luquillo/stem")
  path_view_csv <-
    test_path("private/View/luquillo/ViewFullTable_luquillo.csv")

  expect_true(
    status_is_expected(compare_status(path_view_csv, path_stem_dir))
  )
})
