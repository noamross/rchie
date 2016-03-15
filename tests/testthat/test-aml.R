context("archiml-js test suite")

for(file in list.files(pattern = "\\.aml")) {
  imported <- from_archie(file)
  test_that(paste0(imported$test, " (", basename(file), ")"), {
    expect_identical(imported[-c(1, 2)], fromJSON(imported$result))
  })
}

for(file in list.files(pattern = "\\.aml")) {
  imported <- from_archie(file, simplifyVector = FALSE)
  test_that(paste0(imported$test, "(with fromJSON arguments) (", basename(file), ")"), {
    expect_identical(imported[-c(1, 2)], fromJSON(imported$result, simplifyVector=FALSE))
  })
}


test_that("import from URL works", {
  imported <- from_archie("http://archieml.org/test/1.0/all.0.aml")
  expect_identical(imported[-c(1, 2)], fromJSON(imported$result))
})

test_that("import from string works", {
  imported <- from_archie(aml = "key: value")
  expect_identical(imported, fromJSON("{\"key\":\"value\"}"))
})
