#' @importFrom rlang %||%
view <- function(path = NULL, regexp = NULL) {
  .file <- fs::dir_ls(
    fs::path("data-raw", "private", "view", path %||% ""),
    regexp = regexp
  )
  # fgeo.tool::read_vft(.file)
  .file
}

rtbl::rtbl(
  view("luquillo", "FullTable"),
  view("luquillo", "Taxonomy"),
  plotname = "luquillo"
)
