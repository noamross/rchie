#' Import archieML data from a string, file, or URL
#'
#' This imports data from  New York Times' ArchieML format
#' as an R object.  Text is parsed to JSON using archieml-js, then imported via jsonlite.
#'
#' @param txt a string, file, or URL in ArchieML format
#' @examples
#'    from_archie(txt = 'key: value')
#' @references \url{http://archieml.org/}
#' @import V8
#' @import jsonlite
#' @export
from_archie <- function(txt) {
	if (!is.character(txt)) {
		stop("Argument 'txt' must be an ArchieML string, URL or path to existing file.")
	}
	if (length(txt) == 1 && nchar(txt, type = "bytes") < 1000) {
		if (grepl("^https?://", txt, useBytes = TRUE)) {
			jsonlite:::loadpkg("httr")
			txt <- jsonlite:::raw_to_json(jsonlite:::download_raw(txt))
		}
		else if (file.exists(txt)) {
			txt <- jsonlite:::raw_to_json(readBin(txt, raw(), file.info(txt)$size))
		}
	}
	if (length(txt) > 1) {
		txt <- paste(txt, collapse = "\n")
	}
	ct = new_context()
	ct$source(system.file("archieml-js/archieml.js", package="rchie"))
	ct$assign("txt", txt)
	ct$eval("var parsed = archieml.load(txt);")
	return(ct$get("parsed"))
}
