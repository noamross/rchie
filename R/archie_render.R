#' Render an .Rmd file, first extracting the ArchieML data from the plain text
#'
#' @param input The .Rmd file
#' @param ... parameters to be passed to \link{rmarkdown::render}
#' @export
#' @importFrom rmarkdown render
#' @import knitr
#' @examples
#' \dontrun{
#' archie_render(system.file('test_archie_render.Rmd', package="rchie"),
#' 							 output_dir=getwd())
#' }
archie_render = function(input, ...) {
  archie_data = from_archie(get_rmd_text(input))
	knit_env = list2env(archie_data)
	render(input, envir=knit_env)
}

#'@import knitr
get_rmd_text = function(file) {
	opts_chunk$set(code="", eval=FALSE, echo=FALSE) # A not super robust way to
	tmp = knit(input=file, output = tempfile(), quiet=TRUE) # extract text from a .Rmd
	text = 	paste(rmarkdown:::partition_yaml_front_matter(readLines(tmp))$body,
		collapse="\n")
	opts_chunk$restore()
  return(text)
}
