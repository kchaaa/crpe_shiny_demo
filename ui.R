# Title: Shiny Demo App for CRPE Database [UI/Frontend]
# Owner: Kevin 
# Date: 6-23-2016

#### COMMENT THESE OUT BEFORE PUBLISHING ()
# rm(list=ls())
# setwd("/Users/crpe/Documents/crpe_shiny_demo") # MAC

# Libraries Needed ----------------------------------------------------------
library(shiny) # Need to Run Shiny App
library(shinyWidgets) # Library of More Widgets like the Dropdown Button (see more at: https://github.com/dreamRs/shinyWidgets)

# Scripts Needed ----------------------------------------------------------
source('scripts/list.r') # For Manual Side
source('scripts/helper.r') # For Helpful Functions

## Frontend of the Shiny App-----------------------------------------------
shinyUI(fluidPage(
  # Need to Run These for 'Mandatory Fields' Aspect
  shinyjs::useShinyjs(),
  shinyjs::inlineCSS(appCSS),
  # CRPE Logo
  # img(src = 'data:image/png;base64,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', 
  #     height = '100px', width = '250px', style = "margin-top: 10px"),
  img(src = "/Users/crpe/Documents/crpe_shiny_demo/www", 
      height = '100px', width = '250px', style = "margin-top: 10px"),
  # Application title
  titlePanel("Elastic Beanstalk"), 
  
  # SidePanel -------------------------------------------
  # -The Input/Dropdown Menu that Control the Output
  sidebarLayout(
    sidebarPanel(
      # Displays Dropdown Menu 1: Datasets
      # pickerInput(
      #   inputId = "dataset", 
      #   label = "Select Datasets", 
      #   # choices = dbListTables(conn), 
      #   choices = DATASET,
      #   options = list(`actions-box` = TRUE), 
      #   multiple = TRUE
      # ),
      selectInput(
        inputId = "dataset", 
        label = labelMandatory("Select Dataset"), 
        choices = c("",DATASET), 
        selected = NULL,
        multiple = FALSE),
      
      # Displays Dropdown Menu 2: Year 
      # pickerInput(
      #   inputId = "year", 
      #   label = "Select Year(s)", 
      #   choices = YEARS, options = list(`actions-box` = TRUE), 
      #   multiple = TRUE
      # ),
      numericInput(
        inputId = 'year',
        label = labelMandatory('Select Year'),
        value = '2015',  # Default Starting Value
        min = '1990',
        max = '2015'
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
