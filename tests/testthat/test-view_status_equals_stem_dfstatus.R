library(purrr)
library(dplyr)

test_that("`view$Status` equals `fgeo$DFstatus`", {
  # Params
  path_stem_dir <- test_path("private/fgeo/luquillo/stem")
  path_view_csv <-
    test_path("private/View/luquillo/ViewFullTable_luquillo.csv")

  expect_true(view_status_equals_stem_dfstatus(path_view_csv, path_stem_dir))
})
