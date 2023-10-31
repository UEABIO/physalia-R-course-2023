# (PART\*) Functional Programming {.unnumbered}

# Writing Functions




Good simple intro: https://github.com/tomjemmett/nhs-r_conf_21-fp_workshop

https://www.earthdatascience.org/courses/earth-analytics/automate-science-workflows/write-efficient-code-for-science-r/

https://bookdown.org/rdpeng/rprogdatascience/control-structures.html

## Structuring a function

R makes it easy to create user defined functions by using `function()`. Here is how it works:


```r
# this is an example function
my_function_name <- function(my_args) {
  # document your function here
  # what the function does
  # function inputs and outputs
  some_calculated_output <- (argument1 + argument2 )
  
  return(some_calculated_output)
}
```

* Give your function an object name and assign the function to it, e.g. `my_function_name <- function()`.

* Within the parentheses you specify inputs and arguments just like how pre-written functions work, e.g. `function(my_args)`.

* Next, put all the code you want your function to execute inside curly brackets like this: `function(my_args) {code to run}`

* Use `return()` to specify what you want to your function to output once it is done running the code.


### Activity: Understand the function

Here is a very simple function. Can you guess what it does?


```r
add_one <- function(x) {
  return(x + 1)
}
```



```r
add_one(10)
```

```
## [1] 11
```

What value did you get when running the function above? <input class='webex-solveme nospaces' size='2' data-answer='["11"]'/>

Now try applying your function to this vector:


```r
number_series <- c(1,5,10)
```

You should see it worked on *each element* inside the vector. This emphasises that R is a vector based language (it will by default apply functions on all elements in an object). 

## Function environments

When a function is evaluated, it creates it's own environment. All of the arguments that are passed to the function,
along with any variables created in the function are stored in this new environment.

The function's environment's parent will be the global environment, so we can see all of the variables created in the
global environment. Variables that are created in the function's environment aren't visible from the global environment
though.

If we reassign a variable in a function it will take a copy of that variable rather than mutating the value in the global environment. If we want to update `x` in the global environment we need to use the `<<-` operator.


```r
# x has a value of 1 in the global environment
x <- 1 

fn <- function(y) {
 # the value of x is copied from the global environment
 # but any changes remain only within the function environment
  x <- x * 2
  z <- x + y
  return(z)
}

fn(2)
x
```

```
## [1] 4
## [1] 1
```
<div class="panel panel-default"><div class="panel-heading"> Task </div><div class="panel-body"> 
create a function called `fahr_to_kelvin` that converts temperature values from degrees Fahrenheit to Kelvin.

The conversion is `temp_in_kelvin <- (temp_fahr - 32) * (5 / 9)) + 273.15`
 </div></div>

<button id="displayTextunnamed-chunk-8" onclick="javascript:toggle('unnamed-chunk-8');">Show Solution</button>

<div id="toggleTextunnamed-chunk-8" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
fahr_to_kelvin <- function(fahr) {
  # function that converts temperature in degrees Fahrenheit to kelvin
  # input: fahr: numeric value representing temp in degrees farh
  # output: kelvin: numeric converted temp in kelvin
  kelvin <- ((fahr - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
```
</div></div></div>

The `return()` function can return only a single object. If we want to return multiple values in R, we can use a `list` (or other objects) and return it.

<div class="panel panel-default"><div class="panel-heading"> Task </div><div class="panel-body"> 

To convert temperature to Celsius from kelvin, you subtract 273.15 from the temperature value in kelvin. 
Write a function that performs this conversion and returns "both" kelvin and celsius.
 </div></div>


<button id="displayTextunnamed-chunk-10" onclick="javascript:toggle('unnamed-chunk-10');">Show Solution</button>

<div id="toggleTextunnamed-chunk-10" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
fahr_to_kelvin <- function(fahr) {
  # function that converts temperature in degrees Fahrenheit to kelvin
  # input: fahr: numeric value representing temp in degrees farh
  # output: kelvin: numeric converted temp in kelvin
  celsius <- ((fahr - 32) * (5 / 9))
  kelvin <- celsius +  + 273.15
  
  temps <- list(celsius, kelvin)
  names(temps) <- c("celsius", "kelvin")
  
  return(temps)
}
```
</div></div></div>

<div class="info">
<p>A general rule of thumb. If you end up repeating a line of code more
than three times in a script - you should write a function to do the
work instead. And write clear comments on its use!</p>
<p>Why?</p>
<p>It reduces the numbers of lines of code in your script, it reduces
the amount of repetition in the code, if you need to make changes you
can change the function without having to hunt through all of your
code.</p>
<p>A really good way to organise your functions is to organise them into
a separate script to the rest of your analysis. Write functions in a
separate script and use source(“scripts/functions.R”)</p>
</div>

### Argument defaults

This is an example of a very simple function that just prints the string "Hello World" whenever you type the function `say_hello()`


```r
say_hello <- function(){
  paste("Hello World") 
}

say_hello()
```

```
## [1] "Hello World"
```

### Activity: Understanding arguments

<div class="panel panel-default"><div class="panel-heading"> Task </div><div class="panel-body"> 
What happens when you try to put something in the brackets when **using** this function?
  
e.g. say_hello("Phil")
 </div></div>

<button id="displayTextunnamed-chunk-14" onclick="javascript:toggle('unnamed-chunk-14');">Show Solution</button>

<div id="toggleTextunnamed-chunk-14" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">
Error in say_hello( or something similar, this function has not been set with any arguments, therefore it doesn't know what to do with any values provided to it. </div></div></div>

Now lets try a similar function, but we include an argument:


```r
say_morning <- function(x){
  paste("Good morning", x)
}

#  what about this one?
say_morning("Phil")
```

```
## [1] "Good morning Phil"
```

<div class="panel panel-default"><div class="panel-heading"> Task </div><div class="panel-body"> 
What happens when you DO NOT put something in the brackets when using this function? </div></div>

<button id="displayTextunnamed-chunk-17" onclick="javascript:toggle('unnamed-chunk-17');">Show Solution</button>

<div id="toggleTextunnamed-chunk-17" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
Error in paste("Good morning", x) : 
  argument "x" is missing, with no default
```
</div></div></div>

So that was an example where we included an argument for our function. But now it requires a value be provided in order to work. 

#### Argument defaults

However, you are probably used to the idea that many functions have "default" values for arguments, and we can easily set these.


```r
say_morning_default <- function(name = "you"){
  paste("Good morning", name)
}

say_morning_default()
```

```
## [1] "Good morning you"
```

<div class="try">
<p>There is now a default value supplied to the argument, but this
should still be able to changed when running the function. Try it!</p>
</div>

## Wrapper functions

Wrapper functions in R are a powerful tool for simplifying and customizing the use of existing functions. These functions act as intermediaries between the user and the underlying function, allowing you to add additional functionality, handle errors, or make the function more user-friendly. They are especially useful when you want to streamline repetitive tasks, create more intuitive interfaces, or modify the behavior of built-in functions without altering their source code. In this brief introduction, we'll explore the concept of wrapper functions, their benefits, and how to create and use them effectively in R.

### Default values

ou can create a wrapper function that calls an existing function with default argument values to simplify its usage. For instance, if you frequently use the `mean` function with a specific argument, you can create a wrapper like this:


```r
my_mean <- function(x) {
  mean(x, na.rm = TRUE)
}
```

Now, you can use `my_mean(x)` to calculate the mean while always ignoring `NA` values.

What happens when you try to use your new function `my_mean` and set na.rm  = F?

<button id="displayTextunnamed-chunk-21" onclick="javascript:toggle('unnamed-chunk-21');">Show Solution</button>

<div id="toggleTextunnamed-chunk-21" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```
Error in my_mean(c(5, 6, 7, 8), na.rm = F) : unused argument (na.rm = F)
```
</div></div></div>

If we want to be able to allow users to specify their own values for `na.rm = T` then we need to modify the wrapper function


```r
my_mean <- function(x, na.rm = TRUE) {
  mean(x, na.rm = na.rm)
}
```

With this modification, users can provide their own value for the na.rm argument when calling my_mean. For example:


```r
my_mean(c(1, 2, NA, 4))# By default, NA values are removed
my_mean(c(1, 2, NA, 4), na.rm = FALSE)  # NA values are not removed
```

```
## [1] 2.333333
## [1] NA
```

This modification makes the na.rm argument in the my_mean function flexible and allows users to override the default behavior when needed.

### Using "..."

You can allow the user to access the original arguments of mean() by using the `...` (ellipsis) argument in your wrapper function.

In R the ellipse, ..., is used by functions for one of two things.

- to capture an unknown number of argmunts

- or to pass arguments through to some underlying function, as in ?print().

The `...` argument allows you to pass additional arguments directly to the underlying function. Here's how you can modify the `my_mean` function to maintain the flexibility of the mean() function's arguments:


```r
my_mean <- function(..., na.rm = TRUE) {
  mean(..., na.rm = na.rm)
}
```

Now we can pass arguments directly to mean, and we have a version that by default removes `NA` from our dataframe (but can be overidden if necessary)


```r
my_mean(c(1, 2, NA, 4))
```

```
## [1] 2.333333
```
And we can pass any additional arguments found in mean to our new function e.g. trim


```r
my_mean(c(1, 2, NA, 4), trim = 1) 
```

```
## [1] 2
```

<div class="warning">
<p>Not all functions are designed to accept arbitrary or unspecified
additional arguments via …. In the case of the lm() function for
example, it does not have a formal … argument that allows arbitrary
additional arguments to be passed.</p>
<p>If a function doesn’t support …, attempting to pass extra arguments
using … will result in an error, such as the “used in an incorrect
context, no … to look in” error that you encountered.</p>
</div>




```r
# Custom Linear Regression Wrapper Function
my_lm <- function(...) {
  # Fit the linear regression model
  model <- lm(formula, data = data)
  
  # Summarize the model
  summary_model <- summary(model)
  
  # Print the coefficients and statistics
  cat("Coefficients:\n")
  print(summary_model$coefficients)
  
  # Diagnostic plots
  par(mfrow = c(2, 2))  # Arrange plots in a 2x2 grid
  plot(model, which = 1)  # Residuals vs. Fitted
  plot(model, which = 2)  # Normal Q-Q plot
  plot(model, which = 3)  # Scale-Location plot
  plot(model, which = 4)  # Residuals vs. Leverage
  
  # Return the fitted model
  return(model)
}
```


## Documenting functions

https://www.earthdatascience.org/courses/earth-analytics/automate-science-workflows/write-efficient-code-for-science-r/

Use roxygen-2 style???

## Checking functions

Pure Functions:
A pure function is a concept in programming that describes a function with the following characteristics:

It always produces the same output for the same input.
It has no side effects, meaning it doesn't modify external state or variables.
It relies only on its input parameters to generate output.
In R, pure functions are essential for creating clean and predictable code. They are often used in functional programming to perform operations on data without causing unexpected side effects.

Mathematical Functions:
Mathematical functions are a specific type of pure function that perform mathematical operations on their input parameters. Examples of mathematical functions in R include sqrt(), log(), sin(), and cos(). These functions take one or more arguments and return a result based solely on those arguments, making them referentially transparent.

Referential Transparency:
Referential transparency is a property of pure functions and mathematical functions where the output of a function depends solely on its input, and there are no side effects. In other words, when you call a referentially transparent function with the same input, you will always get the same output. This property makes code easier to understand, test, and reason about.

In R, many built-in functions and packages adhere to referential transparency, making them reliable and predictable for data manipulation and analysis tasks.




```r
library(testthat)

triangle_number <- function(x) {
    0.5 * x * (x + 1)
}
test_that("it works as expected", {
    expect_equal(triangle_number(1),  1)  
    expect_equal(triangle_number(2),  3)  
    expect_equal(triangle_number(3),  6)  
    expect_equal(triangle_number(4), 10)  
    expect_equal(triangle_number(5), 15)  
})
```


```r
test_that("it works as expected", {
    expect_equal(fahr_to_kelvin(92), 306.483, tolerance=1e-2)  
   
})
```


# Flow control

https://modern-rstats.eu/defining-your-own-functions.html#control-flow

https://bookdown.org/rdpeng/rprogdatascience/control-structures.html

Imagine you want a variable to be equal to a certain value if a condition is met. This is a typical problem that requires the `if` and `else` construct. For instance:


```r
a <- 4
b <- 5
```



```r
if (a > b) {
  f <- 20
    } else {
  f <- 10
}

f
```

```
## [1] 10
```

Another way to achieve this is by using the `ifelse()` function:


```r
f <- ifelse(a > b, 20, 10)
f
```

```
## [1] 10
```

`if` and `else` might seem interchangeable with `ifelse()`, but they’re not. `ifelse()` is vectorized. Let’s try the following:


```r
ifelse(c(1,2,4) > c(3, 1, 0), "yes", "no")
```

```
## [1] "no"  "yes" "yes"
```
Trying to attempt the same with `if` and `else` will result in an error as only the first element can be evaluated


```r
if (c(1, 2, 4) > c(3, 1, 0)) print("yes") else print("no")
```

```
Error in if (c(1, 2, 4) > c(3, 1, 0)) print("yes") else print("no") : 
  the condition has length > 1

```

The work around for this would to be use a loop, so that each element along the vector can be evaluated in turn. We will revisit loops shortly. 


```r
vector1 <- c(1, 2, 4)
vector2 <- c(3, 1, 0)

result <- character(length(vector1))  # Create an empty character vector to store the results

for (i in 1:length(vector1)) {
  if (vector1[i] > vector2[i]) {
    result[i] <- "yes"
  } else {
    result[i] <- "no"
  }
}

print(result)
```

```
## [1] "no"  "yes" "yes"
```
### `case_when`

`case_when` is a powerful `tidyverse` function in R that serves as an extension of `if_else`, providing a flexible way to create conditional transformations on multiple values within a dataset. While `if_else` is primarily used for a single condition, `case_when` is designed to handle multiple conditions and allows you to assign specific values or perform operations based on these conditions.

Here's a simple introduction to case_when as an extension of `if_else`:

Imagine you have a dataset with a column called "temperature," and you want to create a new column called "weather" based on different temperature ranges. With if_else, you might write something like this:


```r
temperature <-  c(10, 25, 5, 30, 15)

ifelse(temperature < 10, "Cold",
        ifelse(temperature >= 10 & temperature < 25, "Moderate", "Hot"))
```

```
## [1] "Moderate" "Hot"      "Cold"     "Hot"      "Moderate"
```


```r
case_when(
    temperature < 10 ~ "Cold",
    temperature >= 10 & temperature < 25 ~ "Moderate",
    temperature >= 25 ~ "Hot"
  )
```

```
## [1] "Moderate" "Hot"      "Cold"     "Hot"      "Moderate"
```

## Conditional functions

Let's make a function that reports p-values in APA format (with "p = [rounded value]" when p >= .001 and "p < .001" when p < .001).

You can add a default value to any argument. If that argument is skipped, then the function uses the default argument.

First we could make a function that rounds any value to three digits.


```r
report_p <- function(p, digits = 3) {
      roundp <- round(p, digits)
    reported <-  paste("p =", roundp)
    
    return(reported)
}
```

But we would like this to have a conditional response as well: so we need an `if` `else` statement.


```r
 report_p <- function(p, digits = 3) {
     reported <- if(p < 0.001){
             "p < 0.001"} else{
             paste("p =", round(p, digits))}
             
     
     return(reported)
 }
```

However we soon hit our first problem, this function works well when provided a single numeric value, but when applied to a vector or a dataframe we encounter an error:


```r
x <- c(0,0.05,0.3,0.4)

report_p(x)
```
```
Error in if (p < 0.001) { : the condition has length > 1
```

In R, conditional statements are not vector operations. They deal only with a single value. If you pass in, for example, a vector, the `if` statement will only check the very first element and issue a warning. The solution to this is the `ifelse()` or the tidyverse equivalent `if_else()` function

<div class="tab"><button class="tablinks= T active" onclick="javascript:openCode(event, 'option1= T', '= T');">Base R</button><button class="tablinks= T" onclick="javascript:openCode(event, 'option2= T', '= T');"><tt>tidyverse</tt></button></div><div id="option1= T" class="tabcontent= T">

```r
 report_p <- function(p, digits = 3) {
     reported <- ifelse(p < 0.001,
             "p < 0.001",
             paste("p =", round(p, digits)))
     
     return(reported)
 }
```
</div><div id="option2= T" class="tabcontent= T">

```r
 report_p <- function(p, digits = 3) {
     reported <- if_else(p < 0.001,
             "p < 0.001",
             paste("p =", round(p, digits)))
     
     return(reported)
 }
```
</div><script> javascript:hide('option2= T') </script>

https://stackoverflow.com/questions/50646133/dplyr-if-else-vs-base-r-ifelse



## Warnings and errors

<div class="try">
<p>What happens when omit an argument for p, set the value to 1.5 or a
character “a”?</p>
</div>

Sometimes the function will not run, in the first example because we did not provide an argument default. 

For `p = 1.5` it probably *shouldn't* run (p = 1.5 makes no sense), but it does! 

For `p = "a"` there is a warning but perhaps not a very intuitive one. 

We can make our own custom/specific warnings, try this and run it with the arguments above again! 


<button id="displayTextunnamed-chunk-44" onclick="javascript:toggle('unnamed-chunk-44');">Show Solution</button>

<div id="toggleTextunnamed-chunk-44" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body"><div class="tab"><button class="tablinksunnamed-chunk-44 active" onclick="javascript:openCode(event, 'option1unnamed-chunk-44', 'unnamed-chunk-44');">Base R</button><button class="tablinksunnamed-chunk-44" onclick="javascript:openCode(event, 'option2unnamed-chunk-44', 'unnamed-chunk-44');"><tt>tidyverse</tt></button></div><div id="option1unnamed-chunk-44" class="tabcontentunnamed-chunk-44">

```r
 report_p <- function(p, digits = 3) {
   
  if (!is.numeric(p)) stop("p must be a number")
  if (p <= 0) warning("p-values cannot less 0")
  if (p >= 1) warning("p-values cannot be greater than 1")
   
     reported <- ifelse(p < 0.001,
             "p < 0.001",
             paste("p =", round(p, digits)))
     return(reported)
 }
```
 </div><div id="option2unnamed-chunk-44" class="tabcontentunnamed-chunk-44">
 
 
 ```r
 report_p <- function(p, digits = 3) {
  
  if (!is.numeric(p)) stop("p must be a number")
  
    result <- case_when(
        p <= 0 ~ warning("p-values cannot be less than or equal to 0"),
        p >= 1 ~ warning("p-values cannot be greater than or equal to 1"),
        p < 0.001 ~ "p < 0.001",
        TRUE ~ paste("p =", round(p, digits))
    )
    
    return(result)
 }
 ```
 </div><script> javascript:hide('option2unnamed-chunk-44') </script></div></div></div>


## Activities

Exercise 1: Write a Simple Function
We'll create a function that calculates the GC content of a DNA sequence, and the result melting temperature of the sequence and returns both in a list. GC content is the percentage of the DNA molecule's nitrogenous bases that are either guanine (G) or cytosine (C). This is a common metric used in molecular biology and genetics to analyze DNA sequences. Each GC base addes 4 degrees to melting temp while each AT base adds 2 degrees. 

> Hint`stringr` and associated functions will be very helpful here

<button id="displayTextunnamed-chunk-45" onclick="javascript:toggle('unnamed-chunk-45');">Show Solution</button>

<div id="toggleTextunnamed-chunk-45" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body"><div class="tab"><button class="tablinksunnamed-chunk-45 active" onclick="javascript:openCode(event, 'option1unnamed-chunk-45', 'unnamed-chunk-45');">Base R</button><button class="tablinksunnamed-chunk-45" onclick="javascript:openCode(event, 'option2unnamed-chunk-45', 'unnamed-chunk-45');"><tt>tidyverse</tt></button></div><div id="option1unnamed-chunk-45" class="tabcontentunnamed-chunk-45">

```r
gc_content <- function(dna_sequence) {
  # Convert the input sequence to uppercase to handle mixed-case input
  dna_sequence <- toupper(dna_sequence)
  
 
  
  # Calculate the number of GC bases (C and G) in the sequence
 gc_positions <- unlist(gregexpr("[GC]", dna_sequence))
 gc_count <- length(gc_positions)

  # Calculate the total number of bases in the sequence
  total_bases <- nchar(dna_sequence)
  
  # Calculate the GC content as a percentage
  gc_percentage <- (gc_count / total_bases) * 100
  
  gc_percentage <- round(gc_percentage, 2)
  
  # Calculate AT numbers
  at_count <- total_bases - gc_count
  
  # Calculate melting temp of sequence
  melt_temp <- (gc_count*4) + (at_count*2)
  
  
  dna_content <- list(gc_percentage, melt_temp)
  names(dna_content) <- c("GC Percentage", "Melting temp (celsius)")
  
  
  return(dna_content)
}
```
</div><div id="option2unnamed-chunk-45" class="tabcontentunnamed-chunk-45">

```r
gc_content <- function(dna_sequence) {
  # Convert the input sequence to uppercase to handle mixed-case input
  dna_sequence <- str_to_upper(dna_sequence)
  

  
  # Calculate the number of GC bases (C and G) in the sequence
  gc_count <- sum(str_count(dna_sequence %in% c("G", "C")))
  
  # Calculate the total number of bases in the sequence
  total_bases <- str_length(dna_sequence)
  
  # Calculate the GC content as a percentage
  gc_percentage <- (gc_count / total_bases) * 100
  
  gc_percentage <- round(gc_percentage, 2)
  
   # Calculate AT numbers
  at_count <- total_bases - gc_count
  
  # Calculate melting temp of sequence
  melt_temp <- (gc_count*4) + (at_count*2)
  
  
  dna_content <- list(gc_percentage, melt_temp)
  names(dna_content) <- c("GC Percentage", "Melting temp (celsius)")
  
  
  return(dna_content)
}
```
</div><script> javascript:hide('option2unnamed-chunk-45') </script></div></div></div>

Exercise 2: Document the Function
Add documentation to the factorial function using roxygen2-style comments. Include a title, description, arguments, and examples.

<button id="displayTextunnamed-chunk-46" onclick="javascript:toggle('unnamed-chunk-46');">Show Solution</button>

<div id="toggleTextunnamed-chunk-46" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">


</div></div></div>

Exercise 3: Test the Function
Create a test script that uses test_that to check if the function returns the correct GC percentage and melting temps

<button id="displayTextunnamed-chunk-47" onclick="javascript:toggle('unnamed-chunk-47');">Show Solution</button>

<div id="toggleTextunnamed-chunk-47" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
test_that("gc_content function tests", {
    # Test valid input and GC content calculation
    dna_seq1 <- "ATGCGTAGCT"
    result1 <- gc_content(dna_seq1)
    expect_equal(result1$`GC Percentage`, 50)
    expect_equal(result1$`Melting temp (celsius)`, 30)})
```

```
## Test passed 🎉
```
</div></div></div>

Exercise 4: Handle Errors
You can optionally modify the gc_content function to handle errors such as when the input contains non-DNA characters, or warnings if the the length exceeds 30nt?

<button id="displayTextunnamed-chunk-48" onclick="javascript:toggle('unnamed-chunk-48');">Show Solution</button>

<div id="toggleTextunnamed-chunk-48" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body"><div class="tab"><button class="tablinksunnamed-chunk-48 active" onclick="javascript:openCode(event, 'option1unnamed-chunk-48', 'unnamed-chunk-48');">Base R</button><button class="tablinksunnamed-chunk-48" onclick="javascript:openCode(event, 'option2unnamed-chunk-48', 'unnamed-chunk-48');"><tt>tidyverse</tt></button></div><div id="option1unnamed-chunk-48" class="tabcontentunnamed-chunk-48">

```r
gc_content <- function(dna_sequence) {
  # Convert the input sequence to uppercase to handle mixed-case input
  dna_sequence <- toupper(dna_sequence)
  
  # Check if the input sequence contains only valid DNA characters (A, T, C, G)
  if (!grepl("^[ATCG]+$", dna_sequence)) stop("Invalid DNA sequence. Only A, T, C, and G are allowed.")
  
  if (nchar(dna_sequence) > 30 ) warning("Sequence is > 30 nt temperature predictions may be inaccurate")
  
  
  # Calculate the number of GC bases (C and G) in the sequence
 gc_positions <- unlist(gregexpr("[GC]", dna_sequence))
 gc_count <- length(gc_positions)

  # Calculate the total number of bases in the sequence
  total_bases <- nchar(dna_sequence)
  
  # Calculate the GC content as a percentage
  gc_percentage <- (gc_count / total_bases) * 100
  
  gc_percentage <- round(gc_percentage, 2)
  
  # Calculate AT numbers
  at_count <- total_bases - gc_count
  
  # Calculate melting temp of sequence
  melt_temp <- (gc_count*4) + (at_count*2)
  
  
  dna_content <- list(gc_percentage, melt_temp)
  names(dna_content) <- c("GC Percentage", "Melting temp (celsius)")
  
  
  return(dna_content)
}
```
</div><div id="option2unnamed-chunk-48" class="tabcontentunnamed-chunk-48">

```r
gc_content <- function(dna_sequence) {
  # Convert the input sequence to uppercase to handle mixed-case input
  dna_sequence <- str_to_upper(dna_sequence)
  
  # Check if the input sequence contains only valid DNA characters (A, T, C, G)
if (!str_detect(dna_sequence, "^[ATCG]+$")) stop("Invalid DNA sequence. Only A, T, C, and G are allowed.")

    if (str_length(dna_sequence) > 30 ) warning("Sequence is > 30 nt temperature predictions may be inaccurate")

  
  # Calculate the number of GC bases (C and G) in the sequence
  gc_count <- sum(str_count(dna_sequence %in% c("G", "C")))
  
  # Calculate the total number of bases in the sequence
  total_bases <- str_length(dna_sequence)
  
  # Calculate the GC content as a percentage
  gc_percentage <- (gc_count / total_bases) * 100
  
  gc_percentage <- round(gc_percentage, 2)
  
   # Calculate AT numbers
  at_count <- total_bases - gc_count
  
  # Calculate melting temp of sequence
  melt_temp <- (gc_count*4) + (at_count*2)
  
  
  dna_content <- list(gc_percentage, melt_temp)
  names(dna_content) <- c("GC Percentage", "Melting temp (celsius)")
  
  
  return(dna_content)
}
```
</div><script> javascript:hide('option2unnamed-chunk-48') </script></div></div></div>




# Simple iteration

We’ve seen how to write a function and how they can be used to create concise re-usable operations that can be applied multiple times in a script without having to copy and paste, but where functions really come into their own is when combined with iteration. Iteration is the process of running the same operation on a group of objects, further minimising code replication. 

Functional programming in R requires a good understanding of the types of data structure available in R. So make sure you remember the distinctions between vectors, lists, matrices and dataframes.

In the section below we will start with simple functions that allow you to replicate arguments

## `rep()`

The function `rep()` lets you repeat the first argument a set number of times.


```r
rep(1:5, 5)

rep(c("Adelie", "Gentoo", "Chinstrap"), 2)
```

```
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
## [1] "Adelie"    "Gentoo"    "Chinstrap" "Adelie"    "Gentoo"    "Chinstrap"
```

The default for the amount of repetition is `times = ` it will print the entire vector start to finish THEN repeat.

If the second argument is a vector with the same number of elements as the *first* vector, then it will repeat to the specified values for each


```r
rep(c("Adelie", "Gentoo", "Chinstrap"), c(2, 1, 3))
```

```
## [1] "Adelie"    "Adelie"    "Gentoo"    "Chinstrap" "Chinstrap" "Chinstrap"
```

Or if you use the argument `each` then it will rep all of the first element *first* followed by the second etc.



```r
rep(c("Adelie", "Gentoo", "Chinstrap"), each = 3)
```

```
## [1] "Adelie"    "Adelie"    "Adelie"    "Gentoo"    "Gentoo"    "Gentoo"   
## [7] "Chinstrap" "Chinstrap" "Chinstrap"
```
What do you think will happen if you set both times to 3 and each to 2?


```r
rep(c("Adelie", "Gentoo", "Chinstrap"), times = 2, each = 3)
```

<button id="displayTextunnamed-chunk-53" onclick="javascript:toggle('unnamed-chunk-53');">Show Solution</button>

<div id="toggleTextunnamed-chunk-53" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```
##  [1] "Adelie"    "Adelie"    "Adelie"    "Gentoo"    "Gentoo"    "Gentoo"   
##  [7] "Chinstrap" "Chinstrap" "Chinstrap" "Adelie"    "Adelie"    "Adelie"   
## [13] "Gentoo"    "Gentoo"    "Gentoo"    "Chinstrap" "Chinstrap" "Chinstrap"
```
</div></div></div>


## `seq()`

The function `seq()` is useful for generating a sequence of numbers with some pattern.

Use `seq()` to create a vector of the integers 0 to 10.



```r
seq(1,5)
```

```
## [1] 1 2 3 4 5
```

This is initially very similar to just making a vector with


```r
c(1:5)
```

```
## [1] 1 2 3 4 5
```

But with `seq` we have extra functions. You can set the by argument to count by numbers other than 1 (the default). Use `seq()` to create a vector of the numbers 0 to 100 by 10s.


```r
seq(0, 100, by = 10)
```

```
##  [1]   0  10  20  30  40  50  60  70  80  90 100
```


We also have the argument `length.out`, which is useful when you want to know how to many steps to divide something into


```r
seq(0, 100, length.out = 12)
```

```
##  [1]   0.000000   9.090909  18.181818  27.272727  36.363636  45.454545
##  [7]  54.545455  63.636364  72.727273  81.818182  90.909091 100.000000
```

## `replicate()`

Replicate is our first example of a function whose purpose is to iterate *other* functions

For example the `rnorm` function generates numbers from a normal distribution.

Nesting this inside the `replicate()` function will repeat this command a specified number of times


```r
replicate(3, # times to replicate function
          expr = rnorm(n = 5, 
                       mean = 1,
                       sd = 1))
```

```
##            [,1]       [,2]       [,3]
## [1,]  1.2177639  2.3008201  0.9717606
## [2,] -0.3614238 -0.3141361  0.8596532
## [3,]  0.9482401  4.5944154 -0.3462956
## [4,]  0.9304984 -0.4653099  0.5355213
## [5,]  0.8044913  0.6334838  0.5171776
```

https://www.r-bloggers.com/2023/07/the-replicate-function-in-r/

# Loops

Loops are one of the staples of all programming languages, not just R, and can be a powerful tool; though we will see later there are a suite of alternative to loops in R. 

For loops make it possible to repeat a set of instructions i times. For example, try the following:


```r
for (i in 1:5){
  print("hello")
}
```

```
## [1] "hello"
## [1] "hello"
## [1] "hello"
## [1] "hello"
## [1] "hello"
```

Or


```r
for (i in 1:3) {
  print(i+1)
}
```

```
## [1] 2
## [1] 3
## [1] 4
```

This is a dynamic piece of code where an index 'i' is iteratively replaced by each value in the vector 1:5. 

Let's break it down. Since the first value in our sequence (1:3) is 1, the loop begins by substituting 'i' with 1 and executing everything within the curly braces {1+1}. Loops conventionally use 'i' as the counter, which is short for iteration. However, you are free to use any variable name you prefer:

so the first loop is essentially: 

```
i <- 1 + 1
print(i)

```

Once this first iteration is complete, it loops back to the beginning and replaces i with the next value in our 1:3 sequence (2 in this case):

```
i <- 2 + 1
print(i)

```

This process is then repeated until the loop reaches the final value in the sequence 

```
for (i in 1:3) { # the SEQUENCE is defined (numbers 1 to 5) and loop is opened with "{"
  print(i + 1)    # The OPERATIONS (add 1 to each sequence number and print)
}                            # The loop is closed with "}"

```

## Functions in for loops

Whilst above we have been using simple addition in the body of the loop, you can also combine loops with functions.


```r
# Define a function to calculate the square of a number
square <- function(x) {
  return(x * x)
}

# Use a for loop to calculate and print the squares of numbers from 1 to 5
for (num in 1:5) { # Here I have replace i with num
  result <- square(num)
  cat("The square of", num, "is", result, "\n")
}
```

```
## The square of 1 is 1 
## The square of 2 is 4 
## The square of 3 is 9 
## The square of 4 is 16 
## The square of 5 is 25
```

## For loops in dataframes

Let's create a somewhat more intricate function. Initially, we generate a new tibble by creating four vectors, each consisting of 10 randomly generated numbers. These numbers are designed to be approximately centered around a mean of 0 with a standard deviation of 1. Afterward, we combine these vectors to form the final tibble.


```r
set.seed(1234)

# a simple tibble
df <- tibble(
  a =  rnorm(10),
  b =  rnorm(10),
  c =  rnorm(10),
  d = rnorm(10),
  e = rnorm(10),
  f = rnorm(10),
  g = rnorm(10),
  h = rnorm(10),
)

df
```

<div class="kable-table">

|          a|          b|          c|          d|          e|          f|          g|          h|
|----------:|----------:|----------:|----------:|----------:|----------:|----------:|----------:|
| -1.2070657| -0.4771927|  0.1340882|  1.1022975|  1.4494963| -1.8060313|  0.6565885|  0.0068928|
|  0.2774292| -0.9983864| -0.4906859| -0.4755931| -1.0686427| -0.5820759|  2.5489911| -0.4554687|
|  1.0844412| -0.7762539| -0.4405479| -0.7094400| -0.8553646| -1.1088896| -0.0347604| -0.3665239|
| -2.3456977|  0.0644588|  0.4595894| -0.5012581| -0.2806230| -1.0149620| -0.6696336|  0.6482866|
|  0.4291247|  0.9594941| -0.6937202| -1.6290935| -0.9943401| -0.1623095| -0.0076048|  2.0702709|
|  0.5060559| -0.1102855| -1.4482049| -1.1676193| -0.9685143|  0.5630558|  1.7770844| -0.1533984|
| -0.5747400| -0.5110095|  0.5747557| -2.1800396| -1.1073182|  1.6478175| -1.1386077| -1.3907009|
| -0.5466319| -0.9111954| -1.0236557| -1.3409932| -1.2519859| -0.7733534|  1.3678272| -0.7235818|
| -0.5644520| -0.8371717| -0.0151383| -0.2942939| -0.5238281|  1.6059096|  1.3295648|  0.2582618|
| -0.8900378|  2.4158352| -0.9359486| -0.4658975| -0.4968500| -1.1578085|  0.3364728| -0.3170591|

</div>

Each vector is randomly generated so the actual averages will be slightly different, we can test that here:


```r
mean(df$a)

mean(df$b)

mean(df$c)

mean(df$d)
```

```
## [1] -0.3831574
## [1] -0.1181707
## [1] -0.3879468
## [1] -0.7661931
```

So the above code works, but it is repetitive, applying the same function again and again.

Below we have a simple for loop:


```r
#1. Having a predefined empty vector to receive the values is good practice, we will see why a bit later

output <- vector("double", ncol(df)) # this will have four empty elements the same as the number of columns for the dataframe. The vector is set to receive numeric data
```

Now we run our loop: 


```r
for (i in 1:ncol(df)) {            # 2. sequence - determines what to loop over 
  
  output[[i]] <- mean(df[[i]])      # 3. body - each time the loop runs it allocates a value to output, 
}
output
```

```
## [1] -0.38315741 -0.11817071 -0.38794682 -0.76619306 -0.60979706 -0.27886474
## [7]  0.61659223 -0.04230209
```

Each time the mean is calculate for one column in df this is then stored as an element in the previously empty output vector.

`for()` loops are very useful for quickly iterating over a list, but because R prefers to store everything as a new object with each loop iteration, loops can become quite slow if they are complex, or running many processes and many iterations.



## Speed

### Initialise objects

Pre-allocating the output with the appropriate length before the loop avoids reallocation of memory inside the loop, which can be inefficient for large data. For example:



```r
output2 <- NULL

microbenchmark::microbenchmark(
  for (i in 1:ncol(df)){             
  
  output2 <- c(output2, mean(df[[i]])) # each new calculation is concatenated onto the end of the growing vector
}
)
output2 # note because we did not predefine our vector length it continues to grow! 
```

| |Built inside loop|pre-initialised vector|
|-----|-----|-----|
|min|2.41ms	| 2.37ms|
|max|	9.73ms|8.99ms|
|mean|	2.71ms|2.72 ms|
|median|	2.56ms|2.49ms|


### simple datatypes





```r
df_list <- as.list(df)


microbenchmark::microbenchmark( # check average processing time
for (i in length(df_list)) {           
  
  output[[i]] <- mean(df_list[[i]])      
}
)
```

Depending on your own computer processing power you may get different results - but here

| |List|Tibble|
|-----|-----|-----|
|min|1.92ms	| 2.37ms|
|max|	8.49ms|8.99ms|
|mean|	2.07ms|2.72 ms|
|median|	1.99ms|2.49ms|

### Visualise speed

The `microbenchmark` package has some other useful features including the ability to run multiple functions for comparison simultaneously and with integration with ggplot2 we can plot these results


```r
output_vector <- vector("double", ncol(df))
output_list <- vector(mode = "list", length = ncol(df))
new_output_vector <- NULL
new_output_vector2 <- NULL


mbm <- microbenchmark::microbenchmark(
df_input_vector_output = for (i in 1:ncol(df)) {
  output_vector[[i]] <- mean(df[[i]]) 
}, 
list_input_vector_output = for (i in length(df_list)) {           
    output_vector[[i]] <- mean(df_list[[i]])      
}, 
df_input_build_vector =  for (i in 1:ncol(df)){             
    
    new_output_vector <- c(new_output_vector, mean(df[[i]])) # each new calculation is concatenated onto the end of the growing vector
}, 
list_input_build_vector = for (i in 1:length(df_list)){             
    
   new_output_vector2 <- c(new_output_vector2, mean(df[[i]])) # each new calculation is concatenated onto the end of the growing vector
}
)

mbm
```

<div class="kable-table">

|expr                     |    time|
|:------------------------|-------:|
|df_input_vector_output   | 2932095|
|df_input_vector_output   | 2557884|
|list_input_vector_output | 1981140|
|list_input_build_vector  | 2309782|
|list_input_vector_output | 1938140|
|df_input_build_vector    | 2419513|
|list_input_vector_output | 1906440|
|df_input_build_vector    | 2411132|
|df_input_build_vector    | 2422063|
|list_input_vector_output | 1965290|
|list_input_vector_output | 2001571|
|df_input_build_vector    | 2359012|
|df_input_build_vector    | 2407533|
|df_input_build_vector    | 2403692|
|list_input_build_vector  | 2423193|
|df_input_build_vector    | 2504593|
|df_input_build_vector    | 2442703|
|list_input_vector_output | 2009720|
|list_input_vector_output | 1929339|
|df_input_build_vector    | 2445062|
|list_input_build_vector  | 2276922|
|list_input_vector_output | 1996211|
|df_input_vector_output   | 2439342|
|list_input_build_vector  | 2268382|
|df_input_build_vector    | 2564884|
|list_input_build_vector  | 2322152|
|df_input_vector_output   | 2528643|
|df_input_vector_output   | 2436663|
|list_input_build_vector  | 2301762|
|list_input_build_vector  | 2355002|
|df_input_build_vector    | 2430793|
|list_input_vector_output | 2027320|
|list_input_build_vector  | 2302082|
|df_input_vector_output   | 6165622|
|df_input_vector_output   | 2442622|
|df_input_build_vector    | 2384292|
|df_input_vector_output   | 2551673|
|df_input_build_vector    | 3082296|
|list_input_vector_output | 1944030|
|list_input_vector_output | 1924361|
|list_input_vector_output | 1892321|
|df_input_vector_output   | 2432923|
|df_input_vector_output   | 2428133|
|list_input_build_vector  | 2352272|
|df_input_vector_output   | 2365522|
|list_input_build_vector  | 2425553|
|list_input_build_vector  | 2322852|
|df_input_vector_output   | 2480903|
|df_input_vector_output   | 2490383|
|df_input_build_vector    | 2346673|
|df_input_build_vector    | 2388772|
|df_input_build_vector    | 2397843|
|list_input_vector_output | 1902470|
|list_input_vector_output | 3662769|
|list_input_vector_output | 3560578|
|list_input_vector_output | 3638849|
|df_input_build_vector    | 4005201|
|list_input_build_vector  | 4118522|
|df_input_build_vector    | 4270892|
|list_input_vector_output | 3417998|
|df_input_build_vector    | 4198822|
|df_input_vector_output   | 4395893|
|list_input_build_vector  | 3804890|
|df_input_build_vector    | 2479873|
|df_input_vector_output   | 2504753|
|df_input_build_vector    | 2450063|
|df_input_build_vector    | 2347052|
|list_input_vector_output | 5497509|
|list_input_build_vector  | 2262381|
|df_input_build_vector    | 2557044|
|df_input_build_vector    | 2364212|
|list_input_vector_output | 1933960|
|list_input_build_vector  | 2138492|
|df_input_vector_output   | 2325173|
|list_input_build_vector  | 2245212|
|list_input_vector_output | 1889040|
|list_input_build_vector  | 2348963|
|df_input_build_vector    | 2532943|
|df_input_vector_output   | 2431832|
|list_input_build_vector  | 2221191|
|df_input_vector_output   | 2480123|
|list_input_vector_output | 2067711|
|df_input_build_vector    | 2398973|
|df_input_build_vector    | 2385113|
|list_input_build_vector  | 2168001|
|df_input_build_vector    | 2391523|
|df_input_build_vector    | 2370832|
|df_input_build_vector    | 2366423|
|df_input_vector_output   | 2386912|
|list_input_vector_output | 1881310|
|list_input_build_vector  | 2257022|
|df_input_vector_output   | 2351012|
|list_input_build_vector  | 2239642|
|df_input_vector_output   | 2346532|
|df_input_build_vector    | 2341432|
|df_input_vector_output   | 2348723|
|list_input_vector_output | 1944991|
|df_input_vector_output   | 2418072|
|list_input_build_vector  | 2239192|
|list_input_vector_output | 1961900|
|df_input_build_vector    | 6338863|
|list_input_vector_output | 2049811|
|df_input_vector_output   | 2401703|
|df_input_vector_output   | 2325342|
|list_input_vector_output | 1970980|
|list_input_vector_output | 1866060|
|df_input_build_vector    | 2388512|
|list_input_build_vector  | 2190102|
|list_input_build_vector  | 2301372|
|list_input_build_vector  | 2390452|
|df_input_build_vector    | 3095547|
|list_input_vector_output | 2302232|
|df_input_vector_output   | 4328762|
|list_input_vector_output | 2687524|
|list_input_vector_output | 2820965|
|list_input_build_vector  | 4108491|
|df_input_build_vector    | 3428188|
|df_input_vector_output   | 3477149|
|list_input_vector_output | 3135936|
|list_input_vector_output | 2722744|
|df_input_build_vector    | 2936355|
|df_input_build_vector    | 2634904|
|list_input_build_vector  | 2572804|
|df_input_build_vector    | 2828115|
|list_input_vector_output | 2143611|
|df_input_vector_output   | 2585963|
|df_input_build_vector    | 2736874|
|df_input_build_vector    | 2602733|
|df_input_build_vector    | 2583924|
|list_input_build_vector  | 2748704|
|list_input_vector_output | 2159701|
|list_input_build_vector  | 2393733|
|list_input_vector_output | 2559823|
|df_input_vector_output   | 2950906|
|list_input_vector_output | 6289873|
|list_input_build_vector  | 3303067|
|list_input_vector_output | 2387122|
|list_input_build_vector  | 3795530|
|df_input_vector_output   | 2691234|
|list_input_vector_output | 1986771|
|df_input_build_vector    | 2424542|
|df_input_vector_output   | 2462203|
|df_input_build_vector    | 2664434|
|df_input_vector_output   | 2521553|
|df_input_build_vector    | 2654254|
|df_input_build_vector    | 2780245|
|df_input_build_vector    | 2692534|
|list_input_vector_output | 2147641|
|list_input_vector_output | 2297742|
|list_input_vector_output | 2336482|
|list_input_vector_output | 2043591|
|df_input_vector_output   | 3425408|
|df_input_build_vector    | 2685044|
|df_input_vector_output   | 2666934|
|list_input_build_vector  | 2295202|
|list_input_vector_output | 2606553|
|df_input_build_vector    | 2407632|
|df_input_build_vector    | 3025316|
|list_input_build_vector  | 2264932|
|list_input_build_vector  | 2198461|
|df_input_vector_output   | 2516143|
|df_input_build_vector    | 3369928|
|df_input_build_vector    | 2599154|
|df_input_build_vector    | 2897426|
|list_input_build_vector  | 3175656|
|df_input_build_vector    | 2472473|
|list_input_vector_output | 2018091|
|df_input_vector_output   | 2469883|
|df_input_build_vector    | 6147822|
|list_input_vector_output | 2040601|
|df_input_vector_output   | 2413462|
|list_input_vector_output | 1959820|
|list_input_build_vector  | 2168582|
|df_input_build_vector    | 2363772|
|df_input_build_vector    | 3155606|
|list_input_vector_output | 1959861|
|list_input_vector_output | 2547803|
|df_input_build_vector    | 2397373|
|df_input_vector_output   | 2468792|
|list_input_build_vector  | 2350303|
|df_input_build_vector    | 2361162|
|list_input_vector_output | 1977610|
|list_input_vector_output | 2035071|
|df_input_vector_output   | 2521473|
|list_input_vector_output | 1888000|
|list_input_build_vector  | 2258142|
|df_input_vector_output   | 2353552|
|list_input_vector_output | 1889040|
|df_input_build_vector    | 2368222|
|df_input_build_vector    | 2311822|
|list_input_vector_output | 1940070|
|list_input_vector_output | 1900600|
|df_input_build_vector    | 2670574|
|list_input_build_vector  | 2200721|
|df_input_build_vector    | 2420943|
|list_input_build_vector  | 2200891|
|list_input_build_vector  | 2389453|
|list_input_build_vector  | 2848895|
|list_input_build_vector  | 2757194|
|list_input_build_vector  | 2304662|
|list_input_build_vector  | 2361152|
|df_input_vector_output   | 2378593|
|df_input_vector_output   | 6178412|
|list_input_vector_output | 1888480|
|df_input_vector_output   | 2379802|
|list_input_vector_output | 1856970|
|list_input_build_vector  | 2227132|
|df_input_vector_output   | 2253772|
|df_input_build_vector    | 2366612|
|list_input_build_vector  | 2303722|
|list_input_vector_output | 1867490|
|list_input_vector_output | 1943250|
|df_input_vector_output   | 2313362|
|list_input_build_vector  | 2316122|
|df_input_build_vector    | 2362013|
|df_input_vector_output   | 2406502|
|df_input_build_vector    | 2554483|
|df_input_vector_output   | 2394662|
|df_input_build_vector    | 2441263|
|df_input_build_vector    | 2346812|
|list_input_build_vector  | 2284472|
|df_input_vector_output   | 2341382|
|df_input_build_vector    | 2339543|
|df_input_vector_output   | 2401552|
|df_input_build_vector    | 2345292|
|df_input_vector_output   | 2360423|
|list_input_vector_output | 1867249|
|list_input_build_vector  | 2356433|
|list_input_vector_output | 1871709|
|list_input_build_vector  | 2428983|
|list_input_build_vector  | 2256002|
|list_input_build_vector  | 2203522|
|list_input_build_vector  | 2384513|
|list_input_vector_output | 1915500|
|df_input_build_vector    | 2449863|
|list_input_vector_output | 5499178|
|list_input_build_vector  | 2379033|
|list_input_build_vector  | 2229232|
|list_input_vector_output | 1977000|
|df_input_build_vector    | 2330012|
|list_input_build_vector  | 2218592|
|list_input_vector_output | 1837639|
|df_input_vector_output   | 2367563|
|list_input_vector_output | 1859010|
|df_input_build_vector    | 2388762|
|list_input_vector_output | 2103731|
|list_input_vector_output | 1889800|
|df_input_build_vector    | 2470033|
|df_input_build_vector    | 2362062|
|list_input_vector_output | 1973440|
|list_input_vector_output | 2041441|
|df_input_build_vector    | 2462633|
|list_input_build_vector  | 2197662|
|list_input_build_vector  | 2206571|
|df_input_vector_output   | 2383012|
|df_input_build_vector    | 2305312|
|df_input_build_vector    | 2362893|
|list_input_build_vector  | 2171071|
|df_input_build_vector    | 2353953|
|list_input_build_vector  | 2180112|
|list_input_build_vector  | 2335802|
|df_input_vector_output   | 2516343|
|df_input_build_vector    | 2435953|
|list_input_vector_output | 1967100|
|df_input_vector_output   | 2299582|
|df_input_vector_output   | 2409853|
|list_input_build_vector  | 2212451|
|list_input_vector_output | 2115642|
|df_input_build_vector    | 2649663|
|df_input_vector_output   | 8948827|
|list_input_vector_output | 2087231|
|list_input_build_vector  | 2370002|
|list_input_build_vector  | 2274552|
|list_input_build_vector  | 2140901|
|list_input_build_vector  | 2263121|
|df_input_vector_output   | 2248172|
|list_input_build_vector  | 2216292|
|df_input_vector_output   | 2345192|
|df_input_vector_output   | 2380842|
|df_input_vector_output   | 2435143|
|list_input_build_vector  | 2206622|
|list_input_build_vector  | 2278001|
|list_input_vector_output | 1880521|
|df_input_build_vector    | 2541043|
|list_input_build_vector  | 2260332|
|list_input_build_vector  | 2241281|
|df_input_vector_output   | 2412243|
|list_input_build_vector  | 2267852|
|list_input_build_vector  | 2238021|
|df_input_build_vector    | 2338873|
|list_input_vector_output | 1921760|
|list_input_vector_output | 1842279|
|list_input_build_vector  | 2206102|
|df_input_vector_output   | 2256072|
|df_input_build_vector    | 2342752|
|list_input_build_vector  | 2154671|
|df_input_vector_output   | 2328372|
|df_input_vector_output   | 2373133|
|df_input_build_vector    | 2346632|
|list_input_build_vector  | 2243252|
|list_input_vector_output | 1894240|
|df_input_vector_output   | 2396452|
|list_input_build_vector  | 2251542|
|df_input_build_vector    | 6050301|
|df_input_build_vector    | 2892726|
|df_input_vector_output   | 2509313|
|df_input_vector_output   | 2313222|
|df_input_vector_output   | 2300752|
|df_input_build_vector    | 2322812|
|df_input_vector_output   | 2353632|
|list_input_build_vector  | 2185812|
|list_input_build_vector  | 2266392|
|df_input_vector_output   | 2311872|
|list_input_vector_output | 1950130|
|list_input_build_vector  | 2188681|
|list_input_vector_output | 1985321|
|list_input_vector_output | 1975560|
|df_input_vector_output   | 2432023|
|df_input_build_vector    | 2359582|
|df_input_build_vector    | 2406743|
|list_input_vector_output | 1951320|
|df_input_vector_output   | 2331572|
|df_input_build_vector    | 2402243|
|list_input_vector_output | 1867189|
|df_input_build_vector    | 2398613|
|df_input_vector_output   | 2295442|
|list_input_vector_output | 1968170|
|df_input_build_vector    | 3032106|
|list_input_vector_output | 1961150|
|list_input_vector_output | 2020871|
|list_input_build_vector  | 2194741|
|list_input_vector_output | 1939781|
|list_input_build_vector  | 2391713|
|list_input_build_vector  | 2332532|
|list_input_vector_output | 1909030|
|df_input_vector_output   | 2357763|
|list_input_vector_output | 2004870|
|list_input_build_vector  | 5717030|
|df_input_vector_output   | 2364732|
|df_input_vector_output   | 2344972|
|df_input_vector_output   | 2316312|
|df_input_build_vector    | 2297312|
|list_input_build_vector  | 2233171|
|df_input_build_vector    | 2309992|
|df_input_vector_output   | 2355003|
|list_input_vector_output | 1898040|
|df_input_vector_output   | 2380532|
|df_input_vector_output   | 2353312|
|list_input_build_vector  | 2359073|
|list_input_build_vector  | 2782444|
|list_input_build_vector  | 2396923|
|list_input_vector_output | 2061920|
|df_input_vector_output   | 2453383|
|list_input_build_vector  | 2208702|
|df_input_build_vector    | 2508283|
|df_input_build_vector    | 2345222|
|df_input_vector_output   | 2346912|
|list_input_vector_output | 1858509|
|list_input_vector_output | 2102641|
|list_input_vector_output | 1950131|
|list_input_vector_output | 1922479|
|df_input_vector_output   | 2323962|
|df_input_build_vector    | 2436712|
|df_input_vector_output   | 2355493|
|list_input_build_vector  | 2221031|
|list_input_vector_output | 1939390|
|df_input_vector_output   | 2314381|
|df_input_build_vector    | 2413232|
|list_input_build_vector  | 2204712|
|list_input_build_vector  | 2314582|
|list_input_vector_output | 5674659|
|df_input_build_vector    | 2362683|
|df_input_build_vector    | 2518433|
|list_input_build_vector  | 2441873|
|df_input_vector_output   | 2680144|
|list_input_build_vector  | 2244812|
|df_input_vector_output   | 2269751|
|df_input_vector_output   | 2335122|
|list_input_build_vector  | 2189732|
|df_input_vector_output   | 2391153|
|df_input_vector_output   | 2366672|
|list_input_vector_output | 1968400|
|df_input_vector_output   | 2295642|
|df_input_vector_output   | 2409043|
|df_input_vector_output   | 2499833|
|list_input_build_vector  | 2246691|
|list_input_vector_output | 1934890|
|df_input_vector_output   | 2322712|
|df_input_vector_output   | 2328592|
|df_input_vector_output   | 2380422|
|list_input_build_vector  | 2184262|
|df_input_vector_output   | 2319192|
|df_input_vector_output   | 2915735|
|list_input_build_vector  | 2251332|
|list_input_vector_output | 1886640|
|list_input_build_vector  | 2218561|
|df_input_vector_output   | 2346083|
|list_input_vector_output | 1901500|
|df_input_vector_output   | 2448653|
|list_input_vector_output | 2521753|

</div>



```r
autoplot(mbm)
```

<img src="03-functional-programming_files/figure-html/unnamed-chunk-70-1.png" width="100%" style="display: block; margin: auto;" />



### Do as little as possible inside a loop

R is an interpreted language every thing you write inside a loop runs multiple times. The best thing you can do is to be parsimonious while writing code inside a loop. There are a number of steps that you can do to speed up a loop a bit more.

- Calculate results before the loop

- Initialize objects before the loop

- Iterate on as few numbers as possible

- Write as few functions inside a loop as possible

The main tip is to *Get out of loop* as quickly as possible.

See also https://bookdown.org/csgillespie/efficientR/programming.html#top-5-tips-for-efficient-programming


## Activity

# Apply

We can recreate the output from our loops in the previous chapter with the `apply` function in R. 

The apply functions can be an alternative to writing for loops. The general idea is to apply (or map) a function to each element of an object. For example, you can apply a function to each row or column of a matrix. 

Each function takes at least two arguments: an object and another function. The function is passed as an argument.

Every apply function has the dots, ..., argument that is used to pass on arguments to the function that is given as an argument.

Using apply functions when possible, can lead to shorter, more succinct R code. In this section, we will cover the three main functions, `apply()`, `lapply()`, and `sapply()`. 


- `lapply()`: Loop over a list and evaluate a function on each element

- `sapply()`: Same as lapply but try to simplify the result

- `apply()`: Apply a function over the margins of an array

It is (I think) important to not that the apply family is still looping - but the actual looping is done internally in C code for efficiency reasons. Apply functions are loops under the hood and they are meant for convenience not for speed.


## lapply

The `lapply()` function does the following simple series of operations:

it loops over a list, vector or dataframe, iterating over each element in turn

it applies a function to each element of the list (a function that you specify)

it always returns a list (the l is for “list”).

```
> lapply
function (X, FUN, ...) 
{
    FUN <- match.fun(FUN)
    if (!is.vector(X) || is.object(X)) 
        X <- as.list(X)
    .Internal(lapply(X, FUN))
}
<bytecode: 0x7f79498e5528>
<environment: namespace:base>

```

We can see the operation of an `lapply()` function here:


```r
lapply(df_list, mean)
```

Notice that here we are passing the `mean()` function as an argument to the `lapply()` function. Functions in R can be used this way and can be passed back and forth as arguments just like any other object. When you pass a function to another function, you do not need to include the open and closed parentheses.


```r
empty_list <- vector(mode = "list", length = length(df_list))

microbenchmark::microbenchmark(
 
  forloop = for (i in length(df_list)) {           
  
  empty_list[[i]] <- mean(df_list[[i]])      
  },
 apply = lapply(df_list, mean)
)
```

<div class="kable-table">

|expr    |    time|
|:-------|-------:|
|forloop | 2476143|
|forloop | 2126851|
|apply   |   30160|
|apply   |   23760|
|apply   |   23490|
|forloop | 1968220|
|apply   |   28310|
|apply   |   23510|
|forloop | 2026271|
|forloop | 1917740|
|forloop | 1981260|
|forloop | 1888670|
|forloop | 2043291|
|forloop | 1865140|
|apply   |   28040|
|forloop | 1935740|
|apply   |   28090|
|forloop | 1854310|
|forloop | 1933350|
|forloop | 1866810|
|forloop | 1923780|
|apply   |   28040|
|forloop | 1856730|
|apply   |   27400|
|forloop | 1942670|
|apply   |   28330|
|forloop | 1859920|
|forloop | 1990450|
|forloop | 1862340|
|forloop | 1934340|
|apply   |   28520|
|apply   |   23770|
|apply   |   23840|
|apply   |   22991|
|apply   |   23911|
|forloop | 1901870|
|apply   |   27301|
|forloop | 1980540|
|apply   |   29390|
|apply   |   24090|
|forloop | 1865490|
|forloop | 1920770|
|apply   |   27240|
|apply   |   24390|
|apply   |   23481|
|apply   |   23271|
|apply   |   24560|
|forloop | 1844629|
|forloop | 1907790|
|forloop | 1890800|
|apply   |   27300|
|forloop | 1882240|
|forloop | 2008901|
|forloop | 1903340|
|apply   |   27360|
|apply   |   25590|
|apply   |   24320|
|apply   |   63741|
|apply   |   44320|
|forloop | 1925130|
|forloop | 1907290|
|forloop | 2093411|
|apply   |   30370|
|forloop | 5642799|
|apply   |   27941|
|apply   |   24809|
|apply   |   23041|
|apply   |   24240|
|forloop | 1979850|
|forloop | 1833080|
|apply   |   26970|
|forloop | 1910920|
|apply   |   27350|
|forloop | 1822850|
|apply   |   27570|
|apply   |   23910|
|apply   |   23480|
|apply   |   23610|
|forloop | 1947150|
|forloop | 1901880|
|forloop | 1953530|
|forloop | 1863310|
|apply   |   28210|
|apply   |   24241|
|forloop | 1926859|
|apply   |   27361|
|apply   |   24290|
|apply   |   23980|
|forloop | 1864330|
|forloop | 1944300|
|forloop | 1902290|
|forloop | 1932250|
|apply   |   27720|
|apply   |   25060|
|forloop | 1858100|
|forloop | 2002800|
|forloop | 1886010|
|apply   |   27210|
|apply   |   24151|
|apply   |   24640|
|forloop | 2106211|
|forloop | 1875760|
|apply   |   27081|
|forloop | 1902361|
|apply   |   27490|
|forloop | 1876469|
|forloop | 2111620|
|apply   |   27620|
|apply   |   26310|
|apply   |   24370|
|forloop | 1903320|
|forloop | 1974150|
|forloop | 1929320|
|apply   |   27760|
|apply   |   24561|
|forloop | 1989400|
|apply   |   28470|
|forloop | 1863230|
|apply   |   27280|
|forloop | 1957650|
|forloop | 1954980|
|forloop | 2002311|
|forloop | 1903560|
|apply   |   30160|
|apply   |   25880|
|apply   |   25450|
|forloop | 1994681|
|forloop | 1925370|
|apply   |   28680|
|apply   |   26910|
|apply   |   25120|
|apply   |   24250|
|apply   |   24700|
|apply   |   24931|
|apply   |   25041|
|forloop | 2037170|
|apply   |   34751|
|apply   |   25030|
|forloop | 5521378|
|forloop | 1926959|
|apply   |   37210|
|forloop | 1858300|
|apply   |   27130|
|apply   |   23490|
|forloop | 1835419|
|apply   |   26630|
|apply   |   27741|
|forloop | 1885700|
|forloop | 1856560|
|apply   |   27060|
|apply   |   24711|
|apply   |   23320|
|forloop | 1914990|
|forloop | 1857549|
|apply   |   27400|
|forloop | 1925630|
|forloop | 1845899|
|apply   |   27610|
|apply   |   23750|
|apply   |   23711|
|forloop | 1878850|
|apply   |   26911|
|forloop | 1841459|
|forloop | 1892020|
|forloop | 1879270|
|apply   |   28610|
|forloop | 1894300|
|apply   |   28420|
|apply   |   23960|
|apply   |   23820|
|forloop | 1831160|
|forloop | 1897270|
|forloop | 1854469|
|forloop | 1902619|
|apply   |   27711|
|apply   |   25661|
|forloop | 1857239|
|apply   |   27269|
|apply   |   24330|
|forloop | 1966560|
|forloop | 2569314|
|forloop | 1949110|
|forloop | 1862469|
|apply   |   29570|
|forloop | 1962180|
|apply   |   28100|
|forloop | 1855370|
|forloop | 1950960|
|apply   |   28180|
|forloop | 1870660|
|apply   |   26800|
|forloop | 1964570|
|apply   |   27510|
|forloop | 1907490|
|forloop | 1963520|
|forloop | 1911550|
|apply   |   28481|
|forloop | 1962290|
|apply   |   28010|
|apply   |   26590|

</div>

As well as being slightly faster than the `for()` loop, arguably, `lapply` is also easier to read.


### Run lapply with additional arguments

The first argument of `lapply()` gives the list object to be iterated over. 
The second argument defines an anonymous function.


#### Functions with `lapply`

In this example we define the list to run a function over `numbers`, then write our function as normal. Defined like this it is what we call an anonymous function, it has no name and cannot be used outside of this `lapply` function.


```r
# Create a list of numbers
numbers <- list(1, 2, 3, 4, 5)


# Use lapply to add 10 to each number in the list
result <- lapply(numbers, function(x){
  return(x + 10)
})

# Print the result
print(result)
```

```
## [[1]]
## [1] 11
## 
## [[2]]
## [1] 12
## 
## [[3]]
## [1] 13
## 
## [[4]]
## [1] 14
## 
## [[5]]
## [1] 15
```

#### Using existing functions in `lapply`

In this example we write a named function. Notice how we don't have to use curly brackets or an anonymous function, instead, we just passed `mean`add_value` as the second argument of `lapply()`. I also supply any necessary arguments required by the function by specifying it afterwards.


```r
# Create a list of numbers
numbers <- list(1, 2, 3, 4, 5)

# Define a custom function that adds a given value to each number
add_value <- function(x, value) {
  return(x + value)
}

# Use lapply to add 10 to each number in the list
result <- lapply(numbers, add_value, value = 10)

# Print the result
print(result)
```

```
## [[1]]
## [1] 11
## 
## [[2]]
## [1] 12
## 
## [[3]]
## [1] 13
## 
## [[4]]
## [1] 14
## 
## [[5]]
## [1] 15
```

## sapply

The `sapply()` function behaves similarly to `lapply()`; the only real difference is in the return value. `sapply()` will try to simplify the result of `lapply()` if possible. Essentially, `sapply()` calls `lapply()` on its input and then applies the following algorithm:

- If the result is a list where every element is length 1, then a vector is returned

- If the result is a list where every element is a vector of the same length (> 1), a matrix is returned.

- If it can’t figure things out, a list is returned.


```r
sapply(df_list, mean)
```

```
##           a           b           c           d           e           f 
## -0.38315741 -0.11817071 -0.38794682 -0.76619306 -0.60979706 -0.27886474 
##           g           h 
##  0.61659223 -0.04230209
```

Notice that here `sapply()` returns a vector as each element had length of 1.


## apply

The `apply()` function is used to a evaluate a function (often an anonymous one) over an array. It is most often used to apply a function to the rows or columns of a matrix or dataframe, in fact this function *cannot* be used on a list. Using `apply()` is often not really faster than writing a loop, but it works in one line and is highly compact.

MARGIN = 1 means apply function over rows

MARGIN = 2 means apply function over columns




```r
apply(df, MARGIN = 1, mean)
```

```
##  [1] -0.017615796 -0.155554062 -0.400917401 -0.454979941 -0.003522308
##  [6] -0.125228280 -0.584980350 -0.650446262  0.119856528 -0.188911702
```

- If the result is a list where every element is length 1, then a vector is returned

- If the result is a list where every element is a vector of the same length (> 1), a matrix is returned.

### summary of apply functions

|Function|Arguments|Objective|Input|Output|
|---|---|---|---|---|
|apply|apply(X, MARGIN, FUN)|Apply a function to the rows, columns or both| Dataframe or matrix| vector, list or matrix|
|lapply| lapply(X,FUN)|Apply a function to all the elements of the input| List, vector or dataframe| list|
|sapply| sapply(X,FUN)| Apply a function to all the elements of the input| List, vector or dataframe| vector or matrix|

## Exercise 

<div class="panel panel-default"><div class="panel-heading"> Task </div><div class="panel-body"> 
Make a function that converts values with a normal distribution into their z scores </div></div>


<button id="displayTextunnamed-chunk-78" onclick="javascript:toggle('unnamed-chunk-78');">Show Solution</button>

<div id="toggleTextunnamed-chunk-78" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
z_score <- function(x) {
    (x - mean(x, na.rm = TRUE)) /  
        sd(x, na.rm = TRUE)
}
```
</div></div></div>

<div class="panel panel-default"><div class="panel-heading"> Task </div><div class="panel-body"> 
Choose the appropriate apply function to calculate a matrix of z-scores for the dataframe `df` </div></div>

<button id="displayTextunnamed-chunk-80" onclick="javascript:toggle('unnamed-chunk-80');">Show Solution</button>

<div id="toggleTextunnamed-chunk-80" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

apply(df, MARGIN = 2,  z_score)
</div></div></div>


# Purrr

# Bonus: Simulation

https://stirlingcodingclub.github.io/simulating_data/index.html#sample



```r
library(ggplot2)

# Define a function to run the simulation for a given sample size and effect size
simulate_difference <- function(sample_size, effect_size) {
    set.seed(123)
    
    # Initialize a data frame to store the estimated differences
    results <- data.frame(Simulated_Difference = numeric(100))
    
    for (i in 1:100) {  # Perform 100 simulations for the fixed sample size
        # Generate data for two groups with a specified effect size
        group1 <- rnorm(sample_size, mean = 0, sd = 1)
        group2 <- rnorm(sample_size, mean = effect_size, sd = 1)
        
        # Create a data frame for the two groups
        data_df <- data.frame(Group = rep(c("Group1", "Group2"), each = sample_size),
                              Value = c(group1, group2))
        
        # Fit a linear model to estimate the difference in means
        lm_model <- lm(Value ~ Group, data = data_df)
        
        # Extract the estimated difference from the model
        estimated_difference <- coef(lm_model)[2]
        
        results$Simulated_Difference[i] <- estimated_difference
    }
    
    # Return the data frame of estimated differences
    return(results)
}

# Fixed sample size of 20
sample_size <- 30

# Set the effect size
effect_size <- .8  # Adjust as needed

# Run the simulation for the fixed sample size
simulation_results <- simulate_difference(sample_size, effect_size)

# Calculate the mean and 2.5th and 97.5th percentiles for the confidence interval
mean_difference <- mean(simulation_results$Simulated_Difference)
lower_percentile <- quantile(simulation_results$Simulated_Difference, 0.025)
upper_percentile <- quantile(simulation_results$Simulated_Difference, 0.975)

# Create a density histogram of the estimated differences with lines for percentiles
ggplot(simulation_results, aes(x = Simulated_Difference)) +
    geom_histogram(binwidth = 0.05, fill = "lightblue", color = "black") +
    geom_vline(aes(xintercept = mean_difference), color = "red", linetype = "dashed") +
    geom_vline(aes(xintercept = lower_percentile), color = "blue") +
    geom_vline(aes(xintercept = upper_percentile), color = "blue") +
    labs(x = "Estimated Difference", y = "Density") +
    ggtitle(paste("Density Histogram of Estimated Differences (Sample Size = 20)")) +
    theme_minimal()
```

<img src="03-functional-programming_files/figure-html/unnamed-chunk-81-1.png" width="100%" style="display: block; margin: auto;" />




```r
# Load necessary libraries
library(purrr)

# Define a function to run the simulation for a given sample size and effect size
simulate_power <- function(sample_size, effect_size) {
  set.seed(123)
  
  # Initialize a counter for the number of significant t-tests
  num_significant <- 0
  
  for (i in 1:100) {  # Perform 100 simulations for each sample size

          # Generate data for two groups with a specified effect size
    group1 <- rnorm(sample_size, mean = 0, sd = 1)
    group2 <- rnorm(sample_size, mean = effect_size, sd = 1)

     # Create a data frame for the two groups
        data_df <- data.frame(Group = rep(c("Group1", "Group2"), each = sample_size),
                              Value = c(group1, group2))
        
        # Fit a linear model to estimate the difference in means
        lm_model <- lm(Value ~ Group, data = data_df)
        
        # Extract the p value from the model
       
      
        
    # Check if the null hypothesis is rejected (p-value < 0.05)
    if ( broom::tidy(lm_model)[[2,5]] < 0.05) {
      num_significant <- num_significant + 1
    }
  }
  
  # Return the proportion of significant t-tests (power)
  return(num_significant / 100)
}

# Specify a range of sample sizes to test
sample_sizes <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

# Set the effect size
effect_size <- 1  # Adjust as needed

# Run the simulation for each sample size
simulation_results <- map_dbl(sample_sizes, ~simulate_power(.x, effect_size))

# Plot the power as a function of sample size
plot(sample_sizes, simulation_results, type = "b", xlab = "Sample Size", ylab = "Power", main = "Power vs. Sample Size")
```

<img src="03-functional-programming_files/figure-html/unnamed-chunk-82-1.png" width="100%" style="display: block; margin: auto;" />




## Further Reading:

Simulations: https://rstudio-education.github.io/hopr/

https://aosmith.rbind.io/2018/01/09/simulate-simulate-part1/#simulate-simulate-dance-to-the-music

https://aosmith.rbind.io/2019/07/22/automate-model-fitting-with-loops/

https://aosmith.rbind.io/2017/12/31/many-datasets/#list-all-files-to-read-in



```r
sessionInfo()
```

```
## R version 4.3.1 (2023-06-16)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.6 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/atlas/libblas.so.3.10.3 
## LAPACK: /usr/lib/x86_64-linux-gnu/atlas/liblapack.so.3.10.3;  LAPACK version 3.9.0
## 
## locale:
##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
##  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
##  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
## [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
## 
## time zone: UTC
## tzcode source: system (glibc)
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] testthat_3.1.10    knitr_1.43         webexercises_1.1.0 glossary_1.0.0    
##  [5] lubridate_1.9.2    forcats_1.0.0      stringr_1.5.0      dplyr_1.1.2       
##  [9] purrr_1.0.1        readr_2.1.4        tidyr_1.3.0        tibble_3.2.1      
## [13] ggplot2_3.4.2      tidyverse_2.0.0   
## 
## loaded via a namespace (and not attached):
##  [1] sass_0.4.6        utf8_1.2.3        generics_0.1.3    xml2_1.3.5       
##  [5] stringi_1.7.12    hms_1.1.3         digest_0.6.33     magrittr_2.0.3   
##  [9] evaluate_0.21     grid_4.3.1        timechange_0.2.0  bookdown_0.34    
## [13] fastmap_1.1.1     jsonlite_1.8.7    brio_1.1.3        fansi_1.0.4      
## [17] scales_1.2.1      jquerylib_0.1.4   cli_3.6.1         rlang_1.1.1      
## [21] munsell_0.5.0     withr_2.5.0       cachem_1.0.8      yaml_2.3.7       
## [25] tools_4.3.1       tzdb_0.4.0        memoise_2.0.1     colorspace_2.1-0 
## [29] vctrs_0.6.3       R6_2.5.1          lifecycle_1.0.3   fs_1.6.2         
## [33] pkgconfig_2.0.3   pillar_1.9.0      bslib_0.5.0       gtable_0.3.3     
## [37] glue_1.6.2        xfun_0.39         tidyselect_1.2.0  rstudioapi_0.15.0
## [41] htmltools_0.5.5   rmarkdown_2.23    compiler_4.3.1    downlit_0.4.3
```
