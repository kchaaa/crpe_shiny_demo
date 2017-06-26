# https://github.com/dreamRs/shinyWidgets

library(shiny)
library(shinyWidgets)


names <- c('A', 'B', 'C',
           'D', 'E')
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("CRPE Demo"),
  
  
  sidebarLayout(
    # Dropdown buttons
    sidebarPanel(
      pickerInput(
        inputId = "dataset", 
        label = "Select Datasets", 
        choices = LETTERS, options = list(`actions-box` = TRUE), 
        multiple = TRUE
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      dataTableOutput("my_table"),
      downloadButton('downloadData', 'Download')
    )
  )
))
