# LIBRARIES
library(shiny)
library(shinydashboard)
library(rmarkdown)

# SOURCES

# USER INTERFACE
paper <<-
  # THE UI
  tags$html(tags$head(# tags$script(src = "https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js")
    tags$head(
      tags$script(src = "master_thesis/scripts/resizeIframe.js")
    ))
    ,tags$body(
      tags$iframe(
        # style = "max-height: 100%; max-width: 100%; height:670px; width:100%",
        onload = "resizeIframe(this)",
        src = "master_thesis/paper.pdf"
        #src = "master_thesis/paper.pdf&embedded=true"
        , frameborder = "0"
        , type = 'application/pdf'
      )
    ))