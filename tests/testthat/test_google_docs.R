# test_that("google doc imported correctly",  {
# options(drive.app = Sys.getenv(DRIVE_APP),
# 				drive.secret = Sys.getenv(DRIVE_SECRET),
# 				drive.scope = 'https://www.googleapis.com/auth/drive.readonly')
# }
#
#
#     expect_identical(
#     	from_archie(get_google_doc_text("https://docs.google.com/document/d/1JjYD90DyoaBuRYNxa4_nqrHKkgZf1HrUj30i3rTWX1s/edit")),
#     	from_archie(system.file("ArchieMLParserTestFromGoogle.txt.txt", package="rchie"))
#     )
# 	})
