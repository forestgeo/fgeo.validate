#' Is `fgeo$status` the expected value based on `view$Status`?
#'
#' @param data Dataframe, the output of `compare_status()`.
#'
#' @return Logical.
#' @export
status_is_expected <- function(data) {
  unexpected <- dplyr::filter(data, !.data$status_is_expected)
  identical(nrow(unexpected), 0L)
}

#' Compare status between a ViewFullTable and a fgeo table.
#'
#' @inheritParams view_status_equals_stem_dfstatus
#'
#' @return A dataframe.
#' @export
#' @importFrom stringr str_detect
compare_status <- function(path_view_csv, path_stem_dir) {
  fv <- join_fgeo_and_view(path_view_csv, path_stem_dir)
  fv_status <- dplyr::rename(
    fv[str_detect(names(fv), "id|atus")],
    status_view = .data$Status,
    status_fgeo = .data$status
  )

  fv_status %>%
    dplyr::mutate(
      status_is_expected =
        dplyr::case_when(
          str_detect(.data$status_view, "alive") &
            str_detect(.data$status_fgeo, "A") ~ TRUE,
          str_detect(.data$status_view, "dead") &
            str_detect(.data$status_fgeo, "D") ~ TRUE,
          str_detect(.data$status_view, "broken below|stem dead") &
            str_detect(.data$status_fgeo, "G") ~ TRUE,
          str_detect(.data$status_view, "missing") &
            str_detect(.data$status_fgeo, "M") ~ TRUE,
          str_detect(.data$status_view, "prior") &
            str_detect(.data$status_fgeo, "P") ~ TRUE,
          TRUE ~ FALSE
        )
    )
}
