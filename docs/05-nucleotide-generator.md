
# Session 1: Foundations of Programming in R

## Introduction to R and RStudio (30 minutes)

Brief overview of R and its applications in data analysis and programming.
Introduction to RStudio as an integrated development environment (IDE) for R.
Navigating the RStudio interface: scripts, console, environment, and plots.

## Objects, Variables, and Data Types (1 hour)

Understanding the concept of objects in R: vectors, matrices, data frames, lists.
Assigning values to variables and creating different data types.
Basic operations with objects: arithmetic, indexing, and subsetting.

## Good Coding Practices and Style (1 hour)

Importance of clean and readable code.
Naming conventions for variables, functions, and objects.
Indentation, spacing, and commenting for code clarity.
Introduction to linting tools for code style checking.

## Control Flow: If-Else Statements (1 hour)

Introduction to control structures for conditional execution.
Writing if-else statements for decision-making in code.
Handling multiple conditions using nested if-else statements.

## Writing Functions in R (1 hour)

Understanding the role and benefits of functions in programming.
Creating custom functions using the function() keyword.
Passing arguments to functions and returning values.
Best practices for function design and documentation.

## Hands-On Exercises and Practice (30 minutes)
Interactive coding exercises to reinforce concepts learned.
Applying if-else statements and writing basic functions.
Encouraging participants to practice coding in RStudio.

## Nucleotide generator

### Note use numbers 





```r
# Create a vector representing the nucleotide bases A, T, C, and G
nucleotides <- c("A", "T", "C", "G")
nucleotides
```

```
## [1] "A" "T" "C" "G"
```

To use your nucleotide generator and get a base back, we will use the function `sample()` and sample one element from it. You’ll get a new (maybe different) base each time you roll it:

```
sample(x = nucleotides, size = 1)
## A

sample(x = nucleotides, size = 1)
## C

sample(x = nucleotides, size = 1)
## G
```
Every argument in every R function has a name. You can specify which data should be assigned to which argument by setting a name equal to data, as in the preceding code. This becomes important as you begin to pass multiple arguments to the same function; names help you avoid passing the wrong data to the wrong argument. However, using names is optional. You will notice that R users do not often use the name of the first argument in a function. So you might see the previous code written as:


```r
sample(nucleotides, 1)
```

```
## [1] "A"
```

Often, the name of the first argument is not very descriptive, and it is usually obvious what the first piece of data refers to anyways.

But how do you know which argument names to use? If you try to use a name that a function does not expect, you will likely get an error:


