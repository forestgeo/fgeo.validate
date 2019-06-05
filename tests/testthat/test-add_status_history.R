test_that("add_status_history adds the expected history", {
  data <- tibble::tribble(
    ~censusID, ~DFstatus,
    1,         "alive",
    2,         "alive",
    3,         "dead",
    4,         "alive"
  )

  expect_named(
    add_status_history(data), c("CensusID", "DFstatus", "status_history")
  )
})
