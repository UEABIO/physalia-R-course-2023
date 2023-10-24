
# (PART\*) Introduction to Shiny {.unnumbered}

# Getting to work with Shiny




https://ourcodingclub.github.io/tutorials/shiny/

https://psyteachr.github.io/shiny-tutorials/

https://debruine.github.io/shinyintro/first-app.html

Add change layouts: https://shiny.posit.co/r/articles/build/layout-guide/

https://albert-rapp.de/posts/15_use_js_with_shiny/15_use_js_with_shiny.html

https://albert-rapp.de/posts/06_shiny_app_learnings/06_shiny_app_learnings

Shinyjs: https://deanattali.com/shinyjs/example

Shiny modules - 
https://rviews.rstudio.com/2021/10/20/a-beginner-s-guide-to-shiny-modules/


At its core, Shiny is essentially an R package, similar to dplyr or ggplot2. However, Shiny is unique in that it allows you to build web applications using the R language, instead of relying on traditional web development technologies like JavaScript or HTML5. This R-based approach makes Shiny an efficient choice for creating web applications tailored for data presentation and analysis.

To illustrate, let's take a look at an example of a basic Shiny app that we will recreate in today's tutorial


## IMAGE

Shiny apps are useful for several purposes:

**Interactive Data Visualization for Presentations and Websites:** Shiny apps allow you to create interactive data visualizations, which can enhance your presentations, reports, or websites. Users can explore data, change parameters, and see real-time updates, making the information more engaging and informative.

**Sharing Results with Collaborators:** Shiny apps are valuable for sharing data and analysis results with collaborators, team members, or clients. By creating interactive dashboards or tools, you can make it easier for others to interact with and understand the data, even if they don't have expertise in R or data analysis.

**Communicating Science in an Accessible Way:** Shiny apps can be a powerful tool for scientists, researchers, and educators to communicate complex scientific concepts or research findings to a broader audience. They provide an accessible and user-friendly interface to explore and understand data-driven insights.

**Bridging the Gap Between R Users and Non-R Users:** Shiny acts as a bridge between R users and individuals who may not be familiar with R programming. With Shiny, you can create applications that allow non-R users to interact with and benefit from R's data analysis capabilities without needing to write R code themselves.

## Using the Demo App

New project…
Under the File menu, choose New Project.... You will see a popup window like the one below. Choose New Directory.

### Run the app

Click on Run App in the top right corner of the source pane. The app will open up in a new window. Play with the slider and watch the histogram change.

### Modify the Demo App

Now we’re going to make a series of changes to the demo app until it’s all your own.

You can close the app by closing the window or browser tab it’s running in, or leave it running while you edit the code. If you have multiple screens, it’s useful to have the app open on one screen and the code on another.

# Layout

# Make our own App

Now that you've seen a basic Shiny app in actin, let's return to the beginning and  create our own app.R file. A basic app.R consists of five key parts:

**Package Loading:** At the top of the script, load any necessary R packages for your app to function. `shiny` is a requirement, but you can add others like `dplyr` or `ggplot2` as needed. If any packages are missing, you'll encounter an error, so ensure that you have them installed.


```r
# Load the required packages
library(shiny)       # Essential for running any Shiny app
library(tidyverse)  # Contains readr, dplyr and ggplot2
library(palmerpenguins)    # The source of your data
```

**Data Loading:** Next, load any data necessary for your app. This typically involves reading datasets into R objects. Ensure that you have the data file or source available in the specified format.


```r
# Load the data
penguins <- as_tibble(penguins)
```

**UI Object:** Create an object called ui that defines the app's user interface. This specifies how the app will appear in the web browser. The `fluidPage()` function creates a responsive layout that adjusts to the browser window's size. All of your UI code will go inside the curly braces.


```r
# Define the UI
ui <- fluidPage(
  # Your UI components will be defined here
)
```

**Server Object:** Create another object called server, which contains the app's logic. Here, you specify how your app computes and creates plots, tables, maps, or any other content based on the user's input. All of the app's logic code will be placed inside the server function.


```r
# Define the server logic
server <- function(input, output) {
  # Your server logic will be defined here
}
```

**App Execution:** Finally, include a command at the end of app.R to run your app. This informs Shiny that the user interface is defined by the ui object, and the server logic (data, plots, tables, etc.) is defined by the server object.


```r
# Run the app
shinyApp(ui = ui, server = server)
```

To create your own Shiny app, you should remove any example code generated automatically when you created app.R and replace it with the structure provided above. Check that your final app.R script resembles the following:


<button id="displayTextunnamed-chunk-7" onclick="javascript:toggle('unnamed-chunk-7');">Show Solution</button>

<div id="toggleTextunnamed-chunk-7" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(palmerpenguins)    # The source of your data

# Load the data
penguins <- as_tibble(penguins)

# ui.R ----
ui <- fluidPage(
  # Your UI components will be defined here
)

# server.R ----
server <- function(input, output) {
  # Your server logic will be defined here
}

# Run the app ----
shinyApp(ui = ui, server = server)
```
</div></div></div>

By following these steps, you'll have the basic structure of a Shiny app in place, ready for you to add your UI elements and server logic to create an interactive web application.

# Inputs

Now that you have the basic structure of your Shiny app, you can start adding input and output elements to make it interactive. This example app includes four input widgets: a `selectInput` for genotype, another `selectInput` for histogram color, a `sliderInput` for the number of bins, and a `textInput` for arbitrary text. These widgets provide information on how to display a histogram and its accompanying table. In the example app, all these widgets are placed in the `sidebarPanel`. Here's how you can incorporate these widgets into your app:


```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(palmerpenguins)    # The source of your data

# Load the data
penguins <- as_tibble(penguins)

# ui.R ----
ui <- fluidPage(
  sidebarLayout(
     sidebarPanel(
      demo_sp <- selectInput(inputId = "species",  # Give the input a name "genotype"
                  label = "1. Select species",  # Give the input a label to be displayed in the app
                  choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", "Gentoo" = "Gentoo"), selected = "Adelie"),  # Create the choices that can be selected. e.g. Display "Adelie" and link to value "Adelie"
      demo_select <- selectInput(inputId = "colour", 
                  label = "2. Select histogram colour", 
                  choices = c("blue","green","red","purple","grey"), selected = "grey"),
      demo_slide <- sliderInput(inputId = "bin", 
                  label = "3. Select number of histogram bins", 
                  min=1, max=25, value= c(10)),
      demo_text <- textAreaInput(inputId = "text", 
                label = "4. Enter some text to be displayed",
                rows = 5,
                placeholder = "Enter some information here")
    ),
    mainPanel(
      # Output elements go here
    )
  )
)
# server.R ----
server <- function(input, output) {
  # Your server logic will be defined here

}



# Run the app ----
shinyApp(ui = ui, server = server)
```

In the code above, we've added the input widgets in the `sidebarPanel` section of your `ui` object. These widgets allow users to select a genotype, choose a histogram color, set the number of bins for the histogram, and add arbitrary text.

Let's take a moment to understand the `selectInput()` function and how it's configured:

**inputId = "species":** This is the unique identifier for this input element. It's crucial for later referencing this input within your app script.

**label = "1. Select species":** This is the label you want to display above the input in your app. It provides clarity to users by describing the purpose of the input.

**choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", ...):** Here, you define a list of choices that will be presented in the dropdown menu. Each choice has two parts: the display label (on the left) and the corresponding value that the app will collect and use in its output (on the right).

**selected = "grey":** This specifies the default value selected in the dropdown menu when the app is first loaded. In this example, 'grey' will be preselected.

Now that you've grasped how `selectInput()` works, let's use it to customize your Shiny app further."

The above explanation clarifies the purpose and settings of the `selectInput()` function, and you can use this understanding to configure other input elements in your Shiny app. Below is a summary of the different Input functions available for Shiny

## textInput

## textAreaInput

##selectInput

##checkboxGroupInput

##checkboxInput

##radioButtons

##dateInput

##dateRangeInput

##fileInput


Next, you'll need to implement the server logic and output elements in the `server.R` section. The server logic will define how these inputs affect the display of your histogram and table, but that would require additional code specific to your application's requirements.

Remember that Shiny allows you to create reactive expressions and functions that respond to changes in input values. You can use these reactive expressions to generate the histogram and associated table based on user input.

As you proceed, you can add more details to your `server.R` to handle these inputs and create the corresponding outputs.


## Exercise 

Create an interface that gets people to enter their name, date of birth and select what type of cake they want from a selection OF - 

- Chocolate

- Sponge

- Red Velvet

- Cheesecake


# Outputs



```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(palmerpenguins)    # The source of your data

# Load the data
penguins <- as_tibble(penguins)

# ui.R ----
ui <- fluidPage(
  sidebarLayout(
     sidebarPanel(
      demo_sp <- selectInput(inputId = "species",  # Give the input a name "genotype"
                  label = "1. Select species",  # Give the input a label to be displayed in the app
                  choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", "Gentoo" = "Gentoo"), selected = "Adelie"),  # Create the choices that can be selected. e.g. Display "Adelie" and link to value "Adelie"
      demo_select <- selectInput(inputId = "colour", 
                  label = "2. Select histogram colour", 
                  choices = c("blue","green","red","purple","grey"), selected = "grey"),
      demo_slide <- sliderInput(inputId = "bin", 
                  label = "3. Select number of histogram bins", 
                  min=1, max=25, value= c(10)),
      demo_text <- textAreaInput(inputId = "text", 
                label = "4. Enter some text to be displayed",
                rows = 5,
                placeholder = "Enter some information here")
    ),
    mainPanel(
      # Output elements go here
        textOutput("demo_text"),
        
        plotOutput("demo_plot", width = "500px", height="300px"),
        
        DT::dataTableOutput("demo_table",
                    width = "50%",
                    height = "auto")
    )
  )
)
# server.R ----

 
server <- function(input, output) {
   # Your server logic will be defined here
  output$demo_text <- renderText({
    paste("Figure 1.", input$species, input$text)
  })
  
  output$demo_plot <- renderPlot({
    penguins_filtered <- penguins |>
      filter(species == input$species)
    
    ggplot(penguins_filtered, aes(x = flipper_length_mm)) +
      geom_histogram(fill = input$colour, show.legend = FALSE, bins = input$bin) +
      labs(fill = "Color") +
      theme_minimal()
  })
  
  output$demo_table <- DT::renderDataTable({
   penguins  |> 
      filter(species == input$species) |> 
    summarise(flipper_length_mm = quantile(flipper_length_mm, c(0.25, 0.5, 0.75), na.rm = T), quantile = c(0.25, 0.5, 0.75))
})
  
}



# Run the app ----
shinyApp(ui = ui, server = server)
```

## Text

## Plots

## Images

## Tables

## Layouts, themes, HTML

Exercise: Customize the app's appearance by adding a custom color scheme, a title with a different font, and adjusting the size of the plot.

```
  
p("p creates a paragraph of text."),

      
      p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
      
      strong("strong() makes bold text."),
      
      em("em() creates italicized (i.e, emphasized) text."),
      
      br(),
      
      code("code displays your text similar to computer code"),
      
      div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
      
      br(),
      
      p("span does the same thing as div, but it works with",
        span("groups of words", style = "color:blue"),
        "that appear inside a paragraph."),

```



```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(palmerpenguins)    # The source of your data

# Load the data
penguins <- as_tibble(penguins)

# ui.R ----
ui <- fluidPage(
  sidebarLayout(
     sidebarPanel(
      demo_sp <- selectInput(inputId = "species",  # Give the input a name "genotype"
                  label = "1. Select species",  # Give the input a label to be displayed in the app
                  choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", "Gentoo" = "Gentoo"), selected = "Adelie"),  # Create the choices that can be selected. e.g. Display "Adelie" and link to value "Adelie"
      demo_select <- selectInput(inputId = "colour", 
                  label = "2. Select histogram colour", 
                  choices = c("blue","green","red","purple","grey"), selected = "grey"),
      demo_slide <- sliderInput(inputId = "bin", 
                  label = "3. Select number of histogram bins", 
                  min=1, max=25, value= c(10)),
      demo_text <- textAreaInput(inputId = "text", 
                label = "4. Enter some text to be displayed",
                rows = 5,
                placeholder = "Enter some information here")
    ),
    mainPanel(
      # Output elements go here
        
    tags$ul(
    tags$strong(textOutput("demo_sp")),
    textOutput("demo_text")),
  
        plotOutput("demo_plot", width = "500px", height="300px"),
        
        DT::dataTableOutput("demo_table",
                    width = "50%",
                    height = "auto")
    )
  )
)
# server.R ----

 

server <- function(input, output) {
  

  output$demo_sp <- renderText({
    paste("Figure 1.", input$species)
  })
  
output$demo_text <- renderText({
  (input$text)
})
   
    
  output$demo_plot <- renderPlot({
    penguins_filtered <- penguins |>
      filter(species == input$species)
    
    ggplot(penguins_filtered, aes(x = flipper_length_mm)) +
      geom_histogram(fill = input$colour, show.legend = FALSE, bins = input$bin) +
      labs(fill = "Color") +
      theme_minimal()
  })
  
  output$demo_table <- DT::renderDataTable({
   penguins |>
      filter(species == input$species) |> 
    summarise(flipper_length_mm = quantile(flipper_length_mm, c(0.25, 0.5, 0.75), na.rm = T), quantile = c(0.25, 0.5, 0.75))
})
  
}



# Run the app ----
shinyApp(ui = ui, server = server)
```


# Reactive

```
Error in filter(., species == input$species) : 
  ℹ In argument: `species == input$species`.
Caused by error in `input$species`:
! Can't access reactive value 'species' outside of reactive consumer.
ℹ Do you need to wrap inside reactive() or observe()?

```


```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(palmerpenguins)    # The source of your data

# Load the data
penguins <- as_tibble(penguins)

# ui.R ----
ui <- fluidPage(
  sidebarLayout(
     sidebarPanel(
      demo_sp <- selectInput(inputId = "species",  # Give the input a name "genotype"
                  label = "1. Select species",  # Give the input a label to be displayed in the app
                  choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", "Gentoo" = "Gentoo"), selected = "Adelie"),  # Create the choices that can be selected. e.g. Display "Adelie" and link to value "Adelie"
      demo_select <- selectInput(inputId = "colour", 
                  label = "2. Select histogram colour", 
                  choices = c("blue","green","red","purple","grey"), selected = "grey"),
      demo_slide <- sliderInput(inputId = "bin", 
                  label = "3. Select number of histogram bins", 
                  min=1, max=25, value= c(10)),
      demo_text <- textAreaInput(inputId = "text", 
                label = "4. Enter some text to be displayed",
                rows = 5,
                placeholder = "Enter some information here")
    ),
    mainPanel(
      # Output elements go here
        
    tags$ul(
    tags$strong(textOutput("demo_sp")),
    textOutput("demo_text")),
  
        plotOutput("demo_plot", width = "500px", height="300px"),
        
        DT::dataTableOutput("demo_table",
                    width = "50%",
                    height = "auto")
    )
  )
)
# server.R ----

 

server <- function(input, output) {
  
penguins_filtered <- penguins |>
      filter(species == input$species) 
  
  output$demo_sp <- renderText({
    paste("Figure 1.", input$species)
  })
  
output$demo_text <- renderText({
  (input$text)
})
   

    
  output$demo_plot <- renderPlot({
    
    ggplot(penguins_filtered, aes(x = flipper_length_mm)) +
      geom_histogram(fill = input$colour, show.legend = FALSE, bins = input$bin) +
      labs(fill = "Color") +
      theme_minimal()
  })
  
  output$demo_table <- DT::renderDataTable({
   penguins_filtered |> 
    summarise(flipper_length_mm = quantile(flipper_length_mm, c(0.25, 0.5, 0.75), na.rm = T), quantile = c(0.25, 0.5, 0.75))
})
  
}



# Run the app ----
shinyApp(ui = ui, server = server)
```



```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(palmerpenguins)    # The source of your data

# Load the data
penguins <- as_tibble(penguins)

 

# ui.R ----
ui <- fluidPage(
  sidebarLayout(
     sidebarPanel(
      demo_sp <- selectInput(inputId = "species",  # Give the input a name "genotype"
                  label = "1. Select species",  # Give the input a label to be displayed in the app
                  choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", "Gentoo" = "Gentoo"), selected = "Adelie"),  # Create the choices that can be selected. e.g. Display "Adelie" and link to value "Adelie"
      demo_select <- selectInput(inputId = "colour", 
                  label = "2. Select histogram colour", 
                  choices = c("blue","green","red","purple","grey"), selected = "grey"),
      demo_slide <- sliderInput(inputId = "bin", 
                  label = "3. Select number of histogram bins", 
                  min=1, max=25, value= c(10)),
      demo_text <- textAreaInput(inputId = "text", 
                label = "4. Enter some text to be displayed",
                rows = 5,
                placeholder = "Enter some information here")
    ),
    mainPanel(
      # Output elements go here
        
    tags$ul(
    tags$strong(textOutput("demo_sp")),
    textOutput("demo_text")),
  
        plotOutput("demo_plot", width = "500px", height="300px"),
        
        DT::dataTableOutput("demo_table",
                    width = "50%",
                    height = "auto")
    )
  )
)
# server.R ----

 

server <- function(input, output) {
  
penguins_filtered <- reactive({
  penguins |>
      filter(species == input$species)
})

  output$demo_sp <- renderText({
    paste("Figure 1.", input$species)
  })
  
output$demo_text <- renderText({
  (input$text)
})
   

    
  output$demo_plot <- renderPlot({
    
    ggplot(penguins_filtered(), aes(x = flipper_length_mm)) +
      geom_histogram(fill = input$colour, show.legend = FALSE, bins = input$bin) +
      labs(fill = "Color") +
      theme_minimal()
  })
  
  output$demo_table <- DT::renderDataTable({
   
    penguins_filtered() |> 
    summarise(flipper_length_mm = quantile(flipper_length_mm, c(0.25, 0.5, 0.75), na.rm = T), quantile = c(0.25, 0.5, 0.75))
})
  
}



# Run the app ----
shinyApp(ui = ui, server = server)
```

My most common error is trying to use data or title as an object instead of as a function. Notice how the first argument to ggplot is no longer data, but data() and you set the value of data with data(newdata), not data <- newdata. For now, just remember this as a quirk of shiny.

## Observable

What if you only want to update things when an update button is clicked, and not whenever the user changes an option?

`observeEvent()`. This function runs the code whenever the value of the first argument changes. If there are reactive values inside the function, they won't trigger the code to run when they change.


```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(palmerpenguins)    # The source of your data

# Load the data
penguins <- as_tibble(penguins)

 

# ui.R ----
ui <- fluidPage(
  sidebarLayout(
     sidebarPanel(
      demo_sp <- selectInput(inputId = "species",  # Give the input a name "genotype"
                  label = "1. Select species",  # Give the input a label to be displayed in the app
                  choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", "Gentoo" = "Gentoo"), selected = "Adelie"),  # Create the choices that can be selected. e.g. Display "Adelie" and link to value "Adelie"
      demo_select <- selectInput(inputId = "colour", 
                  label = "2. Select histogram colour", 
                  choices = c("blue","green","red","purple","grey"), selected = "grey"),
      demo_slide <- sliderInput(inputId = "bin", 
                  label = "3. Select number of histogram bins", 
                  min=1, max=25, value= c(10)),
      demo_text <- textAreaInput(inputId = "text", 
                label = "4. Enter some text to be displayed",
                rows = 5,
                placeholder = "Enter some information here"),
      demo_button <- actionButton("update", "Plot")
    ),
    mainPanel(
      # Output elements go here
        
    tags$ul(
    tags$strong(textOutput("demo_sp")),
    textOutput("demo_text")),
  
        plotOutput("demo_plot", width = "500px", height="300px"),
        
        DT::dataTableOutput("demo_table",
                    width = "50%",
                    height = "auto")
    )
  )
)
# server.R ----

 

server <- function(input, output) {
  
 

  observeEvent(input$update, {
    
    penguins_filtered <- penguins |>
      filter(species == input$species)
    
     bins <- input$bin
     
     colour <- input$colour
 

    output$demo_sp <- renderText({
      paste("Figure 1.", input$species)
    })

    output$demo_text <- renderText({
      (input$text)
    })

    output$demo_plot <- renderPlot({
        ggplot(penguins_filtered, aes(x = flipper_length_mm)) +
        geom_histogram(fill = colour, show.legend = FALSE, bins = bins) +
        labs(fill = "Color") +
        theme_minimal()
    })

    output$demo_table <- DT::renderDataTable({
      penguins_filtered |> 
        summarise(flipper_length_mm = quantile(flipper_length_mm, c(0.25, 0.5, 0.75), na.rm = T), quantile = c(0.25, 0.5, 0.75))
    })
  })
  
}




# Run the app ----
shinyApp(ui = ui, server = server)
```

Which things are now updated by the plot button?


# Customising

## Shiny Dashboard


```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(tidyverse)
library(palmerpenguins)    # The source of your data
library(bslib)

# Load the data
penguins <- as_tibble(penguins)

# Calculate column means for the value boxes
means <- penguins |> 
  group_by(species) |> 
  summarise(mean = round(mean(flipper_length_mm, na.rm = T), 2))

# Turn on thematic for theme-matched plots
thematic::thematic_shiny(font = "auto")
theme_set(theme_bw(base_size = 16))

# ui.R ----
ui <- page_sidebar(
  title = "Penguins flipper dashboard",
  sidebar = sidebar(
      demo_sp <- selectInput(inputId = "species",  # Give the input a name "genotype"
                  label = "1. Select species",  # Give the input a label to be displayed in the app
                  choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", "Gentoo" = "Gentoo"), selected = "Adelie"),  # Create the choices that can be selected. e.g. Display "Adelie" and link to value "Adelie"
      demo_select <- selectInput(inputId = "colour", 
                  label = "2. Select histogram colour", 
                  choices = c("blue","green","red","purple","grey"), selected = "grey"),
      demo_slide <- sliderInput(inputId = "bin", 
                  label = "3. Select number of histogram bins", 
                  min=1, max=25, value= c(10)),
      demo_text <- textAreaInput(inputId = "text", 
                label = "4. Enter some text to be displayed",
                rows = 5,
                placeholder = "Enter some information here"),
      demo_button <- actionButton("update", "Plot")
    )
  ,
   layout_columns(
    fill = FALSE,
    value_box(
      title = "Adelie Flipper Length",
      value = scales::unit_format(unit = "mm")(means[[1,2]]),
      showcase = bsicons::bs_icon("align-bottom"),
      theme_color = "grey"
    ),
    value_box(
      title = "Chinstrap Flipper",
      value = scales::unit_format(unit = "mm")(means[[2,2]]),
      showcase = bsicons::bs_icon("align-center"),
      theme_color = "grey"
    ),
 value_box(
      title = "Gentoo Flipper Length",
      value = scales::unit_format(unit = "mm")(means[[3,2]]),
      showcase = bsicons::bs_icon("align-top"),
      theme_color = "grey"
    )
  ),
    
    tags$ul(
    tags$strong(textOutput("demo_sp")),
    textOutput("demo_text")),
 
      # Output elements go here
      layout_columns(
    card(
      full_screen = TRUE,
      card_header("Plot"),
      plotOutput("demo_plot")
    ),
    card(
      full_screen = TRUE,
      card_header("Table"),
      DT::dataTableOutput("demo_table",
                    width = "100%",
                    height = "auto")
    )  
)
)
  

# server.R ----

 

server <- function(input, output) {
  


  observeEvent(input$update, {
    
    penguins_filtered <- penguins |>
      filter(species == input$species)
    
     bins <- input$bin
     
     colour <- input$colour
 

    output$demo_sp <- renderText({
      paste("Figure 1.", input$species)
    })

    output$demo_text <- renderText({
      (input$text)
    })

    output$demo_plot <- renderPlot({
        ggplot(penguins_filtered, aes(x = flipper_length_mm)) +
        geom_histogram(fill = colour, show.legend = FALSE, bins = bins) +
        labs(fill = "Color") +
        theme_minimal(base_size = 16)
    })

    output$demo_table <- DT::renderDataTable({
      penguins_filtered |> 
        summarise(flipper_length_mm = quantile(flipper_length_mm, c(0.25, 0.5, 0.75), na.rm = T), quantile = c(0.25, 0.5, 0.75))
    })
  })
  
}




# Run the app ----
shinyApp(ui = ui, server = server)
```


### Width

Try changing width to see how it changes


```r
 bs_themer()
# add to server function
```

https://shiny.posit.co/blog/posts/bslib-dashboards/#layout-tooling

https://mastering-shiny.org/action-dynamic.html


https://www.jumpingrivers.com/blog/r-shiny-customising-shinydashboard/#:~:text=The%20main%20way%20of%20including,css%20by%20convention.

# Modules

If you find yourself making nearly identical ` glossary("UI", "UIs")` or server functions over and over in the same app, you might benefit from modules. This is a way to define a pattern to use repeatedly.




## Modularizing the UI

The two tabPanels below follow nearly identical patterns. You can often identify a place where modules might be useful when you use a naming convention like ` dt("{base}_{type}")` for the ` arg("id")`s. 


```r
iris_tab <- tabPanel(
  "iris",
  selectInput("iris_dv", "DV", choices = names(iris)[1:4]),
  plotOutput("iris_plot"),
  DT::dataTableOutput("iris_table")
)

penguins_tab <- tabPanel(
  "penguins",
  selectInput("penguins_dv", "DV", choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")),
  plotOutput("penguins_plot"),
  DT::dataTableOutput("penguins_table")
)
```

The first step in modularising your code is to make a function that creates the UIs above from the base ID and any other changing aspects. In the example above, the choices are different for each ` func("selectInput")`, so we'll make a function that has the arguments ` arg("id")` and ` arg("choices")`.

The first line of a UI module function is always `ns <- NS(id)`, which creates a shorthand way to add the base id to the id type. So instead of the ` func("selectInput")`'s name being ` dt("iris_dv")` or ` dt("mtcars_dv")`, we set it as ` func("ns", "dv")`. All ids need to use ` func("ns")` to add the namespace to their ID.


```r
tabPanelUI <- function(id, choices) {
    ns <- NS(id)
    
    tabPanel(
        id,
        selectInput(ns("dv"), "DV", choices = choices),
        plotOutput(ns("plot")),
        DT::dataTableOutput(ns("table"))
    )
}
```

Now, you can replace two tabPanel definitions with just the following code.


```r
iris_tab <- tabPanelUI("iris", names(iris)[1:4])
penguins_tab <- tabPanelUI("penguins", c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g"))
```


## Modularizing server functions

In our original code, we have four functions that create the two output tables and two output plots, but these are also largely redundant.


```r
output$iris_table <- DT::renderDataTable({
    iris
})

output$iris_plot <- renderPlot({
    ggplot(iris, aes(x = Species, 
                     y = .data[[input$iris_dv]],
                     fill = Species)) +
        geom_violin(alpha = 0.5, show.legend = FALSE) +
        scale_fill_viridis_d()
})

output$penguins_table <- DT::renderDataTable({
    penguins
})

output$penguins_plot <- renderPlot({
   
   
    ggplot(penguins, aes(x = species, 
                     y = .data[[input$penguins_dv]],
                     fill = species)) +
        geom_violin(alpha = 0.5, show.legend = FALSE) +
        scale_fill_viridis_d()
})
```


The second step to modularising code is creating a server function. You can put all the functions the relate to the inputs and outputs in the UI function here, so we will include one to make the output table and one to make the output plot.

The server function takes the base id as the first argument, and then any arguments you need to specify things that change between base implementations. Above, the tables show different data and the plots use different groupings for the x axis and fill, so we'll add arguments for ` arg("data")` and ` arg("group_by")`.

A server function **always** contains `moduleServer()` set up like below.


```r
tabPanelServer <- function(id, data, group_by) {
    moduleServer(id, function(input, output, session) {
      # code ...
    })
}
```

No you can copy in one set of server functions above, remove the base name (e.g., "iris_" or "mtcars_") from and inputs or outputs, and replace specific instances of the data or grouping columns with `data` and `group_by`.


```r
tabPanelServer <- function(id, data, group_by) {
    moduleServer(id, function(input, output, session) {
        output$table <- DT::renderDataTable({
            data
        })
        
        output$plot <- renderPlot({
            # handle non-string groupings
            data[[group_by]] <- factor(data[[group_by]])
            ggplot(data, aes(x = .data[[group_by]], 
                             y = .data[[input$dv]],
                             fill = .data[[group_by]])) +
                geom_violin(alpha = 0.5, show.legend = FALSE) +
                scale_fill_viridis_d()
        })
    })
}
```

<div class="warning">
<p>In the original code, the grouping variables were unquoted, but it’s
tricky to pass unquoted variable names to custom functions, and we
already know how to refer to columns by a character object using
<code>.data[[char_obj]]</code>.</p>
<p>The grouping column <code>Species</code> in <code>iris</code> is
already a factor, but recasting it as a factor won’t hurt, and is
required for the <code>mtcars</code> grouping column
<code>vs</code>.</p>
</div>

Now, you can replace the four functions inside the server function with these two lines of code.


```r
tabPanelServer("iris", data = iris, group_by = "Species")
tabPanelServer("penguins", data = penguins, group_by = "species")
```

Our example only reduced our code by 4 lines, but it can save a lot of time, effort, and debugging on projects with many similar modules. For example, if you want to change the plots in your app to use a different geom, now you only have to change one function instead of two.

## Further Resources {#resources-modules}

* [Mastering Shiny: Modules](https://mastering-shiny.org/scaling-modules.html){target="_blank"}
* [Modularizing Shiny app code](https://shiny.rstudio.com/articles/modules.html){target="_blank"}
* [How to use Shiny Modules](https://www.rstudio.com/resources/shiny-dev-con/modules/){target="_blank"} (video)

## Exercises {#exercises-modules}

### Repeat Example {-}

Try to implement the code above on your own.

* Clone "no_modules_demo" `shinyintro::clone("no_modules_demo")`
* Run the app and see how it works
* Create the UI module function and use it to replace `iris_tab` and `mtcars_tab`
* Create the server function and use it to replace the server functions

### New Instance {-}

Add a new tab called "diamonds" that visualises the `diamonds` dataset. Choose the columns you want as choices in the ` func("selectInput")` and the grouping column.


<div class='webex-solution'><button>UI Solution</button>


You can choose any of the numeric columns for the choices.


```r
diamonds_tab <- tabPanelUI("diamonds", c("carat", "depth", "table", "price"))
```

</div>



<div class='webex-solution'><button>Server Solution</button>


You can group by any of the categorical columns: cut, color, or clarity.


```r
tabPanelServer("diamonds", data = diamonds, group_by = "cut")
```

</div>


### Altering modules {-}

* Add another ` func("selectInput")` to the UI that allows the user to select the grouping variable. (`iris` only has one possibility, but `mtcars` and `diamonds` should have several)


<div class='webex-solution'><button>UI Solution</button>


You need to add a new ` func("selectInput")` to the ` func("tabPanel")`. Remember to use ` func("ns")` for the id. The choices for this select will also differ by data set, so you need to add ` arg("group_choices")` to the arguments of this function.


```r
tabPanelUI <- function(id, choices, group_choices) {
    ns <- NS(id)
    
    tabPanel(
        id,
        selectInput(ns("dv"), "DV", choices = choices),
        selectInput(ns("group_by"), "Group By", choices = group_choices),
        plotOutput(ns("plot")),
        DT::dataTableOutput(ns("table"))
    )
}
```

</div>


* Update the plot function to use the value of this new input instead of "Species", "vs", and whatever you chose for `diamonds`.


<div class='webex-solution'><button>Server Solution</button>


You no longer need `group_by` in the arguments for this function because you are getting that info from an input.

Instead of changing ` arg("group_by")` to `input$group_by` in three places in the code below, I just added the line `group_by <- input$group_by` at the top of ` func("moduleServer")`.


```r
tabPanelServer <- function(id, data) {
    moduleServer(id, function(input, output, session) {
        group_by <- input$group_by
      
        # rest of the code is the same ...
    })
}
```

</div>


### New module {-}

There is a ` func("fluidRow")` before the ` func("tabsetPanel")` in the ui that contains three ` func("infoBoxOutput")` and three ` func("renderInfoBoxOutput")` functions in the server function.

Modularise the info boxes and their associated server functions. 


<div class='webex-solution'><button>UI Function</button>



```r
infoBoxUI <- function(id, width = 4) {
    ns <- NS(id)

    infoBoxOutput(ns("box"), width)
}
```

</div>



<div class='webex-solution'><button>Server Function</button>



```r
infoBoxServer <- function(id, title, fmt, icon, color = "purple") {
    moduleServer(id, function(input, output, session) {
        output$box <- renderInfoBox({
            infoBox(title = title,
                    value = format(Sys.Date(), fmt),
                    icon = icon(icon),
                    color = color)
        })
    })
}
```

</div>



<div class='webex-solution'><button>UI Code</button>


In the `ui`, replace the ` func("fluidRow")` with this:


```r
fluidRow(
    infoBoxUI("day"),
    infoBoxUI("month"),
    infoBoxUI("year")
)
```

</div>




<div class='webex-solution'><button>Server Code</button>


In ` func("server")`, replace the three ` func("renderInfoBox")` with this:


```r
infoBoxServer("year", "Year", "%Y", "calendar")
infoBoxServer("month", "Month", "%m", "calendar-alt")
infoBoxServer("day", "Day", "%d", "calendar-day")
```

</div>


## Your app {#your-app-modules}

What you could modularise in your custom app?
# Download? 

# Sharing
