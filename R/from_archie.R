#' Import ArchieML data from a string, file, or URL
#'
#' This imports data from  New York Times' ArchieML format
#' as an R object.  Text is parsed to JSON using archieml-js, then imported via jsonlite.
#'
#' @param aml a string, file, or URL in ArchieML format
#' @param ... arguments to be passed to \link[jsonlite]{fromJSON} to determine
#'   how JSON is parsed
#' @examples
#'    from_archie(aml = 'key: value')
#'    from_archie('http://archieml.org/test/1.0/arrays.1.aml')
#' @references \url{http://archieml.org/}
#' @import V8 jsonlite
#' @export
from_archie <- function(aml, ...) {

  aml <- read(aml)

	ct = new_context()
  ct$source(system.file("archieml-js/archieml.js", package="rchie"))
  ct$assign("aml", aml)
  ct$eval("var parsed = JSON.stringify(archieml.load(aml));")
  return(fromJSON(ct$get("parsed"), ...))
}

#' @import httr
read <- function(x) {
  if (file.exists(x)) {
    readChar(x, file.info(x)$size)
  } else if (!is.null(httr::parse_url(x)$scheme) &&
             identical(try(httr::status_code(httr::HEAD(x)), silent=TRUE), 200L)) {
    res <- httr::GET(x)
    httr::stop_for_status(res)
    httr::content(res, "text")
  } else {
    x
  }
}
