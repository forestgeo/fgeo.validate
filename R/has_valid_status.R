#' Title
#'
#' @param data A fgeo dataframe.
#'
#' @return Logical.
#' @export
has_valid_status <- function(data) {
  all(unique(data$status) %in% valid_status())
}

valid_status <- function() {
  c("A", "D", "G", "M", "P")
}
