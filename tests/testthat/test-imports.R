context("Import types")

test_that("import from URL works", {
  imported <- from_aml("http://archieml.org/test/1.0/arrays.1.aml")
  expect_equivalent(imported[-c(1, 2)], jsonlite::fromJSON(imported$result))
})

test_that("import from string works", {
  imported <- from_aml(aml = "key: value")
  expect_equivalent(imported, jsonlite::fromJSON("{\"key\":\"value\"}"))
})

test_that("multiline inputs are always treated as raw", {
  imported <- from_aml("google_doc.txt\ngoogle_doc.txt")
  expect_equivalent(imported, list())
})

test_that("disallowed types fail", {
  expect_error(
    from_aml(1),
    "Don't know how to read AML from object of class"
  )
  expect_error(
    from_aml(list()),
    "Don't know how to read AML from object of class"
  )
})
