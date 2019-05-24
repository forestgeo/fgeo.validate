library(purrr)
library(dplyr)

test_that("`view$Status` equals `fgeo$DFstatus`", {
  view <- fgeo.tool::read_vft(
    test_path("private/View/luquillo/ViewFullTable_luquillo.csv")
  )
  fgeo <- tor::list_rdata(test_path("private/fgeo/luquillo/full"))
  fgeo_combined <- purrr::reduce(fgeo, dplyr::bind_rows)

  n_startswith_na <- add_id(fgeo_combined) %>%
    filter(grepl("^NA_", .data$id)) %>%
    nrow()
  expect_equal(n_startswith_na, 0L)

  n_endswith_na <- add_id(fgeo_combined) %>%
    filter(grepl("NA$", .data$id)) %>%
    nrow()
  expect_equal(n_endswith_na, 0L)

  f <- add_id(fgeo_combined)
  expect_equal(
    length(f$id),
    length(unique(f$id))
  )

  v <- add_id(view)
  expect_equal(
    length(v$id),
    length(unique(v$id))
  )

  joint <- left_join(
    select(v, id, Status),
    select(add_id(fgeo_combined), id, DFstatus),
    by = "id"
  )

  result <- joint %>%
    mutate(
      is_matching_status = purrr::map2_lgl(
        .data$Status, .data$DFstatus, identical
      )
    ) %>%
    filter(!is.na(Status)) %>%
    filter(!is_matching_status)

  expect_equal(nrow(result), 0L)
})
