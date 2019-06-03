test_that("has_valid_status returns `TRUE`", {
  path <- test_path("private/fgeo/luquillo/stem")
  expect_true(has_valid_status(bind_fgeo(path)))
})
