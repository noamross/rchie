#' Get the (plain) text of a word doc as a character string
#' @importFrom rmarkdown pandoc_convert
#' @param file A *.docx file
get_docx_text = function(file) {
  tmp = tempfile()
  pandoc_convert(file, from="docx", to="plain",
                 output=tmp, wd=normalizePath(dirname(file)))
  txt = readChar(tmp, file.info(tmp)$size)

  return(txt)
  }
