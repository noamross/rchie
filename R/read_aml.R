read_aml <- function(x, ...) {
  UseMethod("read_aml")
}

read_aml.default <- function(x, ...) {
  stop(
    "Don't know how to read AML from object of class ",
    paste0(class(x), collapse = "/")
  )
}

read_aml.character <- function(x, ...) {
  if (length(x) != 1 || grepl("\n", x)) {
    return(x)
  }
  if (is_url(x)) {
    if (requireNamespace("curl", quietly = TRUE)) {
      con <- curl::curl(x)
    }
    else {
      con <- url(x)
    }
    x <- read_aml.connection(con)
    close.connection(con)
  } else if (file.exists(x)) {
    con <- file(x)
    x <- read_aml.connection(con)
    close.connection(con)
  }
  return(x)
}

read_aml.connection <- function(x, ...) {
  readLines(x, warn = FALSE, ...)
}

## functions cribbed from readr
is_url <- function(path) {
  length(path) == 1 && grepl("^(http|ftp)s?://", path)
}
