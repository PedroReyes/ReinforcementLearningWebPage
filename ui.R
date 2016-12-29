# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://www.rstudio.com/shiny/

# LIBRARIES
library(shiny)
library(shinydashboard)
library(rmarkdown)
library(shinyjs)

# SOURCES OF APPLICATIONS
# source: web page index
# source(paste(getwd(), "/index.R", sep = ""))

# source: indexHesperia
# source(paste(getwd(), "/hesperia/indexHesperia.R", sep = ""))

# source: indexMasterThesis
source(paste(getwd(), "/master_thesis/indexMasterThesis.R", sep = ""))

# SOURCES OF INDIVIUAL APPLICATIONS
# source: tabMasterThesis
source(paste(getwd(), "/master_thesis/tabMasterThesis.R", sep = ""))

# if(interactive()){
shinyUI(# ==================================================================
        # EVERYTHING IN ONE
        # ==================================================================
#                 dashboardPage(
#                   dashboardHeader(title = "Pedro Reyes's personal website", disable = FALSE),
#                   dashboardSidebar(disable = FALSE
#                                    ,sidebarMenu(
#                                      menuItem("Master", tabName = "master", icon = icon("th")),
#                                      menuItem("Simulator HESPERIA", tabName = "hesperiaSimulator", icon = icon("dashboard")),
#                                      menuItem("SIPX", tabName = "SIPX", icon = icon("dashboard")),
#                                      menuItem("HESPERIA file reader", tabName = "reader", icon = icon("dashboard"))
#                                    )),
#                   dashboardBody(tabItems(
#                     tabItem(tabName = "master", uiTabMasterThesis),
#                     tabItem(tabName = "hesperiaSimulator", indexHesperia),
#                     tabItem(tabName = "SIPX", h2("Solar Image Proton X Ray (SIPX) forecaster: Este proyecto tiene inicialmente la intención de recopilar
#                                                  imagenes del sol, de rayos X y de protones para la posterior
#                                                  construcción de un predictor pre-tormentas solares y post-tormentas solares")),
#                     tabItem(tabName = "reader", h2("Csv file reader: este proyecto tiene como 
#                                                    unica intención mostrar cada columna de un archivo .csv
#                                                    en una gráfica junto con ciertas características generales como
#                                                    por ejemplo maximo valor, mínimo valor, etc."))
#                   ))
#                 )
        
        # ==================================================================
        # APLICACION CON PAGINA DE INICIO EN LA QUE APARECEN MIS CREDENCIALES
        # ==================================================================
        #     navbarPage(title = "1 + 1",
        #                # APLICACION FINAL
        #                tabPanel("Home", uiHome)
        #                , tabPanel("Master Thesis", indexMasterThesis)
        #                # , tabPanel("Hesperia", indexHesperia)
        #                )
        
        # ==================================================================
        # MASTER THESIS
        # ==================================================================
        indexMasterThesis
        
        # ==================================================================
        # HESPERIA SIMULATOR: CME
        # ==================================================================
        # indexHesperia
        
        # ==================================================================
        # HESPERIA FILE READER
        # ==================================================================
        # indexReader
        )



