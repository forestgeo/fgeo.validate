add_id <- function(.data) {
  out <- tidyr::unite(
    rlang::set_names(.data, tolower),
    "id",
    .data$treeid, .data$stemid, .data$censusid,
    remove = FALSE
  )
  dplyr::bind_cols(out["id"], .data)
}
