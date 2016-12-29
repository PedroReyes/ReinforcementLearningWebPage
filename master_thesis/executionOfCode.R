# LIBRARIES
library(shiny)
library(shinydashboard)
library(rmarkdown)

# SOURCES

# USER INTERFACE
executionOfCode <<-
  fluidRow(# DOWNLOAD THE CODE
    column(
      width = 12,
      box(
        title = "Download the code", status = "primary", width = 12, solidHeader = FALSE
        ,tags$p(
          align = "justify",
          "The code has been written mainly in Java. You can download the code from "
          , tags$a("here",
                   # "https://www.dropbox.com/linkToProject"
                   href = "https://github.com/PedroReyes/ReinforcementLearning"
                   )
          , ". In this .zip file you will find the next sources:"
        )
        
        ,tags$ul(
          # BasicReinforcementLearningAlgorithm
          tags$li(
            tags$p(
              align = "justify","BasicReinforcementLearningAlgorithm: it is the root of the eclipse project."
            )
          )
          # Experimentos
          , tags$li(
            tags$p(
              align = "justify","Experimentos: this folder may not exist but it will be created when you execute
              your first experiments. In this folder it will be stored the different experiments that you execute."
            )
            )
          # GUI
          , tags$li(
            tags$p(
              align = "justify","GUI: this folder contain a simple interface to check the behavior of the
              particular model."
            )
            )
          # src
          , tags$li(
            tags$p(
              align = "justify","src: the main code necessary to execute the experiments is here.
              Inside this folder you find the next folders:"
            ),
            tags$ul(
              # > Analysis
              tags$li(
                tags$p(
                  align = "justify","Analysis: throughout the R scripts in this folder you can check your results
                  locally, that is, on your machine. You can also check the results of your experiments in this
                  web page. A fast summary of this code is that RLGraficar and RLMain is the code you need to visualize
                  your results locally only using R, SetUpServer.R is a script to establish a connection between
                  Java and R so you can generate your plots automatically from code once the execution has finished.
                  Finally the java code in this folder is mean to execute the R code necessary to generate the charts from Java."
                )
                )
              # > Aspects
              ,tags$li(
                tags$p(
                  align = "justify","Aspects: in this folder we have 3 aspects. CapturingExceptions.aj is used to reduce
                  code all over the project for general exceptions so we do not have a lot of try-catch all over the code
                  that increment the number of lines and the elegibility of the code. DebugginAspect.aj is used to debug
                  the classes that is necessary to debug so in case we only want to see the output of class A we can make it
                  throught this class. RLAnalysisSimulationRecord, this aspect is extremely important since is the one that record
                  and store the results of the experiments that we execute. This class made the classes where the reinforcement
                  learning algorithm are executed extremely easy to read since the code for recording is placed in this aspect
                  and not in the classes (i.e. RLearner.java) where the execution is made."
                )
                )
              
              # > Auxiliary
              ,tags$li(
                tags$p(
                  align = "justify","Auxiliary: in this folder we have the class GameMap that is used to model the map
                  of our game. The Helper class is used for general purposes like generating the root mean square of
                  an array, or getting the name of an experiment based on the parameters you selected.
                  Finally, the Parametrizacion class is used to save the value of the parameters of a particular experiment."
                )
                )
              
              # > Output
              ,tags$li(
                tags$p(
                  align = "justify","Output: this folder contain the java class Output. This class is very important
                  since it defines where will be the root folder to store the results, where to get the R scripts to automatically generate
                  the plots, the type of charts you can create, and two arrays, one for setting a description of the
                  exepriment and another to set where exactly must be stored these results."
                )
                )
              
              # > RL
              ,tags$li(
                tags$p(
                  align = "justify","RL: this folder contains the classes necessary to develop any model that use
                  reinforcement learning algorithms. The reinforcement learning algorithms are developed in the class
                  RLearner and the rest of classes are auxiliaries and very self-explained by the name and comments on them
                  (i.e., Policy class, State class, Action class)."
                )
                )
              
              # > WorldGameComplex
              ,tags$li(
                tags$p(
                  align = "justify","WorldGameComplex: this folder is mean to develop your own model and
                  execute experiments on it. You could create another model and experiment in
                  another different folder following the guidelines of the code you have on this package.
                  In this proyect the class that implements the model is GameWorldSimpleMap. The other files
                  in this folder are experiments of this model and you can copy-paste them to develop your own
                  experiments with your own particular values in the parameter of any algorithm that has been
                  developed."
                )
                )
                )
                )
                )
        
        ,tags$p(
          align = "justify",
          "For executing the code you need to install some things and also to download
          some libraries for the execution. For setting up this you must go to the next section"
        )
        )
                )
    
    # SET UP THE ENVIRONMENT
    ,column(
      width = 12 , box(
        title = "Set up the environment", status = "primary", width = 12, solidHeader = FALSE
        
        ,tags$p(
          align = "justify",
          "For executing the code downloaded you need the next resources installed on your machine:"
        )
        
        ,tags$ul(# BasicReinforcementLearningAlgorithm
          tags$li(
            tags$p(
              align = "justify",
              "Eclipse, you can download eclipse from "
              , tags$a(href = "http://www.eclipse.org/downloads/",
                       "http://www.eclipse.org/downloads/")
              , "We have used eclipse Mars 1 and 2 but any other later version will probably work too.
              Besides, we have to set and installed in Eclipse the next:"
            )
            
            , tags$ul(# BasicReinforcementLearningAlgorithm
              tags$li(
                tags$p(
                  align = "justify","Install AspectJ. You only have to go to
                  Eclipse > Help > Install New Software ... and download AspectJ  setting one of the link
                  in this web page "
                  , tags$a(href = "https://eclipse.org/ajdt/downloads/", "https://eclipse.org/ajdt/downloads/")
                  ,". Once AspectJ is installed the aspect that store the experiment results will work."
                )
              )
              
              ,tags$li(
                tags$p(
                  align = "justify","Set the libraries. This is very simple, you just have to
                  add all the libraries that you see in the folder that is attached to the zip
                  you downloaded."
                )
                ))
                )
          
          ,tags$li(
            tags$p(
              align = "justify","RStudio. It is not necessary to install RStudio but if you don't want
              to check you results neither on the web page nor via Eclipse, you can download RStudio and
              do it by yourself using the R script RLMain. The link to download RStudio is "
              , tags$a(href = "https://www.rstudio.com/", "https://www.rstudio.com/")
              , "."
            )
          ))
            )
            )
    
    # RUN EXPERIMENTS
    ,column(
      width = 12 , box(
        title = "Run experiments", status = "primary", width = 12, solidHeader = FALSE
        
        ,tags$p(
          align = "justify","For executing your own experiments you need to do two things: develop the model
          and develop the experiment. For the first one you need to create a class that implements the RLWorld
          interface (not all the methods must have an implemention for running your model, some of them are
          used as auxiliary methods for getting information from the model).
          For the second you need create a main class that looks like ExperimentoQLearning_EGreedy
          and simply set the algorithm you want to execute and the value of the parameters. In case you do not
          set all the parameters the default will be used."
        )
        
        ,tags$p(
          align = "justify","If you go to the project and check the package yourTurn you will see two classes
          that references the model and the experiment. The class EmptyModel implements RLWorld. Not all the
          methods are necessary to run the model, if you go to RLWorld you will see which methods you are
          obliged to implement. After you have your model developed, probably you will have to add some attributes
          and methods that are specific to your model, you will have to develop an experiment."
        )
        
        ,tags$p(
          align = "justify","The first thing you have to do for creating an experiment is to select the
          number of the experiment you want to run. This number is depending on the array you select in the Output class.
          In the next code you see that is referencing the experiment number 1 (it is the position 2 in an array) and
          is using the array Output.simulationPathExperimentosGameWorldWithMap for the name of the experiment and
          Output.simulationDescriptionExperimentosGameWorldWithMap for the description of the experiment."
        )
        
        ,tags$pre(
"
// ==============
// THE EXPERIMENT
// ==============
int numeroDeExperimento = 1;
String urlDelExperimento = Output.simulationPathExperimentosGameWorldWithMap[numeroDeExperimento];
String descriptionDelExperimento = Output.simulationDescriptionExperimentosGameWorldWithMap[numeroDeExperimento];"
        )
        
        ,tags$p(
          align = "justify","The next thing is to select the algorithm we are going to use and the default values
          of the parameters. In the next code you can see that uses Q-Learning, e-greedy, 100 tasks and 150 episodes.
          There are also the default parameters of the algorithms that we can use."
        )
        
        ,tags$pre(
"
// =======================================
// CONTANTS OF THE EXPERIMENT (PARAMETERS)
// =======================================
// Ejecutar el experimento y crear las graficas
boolean ejecutarExperimento = true;
boolean crearGraficasInternas = false; // el learner crea internamente ciertas graficas como las de la policy
boolean crearGrafica = false;
boolean existOptimalPolicy = false;

// Global parameters to any reinforcement learning experiment
final double[] defaultLearningParameterValues = new double[RLearner.LEARNING_PARAMETER.values().length];
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.totalTasks.ordinal()] = 100; // total de tareas
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.totalEpisodes.ordinal()] = 150; // total de episodias por cada atrea

// Learning and selection method
LEARNING_METHOD learningMethod = LEARNING_METHOD.Q_LEARNING;
SELECTION_METHOD selectionMethod = SELECTION_METHOD.E_GREEDY_CHANGING_TEMPORALLY;

// Learning method parameters
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.alphaLearningRate.ordinal()] = 1; // if selected Q_LEARNING, SARSA, TD(LAMBDA) methods
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.gammaDiscountFactor.ordinal()] = 1; // if selected Q_LEARNING, SARSA, TD(LAMBDA) methods
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.lambdaSteps.ordinal()] = 0.8; // if selected Q_LEARNING, SARSA, TD(LAMBDA) methods

// Selected method parameters
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.epsilonSelection.ordinal()] = 0.1; // if selected eGreedySelection
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.c_UCBSelection.ordinal()] = 1; // if selected UCB_selection
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.temperatureSoftmaxSelection.ordinal()] = 1; // if selected softmax selection
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.baselineUsedSoftmaxSelection.ordinal()] = 1; // if selected softmax selection
final double[] epsilonRange = new double[] {
defaultLearningParameterValues[RLearner.LEARNING_PARAMETER.epsilonSelection.ordinal()], 0 }; // if selected eGreedySelection temporal"
        )
        
        ,tags$p(
          align = "justify","The last thing is to select which will be the values you want to evaluate for the parameters
          of the algorithm selected. We stored the values of the parameters in a map and once this is established and the 
          experiment is executed you will get all possible combinations of the parameters you chose. In the next code you can 
          see that two parameters have been chosen and each of one has one single value."
        )
        
        ,tags$pre(
"
// ================================
// PARAMETER THAT IS UNDER ANALISYS
// ================================
Map<String, Parametrizacion> parametrizaciones = new HashMap<>();

// PARAMETRO 1
String nombreParametro1 = RLearner.LEARNING_PARAMETER.alphaLearningRate.name();
int divisionesParametro1 = 1;//4;
double[] learningRateValues = new double[divisionesParametro1];
if (true) { // while a factor approaching 1 will make it strive for a long-term high reward.
//			learningRateValues[0] = 0.1;
//			learningRateValues[1] = 0.5;
learningRateValues[0] = 1.0;
}
parametrizaciones.put(nombreParametro1, new Parametrizacion(learningRateValues, nombreParametro1));

// PARAMETRO 2 (THERE MAY NOT BE A SECOND PARAMETER TO EVALUATE)
String nombreParametro2 = RLearner.LEARNING_PARAMETER.gammaDiscountFactor.name();
int divisionesParametro2 = 1;//6;
double[] discountFactorValues = new double[divisionesParametro2];
if (true) { // (=0 then we have a 1-step TD backup, = 1 then we have a Monte Carlo backup)
discountFactorValues[0] = 1.0;
}
parametrizaciones.put(nombreParametro2, new Parametrizacion(discountFactorValues, nombreParametro2));"
        )
        
        
        )
      
        ))
