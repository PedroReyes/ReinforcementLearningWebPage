# LIBRARIES
library(shiny)
library(shinydashboard)
library(rmarkdown)
library(shinyjs)

# SOURCES
# source: tabMasterThesis
source(paste(getwd(), "/master_thesis/tabMasterThesis.R", sep = ""))

# USER INTERFACE
indexMasterThesis <<-
  fluidRow(useShinyjs(),
#            div(id = "loading_page",
#                p(h1("      Loading..."))),
           # hidden(
             div(
             id = "main_content",
             # style = "height:100vh",
             dashboardPage(
               # title = "Pedro Reyes's personal website",
               dashboardHeader(
                 title =
                   tags$div(
                     id = "headerDiv",
                     style = "background:red;",
                     "Trabajo Fin de Master: Desarrollo de Capacidades de Aprendizaje por Refuerzo de un Personaje Autónomo en un Videojuego"
                   )
                 , disable = TRUE
                 , titleWidth = "100%"
               ),
               dashboardSidebar(disable = TRUE),
               dashboardBody(# Head
                 tags$head(
                   tags$link(rel = "icon", href = "index/tabIcon64.png")
                   # , tags$link(rel = "stylesheet", type = "text/css", href = "myStyle.css")
                 ),
                 bsAlert("alert"),
                 # Body
                 uiTabMasterThesis)
             )
           ))
# )