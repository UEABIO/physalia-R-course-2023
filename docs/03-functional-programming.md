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

|expr                     |     time|
|:------------------------|--------:|
|df_input_vector_output   |  3700455|
|df_input_vector_output   |  2736544|
|list_input_vector_output |  4887727|
|list_input_build_vector  |  2648324|
|list_input_vector_output |  2050003|
|df_input_build_vector    |  2644714|
|list_input_vector_output |  2289893|
|df_input_build_vector    |  2781254|
|df_input_build_vector    |  2944694|
|list_input_vector_output |  2345794|
|list_input_vector_output |  2488113|
|df_input_build_vector    |  2888934|
|df_input_build_vector    |  2632414|
|df_input_build_vector    |  2496594|
|list_input_build_vector  |  2843114|
|df_input_build_vector    |  3140114|
|df_input_build_vector    |  3353495|
|list_input_vector_output |  2587624|
|list_input_vector_output |  2585574|
|df_input_build_vector    |  3164345|
|list_input_build_vector  |  2961914|
|list_input_vector_output |  2567674|
|df_input_vector_output   |  3123275|
|list_input_build_vector  |  2989364|
|df_input_build_vector    |  3052294|
|list_input_build_vector  |  3162885|
|df_input_vector_output   |  3509025|
|df_input_vector_output   |  3152144|
|list_input_build_vector  |  3035225|
|list_input_build_vector  |  3027884|
|df_input_build_vector    |  3643455|
|list_input_vector_output |  2696574|
|list_input_build_vector  |  3133235|
|df_input_vector_output   |  3239244|
|df_input_vector_output   |  3142195|
|df_input_build_vector    |  7204220|
|df_input_vector_output   |  2649514|
|df_input_build_vector    |  2458113|
|list_input_vector_output |  2202103|
|list_input_vector_output |  2009902|
|list_input_vector_output |  2350934|
|df_input_vector_output   |  2839884|
|df_input_vector_output   |  2897504|
|list_input_build_vector  |  2860694|
|df_input_vector_output   |  3219855|
|list_input_build_vector  |  2602344|
|list_input_build_vector  |  2401003|
|df_input_vector_output   |  2585544|
|df_input_vector_output   |  2891994|
|df_input_build_vector    |  2606854|
|df_input_build_vector    |  2700984|
|df_input_build_vector    |  2762624|
|list_input_vector_output |  1986554|
|list_input_vector_output |  2121183|
|list_input_vector_output |  2251294|
|list_input_vector_output |  2136683|
|df_input_build_vector    |  2513773|
|list_input_build_vector  |  2431144|
|df_input_build_vector    |  2615294|
|list_input_vector_output |  2016122|
|df_input_build_vector    |  2579313|
|df_input_vector_output   |  3399755|
|list_input_build_vector  |  2756874|
|df_input_build_vector    |  2518774|
|df_input_vector_output   |  2559903|
|df_input_build_vector    |  2575914|
|df_input_build_vector    |  2745074|
|list_input_vector_output |  2017633|
|list_input_build_vector  |  2549043|
|df_input_build_vector    |  2538143|
|df_input_build_vector    |  2469084|
|list_input_vector_output | 10142374|
|list_input_build_vector  |  2451834|
|df_input_vector_output   |  2683584|
|list_input_build_vector  |  2942724|
|list_input_vector_output |  2317333|
|list_input_build_vector  |  2532974|
|df_input_build_vector    |  2969014|
|df_input_vector_output   |  2516734|
|list_input_build_vector  |  2796254|
|df_input_vector_output   |  3104334|
|list_input_vector_output |  2131963|
|df_input_build_vector    |  2711834|
|df_input_build_vector    |  2794434|
|list_input_build_vector  |  2313394|
|df_input_build_vector    |  2613764|
|df_input_build_vector    |  2593604|
|df_input_build_vector    |  2534574|
|df_input_vector_output   |  2543703|
|list_input_vector_output |  2335784|
|list_input_build_vector  |  2381283|
|df_input_vector_output   |  2684194|
|list_input_build_vector  |  2440663|
|df_input_vector_output   |  2558093|
|df_input_build_vector    |  2594044|
|df_input_vector_output   |  2507104|
|list_input_vector_output |  2101894|
|df_input_vector_output   |  2705215|
|list_input_build_vector  |  2469473|
|list_input_vector_output |  2234813|
|df_input_build_vector    |  2601504|
|list_input_vector_output |  2102283|
|df_input_vector_output   |  2527443|
|df_input_vector_output   |  3058944|
|list_input_vector_output |  2252713|
|list_input_vector_output |  2019533|
|df_input_build_vector    |  6476979|
|list_input_build_vector  |  2357254|
|list_input_build_vector  |  2532223|
|list_input_build_vector  |  2555293|
|df_input_build_vector    |  2399883|
|list_input_vector_output |  2032354|
|df_input_vector_output   |  2606533|
|list_input_vector_output |  2145553|
|list_input_vector_output |  2177973|
|list_input_build_vector  |  2401183|
|df_input_build_vector    |  2694284|
|df_input_vector_output   |  2522213|
|list_input_vector_output |  2536354|
|list_input_vector_output |  2124073|
|df_input_build_vector    |  3281905|
|df_input_build_vector    |  2884884|
|list_input_build_vector  |  4015206|
|df_input_build_vector    |  4030805|
|list_input_vector_output |  2240374|
|df_input_vector_output   |  2717064|
|df_input_build_vector    |  2626913|
|df_input_build_vector    |  3032285|
|df_input_build_vector    |  3679035|
|list_input_build_vector  |  4033676|
|list_input_vector_output |  3732035|
|list_input_build_vector  |  2550214|
|list_input_vector_output |  2562264|
|df_input_vector_output   |  2835973|
|list_input_vector_output |  2137234|
|list_input_build_vector  |  2429013|
|list_input_vector_output |  1999653|
|list_input_build_vector  |  2662044|
|df_input_vector_output   |  2644444|
|list_input_vector_output |  1974963|
|df_input_build_vector    |  2537334|
|df_input_vector_output   |  2606274|
|df_input_build_vector    |  6374999|
|df_input_vector_output   |  2626604|
|df_input_build_vector    |  2463003|
|df_input_build_vector    |  2517094|
|df_input_build_vector    |  2535673|
|list_input_vector_output |  1952562|
|list_input_vector_output |  2100233|
|list_input_vector_output |  1966042|
|list_input_vector_output |  2041603|
|df_input_vector_output   |  2531584|
|df_input_build_vector    |  2702054|
|df_input_vector_output   |  2494433|
|list_input_build_vector  |  2273914|
|list_input_vector_output |  2086183|
|df_input_build_vector    |  2399964|
|df_input_build_vector    |  2528424|
|list_input_build_vector  |  2372973|
|list_input_build_vector  |  2307133|
|df_input_vector_output   |  2521154|
|df_input_build_vector    |  2528084|
|df_input_build_vector    |  2875874|
|df_input_build_vector    |  2580244|
|list_input_build_vector  |  2340363|
|df_input_build_vector    |  2846904|
|list_input_vector_output |  2324683|
|df_input_vector_output   |  3573045|
|df_input_build_vector    |  3372565|
|list_input_vector_output |  2880254|
|df_input_vector_output   |  3080405|
|list_input_vector_output |  2250223|
|list_input_build_vector  |  2694514|
|df_input_build_vector    |  2657014|
|df_input_build_vector    |  2500813|
|list_input_vector_output |  2321574|
|list_input_vector_output |  2181843|
|df_input_build_vector    |  2898874|
|df_input_vector_output   |  7032490|
|list_input_build_vector  |  2465223|
|df_input_build_vector    |  2535903|
|list_input_vector_output |  2152283|
|list_input_vector_output |  1984883|
|df_input_vector_output   |  2540414|
|list_input_vector_output |  1991743|
|list_input_build_vector  |  2652283|
|df_input_vector_output   |  2735553|
|list_input_vector_output |  2191093|
|df_input_build_vector    |  2626213|
|df_input_build_vector    |  2517164|
|list_input_vector_output |  1957193|
|list_input_vector_output |  2216493|
|df_input_build_vector    |  2521513|
|list_input_build_vector  |  2403743|
|df_input_build_vector    |  2495843|
|list_input_build_vector  |  2285254|
|list_input_build_vector  |  2365383|
|list_input_build_vector  |  2256974|
|list_input_build_vector  |  2351283|
|list_input_build_vector  |  2337103|
|list_input_build_vector  |  2420144|
|df_input_vector_output   |  2560103|
|df_input_vector_output   |  2638094|
|list_input_vector_output |  2121443|
|df_input_vector_output   |  2427324|
|list_input_vector_output |  2097873|
|list_input_build_vector  |  2696884|
|df_input_vector_output   |  2459493|
|df_input_build_vector    |  2549154|
|list_input_build_vector  |  2397283|
|list_input_vector_output |  2064673|
|list_input_vector_output |  2625774|
|df_input_vector_output   |  2728324|
|list_input_build_vector  |  2520984|
|df_input_build_vector    |  6528490|
|df_input_vector_output   |  2435334|
|df_input_build_vector    |  2478754|
|df_input_vector_output   |  2419543|
|df_input_build_vector    |  2547454|
|df_input_build_vector    |  2571734|
|list_input_build_vector  |  2912274|
|df_input_vector_output   |  2568834|
|df_input_build_vector    |  2685903|
|df_input_vector_output   |  2511894|
|df_input_build_vector    |  2563624|
|df_input_vector_output   |  2491494|
|list_input_vector_output |  2095103|
|list_input_build_vector  |  2434993|
|list_input_vector_output |  1954273|
|list_input_build_vector  |  2393853|
|list_input_build_vector  |  2594494|
|list_input_build_vector  |  2677564|
|list_input_build_vector  |  2442273|
|list_input_vector_output |  1968543|
|df_input_build_vector    |  2779834|
|list_input_vector_output |  2026833|
|list_input_build_vector  |  2453564|
|list_input_build_vector  |  2758095|
|list_input_vector_output |  2018702|
|df_input_build_vector    |  2864585|
|list_input_build_vector  |  2400573|
|list_input_vector_output |  1964633|
|df_input_vector_output   |  2560393|
|list_input_vector_output |  1940572|
|df_input_build_vector    |  2508424|
|list_input_vector_output |  2009333|
|list_input_vector_output |  2049333|
|df_input_build_vector    |  2459483|
|df_input_build_vector    |  2417694|
|list_input_vector_output |  2148643|
|list_input_vector_output |  5638548|
|df_input_build_vector    |  2536744|
|list_input_build_vector  |  2283333|
|list_input_build_vector  |  2357543|
|df_input_vector_output   |  2615054|
|df_input_build_vector    |  2442244|
|df_input_build_vector    |  2518153|
|list_input_build_vector  |  2536234|
|df_input_build_vector    |  2584183|
|list_input_build_vector  |  2451654|
|list_input_build_vector  |  2286493|
|df_input_vector_output   |  2442214|
|df_input_build_vector    |  2627103|
|list_input_vector_output |  2070603|
|df_input_vector_output   |  2513464|
|df_input_vector_output   |  2413984|
|list_input_build_vector  |  2381254|
|list_input_vector_output |  1989263|
|df_input_build_vector    |  2549274|
|df_input_vector_output   |  2515734|
|list_input_vector_output |  1955283|
|list_input_build_vector  |  2472304|
|list_input_build_vector  |  2308184|
|list_input_build_vector  |  2416503|
|list_input_build_vector  |  2264064|
|df_input_vector_output   |  2455454|
|list_input_build_vector  |  2337253|
|df_input_vector_output   |  2370814|
|df_input_vector_output   |  2707934|
|df_input_vector_output   |  2428413|
|list_input_build_vector  |  2293824|
|list_input_build_vector  |  2452653|
|list_input_vector_output |  2005103|
|df_input_build_vector    |  2754964|
|list_input_build_vector  |  2273353|
|list_input_build_vector  |  6076879|
|df_input_vector_output   |  2496343|
|list_input_build_vector  |  2258634|
|list_input_build_vector  |  2442183|
|df_input_build_vector    |  2431924|
|list_input_vector_output |  2173153|
|list_input_vector_output |  2113413|
|list_input_build_vector  |  2625744|
|df_input_vector_output   |  2512024|
|df_input_build_vector    |  2550714|
|list_input_build_vector  |  2424833|
|df_input_vector_output   |  2465634|
|df_input_vector_output   |  2368923|
|df_input_build_vector    |  2723844|
|list_input_build_vector  |  2279043|
|list_input_vector_output |  2006563|
|df_input_vector_output   |  2493404|
|list_input_build_vector  |  2466924|
|df_input_build_vector    |  2501403|
|df_input_build_vector    |  2468394|
|df_input_vector_output   |  2451103|
|df_input_vector_output   |  2480774|
|df_input_vector_output   |  2436373|
|df_input_build_vector    |  2491264|
|df_input_vector_output   |  2495443|
|list_input_build_vector  |  2322804|
|list_input_build_vector  |  2542463|
|df_input_vector_output   |  2465714|
|list_input_vector_output |  2055243|
|list_input_build_vector  |  2277413|
|list_input_vector_output |  2018893|
|list_input_vector_output |  1936383|
|df_input_vector_output   |  2423303|
|df_input_build_vector    |  2579664|
|df_input_build_vector    |  2716054|
|list_input_vector_output |  2123903|
|df_input_vector_output   |  6220929|
|df_input_build_vector    |  2507574|
|list_input_vector_output |  2013782|
|df_input_build_vector    |  2409034|
|df_input_vector_output   |  2568093|
|list_input_vector_output |  1951183|
|df_input_build_vector    |  2516814|
|list_input_vector_output |  2047913|
|list_input_vector_output |  2198023|
|list_input_build_vector  |  2408283|
|list_input_vector_output |  1997953|
|list_input_build_vector  |  2535644|
|list_input_build_vector  |  2344553|
|list_input_vector_output |  2447874|
|df_input_vector_output   |  2504113|
|list_input_vector_output |  1990822|
|list_input_build_vector  |  2355184|
|df_input_vector_output   |  2383523|
|df_input_vector_output   |  2687314|
|df_input_vector_output   |  2862074|
|df_input_build_vector    |  2469694|
|list_input_build_vector  |  2426113|
|df_input_build_vector    |  2678184|
|df_input_vector_output   |  2637264|
|list_input_vector_output |  2097423|
|df_input_vector_output   |  2607713|
|df_input_vector_output   |  2606843|
|list_input_build_vector  |  2521744|
|list_input_build_vector  |  2344733|
|list_input_build_vector  |  2443264|
|list_input_vector_output |  1981673|
|df_input_vector_output   |  2690124|
|list_input_build_vector  |  2458913|
|df_input_build_vector    |  2503514|
|df_input_build_vector    |  2682554|
|df_input_vector_output   |  6511660|
|list_input_vector_output |  2011363|
|list_input_vector_output |  2329833|
|list_input_vector_output |  2842654|
|list_input_vector_output |  2532014|
|df_input_vector_output   |  2690234|
|df_input_build_vector    |  2558473|
|df_input_vector_output   |  3088985|
|list_input_build_vector  |  2928324|
|list_input_vector_output |  2484834|
|df_input_vector_output   |  2626873|
|df_input_build_vector    |  2605064|
|list_input_build_vector  |  2297953|
|list_input_build_vector  |  2422414|
|list_input_vector_output |  2009833|
|df_input_build_vector    |  2612143|
|df_input_build_vector    |  2532054|
|list_input_build_vector  |  2254173|
|df_input_vector_output   |  2477084|
|list_input_build_vector  |  2240823|
|df_input_vector_output   |  2453414|
|df_input_vector_output   |  2456393|
|list_input_build_vector  |  2661014|
|df_input_vector_output   |  3142685|
|df_input_vector_output   |  2508654|
|list_input_vector_output |  2628484|
|df_input_vector_output   |  3874185|
|df_input_vector_output   |  3048425|
|df_input_vector_output   |  2498084|
|list_input_build_vector  |  2435413|
|list_input_vector_output |  3375955|
|df_input_vector_output   |  2937134|
|df_input_vector_output   |  3799935|
|df_input_vector_output   |  3563286|
|list_input_build_vector  |  2784994|
|df_input_vector_output   |  2875404|
|df_input_vector_output   |  6814820|
|list_input_build_vector  |  2630433|
|list_input_vector_output |  2067203|
|list_input_build_vector  |  2365154|
|df_input_vector_output   |  2404003|
|list_input_vector_output |  2042573|
|df_input_vector_output   |  2415383|
|list_input_vector_output |  2103503|

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
|forloop | 2571784|
|forloop | 2108043|
|apply   |   33630|
|apply   |   25410|
|apply   |   24020|
|forloop | 2121023|
|apply   |   29250|
|apply   |   26810|
|forloop | 2095003|
|forloop | 2058423|
|forloop | 2046783|
|forloop | 2155313|
|forloop | 2088573|
|forloop | 1914703|
|apply   |   29270|
|forloop | 1990803|
|apply   |   29290|
|forloop | 1918322|
|forloop | 1980853|
|forloop | 1899083|
|forloop | 1993493|
|apply   |   29270|
|forloop | 1952543|
|apply   |   29310|
|forloop | 2208543|
|apply   |   28240|
|forloop | 2413514|
|forloop | 2658243|
|forloop | 2189484|
|forloop | 2174832|
|apply   |   29749|
|apply   |   24431|
|apply   |   24550|
|apply   |   24350|
|apply   |   24750|
|forloop | 2026663|
|apply   |   36980|
|forloop | 1892713|
|apply   |   27040|
|apply   |   24511|
|forloop | 2026443|
|forloop | 1995073|
|apply   |   30240|
|apply   |   24100|
|apply   |   24000|
|apply   |   23521|
|apply   |   23820|
|forloop | 2085543|
|forloop | 1896732|
|forloop | 2170313|
|apply   |   29250|
|forloop | 1980763|
|forloop | 2141923|
|forloop | 2318674|
|apply   |   29611|
|apply   |   26290|
|apply   |   23990|
|apply   |   24310|
|apply   |   24770|
|forloop | 2096553|
|forloop | 2041333|
|forloop | 2080633|
|apply   |   28490|
|forloop | 2242523|
|apply   |   29120|
|apply   |   26050|
|apply   |   25080|
|apply   |   24960|
|forloop | 2166083|
|forloop | 2178383|
|apply   |   86910|
|forloop | 2063952|
|apply   |   28429|
|forloop | 2058554|
|apply   |   28640|
|apply   |   24529|
|apply   |   24800|
|apply   |   25100|
|forloop | 2254663|
|forloop | 2563764|
|forloop | 2141103|
|forloop | 9190103|
|apply   |   31740|
|apply   |   25720|
|forloop | 2207533|
|apply   |   30670|
|apply   |   24230|
|apply   |   33020|
|forloop | 2548634|
|forloop | 2943604|
|forloop | 2575144|
|forloop | 2308653|
|apply   |   43850|
|apply   |   26340|
|forloop | 2093123|
|forloop | 2193533|
|forloop | 2051633|
|apply   |   29650|
|apply   |   25100|
|apply   |   24860|
|forloop | 2309114|
|forloop | 2192723|
|apply   |   29910|
|forloop | 1885773|
|apply   |   29390|
|forloop | 1954923|
|forloop | 2301213|
|apply   |   29290|
|apply   |   25140|
|apply   |   23940|
|forloop | 2086943|
|forloop | 1969823|
|forloop | 2020323|
|apply   |   28640|
|apply   |   24110|
|forloop | 1958462|
|apply   |   53989|
|forloop | 2000812|
|apply   |   27440|
|forloop | 2006742|
|forloop | 2337614|
|forloop | 2043933|
|forloop | 1978323|
|apply   |   28380|
|apply   |   24890|
|apply   |   24690|
|forloop | 1875602|
|forloop | 2231444|
|apply   |   29480|
|apply   |   26641|
|apply   |   24900|
|apply   |   24710|
|apply   |   24750|
|apply   |   24210|
|apply   |   24540|
|forloop | 2017563|
|apply   |   27670|
|apply   |   24880|
|forloop | 2014493|
|forloop | 2042413|
|apply   |   29210|
|forloop | 2163403|
|apply   |   28490|
|apply   |   25030|
|forloop | 2106083|
|apply   |   29430|
|apply   |   25220|
|forloop | 2065493|
|forloop | 1989923|
|apply   |   70730|
|apply   |   46970|
|apply   |   25140|
|forloop | 2081693|
|forloop | 2229893|
|apply   |   31440|
|forloop | 2351923|
|forloop | 2454133|
|apply   |   28440|
|apply   |   24980|
|apply   |   24670|
|forloop | 1980953|
|apply   |   28770|
|forloop | 2281753|
|forloop | 2196094|
|forloop | 2244673|
|apply   |   31370|
|forloop | 6129599|
|apply   |   28900|
|apply   |   24420|
|apply   |   23960|
|forloop | 1936342|
|forloop | 1964173|
|forloop | 1865893|
|forloop | 1860043|
|apply   |   27650|
|apply   |   24600|
|forloop | 1998263|
|apply   |   46690|
|apply   |   42410|
|forloop | 2288253|
|forloop | 2264573|
|forloop | 1976193|
|forloop | 2345994|
|apply   |   30391|
|forloop | 1992632|
|apply   |   28889|
|forloop | 1873562|
|forloop | 2491804|
|apply   |   29530|
|forloop | 2043923|
|apply   |   28720|
|forloop | 2026143|
|apply   |   28500|
|forloop | 1888623|
|forloop | 2042172|
|forloop | 2118553|
|apply   |   28110|
|forloop | 1994642|
|apply   |   29000|
|apply   |   24200|

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
