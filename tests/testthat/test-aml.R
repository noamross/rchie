# Run test on the examples

context("archiml-js test suite")

test_aml_file <- function(amlfile) {
  aml_parsed <- from_aml(amlfile)

  test_that(paste0(aml_parsed$test, "(", basename(amlfile), ")"), {
    expect_equivalent(
      aml_parsed[-c(1, 2)],
      jsonlite::fromJSON(aml_parsed$result, simplifyVector = FALSE)
    )
  })
}

aml_tests <- list.files(path = ".", pattern = "\\.aml")

for (amlfile in aml_tests) {
  if (.Platform$OS.type == "windows" &&
    grepl("unicode", amlfile, fixed = TRUE)) {
    next
  }
  test_aml_file(amlfile)
}


context("JSON handling")

test_that("pretty-printing works", {
  imported <- aml_to_json("arrays_complex.10.aml")
  expect_equal(length(grep("\\n", imported)), 0)
  imported <- aml_to_json("arrays_complex.10.aml", pretty = TRUE)
  expect_gte(length(grep("\\n", imported)), 1)
})

test_that("output is a length-1 character of class json", {
  imported <- aml_to_json("arrays_complex.10.aml")
  expect_s3_class(imported, c("character", "json"))
  expect_equal(length(imported), 1)
})
