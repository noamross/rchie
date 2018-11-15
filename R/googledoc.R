gd_installed <- function() {
  is.element("googledrive", installed.packages()[,1])
}


tf <- tempfile()
gdoc <- as_id("https://docs.google.com/document/d/1JjYD90DyoaBuRYNxa4_nqrHKkgZf1HrUj30i3rTWX1s/edit")
dtxt <- drive_download(gdoc, path = tf, type = "txt", overwrite = TRUE, verbose = FALSE)
readLines(dtxt$local_path)
dhtm <- drive_download(gdoc, path = tf, type = "html", overwrite = TRUE, verbose = FALSE)
readLines(dhtm$local_path)
