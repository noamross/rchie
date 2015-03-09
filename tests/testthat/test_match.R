context('ArchieML/JSON examples match')


test_that("ArchieML/JSON examples match", {

  skip_on_cran()

    expect_identical(
    from_archie('key: This is a value'),
    jsonlite::fromJSON('{
                "key": "This is a value"
              }'))

  expect_identical(
    from_archie('1: value
                 2:value
                 3   : value
                  4:    value
                 5:  value

                 a: lowercase a
                 A: uppercase A'),
    jsonlite::fromJSON('{
                         "1": "value",
                         "2": "value",
                         "3": "value",
                         "4": "value",
                         "5": "value",
                          "a": "lowercase a",
                         "A": "uppercase A"
                       }'))

    expect_identical(
    from_archie('{colors.reds}
                 crimson: #dc143c;
                 darkred: #8b0000;

                 {colors.blues}
                 cornflowerblue: #6495ed;
                 darkblue: #00008b;'),
    jsonlite::fromJSON('{
                         "colors": {
                           "reds": {
                             "crimson": "#dc143c;",
                             "darkred": "#8b0000;"
                           },
                           "blues": {
                             "cornflowerblue": "#6495ed;",
                             "darkblue": "#00008b;"
                           }
                         }
                       }'))
})

context('Other import formats match')

test_that("docx imported correctly",  {

    skip_on_cran()
    expect_identical(
      from_archie("ArchieMLParserTest.docx"),
      from_archie("ArchieMLParserTest_docx_plain.txt")
    )

	})

test_that("rmd imported correctly",  {
    expect_identical(
    	from_archie("test_archie_render.Rmd"),
    	from_archie("test_archie_render.txt")
    )
	})

