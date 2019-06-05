library(tidyverse)
out <- compare_status(path_view_csv, path_stem_dir)

out %>%
  filter(!status_is_expected)

# # A tibble: 1 x 5
# id             status_view DFstatus status_fgeo status_is_expected
# <chr>          <chr>       <chr>    <chr>       <lgl>
#   1 95178_128572_5 dead        dead     A           FALSE

view <- read_view("fulltable", "luquillo")
path <- test_path("private/fgeo/luquillo/stem")
fgeo <- tor::list_rdata(path)

pick_bad_row <- function(data) {
  rlang::set_names(data, tolower) %>%
    filter(
      treeid == "95178",
      # censusid == 5,
      stemid == "128572"
    ) %>%
    select(treeid, stemid, matches("status"), censusid)
}

pick_bad_row(view)
pick_bad_row(fgeo[[5]])
