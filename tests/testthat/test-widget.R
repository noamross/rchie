if (requireNamespace("htmlwidgets") && requireNamespace("htmltools") &&
    requireNamespace("googledrive") && Sys.getenv("RCHIE_DRIVE_KEY") != "") {

  context("widget")
  library(googledrive)
  drive_deauth()
  drive_auth_config(api_key = Sys.getenv("RCHIE_DRIVE_KEY"))
  gurl <- "https://docs.google.com/document/export?format=txt&id=1oYHXxvzscBBSBhd6xg5ckUEZo3tLytk9zY0VV_Y7SGs"
  test_that( "archieml makes a htmlwidget ", {
    expect_is( archieml(key = "key", src = gurl), "htmlwidget" )
  })


  test_that("options passed as expected", {
    key = "key"
    obj <- archieml(key = key, src = gurl)
    expect_identical( obj$x, list(src = gurl, key = as.list(key), markdown = TRUE,
                                  inline = FALSE, fallback = NULL))

  })
}
