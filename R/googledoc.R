read_aml.drive_id <- function(x) {
  gd_check()

  if (length(x) != 1) {
    stop("This function only reads one document at a time")
  }

  meta <- googledrive::drive_get(x)$drive_resource[[1]]$mimeType

  if (meta == "application/vnd.google-apps.document") {
    type <- "txt"
  } else if (meta == "text/plain") {
    type <- NULL
  } else {
    stop("Only Google Docs and plain text files can be read from Google Drive.")
  }

  tf <- tempfile(fileext = ".txt")
  googledrive::drive_download(x,
    path = tf, type = type, overwrite = TRUE,
    verbose = FALSE
  )
  con <- file(tf)
  x <- read_aml.connection(con)
  close.connection(con)
  return(x)
}

gd_installed <- function() {
  x <- requireNamespace("googledrive", quietly = TRUE)
  return(x)
}

gd_check <- function() {
  if (!gd_installed()) {
    stop("The 'googledrive' package is required to read from Google Docs")
  }
}
