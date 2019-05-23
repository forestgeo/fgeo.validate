#' @importFrom rlang %||%
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

fgeo_done <- fs::path_file(fs::dir_ls("data-raw/private/fgeo"))
view_all <- fs::path_file(fs::dir_ls("data-raw/private/view"))
is_done <- view_all %in% fgeo_done
view_todo <- view_all[!is_done]
view_todo

# luquillo
rtbl::rtbl(
  read_view("FullTable", "luquillo"),
  read_view("Taxonomy", "luquillo"),
  plotname = "luquillo"
)

# hkk
rtbl::rtbl(
  read_view("FullTable", "luquillo"),
  read_view("Taxonomy", "luquillo"),
  plotname = "hkk"
)

# palanan
rtbl::rtbl(
  read_view("FullTable", "luquillo"),
  read_view("Taxonomy", "luquillo"),
  plotname = "palanan"
)

# yosemite
rtbl::rtbl(
  read_view("FullTable", "luquillo"),
  read_view("Taxonomy", "luquillo"),
  plotname = "yosemite"
)



# TODO: onecensus
