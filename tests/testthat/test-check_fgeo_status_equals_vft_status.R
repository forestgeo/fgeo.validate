test_that("check_fgeo_status_equals_vft_status", {
  plotname <- "luquillo"
  view <- read_view("FullTable", plotname)
  fgeo <- tor::list_rdata(
    here::here("data-raw", "private", "fgeo", plotname, "full")
  )
  fgeo_combined <- purrr::reduce(fgeo, dplyr::bind_rows)

  library(tidyverse)
  add_id(fgeo_combined) %>%
    filter(!is.na()) %>%
    select(id, treeID, stemID) %>%
    add_count(id) %>%
    filter(n > 1)

  f <- add_id(fgeo_combined)
  length(f$id)
  length(unique(f$id))



  add_id(fgeo[[1]])
  f <- add_id(fgeo[[1]])
  v <- add_id(view)

})
