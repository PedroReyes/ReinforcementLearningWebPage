# LIBRARIES
library(shiny)
library(shinydashboard)
library(rmarkdown)

# SOURCES

# USER INTERFACE
gameplay <<-
  fluidRow(column(8
                  ,box(
                    title = "",#"Tank World",
                    width = 12, status = "primary"
                    # THE GAME
                    # ,verbatimTextOutput("nText")
                    
                    # THE UI
                    ,tags$html(tags$body(
                      singleton(tags$head(
                        tags$script(src = "master_thesis/app/libraries/p5.js")
                      ))
                      ,singleton(tags$head(
                        tags$script(src = "master_thesis/app/sketch.js")
                      ))
                      ,singleton(tags$head(
                        tags$script(src = "master_thesis/app/auxiliaryScripts.js")
                      ))
                      ,singleton(tags$div(id = 'divCanvas', style = 'width:auto; height:auto'))
                    ))
                  ))
           ,column(
             4
             # EXECUTE GAME
             ,box(
               width = 12, status = "primary", collapsible = FALSE, collapsed = TRUE #solidHeader = TRUE,
               
               ,actionButton(
                 inputId = "buttonExecuteGame", label = "",
                 #label = "Execute simulation", 
                 icon = icon("play", lib = "glyphicon")
               )
               
               ,actionButton(inputId = "buttonRepeatGame", label = "",
                             icon = icon("repeat", lib = "glyphicon"))
               
               ,actionButton(
                 inputId = "buttonStopGame", label = "",
                 #label = "Stop simulation", 
                 icon = icon("stop", lib = "glyphicon")
               )
             )
             
             # LEARNING METHOD
             ,box(
               title = "Learning Method", width = 12, status = "warning", collapsible = TRUE, collapsed = TRUE, #solidHeader = TRUE,
               # fluidRow(
               selectInput(
                 "selectInputLearningMethod", "Learning Methods",
                 choices = c("Q-learning" = "qlearning","SARSA" = "sarsa"),
                 selected = "sarsa"
               )
               
               ,sliderInput(
                 "learningRateValue", "Learning rate", min = 0, max = 1, value = 1.0
               )
               
               ,sliderInput(
                 "discountFactorValue", "Discount factor", min = 0, max = 1, value = 0.98
               )
               
               # Initial Q-values
               ,numericInput("initialQValue", "Initial Q-Value", value = 0)
               # )
             )
             
             # ACTION SELECTION METHOD
             ,box(
               title = "Action Selection Method", width = 12, status = "warning", collapsible = TRUE, collapsed = TRUE,#solidHeader = TRUE,
               selectInput(
                 "selectInputSelectionMethod", "Selection methods",
                 choices = c(
                   "eGreedy" = "egreedy",
                   "Soft-max" = "softmax",
                   "UCB" = "ucb"
                 ),
                 selected = "softmax"
               )
               
               # This outputs the dynamic UI component
               ,uiOutput("uiSelectionMethod")
             )
             
             # EXECUTION PARAMETERS
             ,box(
               title = "Execution parameters", width = 12, status = "warning", collapsible = TRUE, collapsed = FALSE#, solidHeader = TRUE
               
               # Number of episodes
               ,numericInput("numberOfEpisodes", "Number of Episodes", value = 150)
               
               # Map dimension
               ,selectInput(
                 inputId = "mapDimension", label = "Map dimension",
                 choices = c(
                   "3x3" = "3",
                   "4x4" = "4",
                   "5x5" = "5",
                   "6x6" = "6",
                   "7x7" = "7",
                   "8x8" = "8"
                 ),
                 selected = "6"
               )
               
               # Map type
               ,checkboxInput("usePersonalizedMap", "Use chess map", FALSE)
               
               # Time threshold for training
               ,numericInput("trainingTimeThreshold", "Time threshold for training (minutes)", value = 1)
               
               # This outputs the dynamic UI component
               ,uiOutput("uiExecutionSpeed")
             )
           ))