# List of functions we could use

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
