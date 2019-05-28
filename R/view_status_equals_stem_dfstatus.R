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
  view <- fgeo.tool::read_vft(path_view_csv)
  fgeo <- tor::list_rdata(path_stem_dir)
  fgeo_combined <- purrr::reduce(fgeo, dplyr::bind_rows)

  n_startswith_na <- add_id(fgeo_combined) %>%
    filter(grepl("^NA_", .data$id)) %>%
    nrow()
  expect_equal(n_startswith_na, 0L)

  n_endswith_na <- add_id(fgeo_combined) %>%
    filter(grepl("NA$", .data$id)) %>%
    nrow()
  expect_equal(n_endswith_na, 0L)

  fgeo_table <- add_id(fgeo_combined)
  expect_equal(
    length(fgeo_table$id),
    length(unique(fgeo_table$id))
  )

  view_table <- add_id(view)
  expect_equal(
    length(view_table$id),
    length(unique(view_table$id))
  )

  fgeo_and_view <- left_join(
    select(view_table, id, Status),
    select(add_id(fgeo_combined), id, DFstatus),
    by = "id"
  )

  fgeo_and_view %>%
    mutate(
      is_matching_status = purrr::map2_lgl(
        .data$Status, .data$DFstatus, ~ isTRUE(all.equal(.x, .y))
      )
    ) %>%
    filter(!is.na(Status)) %>%
    filter(!is_matching_status)
}
