# Run test on the examples

context("archiml-js test suite")

test_aml_file <- function(amlfile) {
  aml_parsed <- from_aml(amlfile)

  test_that(paste0(aml_parsed$test, "(", basename(amlfile), ")"), {
    expect_equivalent(
      aml_parsed[-c(1,2)],
      jsonlite::fromJSON(aml_parsed$result, simplifyVector = FALSE)
    )
  })
}

aml_tests <- list.files(path = ".", pattern = "\\.aml")

for (amlfile in aml_tests) {
  test_aml_file(amlfile)
}

context("imports")

test_that("import from URL works", {
  imported <- from_aml("http://archieml.org/test/1.0/arrays.1.aml")
  expect_equivalent(imported[-c(1, 2)], jsonlite::fromJSON(imported$result))
})

test_that("import from string works", {
  imported <- from_aml(aml = "key: value")
  expect_equivalent(imported, jsonlite::fromJSON("{\"key\":\"value\"}"))
})

context("json")

test_that("pretty-printing works", {
  imported <- aml_to_json("arrays_complex.10.aml")
  expect_equal(length(grep("\\n", imported)), 0)
  imported <- aml_to_json("arrays_complex.10.aml", prettify = TRUE)
  expect_gte(length(grep("\\n", imported)), 1)
})
