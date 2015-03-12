
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  # Application title
  titlePanel("Using ArchieML, Google Docs, and R Markdown For Collaborative Writing"),

  # Sidebar with a slider input for number of bins
  verticalLayout(
    actionButton("value", "Update", icon("refresh")),
    htmlOutput("doc")
   )
  )
)
