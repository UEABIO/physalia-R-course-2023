# (PART\*) Data Presentation {.unnumbered}

# Data visualisation with ggplot2






## Intro to grammar


The ggplot2 package is widely used and valued for its simple, consistent approach to making data visuals.

The 'grammar of graphics' relates to the different components of a plot that function like different parts of linguistic grammar. For example, all plots require axes, so the x and y axes form one part of the ‘language’ of a plot. Similarly, all plots have data represented between the axes, often as points, lines or bars. The visual way that the data is represented forms another component of the grammar of graphics. Furthermore, the colour, shape or size of points and lines can be used to encode additional information in the plot. This information is usually clarified in a key, or legend, which can also be considered part of this ‘grammar’.

The philosophy of ggplot is much better explained by the package author, Hadley Wickham (@R-ggplot2). For now, we just need to be aware that ggplots are constructed by specifying the different components that we want to display, based on underlying information in a data frame.

<div class="figure" style="text-align: center">
<img src="images/ambitious.png" alt="An example of what we can produce in ggplot" width="100%" />
<p class="caption">(\#fig:ambitious-figure)An example of what we can produce in ggplot</p>
</div>

#### Before we start

You should have a workspace ready to work with the Palmer penguins data. Load this workspace now. 

Think about some basic checks before you start your work today.

#### Checklist


<div class="try">
<p>Today we are going to make a NEW R script in the same project space
as we have previously been working. This is part of organising our
workspace so that our analysis workflow is <a
href="#activity-1-organising-our-workspace">well documented and easy to
follow</a></p>
</div>

* Open a **new** R script - we are moving on from data wrangling to data visualisation

* Save this file **in the scripts folder** and call it `02_visualisation_penguins.R`

* Add the following to your script and run it:


```r
# LOAD R OBJECTS AND FUNCTIONS ----
source("scripts/01_import_penguins_data.R")
# import tidied penguins data and functions
#__________________________----
```

* You should find your Environment fills up with objects from script 1


<div class="info">
<p>The <code>source()</code> function is a very handy way of allowing
you to have different scripts for different parts of your R project, but
allow access to objects built elsewhere. In this way we are building our
analysis in stages.</p>
</div>

<div class="warning">
<p>The above command will ONLY work if you remembered to save and name
your script exactly as above AND put that script inside a subfolder
called scripts.</p>
<p>Does your project look like the one below?</p>
</div>


<div class="figure" style="text-align: center">
<img src="images/project_penguin.png" alt="My neat project layout" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-7)My neat project layout</p>
</div>

<div class="figure" style="text-align: center">
<img src="images/r_script.png" alt="If you have sucessfully saved 02_visualisation_penguins.R it should be visible here too " width="100%" />
<p class="caption">(\#fig:unnamed-chunk-8)If you have sucessfully saved 02_visualisation_penguins.R it should be visible here too </p>
</div>

#### What if source isn't working?

If source isn't working, or you can't figure out your project set-up you can complete this worksheet if you put the following commands at the top of your script *instead* of `source("scripts/01_import_penguins_data.R")`


<div class='webex-solution'><button>Script adjustment</button>



```r
#___________________________----
# SET UP ----
## An analysis of the bill dimensions of male and female Adelie, Gentoo and Chinstrap penguins ----

### Data first published in  Gorman, KB, TD Williams, and WR Fraser. 2014. “Ecological Sexual Dimorphism and Environmental Variability Within a Community of Antarctic Penguins (Genus Pygoscelis).” PLos One 9 (3): e90081. https://doi.org/10.1371/journal.pone.0090081. ----
#__________________________----

# PACKAGES ----
library(tidyverse) # tidy data packages
library(janitor) # cleans variable names
library(lubridate) # make sure dates are processed properly
#__________________________----

# IMPORT DATA ----
penguins <- read_csv ("data/penguins_raw.csv")

penguins <- janitor::clean_names(penguins) # clean variable names
#__________________________----
```


</div>


## Building a plot

To start building the plot We are going to use the penguin data we have been working with previously. First we must specify the data frame that contains the relevant data for our plot. We can do this in two ways: 

1) Here we are ‘sending the penguins data set into the ggplot function’:


```r
# Building a ggplot step by step ----
## Render a plot background ----
penguins  |>  
  ggplot()
```

2) Here we are specifying the dataframe *within* the `ggplot()` function

The output is identical


```r
ggplot(data = penguins)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-11-1.png" width="100%" style="display: block; margin: auto;" />

<div class="info">
<p>Running this command will produce an empty grey panel. This is
because we need to specify how different columns of the data frame
should be represented in the plot.</p>
</div>

### Aesthetics - `aes()`

We can call in different columns of data from any dataset based on their column names. Column names are given as ‘aesthetic’ elements to the ggplot function, and are wrapped in the aes() function.

Because we want a scatter plot, each point will have an x and a y coordinate. We want the x axis to represent flipper length ( x = flipper_length_mm ), and the y axis to represent the body mass ( y = body_mass_g ).

We give these specifications separated by a comma. Quotes are not required when giving variables within `aes()`.

<div class="info">
<p>Those interested in why quotes aren’t required can read about <a
href="https://edwinth.github.io/blog/nse/">non-standard
evaluation</a>.</p>
</div>



```r
## Set axes ----
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g))
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-14-1.png" width="100%" style="display: block; margin: auto;" />

So far we have the grid lines for our x and y axis. `ggplot()` knows the variables required for the plot, and thus the scale, but has no information about how to display the data points.

## Geometric representations - geom()

Given we want a scatter plot, we need to specify that the geometric representation of the data will be in point form, using geom_point(). [There are many geometric object types](https://ggplot2.tidyverse.org/reference/#geoms).

<div class="figure" style="text-align: center">
<img src="images/geoms.png" alt="geom shapes" width="100%" />
<p class="caption">(\#fig:img-objects-enviro)geom shapes</p>
</div>

Here we are adding a layer (hence the + sign) of points to the plot. We can think of this as similar to e.g. Adobe Photoshop which uses layers of images that can be reordered and modified individually. Because we add to plots layer by layer **the order** of your geoms may be important for your final aesthetic design. 

For ggplot, each layer will be added over the plot according to its position in the code. Below I first show the full breakdown of the components in a layer. Each layer requires information on

* data
* aesthetics
* geometric type
* any summary of the data
* position


```r
## Add a geom ----
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g))+
  layer(                # layer inherits data and aesthetic arguments from previous
    geom="point",       # draw point objects
    stat="identity",    # each individual data point gets a geom (no summaries)
    position=position_identity()) # data points are not moved in any way e.g. we could specify jitter or dodge if we want to avoid busy overlapping data
```

This is quite a complicate way to write new layers - and it is more usual to see a simpler more compact approach


```r
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g))+
  geom_point() # geom_point function will always draw points, and unless specified otherwise the arguments for position and stat are both "identity".
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-16-1.png" width="100%" style="display: block; margin: auto;" />

Now we have the scatter plot! Each row (except for two rows of missing data) in the penguins data set now has an x coordinate, a y coordinate, and a designated geometric representation (point).

From this we can see that smaller penguins tend to have smaller flipper lengths.

### |> and +

ggplot2, an early component of the tidyverse package, was written before the pipe was introduced. The + sign in ggplot2 functions in a similar way to the pipe in other functions in the tidyverse: by allowing code to be written from left to right.

### Colour

The colors of lines and points can be set directly using `colour="red"`, replacing “red” with a color name. The colors of filled objects, like bars, can be set using `fill="red"`.


```r
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g))+
  geom_point(colour="red")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-17-1.png" width="100%" style="display: block; margin: auto;" />

However the current plot could be more informative if colour was used to convey information about the species of each penguin.

In order to achieve this we need to use `aes()` again, and make the colour conditional upon a variable.

Here, the `aes()` function containing the relevant column name, is given within the `geom_point()` function.

<div class="warning">
<p>A common mistake is to get confused about when to use (or not use)
<code>aes()</code></p>
<p>If specifying a fixed aesthetic e.g. red for everything it DOES NOT
go inside <code>aes()</code> instead specify e.g. colour = “red” or
shape =21.</p>
<p>If you wish to modify an aethetic according to a variable in your
data THEN it DOES go inside <code>aes()</code>
e.g. <code>aes(colour = species)</code></p>
</div>



```r
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g))+
  geom_point(aes(colour=species))
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-19-1.png" width="100%" style="display: block; margin: auto;" />

<div class="info">
<p>You may (or may not) have noticed that the grammar of ggplot (and
tidyverse in general) accepts British/Americanization for
spelling!!!</p>
</div>

With data visualisations we can start to gain insights into our data very quickly, we can see that the Gentoo penguins tend to be both larger and have longer flippers

<div class="info">
<p>Add carriage returns (new lines) after each |&gt; or + symbols.</p>
<p>In most cases, R is blind to white space and new lines, so this is
simply to make our code more readable, and allow us to add readable
comments.</p>
</div>

### More layers

We can see the relationship between body size and flipper length. But what if we want to model this relationship with a trend line? We can add another ‘layer’ to this plot, using a different geometric representation of the data. In this case a trend line, which is in fact a summary of the data rather than a representation of each point.

The `geom_smooth()` function draws a trend line through the data. The default behaviour is to draw a local regression line (curve) through the points, however these can be hard to interpret. We want to add a straight line based on a linear model (‘lm’) of the relationship between x and y. 

This is our **first** encounter with linear models in this course, but we will learn a lot more about them later on. 


```r
## Add a second geom ----
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g))+
  geom_point(aes(colour=species))+
  geom_smooth(method="lm",    #add another layer of data representation.
              se=FALSE,
              aes(colour=species)) # note layers inherit information from the top ggplot() function but not previous layers - if we want separate lines per species we need to either specify this again *or* move the color aesthetic to the top layer. 
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-22-1.png" width="100%" style="display: block; margin: auto;" />

In the example above we may notice that we are assigning colour to the same variable (species) in both geometric layers. This means we have the option to simplify our code. Aesthetics set in the "top layer" of `ggplot()` are inherited by all subsequent layers.


```r
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g,
             colour=species))+ ### now colour is set here it will be inherited by ALL layers
  geom_point()+
  geom_smooth(method="lm",    #add another layer of data representation.
              se=FALSE)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-23-1.png" width="100%" style="display: block; margin: auto;" />


<div class="try">
<p>Note - that the trend line is blocking out certain points, because it
is the ‘top layer’ of the plot. The geom layers that appear early in the
command are drawn first, and can be obscured by the geom layers that
come after them.</p>
<p>What happens if you switch the order of the geom_point() and
geom_smooth() functions above? What do you notice about the trend
line?</p>
</div>


### Co-ordinate space

ggplot will automatically pick the scale for each axis, and the type of coordinate space. Most plots are in Cartesian (linear X vs linear Y) coordinate space.

For this plot, let’s say we want the x and y origin to be set at 0. To do this we can add in `xlim()` and `ylim()` functions, which define the limits of the axes:


```r
## Set axis limits ----
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g,
             colour=species))+ 
  geom_point()+
  geom_smooth(method="lm",    
              se=FALSE)+
  xlim(0,240) + ylim(0,7000)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-25-1.png" width="100%" style="display: block; margin: auto;" />

Further, we can control the coordinate space using `coord()` functions. Say we want to flip the x and y axes, we add `coord_flip()`:


```r
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g,
             colour=species))+ 
  geom_point()+
  geom_smooth(method="lm",    
              se=FALSE)+
  xlim(0,240) + ylim(0,7000)+
  coord_flip()
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-26-1.png" width="100%" style="display: block; margin: auto;" />

## Labels

By default, the axis labels will be the column names we gave as aesthetics aes(). We can change the axis labels using the xlab() and ylab() functions. Given that column names are often short and can be cryptic, this functionality is particularly important for effectively communicating results.


```r
## Custom labels ----
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g,
             colour=species))+ 
  geom_point()+
  geom_smooth(method="lm",    
              se=FALSE)+
  labs(x = "Flipper length (mm)",
       y = "Body mass (g)")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-27-1.png" width="100%" style="display: block; margin: auto;" />

#### Titles and subtitles


```r
## Add titles ----
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g,
             colour=species))+ 
  geom_point()+
  geom_smooth(method="lm",    
              se=FALSE)+
  labs(x = "Flipper length (mm)",
       y = "Body mass (g)",
       title= "Penguin Size, Palmer Station LTER",
       subtitle= "Flipper length and body mass for three penguin species")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-28-1.png" width="100%" style="display: block; margin: auto;" />

## Themes

Finally, the overall appearance of the plot can be modified using theme() functions. The default theme has a grey background.
You may prefer `theme_classic()`, a `theme_minimal()` or even `theme_void()`. Try them out.


```r
## Custom themes ----
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g,
             colour=species))+ 
  geom_point()+
  geom_smooth(method="lm",    
              se=FALSE)+
  labs(x = "Flipper length (mm)",
       y = "Body mass (g)",
       title= "Penguin Size, Palmer Station LTER",
       subtitle= "Flipper length and body mass for three penguin species")+
  theme_void()
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-29-1.png" width="100%" style="display: block; margin: auto;" />

<div class="info">
<p>There is a lot more customisation available through the theme()
function. We will look at making our own custom themes in later
lessons</p>
<p>You can also try installing and running an even wider range of
pre-built themes if you install the R package <a
href="https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/">ggthemes</a>.</p>
<p>First you will need to run the
<code>install.packages("ggthemes")</code> command. Remember this is one
of the few times a command should NOT be written in your script but
typed directly into the console. That’s because it’s rude to send
someone a script that will install packages on their computer - think of
<code>library()</code> as a polite request instead!</p>
<p>To access the range of themes available type
<code>help(ggthemes)</code> then follow the documentation to find out
what you can do.</p>
</div>

## More geom shapes

### Jitter

The `geom_jitter()` command adds some random scatter to the points which can reduce over-plotting. Compare these two plots:

<img src="05-ggplot_files/figure-html/unnamed-chunk-31-1.png" width="100%" style="display: block; margin: auto;" />


```r
## geom point

ggplot(data = penguins, aes(x = species, y = culmen_length_mm)) +
  geom_point(aes(color = species),
              alpha = 0.7, 
              show.legend = FALSE) 

## More geoms ----
ggplot(data = penguins, aes(x = species, y = culmen_length_mm)) +
  geom_jitter(aes(color = species),
              width = 0.1, # specifies the width, change this to change the range of scatter
              alpha = 0.7, # specifies the amount of transparency in the points
              show.legend = FALSE) # don't leave a legend in a plot, if it doesn't add value
```

### Boxplots

Box plots, or ‘box & whisker plots’ are another essential tool for data analysis. Box plots summarize the distribution of a set of values by displaying the minimum and maximum values, the median (i.e. middle-ranked value), and the range of the middle 50% of values (inter-quartile range).
The whisker line extending above and below the IQR box define Q3 + (1.5 x IQR), and Q1 - (1.5 x IQR) respectively. You can watch a short video to learn more about box plots [here](https://www.youtube.com/watch?v=fHLhBnmwUM0).

<img src="images/boxplot.png" width="80%" style="display: block; margin: auto;" />

To create a box plot from our data we use (no prizes here) `geom_boxplot()`


```r
ggplot(data = penguins, aes(x = species, y = culmen_length_mm)) +
  geom_boxplot(aes(fill = species),
              alpha = 0.7, 
              width = 0.5, # change width of boxplot
              show.legend = FALSE)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-34-1.png" width="100%" style="display: block; margin: auto;" />

<div class="try">
<p>Note that when specifying colour variables using <code>aes()</code>
some geometric shapes support an internal colour “fill” and an external
colour “colour”. Try changing the aes fill for colour in the code above,
and note what happens.</p>
</div>

The points indicate outlier values [i.e., those greater than Q3 + (1.5 x IQR)].

We can overlay a boxplot on the scatter plot for the entire dataset, to fully communicate both the raw and summary data. Here we reduce the width of the jitter points slightly.



```r
ggplot(data = penguins, aes(x = species, y = culmen_length_mm)) +
  geom_boxplot(aes(fill = species), # note fill is "inside" colour and colour is "edges" - try it for yourself
              alpha = 0.2, # fainter boxes so the points "pop"
              width = 0.5, # change width of boxplot
              outlier.shape=NA)+
  geom_jitter(aes(colour = species),
                width=0.2)+
  theme(legend.position = "none")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-36-1.png" width="100%" style="display: block; margin: auto;" />


<div class="warning">
<p>In the above example I switched from using show.legend=FALSE inside
the geom layer to using theme(legend.position=“none”). Why? This is an
example of reducing redundant code. I would have to specify
show.legend=FALSE for every geom layer in my plot, but the theme
function applies to every layer. Save code, save time, reduce
errors!</p>
</div>


### Density and histogram

Compare the following two sets of code:


```r
penguins |> 
    ggplot(aes(x=culmen_length_mm, fill=species),
           position = "identity")+
    geom_histogram(bins=50)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-38-1.png" width="100%" style="display: block; margin: auto;" />

At first you might struggle to see/understand the difference between these two charts. The shapes should be roughly the same. 


```r
penguins |> 
    ggplot(aes(x=culmen_length_mm, fill=species))+
    geom_histogram(bins=50, 
                   aes(y=..density..),
                   position = "identity")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-39-1.png" width="100%" style="display: block; margin: auto;" />


<div class='webex-solution'><button>Explain this</button>


The first block of code produced a frequency histogram, each bar represents the actual number of observations made within each 'bin', the second block of code shows the 'relative density' within each bin. In a density histogram the area under the curve for each sub-group will sum to 1. This allows us to compare distributions and shapes between sub-groups of different sizes. For example there are far fewer Adelie penguins in our dataset, but in a density histogram they occupy the same area of the graph as the other two species.


</div>


<br>

## More Colours

There are two main differences when it comes to colors in `ggplot2`. Both arguments, color and fill, can be specified as single color or
assigned to variables.

As you have already seen in this tutorial, variables that are inside the aesthetics are encoded by variables and those that are outside are properties that are unrelated to the variables.


```r
penguins |> 
    ggplot(aes(x=culmen_length_mm))+
    geom_histogram(bins=50, 
                   aes(y=..density..,
                       fill=species), 
                   position = "identity",
                   colour="black")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-41-1.png" width="100%" style="display: block; margin: auto;" />

#### Choosing and using colour palettes

You can specify what colours you want to assign to variables in a number of different ways. 

In ggplot2, colors that are assigned to variables are modified via the scale_color_* and the scale_fill_* functions. In order to use color with your data, most importantly you need to know if you are dealing with a categorical or continuous variable. The color palette should be chosen depending on type of the variable:

* **sequential or diverging** color palettes being used for continuous variables 

* **qualitative** color palettes for (unordered) categorical variables:

<img src="images/palette.png" width="80%" style="display: block; margin: auto;" />

You can pick your own sets of colours and assign them to a categorical variable. The number of specified colours **has** to match the number of categories. You can use a wide number of preset colour [names](https://www.datanovia.com/en/blog/awesome-list-of-657-r-color-names/) or you can use [hexadecimals](https://www.datanovia.com/en/blog/awesome-list-of-hexadecimal-colors-you-should-have/). 



```r
## Custom colours ----

penguin_colours <- c("darkolivegreen4", "darkorchid3", "goldenrod1")

penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g))+
  geom_point(aes(colour=species))+
  scale_color_manual(values=penguin_colours)+
  theme_minimal()
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-43-1.png" width="100%" style="display: block; margin: auto;" />

You can also use a range of inbuilt colour palettes: 


```r
penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g))+
  geom_point(aes(colour=species))+
  scale_color_brewer(palette="Set1")+
  theme_minimal()
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-44-1.png" width="100%" style="display: block; margin: auto;" />


<div class="info">
<p>You can explore all schemes available with the command
<code>RColorBrewer::display.brewer.all()</code></p>
</div>

There are also many, many extensions that provide additional colour palettes. Some of my favourite packages include [ggsci](https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html) and [wesanderson](https://github.com/karthik/wesanderson)

<img src="images/wesanderson.png" width="80%" style="display: block; margin: auto;" />

## Accessibility

#### Colour blindness

It's very easy to get carried away with colour palettes, but you should remember at all times that your figures must be accessible. One way to check how accessible your figures are is to use a colour blindness checker [colorBlindness](https://cran.r-project.org/web/packages/colorBlindness/vignettes/colorBlindness.html)


```r
## Check accessibility ----

library(colorBlindness)
colorBlindness::cvdPlot() # will automatically run on the last plot you made
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-47-1.png" width="100%" style="display: block; margin: auto;" />


#### Guides to visual accessibility 

Using colours to tell categories apart can be useful, but as we can see in the example above, you should choose carefully. Other aesthetics which you can access in your geoms include `shape`, and `size` - you can combine these in complimentary ways to enhance the accessibility of your plots. Here is a hierarchy of "interpretability" for different types of data 

<img src="images/list.png" width="80%" style="display: block; margin: auto;" />


<img src="images/shape_v_colour.png" width="80%" style="display: block; margin: auto;" />

## Multiple plots

#### Facets

Adding combinations of different aesthetics allows you to layer more information onto a 2D plot, sometimes though things will just become *too* busy. At the point where it becomes difficult to see the trends or differences in your plot then we want to break up a single plot into sub-plots; this is called ‘faceting’. Facets are commonly used when there is too much data to display clearly in a single plot. We will revisit faceting below, however for now, let’s try to facet the plot according to sex.

To do this we use the tilde symbol ‘~’ to indicate the column name that will form each facet.


```r
## Facetting ----
penguins |> 
  drop_na(sex) |> 
  ggplot(aes(x=flipper_length_mm, 
             y = body_mass_g,
             colour=species))+ 
  geom_point()+
  geom_smooth(method="lm",    
              se=FALSE)+
  facet_wrap(~sex)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-50-1.png" width="100%" style="display: block; margin: auto;" />

#### Patchwork

There are many times you might want to *combine* separate figures into multi-panel plots. Probably the easiest way to do this is with the `patchwork` package (@R-patchwork). 


```r
## Patchwork ----
library(patchwork)

p1 <- penguins |> 
  ggplot(aes(x=flipper_length_mm, 
             y = culmen_length_mm))+
  geom_point(aes(colour=species))+
  scale_color_manual(values=penguin_colours)+
  theme_minimal()

p2 <- penguins |> 
  ggplot(aes(x=culmen_depth_mm, 
             y = culmen_length_mm))+
  geom_point(aes(colour=species))+
  scale_color_manual(values=penguin_colours)+
  theme_minimal()

p3 <- penguins |>     
  group_by(sex,species) |> 
    summarise(n=n()) |> 
     drop_na(sex) |> 
     ggplot(aes(x=species, y=n)) + 
  geom_col(aes(fill=sex), 
               width=0.8,
               position=position_dodge(width=0.9), 
               alpha=0.6)+
     scale_fill_manual(values=c("darkorange1", "azure4"))+
     theme_classic()

 (p1+p2)/p3+
  plot_layout(guides = "collect") 
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-51-1.png" width="100%" style="display: block; margin: auto;" />

## Activity: Replicate this figure

<div class="try">
<p>How close can you get to replicating the figure below?</p>
<p>Make a NEW script for this assignment - replicate_figure.R</p>
<p>Make sure to use the tips and links at the end of this chapter, when
you are done save the file</p>
</div>

<img src="05-ggplot_files/figure-html/unnamed-chunk-53-1.png" width="100%" style="display: block; margin: auto;" />



<div class='webex-solution'><button>Solution</button>



```r
pal <- c("#FF8C00", "#A034F0", "#159090")

penguins |> 
  ggplot(aes(x = species,
             y = body_mass_g,
             fill = species,
             colour = species))+
  geom_violin(alpha = 0.2)+
  geom_boxplot(width = 0.2,
               alpha = 0.6)+
  scale_fill_manual(values = pal)+
  scale_colour_manual(values = pal)+
  theme_classic()+
  theme(legend.position = "none")+
    labs(
    x = "",
    y = "Body mass (g)",
    title = "Body mass of brush-tailed penguins",
    subtitle = "Box and violin plot of body mass by species")
```


</div>



## Saving

One of the easiest ways to save a figure you have made is with the `ggsave()` function. By default it will save the last plot you made on the screen. 

You should specify the output path to your **figures** folder, then provide a file name. Here I have decided to call my plot *plot* (imaginative!) and I want to save it as a .PNG image file. I can also specify the resolution (dpi 300 is good enough for most computer screens).


```r
# OUTPUT FIGURE TO FILE

ggsave("outputs/YYYYMMDD_ggplot_workshop_final_plot.png", dpi=300)
```

<div class="try">
<p>If you got this far and still have time why not try one of the
following:</p>
<ol style="list-style-type: decimal">
<li><p>Making another type of figure using the penguins dataset, use the
further reading below to use for inspiration.</p></li>
<li><p>Use any of your own data</p></li>
</ol>
</div>


#### Quitting

<div class="warning">
<p>Make sure you have saved your script! Remember to Download your image
file from RStudio Cloud onto YOUR computer.</p>
</div>


<div class="info">
<p>run <code>SessionInfo()</code> at the end of your script to gather
the packages and versions you have been using. This is very useful for
when you <a href="#how-to-cite-r-and-rstudio">cite R versions and
packages</a> when writing reports later.</p>
</div>

## Finished

* Make sure you have **saved your scripts 💾** in the ["scripts" folder](#activity-1-organising-our-workspace).


#### What we learned

You have learned

* The anatomy of ggplots

* How to add geoms on different layers

* How to use colour, colour palettes, facets, labels and themes

* Putting together multiple figures

* How to save and export images


## Further Reading, Guides and tips on data visualisation

* [R Cheat Sheets](https://www.rstudio.com/resources/cheatsheets/)

* [Fundamentals of Data Visualization](https://clauswilke.com/dataviz/): this book tells you everything you need to know about presenting your figures for accessbility and clarity

* [Beautiful Plotting in R](https://www.cedricscherer.com/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/): an incredibly handy ggplot guide for how to build and improve your figures

* [The ggplot2 book](https://ggplot2-book.org/): the original Hadley Wickham book on ggplot2


# Extensions for ggplot2

https://exts.ggplot2.tidyverse.org/

- gghighlight
- ggforce

- functions on ggplot



## ggdist

### Rainclouds


```r
library(ggdist)

penguins |> 
    ggplot(aes(x = species,
               y = culmen_length_mm,
              fill = species)) +
  ggdist::stat_halfeye(
    point_colour = NA,
    .width = 0,
    # shift raincloud up
    justification = -.2)+
  geom_boxplot(# remove outlier dots
    outlier.shape = NA,
    # shrink width of box
    alpha = .4,
    # fade box
               width = .1)+
  ggdist::stat_dots(aes(colour = species),
                  # put dots underneath
                    side = "left",
                  # move position down
                    justification = 1.1,
                  # size of dots 
                    dotsize = .2,
                    
                  # adjust bins (grouping) of dots
                    binwidth = .4)+
  scale_fill_manual(values = pal) +
  scale_colour_manual(values = pal)+
  guides(fill = "none")+
  coord_flip() # rotate figure
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-59-1.png" width="100%" style="display: block; margin: auto;" />


### Interval stats


```r
penguins |> 
  drop_na(sex) |> 
    ggplot(aes(x = species,
               y = culmen_length_mm))+
  ggdist::stat_interval(.width = c(.5, .66, .95))+
  ggdist::stat_halfeye(aes(fill = sex),
                       .width = 0,
                       shape = 21,
                       colour = "white",
                       slab_alpha = .4,
                       size = .5,
                       position = position_nudge(x = .05))+
  scale_color_viridis_d(option = "mako", direction = -1, end = .9)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-60-1.png" width="100%" style="display: block; margin: auto;" />
## Density


```r
library(ggdensity)

penguins |>  
    ggplot(aes(x = culmen_length_mm, 
               y = culmen_depth_mm,
               colour = species)) +
  geom_point(alpha = .2) +
  ggdensity::geom_hdr_lines()+
   scale_colour_manual(values = pal)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-61-1.png" width="100%" style="display: block; margin: auto;" />

## ggridges


```r
library(ggridges)

penguins |>  
    ggplot(aes(x = culmen_length_mm, 
               y = species,
               fill = species)) +
  geom_density_ridges() + # use hjust and vjust to position text
  scale_fill_manual(values = pal) +
  scale_colour_manual(values = pal)+
  theme(legend.position = "none")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-62-1.png" width="100%" style="display: block; margin: auto;" />

## Dumbell charts


```r
library(ggalt)

summary_counts <- penguins |> 
  group_by(sex, species) |> 
  summarise(mean = mean(body_mass_g, na.rm = T)) |> 
  pivot_wider(names_from = sex, values_from = mean)

ggplot(summary_counts, 
       aes(y=species, x=FEMALE, xend=MALE)) +
  geom_dumbbell(size=3, color="#e3e2e1",
                colour_x = "#5b8124", colour_xend = "#bad744") +
  geom_text( x=summary_counts[[3,2]], y=3, aes(label="Female"),
             color="#9fb059", size=3, vjust=-2, fontface="bold")+
  geom_text(x=summary_counts[[3,3]], y=3, aes(label="Male"),
             color="#bad744", size=3, vjust=-2, fontface="bold")+
  labs(x = "Body mass (g)",
       y = "")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-63-1.png" width="100%" style="display: block; margin: auto;" />

## Text

### textpaths


```r
library(geomtextpath)

penguins |> 
    ggplot(aes(x = culmen_length_mm, 
               colour = species,
               label = species))+
  geom_textdensity( hjust = 0.35, vjust = .1)+ # use hjust and vjust to position text
  theme(legend.position = "none")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-64-1.png" width="100%" style="display: block; margin: auto;" />

### ggtext

https://rfortherestofus.com/2020/05/color-titles-ggtext#:~:text=Adding%20color%20to%20titles%20using,HTML%2C%20not%20as%20raw%20text.


```r
library(ggtext)

penguins |> 
  mutate(species = fct_relevel(species, "Chinstrap", "Gentoo", "Adelie")) |> 
  group_by(species) |> 
    summarise(n=n()) |> 
ggplot(aes(x = species,
           y = n,
           fill = species))+
        geom_col()+
  geom_label(aes(label = n),
            fill = "white",
            nudge_y = 1,
            colour = "black",
            fontface = "bold")+
  labs(x = "",
       y = "Count",
       title = paste(
         'There are almost half the observations on <br> <span style = "color:#A034F0">Chinstrap</span> penguins,  as there are <br> on <span style = "color:#FF8C00">Adelie</span> and <span style ="color:#159090">Gentoo</span>penguins'
       ))+
  scale_fill_manual(
    # when reordering levels - be careful about keeping colours consistent
    values = c("#FF8C00", "#159090", "#A034F0"))+
  coord_flip()+
  scale_y_continuous(limits = c(0, 200))+
  theme(legend.position = "none",
        axis.text.y = element_text(
      color = c("#FF8C00", "#159090", "#A034F0")),
      plot.title = element_markdown())
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-65-1.png" width="80%" style="display: block; margin: auto;" />
## Bump charts


```r
library(ggbump)

penguin_summary <- penguins |> 
  mutate(date_egg = dmy(date_egg)) |> 
  filter(clutch_completion == "Yes") |> 
  mutate(year = year(date_egg)) |> 
  group_by(species, year) |> 
  summarise(n = n())

penguin_summary |>
  ggplot(aes(x = year, 
             y = n,
             colour = species))+
  geom_point(size = 7)+
  geom_bump()+
  geom_text(data = penguin_summary |> filter(year == max(year)),
                                             aes(x = year + 0.1,
                                                 label = species,
                                                  hjust = 0),
            size = 5)+
  scale_x_continuous(limits = c(2007, 2009.5),
                     breaks = (2007:2009))+
  labs(y = "Total number of complete clutches")+
  scale_fill_manual(values = pal) +
  scale_colour_manual(values = pal)+
  theme(legend.position = "none")
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-66-1.png" width="100%" style="display: block; margin: auto;" />


gghiglight

functions! 

maps! 


## Layouts and compositions

Patchwork, text and images!!!!





```r
library(patchwork)
library(png)
library(ggpubr)

penguin_pic <- png::readPNG("images/lter_penguins.png")

penguin_fig <- ggplot() +
  background_image(penguin_pic)
```


```r
text <- tibble(
  x = 0, y = 0, label = 'Simpsons Paradox is a statistical phenomenon where an association between two variables in a population emerges, disappears or reverses when the population is divided into subpopulations such as <span style = "color:#FF8C00">Adelie</span>, <span style ="color:#159090">Gentoo</span>, and <span style = "color:#A034F0">Chinstrap</span> penguin species'
)



pt <- ggplot(text, aes(x = x, y = y)) +
  ggtext::geom_textbox(
    aes(label = label),    # Map the 'label' column from the 'text' data to the text labels
    box.color = NA,         # Make the text box border color transparent
    width = unit(10, "lines"),  # Set the width of the text boxes to 15 lines
    color = "grey40",       # Set the text color to a light gray
    size = 3,             # Set the text size to 4 (adjust as needed)
    lineheight = 1.4        # Set the line height for text within the boxes
  ) +
  # Customize the plot coordinate system
  coord_cartesian(expand = FALSE, clip = "off") +

  # Apply a theme with a blank (void) background
  theme_void()

pt
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-69-1.png" width="100%" style="display: block; margin: auto;" />



```r
layout <- "
AACCC
AACCC
BBDDD
BBDDD
"

p1 <- ggplot(penguins, aes(x= culmen_length_mm, 
                     y= culmen_depth_mm)) +
    geom_point()+
  geom_smooth(method="lm",
              se=FALSE)+
  theme(legend.position="none")+
    labs(x="Bill length (mm)",
         y="Bill depth (mm)")

p2 <- ggplot(penguins, aes(x= culmen_length_mm, 
                     y= culmen_depth_mm,
                     colour=species)) +
    geom_point()+
  geom_smooth(method="lm",
              se=FALSE)+
  scale_colour_manual(values=pal)+
  theme(legend.position="none")+
    labs(x="Bill length (mm)",
         y="Bill depth (mm)")

p1 + p2 + 
  pt +  penguin_fig + 
  plot_layout(design = layout)
```

<img src="05-ggplot_files/figure-html/unnamed-chunk-70-1.png" width="100%" style="display: block; margin: auto;" />

## Activity: Create a Publication-Style Multi-Panel Figure

Objective: Design and create a multi-panel data visualization figure in the style of a research publication. This exercise will challenge your skills in data visualization, data manipulation, and creating complex figures.

Steps:

- Choose a Dataset: Select a dataset that is suitable for creating a multi-panel figure. It could be related to a scientific research topic, public data (e.g., from government sources or data repositories), or any other dataset that interests you.

- Data Preprocessing: Use dplyr and tidyr to preprocess the data. You may need to aggregate, filter, or reshape the data to fit the structure you want for your figure.

- Design the Figure: Decide on the structure of your multi-panel figure. You could create subplots or facets to represent different aspects of the data. For example, you might have multiple box plots, scatter plots, or other visualizations arranged in a grid.

- Create the Plot: Use ggplot2 to create the individual panels or subplots. Customize the appearance of each panel, including labels, colors, and titles.

- Combine the Panels: Use the patchwork package or another method to arrange the individual panels into a single figure. This may involve adjusting the layout, labeling, and legends to make the figure coherent.

- Add Annotations: Add relevant annotations to the figure, such as titles, subtitles, captions, and any necessary notes to explain the data or results.

- Customize the Theme: Apply a custom theme to the entire figure. You can modify fonts, colors, grid lines, and other elements to match the style of a publication.


Tips:

Plan your figure carefully, considering what story or message you want to convey.
Experiment with different geoms, scales, and themes to achieve the desired visual effect.
Use effective data visualization principles, such as avoiding misleading scales, providing clear labels and legends, and ensuring that the figure is accessible to a wide audience.


# Custom ggplot themes

Custom ggplot themes

It is often the case that we start to default to a particular 'style' for our figures, or you may be making several similar figures within a research paper. Creating custom functions can extend to making our own custom ggplot themes. You have probably already used theme variants such as `theme_bw()`, `theme_void()`, `theme_minimal()` - these are incredibly useful, but you might find you still wish to make consistent changes. 

Here is a plot we can make with the `dros_weight` tibble:


```r
plot <- dros_weight %>% 
  ggplot(aes(x=sex,
         y=weight_mg))+
  geom_jitter(width = 0.1)

plot
```

With the addition of a title and `theme_classic()` we can improve the style quickly


```r
plot+
  ggtitle("Comparison of weights (mg) between \nmale and female Drosophila")+
  theme_classic()
```

But I **still** want to make some more changes, rather than do this work for one figure, and potentially have to repeat this several times for subsequent figures, I can decide to make a new function instead. See [here](https://ggplot2.tidyverse.org/reference/theme.html) for a full breakdown of the arguments for the `theme()` function. 

<div class="info">
<p>Note when using a pre-set theme, and then modifying it further, it is
important to get the order of syntax correct e.g</p>
<p>theme_classic + theme() # is correct</p>
<p>theme() + theme_classic() # will not work as intended</p>
</div>


```r
# custom theme sets defaults for font and size, but these can be changed without changing the function
theme_custom <- function(base_size=12, base_family="serif"){
  theme_classic(base_size = base_size, 
                base_family = base_family,
                )  %+replace%
# update theme minimal 
theme(
  # specify default settings for plot titles - use rel to set titles relative to base size
  plot.title=element_text(size=rel(1.5),
      face="bold",
      family=base_family),
  #specify defaults for axis titles
  axis.title=element_text(
    size=rel(1),
    family=base_family),
  # specify position for y axis title
  axis.title.y=element_text(margin = margin(r = 10, l= 10)),
  # specify position for x axis title
  axis.title.x = element_text(margin = margin( t = 10, b = 10)),
  # set major y grid lines
  panel.grid.major.y = element_line(colour="gray", size=0.5),
  # add axis lines
  axis.line=element_line(),
   # Adding a 0.5cm margin around the plot
  plot.margin = unit(c(0.2, 0.5, 0.5, 0.5), units = , "cm"),    
   # Setting the font for the legend text
  legend.text = element_text(face = "italic"),   
    # Removing the legend title
          legend.title = element_blank(),    
   # Setting the position for the legend - 0 is left/bottom, 1 is top/right
          legend.position = c(0.9, 0.8)             
)
  
}
```

With this function set, I can now use it for as many figures as I wish. To use it in the future I should probably save it in a unique script, with a clear title and comments for future use. 

I could then easily use `source("custom_theme_function.R")` to make this available to any scripts I was using. 


```r
plot+
theme_custom()
```


# Making tables with gt



