# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://www.rstudio.com/shiny/
#

# LIBRARIES
library(shiny)
library(shinyjs)
library(shinyBS)

# SOURCES FOR MASTER THESIS
# source: Graficar
sourceRLGraficar <-
  paste(getwd(), "/master_thesis/rCodeForCreatingCharts/RLGraficar.R", sep = "")
source(sourceRLGraficar)

# source: Connecting R to Java (to the Reinforcement Learning algorithms written in Java)
sourceConnectingRtoJava <-
  paste(getwd(), "/master_thesis/CallingJavaFromR.R", sep = "")
source(sourceConnectingRtoJava)

# SOURCES FOR HESPERIA
# source: Downloading HEPAD data
# sourceDownloadingHepadData <- paste(getwd(), "/hesperia/DownloadHepadData.R", sep = "")
# source(sourceDownloadingHepadData)

# OPTIONS
options(shiny.maxRequestSize = 50 * 1024 ^ 2)  # 50MB now is the limit to upload

# GLOBAL AUXILIARY VARIABLES (READ-ONLY, EACH USER SESSION)
# winProbabilityChart <- NULL

# METHODS
# load_data <- function(seconds) {
#   if(seconds!=0){
#     Sys.sleep(seconds)
#   }
#   hide("loading_page")
#   show("main_content")
# }

# DEFAULT VALUES FOR THE GAME
classpath <- paste(getwd(),"/master_thesis/java/RLJava.jar", sep = "")
learningRate <- 1.0
discountFactor <- 0.98
initialEpsilonGreedy <- 0.2
finalEpsilonGreedy <- 0.05
cExploratoryUCB <- 0.01
temperatureSoftmax <- 0.5
executionSpeedness <- 0.02
usePersonalizedMap <- FALSE

# if(interactive()){
shinyServer(function(input, output, session) {
  # Remove when uploading the code
  # (I do not want the real Shiny app to stop every time a user leaves the app.)
  #session$onSessionEnded(stopApp)
  
  # =========================================
  # MASTER THESIS - tab icon
  # =========================================
  # Send a pre-rendered image, and don't delete the image after sending it
  output$icon <- renderImage({
    # Return a list containing the filename and alt text
    list(src = "www/index/tabIcon32.png", alt = "web page icon")
    
  }, deleteFile = FALSE)
  
  # =========================================
  # MASTER THESIS - check your experiments
  # =========================================
  # > SHOW DOWNLOAD BUTTON JUST IF THERE ARE FILES SELECTED
  output$downloadButton <- renderUI({
    if (!is.null(input$files) && length(input$files > 0)) {
      downloadButton(outputId = "downloadResults", label = "Download results")
    }else{
      downloadButton(outputId = "downloadResults", label = "Download results", class = "disabled")
    }
  })
  
  # > DOWNLOAD IMAGES
  output$downloadResults <- downloadHandler(
    filename = "Results.zip",
    content = function(fname) {
      if (!is.null(input$files) && length(input$files)>0) {
        # Setting temporal folder for save images
        tmpdir <- tempdir()
        setwd(tempdir())
        # print(tempdir())
        
        # List of files content
        lst <- list()
        for (i in 1:length(input$files[,1])) {
          lst[[i]] <-
            read.csv(input$files[[i, 'datapath']], sep = ";", header = TRUE)
        }
        
        # Name of the charts
        fs <- c(
          "xEpisode_yWinProbability.png",
          "xEpisode_yAverageStepsWhenWin.png",
          "xEpisode_yAverageReward.png",
          "xEpisode_yPercentageOfActions.png"
        )
        
        # Graficas
        for (index in 1:length(fs)) {
          # The name of the file
          png(fs[index])
          
          # The type of the cahrt
          typeOfChart <-
            substr(fs[index], 1, regexpr("\\.[^\\.]*$", fs[index]) - 1)
          
          # The chart
          if (!is.null(input$files)) {
            graficar(
              chartType = typeOfChart, dataOfSingleFile = lst, workingDir = NULL, savePlot = FALSE,nombreFicheroSimulacion = NULL
            )
          }
          
          # Deving off
          dev.off()
        }
        
        print("zipped!")
        
        # Zipping all the images in a zip file
        zip(zipfile = fname, files = fs)
      }else{
        print("wtf!?")
      }
    }
  )
  
  # > SELECT FILES AND SHOW THE RESULTS
  observeEvent(input$files, {
    if (!is.null(input$files)) {
      # List of files content
      lst <- list()
      for (i in 1:length(input$files[,1])) {
        lst[[i]] <-
          read.csv(input$files[[i, 'datapath']], sep = ";", header = TRUE)
      }
      
      # Checking that the function for plotting is already in the environment
      if (!exists("graficar", mode = "function")) {
        source(sourceRLGraficar)
      }
      
      #Graficar
      output$winProbability <- renderPlot({
        graficar(
          chartType = "xEpisode_yWinProbability", dataOfSingleFile = lst, workingDir = NULL, savePlot = FALSE, nombreFicheroSimulacion = NULL
        )
      })
      
      output$stepsWhenWin <- renderPlot({
        graficar(
          chartType = "xEpisode_yAverageStepsWhenWin", dataOfSingleFile = lst, workingDir = NULL, savePlot = FALSE, nombreFicheroSimulacion = NULL
        )
      })
      
      output$averageReward <- renderPlot({
        graficar(
          chartType = "xEpisode_yAverageReward", dataOfSingleFile = lst, workingDir = NULL, savePlot = FALSE, nombreFicheroSimulacion = NULL
        )
      })
      
      output$percentageOfActions <- renderPlot({
        graficar(
          chartType = "xEpisode_yPercentageOfActions", dataOfSingleFile = lst, workingDir = NULL, savePlot = FALSE, nombreFicheroSimulacion = NULL
        )
      })
    }
  })
  
  # > INITIAL IMAGES
  if (FALSE) {
    output$winProbability <- renderImage({
      return(
        list(
          src = "www/master_thesis/images/xEpisode_yWinProbability.png",
          contentType = "image/png",
          alt = "Win probability"
        )
      )
    }, deleteFile = FALSE)
    
    output$stepsWhenWin <- renderImage({
      return(
        list(
          src = "www/master_thesis/images/xEpisode_yAverageStepsWhenWin.png",
          contentType = "image/png",
          alt = "Steps when win"
        )
      )
    }, deleteFile = FALSE)
    
    output$averageReward <- renderImage({
      return(
        list(
          src = "www/master_thesis/images/xEpisode_yAverageReward.png",
          contentType = "image/png",
          alt = "Average reward"
        )
      )
    }, deleteFile = FALSE)
    
    output$percentageOfActions <- renderImage({
      return(
        list(
          src = "www/master_thesis/images/xEpisode_yPercentageOfActions.png",
          contentType = "image/png",
          alt = "Percentage of actions"
        )
      )
    }, deleteFile = FALSE)
  }
  
  # =========================================
  # MASTER THESIS - execution of the game
  # =========================================
  # APP - PARAMETERS SELECTION - LEARNING METHOD
  output$uiExecutionSpeed <- renderUI({
    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.
    sliderInput(
      inputId = "executionSpeedness", "Execution speedness (seconds)", min = 0, max = 1, value = executionSpeedness
    )
  })
  
  # APP - GETTING A LEARNER FOR LISTING THE LEARNING METHODS
  learner <- learnerNewInstance(classpath)
  
  learningMethods <- list()
  
  learningMethods[learner$getLearningMethods()] <-
    learner$getLearningMethods()
  
  # Can also set the label and select items
  updateSelectInput(
    session, "selectInputLearningMethod", "Learning Methods",
    choices = learningMethods,#c("Q-learning" = "qlearning", "SARSA" = "sarsa"),
    selected = learningMethods[[1]]
  )
  
  # APP - GETTING A LEARNER FOR LISTING THE SELECTION METHODS
  learner <- learnerNewInstance(classpath)
  
  selectionMethods <- list()
  
  selectionMethods[learner$getSelectionMethods()] <-
    learner$getSelectionMethods()
  
  # Can also set the label and select items
  updateSelectInput(
    session, "selectInputSelectionMethod", "Selection Methods",
    choices = selectionMethods,#c("Q-learning" = "qlearning", "SARSA" = "sarsa"),
    selected = selectionMethods[[2]]
  )
  
  # APP - PARAMETERS SELECTION - SELECTION METHOD
  output$uiSelectionMethod <- renderUI({
    if (is.null(input$selectInputSelectionMethod))
      return()
    
    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.
    switch(
      input$selectInputSelectionMethod,
      "E_GREEDY" = tags$div(
        sliderInput(
          "initialEpsilonGreedy", "Initial exploratory factor", min = 0, max = 1, value = initialEpsilonGreedy
        )
      )
      
      ,"E_GREEDY_CHANGING_TEMPORALLY" = tags$div(
        sliderInput(
          "initialEpsilonGreedy", "Initial exploratory factor", min = 0, max = 1, value = initialEpsilonGreedy
        )
        
        ,sliderInput(
          "finalEpsilonGreedy", "Final exploratory factor", min = 0, max = 1, value = finalEpsilonGreedy
        )
      )
      
      ,"SOFT_MAX" = tags$div(
        sliderInput(
          "temperatureSoftmax", "Temperature", min = 0, max = 1, value = temperatureSoftmax
        )
        ,checkboxInput("baselineSoftmax", "Use baseline", value = TRUE)
      )
      
      ,"UCB" = tags$div(
        sliderInput(
          "exploratoryFactorUcb", "Exploratory factor C", min = 0, max = 1, value = cExploratoryUCB
        )
      )
    )
  })
  
  # APP - BUTTON - LOCAL VARIABLE TO CHECK GAME STATE
  executeGame <-
    reactiveValues(ntext = "", playing = NULL, learner = NULL, stopTraining = FALSE)
  
  # APP - BUTTON - EXECUTE GAME
  # executeGame <- eventReactive
  observeEvent(input$buttonExecuteGame, {
    # If we are here this condition does not have any authority
    executeGame$stopTraining <- FALSE
    
    # Values of the parameters execution
    sizeMap <- as.integer(isolate(input$mapDimension)) # 5
    numberOfEpisodes <-
      as.integer(isolate(input$numberOfEpisodes)) # 100
    initPolicyValues <- as.double(isolate(input$initialQValue))# 0.0
    learningRate <-
      ifelse(length(isolate(input$learningRateValue)) != 0, as.double(isolate(input$learningRateValue)), learningRate) # 1.0
    discountFactor <-
      ifelse(length(isolate(input$discountFactorValue)) != 0, as.double(isolate(input$discountFactorValue)), discountFactor) # 0.2
    epsilonInicial <-
      ifelse(length(isolate(input$initialEpsilonGreedy)) != 0, as.double(isolate(input$initialEpsilonGreedy)), initialEpsilonGreedy) # 0.2
    epsilonFinal <-
      ifelse(length(isolate(input$finalEpsilonGreedy)) != 0, as.double(isolate(input$finalEpsilonGreedy)), finalEpsilonGreedy) # 0.05
    cExploratoryUCB <-
      ifelse(length(isolate(input$exploratoryFactorUcb)) != 0, as.double(isolate(input$exploratoryFactorUcb)), cExploratoryUCB) # 0.05
    usePersonalizedMap <-
      ifelse(length(isolate(input$usePersonalizedMap)) != 0, as.logical(isolate(input$usePersonalizedMap)), usePersonalizedMap) # 0.05
    learningMethod <- isolate(input$selectInputLearningMethod)
    actionSelectionMethod <-
      isolate(input$selectInputSelectionMethod)
    
    # Sending initial configuration
    session$sendCustomMessage(type = 'parameters', message = c(sizeMap))
    
    #==================================================
    #TRAINING A NON-TRAINED LEARNER STEP BY STEP FROM R
    #==================================================
    # Learner con el que realizar los pasos
    print("training starts ...")
    # learner <- trainedLearner(sizeMap, numberOfEpisodes, initPolicyValues, learningRate, discountFactor, epsilonInicial, epsilonFinal, cExploratoryUCB, usePersonalizedMap, learningMethod, actionSelectionMethod, classpath)
    learner <- nonTrainedLearner(sizeMap, numberOfEpisodes, initPolicyValues, learningRate, discountFactor, epsilonInicial, epsilonFinal, cExploratoryUCB, usePersonalizedMap, learningMethod, actionSelectionMethod, classpath)
    
    # Progress of the learning process
    progressBarLearner <- Progress$new(session, min = 1, max = learner$getTotalEpisodes())
    on.exit(progressBarLearner$close())
    
    learner$newPolicy()
    
    start.time <- Sys.time() # there is a time threshold
    totalEpisodes <- (learner$getTotalEpisodes()-1)
    
    # Training
    for (auxEpisode in 0:totalEpisodes) {
      # Stop the training if surpass time threshold for training
      taken.time <- (Sys.time() - start.time)
      
      if(taken.time > (input$trainingTimeThreshold*60)){
        # is.logical(executeGame$stopTraining) && as.logical(executeGame$stopTraining)){
        print("time surpassed!!")
        executeGame$stopTraining <- TRUE
        
        progressBarLearner$set(
          message = "Time for training surpassed!", detail = paste("Threshold time for training: ",input$trainingTimeThreshold," minutes", sep = ""))
        Sys.sleep(5)
        break;
      }
      
      # Progress bar of the learner
      progressBarLearner$set(
        value = learner$getEpisodeNumber(),
        message = 'Executing episodes...',
        detail = paste(
          auxEpisode+1,"/",
          totalEpisodes+1, sep = ""
        )
      )
      
      # Learner
      learner$setEpisodeNumber(as.integer(auxEpisode))
      learner$runEpoch()
    }
    print("...training finished")
    #==================================================
    
    #==================================================
    #TRAINING A TRAINED LEARNER STEP BY STEP FROM R
    #==================================================
    # Learner con el que realizar los pasos
    # learner <- trainedLearner(sizeMap, numberOfEpisodes, initPolicyValues, learningRate, discountFactor, epsilonInicial, epsilonFinal, cExploratoryUCB, usePersonalizedMap, learningMethod, actionSelectionMethod, classpath)
    #==================================================
    if(is.logical(executeGame$stopTraining) && !as.logical(executeGame$stopTraining)){
      # Get initial state
      learner$setNewState(learner$getThisWorld()$resetState())
      
      # Update GUI
      session$sendCustomMessage(type = 'agentPosition', message = learner$getNewState()$agentPosition())
      session$sendCustomMessage(
        type = 'fullLife', message = c(
          learner$getThisWorld()$getAgentFullLife(),
          learner$getThisWorld()$getEnemyFullLife()
        )
      )
      
      mapByZone <-
        learner$getThisWorld()$getGameMap()$getMapAsMatrix()
      mapByZone <- matrix(mapByZone, ncol = sizeMap)
      session$sendCustomMessage(type = 'mapState', message = mapByZone)
      
      # Debugging
      result <- paste(
        "Executing game using ", "\n"
        ,"a learning method ", input$selectInputLearningMethod,"(", input$learningRateValue, ", " , input$discountFactorValue,")", "\n"
        ,"with an action selection method ", input$selectInputSelectionMethod, "\n"
        ,"with a map of " , input$executionParameters, " and ", input$numberOfEpisodes, " episodes", "\n"
        ,"Directory: ", classpath, "\n"
        , sep = ""
      )
      
      # print(result)
      
      executeGame$ntext <- result
      executeGame$playing <- TRUE
      executeGame$learner <- learner
    }
  })
  
  # APP - BUTTON - REPEAT GAME
  observeEvent(input$buttonRepeatGame, {
    # We can only re-execute if an ealier game was played
    if (!is.null(executeGame$learner)) {
      # Get initial state
      executeGame$learner$setNewState(executeGame$learner$getThisWorld()$resetState())
      
      # Update GUI
      session$sendCustomMessage(type = 'agentPosition', message = executeGame$learner$getNewState()$agentPosition())
      session$sendCustomMessage(
        type = 'fullLife', message = c(
          executeGame$learner$getThisWorld()$getAgentFullLife(),
          executeGame$learner$getThisWorld()$getEnemyFullLife()
        )
      )
      
      # Stop the game
      executeGame$ntext <- "result"
      executeGame$playing <- TRUE
    }
  })
  
  
  addPopover(
    session, "buttonRepeatGame", "Re-executing", content = paste0(
      "This works only if you execute the game early.",
      " The re-execute button executes again the game with the latest values of the parameters."
    ), trigger = 'hover'
  )
  
  # APP - BUTTON - STOP GAME
  observeEvent(input$buttonStopGame, {
    executeGame$ntext <- "result"
    executeGame$playing <- FALSE
    executeGame$stopTraining <- TRUE
  })
  
  # Anything that calls autoInvalidateForGameExecution will automatically invalidate every 2 seconds.
  autoInvalidateForGameExecution <- reactiveTimer(intervalMs = 100, session = session)
  
  # APP - CODE FOR EXECUTING THE GAME
  observe({
    # Executing only the game if the user says so and the learner is available
    if (is.logical(executeGame$playing) && as.logical(executeGame$playing) && !is.null(executeGame$learner)) {
      # Execute new action and get the new state
      newState <-
        executeGame$learner$getThisWorld()$getNextState(executeGame$learner$selectAction(executeGame$learner$getNewState()))
      
      if(!is.null(newState)){
        # Setting the new state
        executeGame$learner$setNewState(newState);
        
        # Execute again only if we are not in an end state
        if (!executeGame$learner$getThisWorld()$endState(newState)) {
          # Speed of the execution
          executionSpeedness <-
            ifelse(is.null(isolate(input$executionSpeedness)), executionSpeedness, isolate(input$executionSpeedness))
          
          # Reset new value
          autoInvalidateForGameExecution <-
            reactiveTimer(executionSpeedness * 1000, session = session)#executionSpeedness*1000)
        }
        
        print(paste("Agent destruido: ", newState$agenteDestruido(), sep=""))
        print(paste("Enemy destruido: ", newState$enemigoDestruido(), sep=""))
        
        
        # Do something each time this is invalidated.
        # The isolate() makes this observer _not_ get invalidated and re-executed when input$n changes.
        # Update GUI
        session$sendCustomMessage(type = 'agentPosition', message = newState$agentPosition())
        session$sendCustomMessage(type = 'receivingAirAttack', message = newState$recibiendoBombardeo())
        session$sendCustomMessage(type = 'lifeState', message = newState$getLife())
        session$sendCustomMessage(type = 'agentIsDead', message = newState$agenteDestruido())
        session$sendCustomMessage(type = 'enemyIsDead', message = newState$enemigoDestruido())
        session$sendCustomMessage(
          type = 'nextGreedyPositions', message = executeGame$learner$getNextGreedyAgentPositions(as.integer(3), newState)
        )
        
        # print(newState$agentDestruido())
        if(newState$agenteDestruido() || newState$enemigoDestruido()){
                executeGame$playing <- FALSE
                executeGame$stopTraining <- TRUE
        }
      }else{
        print("'newState' is null")
      }
    }
    
    # Invalidate and re-execute this reactive expression every time the timer fires.
    autoInvalidateForGameExecution()
  })
  
  # Debug
  output$nText <- renderText({
    executeGame$ntext
  })
  
  # =========================================
  # HESPERIA
  # =========================================
#   # Data to be plotted
#   year <- 2016
#   month <- 9
#   day <- 14
#   
#   # Code for plotting
#   output$plotProtonData <-
#     renderPlot({
#       # plotHepadData(goes <- 6, year <- 1992, month <- 7, column <- "P10")
#       # Place where the data is extracted from
#       goes <- 6
#       year <- 1992
#       month <- 7
#       column <- 2 # c("time", "p8", "p9", "p10", "p11", "a7", "a8")
#       print(paste(getwd(), "/hesperia/downloadHepadData.R", sep = ""))
#       
#       # Checking that the function for plotting is already in the environment
#       if (!exists("plotHepadData", mode = "function")) {
#         source(sourceDownloadingHepadData)
#       }
#       
#       # Plotting
#       plotHepadData(goes, year, month, "xs")
#     })
#   
#   output$plotXrayData <-
#     renderPlot({
#       # plotHepadData(goes <- 6, year <- 1992, month <- 7, column <- "xl")
#       
#     })
#   
#   output$picture <-
#     renderPlot({
#       # Download image of the sun
#       library("jpeg")
#       src <-
#         paste(
#           "http://sohowww.nascom.nasa.gov//data/REPROCESSING/Completed/",
#           year,"/eit304/",
#           year,ifelse(
#             month < 10, paste("0",as.character(month), sep = ""),as.character(month)
#           ),ifelse(
#             day < 10, paste("0",as.character(day), sep = ""),as.character(day)
#           )
#           ,"/",year,ifelse(
#             month < 10, paste("0",as.character(month), sep = ""),as.character(month)
#           ),ifelse(
#             day < 10, paste("0",as.character(day), sep = ""),as.character(day)
#           )
#           ,"_1319_eit304_1024.jpg", sep = ""
#         )
#       download.file(src,'www/hesperia/images/mostRecentSunImage.jpg', mode = 'wb')
#       
#       # Create plot with the image
#       par(mar = c(0, 0, 0, 0.0), oma = c(0,0,0,0))
#       jj <-
#         readJPEG("www/hesperia/images/mostRecentSunImage.jpg",native = TRUE)
#       plot(0:1,0:1,type = "n",ann = FALSE,axes = FALSE)
#       rasterImage(jj,0,0,1,1)
#     })
  
  
  # =========================================
  # OTHER PROJECTS
  # =========================================
  # load_data(0);
})
# }
