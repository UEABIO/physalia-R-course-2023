
# Session : Shiny




https://ourcodingclub.github.io/tutorials/shiny/

https://psyteachr.github.io/shiny-tutorials/

https://debruine.github.io/shinyintro/first-app.html

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


## Make our own App

Now that you've seen a basic Shiny app in actin, let's return to the beginning and  create our own app.R file. A basic app.R consists of five key parts:

**Package Loading:** At the top of the script, load any necessary R packages for your app to function. `shiny` is a requirement, but you can add others like `dplyr` or `ggplot2` as needed. If any packages are missing, you'll encounter an error, so ensure that you have them installed.


```r
# Load the required packages
library(shiny)       # Essential for running any Shiny app
library(tidyverse)  # Contains readr, dplyr and ggplot2
library(agridat)    # The source of your data
```

**Data Loading:** Next, load any data necessary for your app. This typically involves reading datasets into R objects. Ensure that you have the data file or source available in the specified format.


```r
# Load the data
Barley <- as_tibble(beaven.barley)
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

To create your own Shiny app, you should remove any example code generated automatically when you created app.R and replace it with the structure provided above. Your final app.R script should resemble the following:




<button id="displayTextunnamed-chunk-8" onclick="javascript:toggle('unnamed-chunk-8');">Show Solution</button>

<div id="toggleTextunnamed-chunk-8" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
# Packages ----
library(shiny)       # Essential for running any Shiny app
library(ggplot2)     # Useful for creating visually appealing plots
library(dplyr)       # Handy for data filtering and manipulation
library(agridat)    # The source of your data

# Loading data ----
Barley <- as.data.frame(beaven.barley)

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
