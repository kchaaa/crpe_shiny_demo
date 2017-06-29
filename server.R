# Title: Shiny Demo App for CRPE Database [Server/Backend]
# Owner: Kevin 
# Date: 6-23-2016

#### COMMENT THESE OUT BEFORE PUBLISHING ()
# rm(list=ls())
# setwd("/Users/crpe/Documents/crpe_shiny_demo") # MAC
# setwd("C:/Users/phato_000/Documents/CRPE/Shiny/crpe_shiny_demo") # PC

library(shiny) # Need to Run Shiny App
library(shinyjs) # Need to Make Fields Mandatory/Optional and Do Other Cool Stuff
library(DBI) # Need to Query with Database
# library(plyr) # Optional (for now)
# library(dplyr) # Optional (for now)
# library(dbplyr) # Allows you to interact with the database using dplyr instead of SQL (same concept, different terms)
# IF having problems, use devtools::install_github("tidyverse/dbplyr") (make sure to have devtools installed first)
library(RPostgreSQL) # Need to Read PostgreSQL
library(RMySQL)
library(DT) # Need to Download Filtered DataTable
library(stringr)


source('scripts/list.r')
source('scripts/helper.r')  # For Helpful Functions


## Backend of the Shiny App --------------------------------------------------------
shinyServer(function(input, output) {
  
  dataTable <- reactive({
    ## Establish Connection to DB --------------------------------------------------------
    # Connects to the server
    conn <- 
      dbConnect(
        drv = dbDriver("PostgreSQL"), 
        dbname = "Education",
        host = 'education.csj8biafq77k.us-west-2.rds.amazonaws.com',
        port = '5432',
        user = "crpe",
        password = "!crpecrpe1") 
    
    # Disconnects from the Database Once User Done using App 
    on.exit(dbDisconnect(conn)) 
    WORKING_INPUT <- c()
    SELECTED_DATASET <- input$dataset
    CONDITION_EXISTS <- function() {
      
      D <- Switch (SELECTED_DATASET) {
        Case(SELECTED_DATASET = 'edfacts'):
          Return('edfacts.DISTRICT ')
        Case(SELECTED_DATASET = 'ocr) :
          Return( 'ocr.ENROLLMENT  ')
        Case(SELECTED_DATASET = 'ccd) :
          Return('ccd.DEMOGRAPHIC  ')          
        Case(SELECTED_DATASET = 'state) :
          Return( 'state.STATENAM ')
        Case(SELECTED_DATASET = 'census):
          Return( 'census.TRACT ')
        Case(SELECTED_DATASET = 'local):
          Return( 'local.LOCAL_INFO  ')
        Default:
          Throw(ERROR);
      }
      
      str <- D
      
      for (i in WORKING_INPUT) {
        #simon owns this
        #lol
        #this code does some things, and then it stops
        #cool
        #good job boy-o
        paste(str, ' OR ', D, ' = ', i, sep ='')  
      }  
      str <- str_split?str_spl
      return(substr(str, 4, stop))
      
    } 
    # SQL Query
    query <- paste(
      "SELECT * FROM ",
      SELECTED_DATASET,
      " WHERE ",
      paste(SELECTED_DATASET, '.YEAR', sep = ""),
      "=",
      input$year,
      "AND (",
      CONDITION_EXISTS,
      ");",
      sep = "")
    
    
    
    # Gets the Data
    dbGetQuery(conn, query)
    
    
    ## TEST: check if the connection is successful (MAKE SURE TO COMMENT OUT BEFORE RUNNING)
    # Run together with conn from above^
    # dbListTables(conn)
    # RESULT Should Be: "mockschools" "mockcensus", mockstates (or whatever the list of datasets are in the DB)
  })
  
  # Renders the data table based on the inputs from the side panel
  output$myTable <- renderDataTable({
    dataTable()
  })
  
  # Download Button
  output$downloadBttn <- downloadHandler(
    filename = function() { paste('data_', getFormattedTime(), '.csv', sep='') },
    content = function(file) {
      write.csv(dataTable(), file, row.names = FALSE)
    }
  )
  
  # Mandatory Fields Part
  observe({
    # check if all mandatory fields have a value
    mandatoryFilled <-
      vapply(fieldsMandatory,
             function(x) {
               !is.null(input[[x]]) && input[[x]] != ""
             },
             logical(1))
    mandatoryFilled <- all(mandatoryFilled)
    
    # enable/disable the submit button
    shinyjs::toggleState(id = "submitBttn", condition = mandatoryFilled)
  })
  
  # Resets Page
  observeEvent(
    input$resetBttn, {
      js$reset()
    }
  )
  
})