#' Import ArchieML data from a string, file, or URL
#'
#' This imports data from  New York Times' ArchieML format
#' as an R object.  Text is parsed to JSON using archieml-js, then imported via jsonlite.
#'
#' Supported file formats (currently docx and Rmd) will automatically be converted
#' to plain text for extracting.  Note that for Rmd, this means extracting
#' only the text sections, not the code blocks or YAML header.
#'
#' @param txt a string, file, or URL in ArchieML format
#' @param ... arguments to be passed to \link[jsonline]{fromJSON} to
#'
#' @examples
#'    from_archie(txt = 'key: value')
#' @references \url{http://archieml.org/}
#' @import V8
#' @import jsonlite
#' @importFrom tools file_ext
#' @export
from_archie <- function(txt, ...) {
	if (!is.character(txt)) {
		stop("Argument 'txt' must be an ArchieML string, URL or path to existing file.")
	}
	if (length(txt) == 1 && nchar(txt, type = "bytes") < 1000) {
		if (grepl("^https?://", txt, useBytes = TRUE)) {
			jsonlite:::loadpkg("httr")
			txt <- jsonlite:::raw_to_json(jsonlite:::download_raw(txt))
		}
		else if (file.exists(txt)) {
			if(tools:::file_ext(txt) == "docx") {
				txt = get_docx_text(txt)
			} else if(tools:::file_ext(txt) %in% c("rmd", "Rmd")) {
				txt = get_rmd_text(txt)
			} else {
				txt <- jsonlite:::raw_to_json(readBin(txt, raw(), file.info(txt)$size))
			}
		}
	}
	if (length(txt) > 1) {
		txt <- paste(txt, collapse = "\n")
	}

	ct = new_context()
  ct$source(system.file("archieml-js/archieml.js", package="rchie"))
  ct$assign("txt", txt)
  ct$eval("var parsed = JSON.stringify(archieml.load(txt));")
  return(fromJSON(ct$get("parsed"), ...))
}
