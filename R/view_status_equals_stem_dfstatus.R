#' Is the variable Status of a ViewFullTable equal to DFstatus of a stem table?
#'
#' Check that `DFstatus` is exactly the same as the `Status` variable in
#' ViewFullTable.
#'
#' @param path_view_csv A file, e.g. "ViewFullTable.csv".
#' @param path_stem_dir A directory, e.g. "stem"
#'
#' @return Logical.
#' @export
#'
#' @examples
#' \dontrun{
#' path_stem_dir <- test_path("private/fgeo/luquillo/stem")
#' path_view_csv <-
#'   test_path("private/View/luquillo/ViewFullTable_luquillo.csv")
#' view_status_equals_fgeo_dfstatus(path_view_csv, path_stem_dir)
#' }
view_status_equals_stem_dfstatus <- function(path_view_csv, path_stem_dir) {
  df <- different_status_df(path_view_csv, path_stem_dir)
  identical(nrow(df), 0L)
}

different_status_df <- function(path_view_csv, path_stem_dir) {
  join_fgeo_and_view(path_view_csv, path_stem_dir) %>%
    dplyr::mutate(
      is_matching_status = purrr::map2_lgl(
        .data$Status, .data$DFstatus, ~ isTRUE(all.equal(.x, .y))
      )
    ) %>%
    dplyr::filter(!is.na(Status)) %>%
    dplyr::filter(!is_matching_status)
}

join_fgeo_and_view <- function(path_view_csv, path_stem_dir) {
  view <- fgeo.tool::read_vft(path_view_csv)

  dplyr::left_join(
    dplyr::select(add_id(view), dplyr::everything()),
    dplyr::select(add_id(bind_fgeo(path_stem_dir)), dplyr::everything()),
    by = "id"
  )
}

bind_fgeo <- function(path) {
  purrr::reduce(tor::list_rdata(path), dplyr::bind_rows)
}
