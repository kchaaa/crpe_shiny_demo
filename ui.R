# Title: Shiny Demo App for CRPE Database [UI/Frontend]
# Owner: Kevin 
# Date: 6-23-2016

#### COMMENT THESE OUT BEFORE PUBLISHING ()
# rm(list=ls())
# setwd("/Users/crpe/Documents/crpe_shiny_demo") # MAC

library(shiny) # Need to Run Shiny App
library(shinyWidgets) # Library of More Widgets like the Dropdown Button (see more at: https://github.com/dreamRs/shinyWidgets)

## Lists ------------------------------------------------------------------
# Names for the Options OF Dropdown Menu 1: Datasets
# Names for the Options OF Dropdown Menu 2: Year
YEARS <- c('2014-15', '2013-14', '2012-13', 
           '2011-12', '2010-11', '2009-10', 
           '2008-09', '2007-08', '2006-07', 
           '2005-06', '2004-05', '2003-04', 
           '2002-03', '2001-02', '2000-01' )
# Names for the Options OF Dropdown Menu 4: City
STATE <- c('AL', 'AK', 'AZ', 'AR', 'CA', 'CO',
           'CT', 'DE', 'DC', 'FL', 'GA', 'HI',
           'ID', 'IL', 'IN', 'IA', 'KS', 'KY',
           'LA', 'ME', 'MD', 'MA', 'MI', 'MN',
           'MS', 'MO', 'MT', 'NE', 'NV', 'NH',
           'NJ', 'NM', 'NY', 'NC', 'ND', 'OH',
           'OK', 'OR', 'PA', 'RI', 'SC', 'SD',
           'TN', 'TX', 'UT', 'VT', 'VA', 'WA',
           'WV', 'WI', 'WY')
# Names for the Options OF Dropdown Menu 4: City
CITY <- c('Atlanta', 'Baltimore', 'Boston', 'Camden',
          'Denver', 'Detroit', 'Houston', 'Indianapolis', 
          'Kansas City', 'Little Rock', 'Los Angeles', 'Memphis', 
          'New Orleans', 'New York City', 'Newark', 'Oakland', 
          'Philadelphia', 'San Antonio', 'Tulsa', 'Washington DC' )
# Names for the Options OF Dropdown Menu 5: District
DISTRICT <- c('APS', 'BCPS', 'BPS', 'CSD', 
              'DPS', 'DPSCD', 'HISD', 'IPS',
              'KCPS', 'LRSD', 'LAUSD', 'SCS',
              'OPBD', 'NYC', 'NPS', 'OUSD',
              'PSD', 'SAISD', 'TPS', 'DCPS')

# Define which fields are mandatory
fieldsMandatory <- c("dataset", "state")

## Frontend of the Shiny App-----------------------------------------------
shinyUI(fluidPage(
  # CRPE Logo
  img(src='img/crpe.svg'),
  # Application title
  titlePanel("CRPE Database Demo"), 
  
  # SidePanel -------------------------------------------
  # -The Input/Dropdown Menu that Control the Output
  sidebarLayout(
    sidebarPanel(
      # Displays Dropdown Menu 1: Datasets
      pickerInput(
        inputId = "dataset", 
        label = "Select Datasets", 
        choices = dbListTables(conn), options = list(`actions-box` = TRUE), 
        multiple = TRUE
      ),
      
      
      
      
      # Displays Dropdown Menu 2: Year 
      # pickerInput(
      #   inputId = "year", 
      #   label = "Select Year(s)", 
      #   choices = YEARS, options = list(`actions-box` = TRUE), 
      #   multiple = TRUE
      # ),
      numericInput(
        inputId = 'year',
        label = 'Select Which Year',
        value = '2015'  # Default Starting Value
      ),
      
      # Pick the State
      pickerInput(
        inputId = "state", 
        label = "Select State", 
        choices = STATE, options = list(`actions-box` = TRUE), 
        multiple = TRUE
      ),
      
      # Pick the City
      pickerInput(
        inputId = "city", 
        label = "Select City", 
        choices = CITY, options = list(`actions-box` = TRUE), 
        multiple = TRUE
      ),
      
      # Pick the District
      pickerInput(
        inputId = "district", 
        label = "Select District", 
        choices = DISTRICT, options = list(`actions-box` = TRUE), 
        multiple = TRUE
      ),
      
      # Displays the Submit button
      actionButton(inputId = "submitBttn", 
                   label = "Submit",
                   width = '85px'),
      
      # Displays the Reset button
      actionButton(inputId = "resetBttn", 
                   label = "Reset",
                   width = '85px'),
      
      # Blank Space
      hr()
      
    ),
    
    # MainPanel -------------------------------------------
    # -The Output/Table Displayed Based on Input
    mainPanel(
      # Displays Data Table
      conditionalPanel(
        condition = "input.submitBttn == 1",
        dataTableOutput(outputId = "my_table")
        # find out if you can include its own scroller
      ),
      
      # Blank Space
      hr(),
      
      # Displays Download Button
      downloadButton(outputId = 'downloadBttn', 
                     label = 'Download')
    )
  )
))
