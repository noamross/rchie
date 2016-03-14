context("archiml-js test suite")

for(file in list.files(pattern = "\\.aml")) {
  imported = from_archie(file)
  test_that(paste0(imported$test, " (", basename(file), ")"), {
    expect_identical(imported[-(1:2)], fromJSON(imported$result))
  })
}

