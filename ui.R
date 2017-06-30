# Title: Shiny Demo App for CRPE Database [UI/Frontend]
# Owner: Kevin 
# Date: 6-23-2016

#### COMMENT THESE OUT BEFORE PUBLISHING ()
rm(list=ls())
setwd("/Users/crpe/Documents/crpe_shiny_demo") # MAC

# Libraries Needed ----------------------------------------------------------
library(shiny) # Need to Run Shiny App
library(shinyWidgets) # Library of More Widgets like the Dropdown Button (see more at: https://github.com/dreamRs/shinyWidgets)
library(shinyjs) # Need for shinyjs

# Scripts Needed ----------------------------------------------------------
source('scripts/list.r') # For Manual Side
source('scripts/helper.r') # For Helpful Functions

## Frontend of the Shiny App-----------------------------------------------
shinyUI(fluidPage(
  # Need to Run These for 'Mandatory Fields' Aspect
  shinyjs::useShinyjs(),
  shinyjs::inlineCSS(appCSS),
  # CRPE Logo
  img(src = "crpe.png", 
      height = '100px', width = '250px', style = "margin-top: 10px"),
  # Application title
  titlePanel("and the Beanstalk"), 
  
  tabPanel(
    
  )
  
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
        choices = c("",dbListTables(conn)), 
        selected = NULL,
        multiple = FALSE),
      
      # Displays Dropdown Menu 2: Year 
      conditionalPanel(
        condition = 'input.dataset!=null',
        pickerInput(
          inputId = "year",
          label = "Select Year(s)",
          choices = YEAR, options = list(`actions-box` = TRUE),
          multiple = TRUE
        )
      ),
      
      # Pick the District
      conditionalPanel(
        condition = "input.dataset.includes(mockschools)",
        pickerInput(
          inputId = "district", 
          label = "Select District", 
          choices = DISTRICT, options = list(`actions-box` = TRUE), 
          multiple = TRUE
        )
      ),
      
      # Pick the City
      conditionalPanel(
        condition = "input.dataset == mockcensus",
        pickerInput(
          inputId = "city", 
          label = "Select City", 
          choices = CITY, options = list(`actions-box` = TRUE), 
          multiple = TRUE
        )
      ),
      
      # Pick the State
      conditionalPanel(
        condition = "input.dataset == mockstates",
        pickerInput(
          inputId = "state", 
          label = "Select State", 
          choices = STATE, options = list(`actions-box` = TRUE), 
          multiple = TRUE
        )
      ),
      
      # Displays the Submit button
      actionButton(inputId = "submitBttn", 
                   label = "Submit",
                   width = '85px'),
      
      # JS code for Reset Button
      extendShinyjs(text = jsResetCode),
      # Displays the Reset Button
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
        condition = "input.submitBttn == 1", # means first click
        dataTableOutput(outputId = "myTable")
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
