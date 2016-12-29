# LIBRARIES
library(shiny)
library(shinydashboard)
library(rmarkdown)

# SOURCES
# source: tabAuthor
source(paste(getwd(), "/home/Home.R", sep = ""))

# source: checkResults
source(paste(getwd(), "/master_thesis/checkResults.R", sep = ""))

# source: gameplay
source(paste(getwd(), "/master_thesis/gameplay.R", sep = ""))

# source: gameplay
source(paste(getwd(), "/master_thesis/executionOfCode.R", sep = ""))

# source: paper
source(paste(getwd(), "/master_thesis/paper.R", sep = ""))

# USER INTERFACE
uiTabMasterThesis <<-
  # PAPER
  # fillPage(
  fluidRow(
    column(
    12,
    # checkResults
    tabBox(
      title = imageOutput("icon", height = "16px")#"Title"
      
      # The id lets us use input$tabset1 on the server to find the current tab
      ,id = "tabsetMasterThesis", side = "right", width = 12
      , height = "100%" # HEIGHT DEBERÍA SER AUTOMATICO
      # ,onload = "resizeIframe(this)"
      # GAME_PLAY
      ,tabPanel("Gameplay", gameplay)
      
      # CHECK RESULTS
      ,tabPanel("Check your experiment's results", checkResults)
      
      # CODE
      ,tabPanel("Code", executionOfCode)
      
      # PAPER
      ,tabPanel("Master Thesis", paper)
      
      # AUTHOR
      ,tabPanel("Author", uiHome)
    )
  ))
# )
