create_fgeo_tables <- function(plotname) {
  rtbl::rtbl(
    read_view("FullTable", plotname),
    read_view("Taxonomy", plotname),
    plotname = plotname
  )
}

read_view <- function(.table = NULL, plotname = NULL) {
  if (!grepl("fulltable|taxonomy", tolower(.table))) {
    abort("`.table` must match 'fulltable' or 'taxonomy'")
  }

  path <- fs::dir_ls(
    path = testthat::test_path("private", "view", plotname %||% ""),
    regexp = .table,
    ignore.case = TRUE
  )

  if (grepl("fulltable", tolower(.table))) {
    return(fgeo.tool::read_vft(path))
  }

  fgeo.tool::read_taxa(path)
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

