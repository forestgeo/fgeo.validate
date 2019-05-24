read_view <- function(.table = NULL, plotname = NULL) {
  if (!grepl("fulltable|taxonomy", .table, ignore.case = TRUE)) {
    abort("`.table` must match 'full' or 'taxa'")
  }

  path <- fs::path("data-raw", "private", "view", plotname %||% "")

  if (grepl("full", .table, ignore.case = TRUE)) {
    result <- fgeo.tool::read_vft(fs::dir_ls(path = path, regexp = .table))
  } else {
    result <- fgeo.tool::read_taxa(fs::dir_ls(path = path, regexp = .table))
  }

  result
}

# yosemite
rtbl::rtbl(
  read_view("FullTable", "luquillo"),
  read_view("Taxonomy", "luquillo"),
  plotname = "yosemite"
)
