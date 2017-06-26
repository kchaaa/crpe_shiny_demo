

library(shiny)
library(DBI)
library(plyr)
library(dplyr)
library(dbplyr)
library(RPostgreSQL)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  ## SidePanel ##
  
  
  
  
  ## MainPanel ##
  # connects to database
  output$my_table <- renderDataTable({
    conn <- 
      # Connects to the server
      dbConnect(
      drv = dbDriver("PostgreSQL"),
      dbname = "Education",
      host = 'education.csj8biafq77k.us-west-2.rds.amazonaws.com',
      port = '5432',
      user = "crpe",
      password = "test12CRPE!"
      )
      # Exits 
      on.exit(dbDisconnect(conn), add = TRUE)
      # Gets the data
      dbGetQuery(conn, paste0(
        "SELECT * FROM mockschools ", input$dataset, ";"))
  })
  
  #download button
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dataset, '.csv', sep='') },
    content = function(file) {
      write.csv(datasetInput(), file)
    }
  )
})
