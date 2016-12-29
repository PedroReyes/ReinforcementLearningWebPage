# LIBRARIES
library(shiny)
library(shinydashboard)
library(rmarkdown)
library(shinyBS)

# USER INTERFACE
uiHome <<-
  #fluidRow(
  wellPanel(
    # Show a plot of the generated distribution
    
    headerPanel("Pedro Reyes", windowTitle = "Personal Website"),
    fluidRow(
      # Profile picture
      column(
        4, tags$img(
          height = 250, width = 250, src = "./home/profilePicture.jpg"
        )
      ),
      
      # Profile description
      column(
        8,
        tags$strong("Data analyst."),
        
        tags$br(),
        "Degree in Software Engineering, University of Málaga (Spain).",
        
        tags$br(),
        "M.Sc. in Software Engineering and Artificial Intelligence, University of Málaga (Spain).",
        
        tags$br(),
        tags$h3("Contact info"),
        tags$a(href = "http://www.lcc.uma.es/", "Departamento de Lenguajes y Ciencias de la Computación"),
        
        tags$br(),
        tags$a(href = "http://www.informatica.uma.es/", "ETSI Informatica."),
        tags$a(href = "http://www.uma.es/", " Universidad de Málaga."),
        
        tags$br(),
        "Bulevar Louis Pasteur, 35. Campus de Teatinos.",
        
        tags$br(),
        "29071 Málaga. Spain.",
        
#         tags$br(),
#         tags$img(
#           height = 20, width = 150, src = "./home/email.png"
#         ),
        
        tags$br(),
        tags$img(
          height = 20, width = 150, src = "./home/emailPersonal.png"
        ),
        
        # tags$br(),
        tags$a(href="https://www.linkedin.com/in/pedro-jes%C3%BAs-reyes-santiago-54a199a6",
               tags$img(
                 height = 20, width = 20, src = "./home/linkedin.png"
               )
        )
      )
      
      #       ,column(12,
      #               dashboardPage(
      #                 dashboardHeader(
      #                   title = "Recent proyects",
      #                   titleWidth = 2000,
      #                   disable = TRUE),
      #                 dashboardSidebar(disable = TRUE),
      #                 dashboardBody(
      #                   box(width = 4,
      #                       title = "Development Of Reinforcement Learning Algorithm", solidHeader = TRUE, status = "primary",
      #                       "Master thesis based on ...",
      #                       actionButton("goMasterThesis", "Go!")
      #                   ),
      #
      #                   box(width = 4,
      #                       title = "Proyect 1", solidHeader = TRUE, status = "primary",
      #                       "This proyect is ...",
      #                       actionButton("goButton", "Go!")
      #                   ),
      #
      #                   box(width = 4,
      #                       title = "Proyect 2", solidHeader = TRUE, status = "primary",
      #                       "This proyect is ...",
      #                       actionButton("goButton", "Go!")
      #                   )
      #                 )
      #               ))
      # ==============================================================
      # ANOTHER CODE FOR DISPLAYING PDFs
      # ==============================================================
      #                         ,column(
      #                           12,
      #
      #                           tags$iframe(
      #                             style = "height:400px; width:100%; scrolling=yes",
      #                             #src="https://cran.r-project.org/doc/manuals/r-release/R-intro.pdf")
      #                             src = "xEpisode_yWinProbability.pdf"
      #                               #paste(getwd(), "/xEpisode_yWinProbability.pdf", sep = "")
      #                           )
      #                         )
      
    )
  )