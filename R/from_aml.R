#' Import ArchieML data from a string, file, or URL
#'
#' This imports data from  New York Times' ArchieML format as an R object. Text
#' is parsed to JSON using
#' [archieml-js](https://github.com/newsdev/archieml-js), then imported via
#' [jsonlite::fromJSON].
#'
#' This function was formerly named `from_archie`, which is now deprecated.
#'
#' @param aml a string, file, connection, URL, or  Google Drive ID created by
#'   [googledrive::as_id] from which to read ArchieML. Inputs of length > 1,
#'   with line breaks, or non-existent file names will always be treated as raw
#'   ArchieML.  To read multiple ArchieML inputs use a function such as
#'   [lapply].
#' @param simplifyVector,simplifyDataFrame,simplifyMatrix,flatten passed to
#'   \link[jsonlite]{fromJSON} to determine how the JSON generated from is
#'   parsed.  If raw JSON outputs are desired use [aml_to_json]
#' @param ... further arguments to be passed to[jsonlite::fromJSON], for
#'   class-specific print methods
#' @return A list of class "from_aml"
#' @examples
#' from_aml(aml = "key: value")
#' from_aml("http://archieml.org/test/1.0/arrays.1.aml")
#'
#' \donttest{\dontrun{
#' # See source at:
#' # https://drive.google.com/open?id=1oYHXxvzscBBSBhd6xg5ckUEZo3tLytk9zY0VV_Y7SGs
#' library(googledrive)
#' from_aml(as_id("1oYHXxvzscBBSBhd6xg5ckUEZo3tLytk9zY0VV_Y7SGs"))
#' }}
#' @seealso [aml_to_json]
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

#' @rdname from_aml
#' @usage  
#' @export
from_archie <- function(...) {
  .Deprecated("from_aml")
  from_aml(...)
}

#' Convert AML to JSON
#'
#' This imports data from  New York Times' ArchieML format as a JSON sting.
#' Text is parsed to JSON using
#' [archieml-js](https://github.com/newsdev/archieml-js).
#'
#' @param aml a string, file, connection, URL, or  Google Drive ID created by
#'   [googledrive::as_id] from which to read ArchieML. Inputs of length > 1,
#'   with line breaks, or non-existent filenames will always be treated as raw
#'   ArchieML.  To read multiple ArchieML inputs use a function such as [lapply].
#' @param pretty prettify JSON output?
#' @param indent if prettifying, what indent level? Passed to
#'   \link[jsonlite]{prettify}.
#' @importFrom jsonlite prettify
#' @importFrom V8 new_context
#' @export
#' @return A length-1 character vector of class "json"
#' @examples
#' aml_to_json(aml = "key: value")
#' aml_to_json("http://archieml.org/test/1.0/arrays.1.aml")
#'
#' \donttest{\dontrun{
#' # See source at:
#' # https://drive.google.com/open?id=1oYHXxvzscBBSBhd6xg5ckUEZo3tLytk9zY0VV_Y7SGs
#' library(googledrive)
#' aml_to_json(as_id("1oYHXxvzscBBSBhd6xg5ckUEZo3tLytk9zY0VV_Y7SGs"),
#'   pretty = TRUE)
#' }}
#' @seealso [from_aml]
#' @references \url{http://archieml.org/}
aml_to_json <- function(aml, pretty = FALSE, indent = 4) {
  aml <- read_aml(aml)
  aml <- paste(aml, collapse = "\n")
  ct <- new_context()
  ct$source(system.file("archieml-js/archieml.js", package = "rchie"))
  ct$assign("aml", aml)
  json <- ct$eval("JSON.stringify(archieml.load(aml));")
  class(json) <- "json"
  if (pretty) json <- prettify(json, indent = indent)
  return(json)
}

