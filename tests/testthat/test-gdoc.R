if (requireNamespace("googledrive") && Sys.getenv("RCHIE_DRIVE_KEY") != "") {
  context("Google Drive handling")

  googledrive::drive_auth_config(
    active = FALSE,
    api_key = Sys.getenv("RCHIE_DRIVE_KEY"),
    verbose = FALSE
  )

  test_that("import from a Google Doc works", {
    gurl <- "https://docs.google.com/document/d/1oYHXxvzscBBSBhd6xg5ckUEZo3tLytk9zY0VV_Y7SGs/edit" # nolint
    imported_g <- from_aml(googledrive::as_id(gurl))
    imported_txt <- from_aml("google_doc.txt")
    expect_equivalent(imported_g, imported_txt)
  })

  test_that("import from a Google Drive text file works", {
    gurl <- "https://drive.google.com/file/d/1pXCkhOsFtLUD8Gr6PIkWlEM1NYXXOW5V/view" # nolint
    imported_g <- from_aml(googledrive::as_id(gurl))
    imported_txt <- from_aml("google_doc.txt")
    expect_equivalent(imported_g, imported_txt)
  })

  test_that("trying to import wrong Google Drive file types fails", {
    gurl <- "https://docs.google.com/spreadsheets/d/1TUlD_Yn9cFGWSd9PV1Sy2_1MtrXivVG1JQy6DQ12EX0/edit" # nolint
    expect_error(
      from_aml(googledrive::as_id(gurl)),
      "Only Google Docs and plain text files can be read from Google Drive"
    )
  })

  test_that("Only one google doc is allowed per call", {
    gurl <- "https://docs.google.com/spreadsheets/d/1TUlD_Yn9cFGWSd9PV1Sy2_1MtrXivVG1JQy6DQ12EX0/edit" # nolint
    expect_error(
      from_aml(googledrive::as_id(c(gurl, gurl))),
      "This function only reads one document at a time"
    )
  })
}
