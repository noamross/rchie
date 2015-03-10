context('Online Services')

test_that("google doc imported correctly",  {
  d_token = readRDS(system.file("token_file", package="rchie"))
  library(driver, quietly=TRUE)
  archie_test_id = '16WHsVRyCM6dHVHTvFYsTbNaIl1vavGPp8GU3OnUS7oE'
	meta_d = file_metadata(d_token, archie_test_id)
	tmp = tempfile()
	download_file(d_token, meta_d, 'text/plain', tmp)
  expect_identical(
      from_archie(tmp),
      from_archie(system.file("ArchieMLParserTestFromGoogle.txt", package="rchie"))
    )
  })
