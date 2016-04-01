# Run test on the examples

if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  testthat::test_examples('../../man')
}
