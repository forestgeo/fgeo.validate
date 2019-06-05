test_that("status_is_expected returns `TRUE`", {
  skip("Not a crucial test right now--and takes long to run.")
  path_stem_dir <- test_path("private/fgeo/luquillo/stem")
  path_view_csv <-
    test_path("private/View/luquillo/ViewFullTable_luquillo.csv")

  # One dead tree in census 5 was later found alive--so its status is ammended.
  expect_false(
    status_is_straightforward(compare_status(path_view_csv, path_stem_dir))
  )
})
