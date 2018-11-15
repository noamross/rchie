#' Import ArchieML data from a string, file, or URL
#'
#' This imports data from  New York Times' ArchieML formatas an R object.  Text
#' is parsed to JSON using archieml-js, then imported via jsonlite.
#'
#' @param aml a string, file, or URL in ArchieML format
#' @param simplifyVector,simplifyDataFrame,simplifyMatrix,flatten passed to
#'   passed to \link[jsonlite]{fromJSON} to determine how JSON is parsed
#' @param ... further arguments to be passed to \link[jsonlite]{fromJSON}, for
#'   class-specific print methods
#' @examples
#' from_aml(aml = "key: value")
#' from_aml("http://archieml.org/test/1.0/arrays.1.aml")
#' @references \url{http://archieml.org/}
#' @importFrom jsonlite fromJSON
#' @export
from_aml <- function(aml,
                     simplifyVector = FALSE,                   # nolint
                     simplifyDataFrame = simplifyVector,       # nolint
                     simplifyMatrix = simplifyVector,          # nolint
                     flatten = FALSE, ...) {
  json <- aml_to_json(aml)
  result <- fromJSON(json,
    simplifyVector = simplifyVector,
    simplifyDataFrame = simplifyDataFrame,
    simplifyMatrix = simplifyMatrix,
    flatten = FALSE, ...
  )

  class(result) <- c("list", "from_aml")
  return(result)
}

#' Convert AML to JSON
#'
#' @param aml a string, file, or URL in ArchieML format
#' @param prettify prettyify JSON?
#' @param indent if prettifying, what indent level? Passed to
#'   \link[jsonlite]{prettify}
#' @importFrom jsonlite prettify
#' @import V8
#' @export
aml_to_json <- function(aml, prettify=FALSE, indent = 4) {
  aml <- read(aml)
  ct <- new_context()
  ct$source(system.file("archieml-js/archieml.js", package = "rchie"))
  ct$assign("aml", aml)
  json <- ct$eval("JSON.stringify(archieml.load(aml));")
  if (prettify) json <- prettify(json, indent = indent)
  return(json)
}

#' @import httr
read <- function(x) {
  if (file.exists(x)) {
    readChar(x, file.info(x)$size)
  } else if (!is.null(httr::parse_url(x)$scheme) &&
    identical(try(httr::status_code(httr::HEAD(x)), silent = TRUE), 200L)) {
    res <- httr::GET(x)
    httr::stop_for_status(res)
    httr::content(res, "text")
  } else {
    x
  }
}
