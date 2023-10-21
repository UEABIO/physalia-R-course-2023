library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(agridat)    # The source of your data

# Loading data ----
Barley <- as.data.frame(beaven.barley)

# ui.R ----
ui <- fluidPage(
  titlePanel("Barley Yield"),
  sidebarLayout(
    sidebarPanel(
      demo_gen <- selectInput(inputId = "gen",  # Give the input a name "genotype"
                  label = "1. Select genotype",  # Give the input a label to be displayed in the app
                  choices = c("A" = "a","B" = "b","C" = "c","D" = "d","E" = "e","F" = "f","G" = "g","H" = "h"), selected = "a"),  # Create the choices that can be selected. e.g. Display "A" and link to value "a"
      demo_colour <- selectInput(inputId = "colour", 
                  label = "2. Select histogram colour", 
                  choices = c("blue","green","red","purple","grey"), selected = "grey"),
      demo_bin <- sliderInput(inputId = "bin", 
                  label = "3. Select number of histogram bins", 
                  min=1, max=25, value= c(10)),
      demo_text <- textAreaInput(inputId = "text", 
                label = "4. Enter some text to be displayed",
                rows = 5,
                placeholder = "Enter some information here"),
      demo_date <- dateRangeInput(inputId = "date_range", 
                                  label = "Select Date Range", 
                                  start = "2022-01-01", 
                                  end = "2022-12-31",
                                  format = "yyyy-mm-dd")  # New dateInput widget
    ),
    mainPanel()
  )
)

# server.R ----
server <- function(input, output) {
  
 
}

# Run the app ----
shinyApp(ui = ui, server = server)