
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
shinyServer(function(input, output) {
  library(rmarkdown)

	output$doc = renderText({
		input$value
		render('doc/archiedocdemo.Rmd', output_format="html_document")
		readChar("doc/archiedocdemo.html", file.info("doc/archiedocdemo.html")$size)
	})
})
