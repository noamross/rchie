#' Inject text into an HTML document from an AML source
#'
#' This [**htmlwidget**](https://www.htmlwidgets.org/) prints text from a field
#' in a source AML document.
#'
#' @details A common source for the AML is a Google Document, which should be
#' accssed via its plain-text URL:
#' `https://docs.google.com/document/export?format=txt&id=DOCUMENT_ID`.  The
#' document will need to be publicly viewable for this to work.  Future versions
#' may enable authorized viewing via Google log-in. Note that due to security
#' limitations on cross-domain requests in most browsers, this will not work
#' when viewing a file locally, but it will when hosted on the web.
#'
#' @param key the key of the object in the ArchieML document. Nested elements
#'   can be accessed with length > 1 keys such as `c("top-level",
#'   "next-level")`.
#' @param src the URL of the source document. If NULL, the widget will attempt
#'   to use `params$aml_source`, which can be set in the YAML metadata of an R
#'   Markdown document (see
#'   [here](https://bookdown.org/yihui/rmarkdown/params-declare.html)).
#' @param markdown Should the contents of the AML field be processed as
#'   markdown? Defaults to TRUE, in which case text is processed with
#'   [markdown-it](https://github.com/markdown-it/markdown-it).
#' @param inline If TRUE, markdown will be processed only inline, without any
#' `<p>` tags. Useful if you are inserting into a paragaph of text or figure.
#' @param fallback Text to use should the AML source or field not be found.
#' @param elementId If set, give the element this name. `params$aml_source`, so you
#'   can set `aml_source:` in the `params:` section of the YAML header of a
#'   parameterized report.
#' @export
archieml <- function(key = NULL, src = NULL, markdown = TRUE, inline = FALSE,
                     fallback = NULL,  elementId = NULL) {
  if (!requireNamespace("htmlwidgets")) {
    stop("The htmlwidgets package is required to use this function.")
  }

  if (is.null(src) && !exists("params")) {
    stop("No ArchieML source specified")
  } else if (is.null(src) && is.null(get("params")[["aml_source"]])) {
    stop("No ArchieML source specified")
  } else if (is.null(src)) {
    src <- get("params")[["aml_source"]]
  }

    # forward options using x
  x = list(
    src = src,
    key = as.list(key),
    markdown = markdown,
    inline = inline,
    fallback = fallback
    )

  # create widget
  htmlwidgets::createWidget(
    name = 'archieml',
    x,
    package = 'rchie',
    elementId = elementId
  )
}

archieml_html <- function(id, style, class, ...){
  htmltools::tags$span(id = id, class = class)
}
