# LIBRARIES
library(shiny)
library(shinydashboard)
library(rmarkdown)

# SOURCES

# USER INTERFACE
checkResults <<-
  fluidRow(column(
    width = 12,align = "center"
    ,box(
      #style = "width: 95%; margin: auto",
      title = "Performance of the algorithm"
      
      , width = 12, status = "primary", solidHeader = TRUE, collapsible = FALSE, collapsed = FALSE
      
      # Probability of wining
      ,box(
        width = 3, status = "primary", solidHeader = TRUE, #height = "300px", # collapsible = TRUE, collapsed = FALSE,
        title = "Win probability",
        #                img(src = 'master_thesis/images/xEpisode_yWinProbability.png'
        #                    ,align = "right", style = "height: 100%; width: 100%; object-fit: contain")
        imageOutput(outputId = "winProbability", width = "100%")
      )
      
      # Average steps when wining
      ,box(
        width = 3, status = "primary", solidHeader = TRUE, #height = "300px", # collapsible = TRUE, collapsed = FALSE,
        title = "Average of steps when win",
        #                img(src = 'master_thesis/images/xEpisode_yAverageStepsWhenWin.png'
        #                    ,align = "right", style = "height: 100%; width: 100%; object-fit: contain")
        imageOutput(outputId = "stepsWhenWin", width = "100%")
      )
      
      ,box(
        width = 3, status = "primary", solidHeader = TRUE, #height = "300px", # collapsible = TRUE, collapsed = FALSE,
        title = "Average reward",
        #                img(src = 'master_thesis/images/xEpisode_yAverageReward.png'
        #                    ,align = "right", style = "height: 100%; width: 100%; object-fit: contain")
        imageOutput(outputId = "averageReward", width = "100%")
      )
      
      ,box(
        width = 3, status = "primary", solidHeader = TRUE, #height = "300px", # collapsible = TRUE, collapsed = FALSE,
        title = "Percetage of actions",
        #                img(src = 'master_thesis/images/xEpisode_yPercentageOfActions.png'
        #                    ,align = "right", style = "height: 100%; width: 100%; object-fit: contain")
        imageOutput(outputId = "percentageOfActions", width = "100%")
      )
    )
  )
  
  , column (
    width = 12, align = "center"
    ,box(
      width = 2, status = "primary", 
      # downloadButton(outputId = "downloadPlot", label = "Download charts")
      uiOutput(outputId = "downloadButton")
    )
    # ,box(width = 10, height = "100px", "DRAG AND DROP THE FILES HERE.", status = "primary", background = "olive")
    ,box(
      width = 10,
      status = "primary",
      # includeCSS("www/styles.css"),
      fileInput(
        inputId = 'files'
        ,label = 
          NULL
        # 'Choose CSV File'
        ,multiple = TRUE
        ,accept = c('text/csv',
                   'text/comma-separated-values,text/plain',
                   '.csv')
        ,width = "100%"
        # ,style = "display:none"
      )
    )
    # ,box(width = 12, tags$div(uiOutput("tables")))
  ))