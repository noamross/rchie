Running tests from examples:

  -   Tests can be put in roxygen @examples with \dontrun{} and \dontshow{}
  -   `devtools::run_examples(show=FALSE, run=FALSE)` will run tests,
      can be put in a single test file in test directory
      -   However, this fails on R CMD CHECK because you can't redocument
          package in the midst of R CMD CHECK
      -   Instead, use `testthat::test_examples('../../man')`.  However,
          this does not have ability to run `\dontrun{}` or `\dontshow{}`.
          Requires a small PR to testhat to fix.
  -   Challenge: Putting tests in Roxygen deprives you of syntax highlighting,
      tab completion, etc., 
  -   A @tests roclet could generate tests and put them in the test directory
  -   
