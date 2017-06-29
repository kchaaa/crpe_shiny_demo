# List of functions we could use

library(shinyjs)
library(V8)

# Gets a Formmated String of Timestamp
getFormattedTime <- function() {
  format(Sys.time(), "%Y%m%d")
}

# Adds the Asterix to Mandatory Fields
labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}
# Makes the Asterix Red
appCSS <- ".mandatory_star { color: red; }"

# Resets the page
jsResetCode <- "shinyjs.reset = function() {history.go(0)}" 
