# Clear environment
rm(list = ls())

learnerNewInstance <- function(classpath){
  # Console in case of error: sudo R CMD javareconf
  library(rJava)
  # "/Users/pedro/Google Drive/generatedJar/RLJava.jar"
  init = .jinit(classpath = classpath, parameters = "-Xmx512m", force.init = FALSE)

  # The object in charge to execute the learner
  obj <- .jnew(
    "RLearnerExecutor",
    as.integer(0),
    as.integer(0),
    as.double(0),
    as.double(0),
    as.double(0),
    as.double(0),
    as.double(0),
    as.double(0),
    as.logical(FALSE),
    as.character(""),
    as.character("")
  )
  
  # Getting the learner
  learner <- obj$getLearner()
  
  return (learner)
}

nonTrainedLearner <-
  function(sizeMap,numberOfEpisodes,initPolicyValues,alpha,gamma,epsilonInicial,epsilonFinal, cExploratoryUCB, usePersonalizedMap, learningMethod, actionSelectionMethod, classpath) {
    # Console in case of error: sudo R CMD javareconf
    library(rJava)
    # "/Users/pedro/Google Drive/generatedJar/RLJava.jar"
    init = .jinit(classpath = classpath, parameters = "-Xmx512m", force.init = FALSE)
    
    # The object in charge to execute the learner
    obj <- .jnew(
      "RLearnerExecutor",
      as.integer(sizeMap),
      as.integer(numberOfEpisodes),
      as.double(initPolicyValues),
      as.double(alpha),
      as.double(gamma),
      as.double(epsilonInicial),
      as.double(epsilonFinal),
      as.double(cExploratoryUCB),
      as.logical(usePersonalizedMap),
      learningMethod,
      actionSelectionMethod
    )
    
    # Getting the learner
    learner <- obj$getLearner()
    
    return(learner)
  }

trainedLearner <-
  function(sizeMap,numberOfEpisodes,initPolicyValues,alpha,gamma,epsilonInicial,epsilonFinal, cExploratoryUCB, usePersonalizedMap, learningMethod, actionSelectionMethod, classpath) {
    # Console in case of error: sudo R CMD javareconf
    library(rJava)
    # "/Users/pedro/Google Drive/generatedJar/RLJava.jar"
    init = .jinit(classpath = classpath, parameters = "-Xmx512m", force.init = FALSE)
    
    # The object in charge to execute the learner
    obj <- .jnew(
      "RLearnerExecutor",
      as.integer(sizeMap),
      as.integer(numberOfEpisodes),
      as.double(initPolicyValues),
      as.double(alpha),
      as.double(gamma),
      as.double(epsilonInicial),
      as.double(epsilonFinal),
      as.double(cExploratoryUCB),
      as.logical(usePersonalizedMap),
      learningMethod,
      actionSelectionMethod
    )
    
    # Training the learner
    .jcall(obj, returnSig = "V", "executeLearner") # invoke sayHello method
    
    # Getting the learner
    learner <- obj$getLearner()
    
    return(learner)
  }