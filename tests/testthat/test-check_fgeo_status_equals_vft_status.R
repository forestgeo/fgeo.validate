test_that("check_fgeo_status_equals_vft_status", {
  read_view <- function(.table = NULL, plotname = NULL) {
    if (!grepl("fulltable|taxonomy", .table, ignore.case = TRUE)) {
      rlang::abort("`.table` must match 'fulltable' or 'taxonomy'")
    }

    path <- fs::path("data-raw", "private", "view", plotname %||% "")

    if (grepl("fulltable", .table, ignore.case = TRUE)) {
      result <- fgeo.tool::read_vft(
        fs::dir_ls(path = path, regexp = .table, ignore.case = TRUE)
      )
    } else {
      result <- fgeo.tool::read_taxa(
        fs::dir_ls(path = path, regexp = .table, ignore.case = TRUE)
      )
    }

    result
  }

  plotname <- "luquillo"
  view <- read_view("fulltable", plotname)
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
