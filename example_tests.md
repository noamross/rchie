Running tests from examples:

  -   Tests can be put in roxygen @examples with \dontshow{} if desired
  -   Tests should load the **testhat** library
  -   In the tests directory, include a file with the following:
  
          if (identical(Sys.getenv("NOT_CRAN"), "true")) {
            testthat::test_examples('../../man')
          }

      -   This runs the examples with **testthat** reporting when running
          interactively, but does not under R CMD check, as they then run
          when R CMD check runs examples.
          
  -   Other tests can be put in other files.
  -   Challenge: Putting tests in Roxygen deprives you of syntax highlighting,
      tab completion, etc., perhaps RStudio could detect code in Roxygen comments
      to make this easier
  -   A @tests roclet could generate tests and put them in the test directory
