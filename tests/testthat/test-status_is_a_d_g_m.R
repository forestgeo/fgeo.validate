test_that("status_is_a_d_g_m returns `TRUE`", {
  testthat::skip("skip while refactoring")
  # Params
  path_stem_dir <- test_path("private/fgeo/luquillo/stem")
  path_view_csv <-
    test_path("private/View/luquillo/ViewFullTable_luquillo.csv")

  fv <- join_fgeo_and_view(path_view_csv, path_stem_dir)

  expect_true(
    status_is_a_d_g_m(path_view_csv, path_stem_dir)
  )
})
