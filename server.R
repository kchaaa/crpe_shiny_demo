# Title: Shiny Demo App for CRPE Database [Server/Backend]
# Owner: Kevin 
# Date: 6-23-2016

#### COMMENT THESE OUT BEFORE PUBLISHING ()
# rm(list=ls())
# setwd("/Users/crpe/Documents/crpe_shiny_demo") # MAC

library(shiny) # Need to Run Shiny App
library(shinyjs) # Need to Make Fields Mandatory/Optional and Do Other Cool Stuff
library(DBI) # Need to Query with Database
# library(plyr) # Optional (for now)
# library(dplyr) # Optional (for now)
# library(dbplyr) # Allows you to interact with the database using dplyr instead of SQL (same concept, different terms)
# IF having problems, use devtools::install_github("tidyverse/dbplyr") (make sure to have devtools installed first)
library(RPostgreSQL) # Need to Read PostgreSQL


## Establish Connection to DB --------------------------------------------------------
# Connects to the server
conn <- 
  dbConnect(
    drv = dbDriver("PostgreSQL"), 
    dbname = "Education",
    host = 'education.csj8biafq77k.us-west-2.rds.amazonaws.com',
    port = '5432',
    user = "crpe",
    password = "!crpecrpe1"
  )
## TEST: check if the connection is successful (MAKE SURE TO COMMENT OUT BEFORE RUNNING)
# Run together with conn from above^
# dbListTables(conn)
# RESULT Should Be: "mockschools" "mockcensus", mockstates (or whatever the list of datasets are in the DB)


## Backend of the Shiny App --------------------------------------------------------
shinyServer(function(input, output) {
  ## SidePanel ---------------------------------------------------------------------
  
  
  
  ## MainPanel ---------------------------------------------------------------------
  # Renders the data table based on the inputs from the side panel
  output$my_table <- renderDataTable({
    
    # Disconnects from the Database Once User Done using App 
    on.exit(dbDisconnect(conn), add = TRUE)
    
    
    # Gets the Data
    dbGetQuery(conn, paste(
      "SELECT * FROM ", input$dataset, ";", sep = ""))
    
    
    
  })
  
  # Prepares Data Table to be Downloaded
  dataTable <- reactive({
    
  })
  
  # Download Button
  output$downloadBttn <- downloadHandler(
    filename = function() { paste0('test', '.csv') },
    content = function(file) {
      write.csv(dataTable(), file, row.names = FALSE)
    }
  )
  
})
