create_fgeo_tables <- function(plotname) {
  rtbl::rtbl(
    read_view("FullTable", plotname),
    read_view("Taxonomy", plotname),
    plotname = plotname
  )
}

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

add_id <- function(.data) {
  out <- tidyr::unite(
    rlang::set_names(.data, tolower),
    "id",
    .data$treeid, .data$stemid, .data$censusid,
    remove = FALSE
  )
  dplyr::bind_cols(out["id"], .data)
}

