---
output: html_document
editor_options: 
  chunk_output_type: console
---
# (PART\*) Mixed Models {.unnumbered}

# Foundations of Mixed Modelling








## What is a mixed model?

Mixed models (also known as linear mixed models or hierarchical linear models) are statistical tests that build on the simpler tests of regression, t-tests and ANOVA. All of these tests are special cases of the general linear model; they all fit a straight line to data to explain variance in a systematic way. 

The key difference with a linear mixed-effects model is the inclusion of random effects - variables where our observations are grouped into subcategories that systematically affect our outcome - to account for important structure in our data. 

The mixed-effects model can be used in many situations instead of one of our more straightforward tests when this structure may be important. The main advantages of this approach are: 

i) mixed-effects models account for more of the variance 
ii) mixed-effects models incorporate group and even individual-level differences
iii) mixed-effects models cope well with missing data, unequal group sizes and repeated measurements


## Fixed vs Random effects

Fixed effects and random effects are terms commonly used in mixed modeling, which is a statistical framework that combines both in order to analyze data. 

In mixed modeling, the fixed effects are used to estimate the overall relationship between the predictors and the response variable, while the random effects account for the within-group variability and allow for the modeling of the individual differences or group-specific effects.

The hierarchical structure of data refers to a data organization where observations are nested within higher-level groups or clusters. For example, students nested within classrooms, patients nested within hospitals, or employees nested within companies. This hierarchical structure introduces dependencies or correlations within the data, as observations within the same group tend to be more similar to each other than observations in different groups.

The need for mixed models arises when we want to account for these dependencies and properly model the variability at different levels of the hierarchy. Traditional regression models, such as ordinary least squares (OLS), assume that the observations are independent of each other. However, when working with hierarchical data, this assumption is violated, and ignoring the hierarchical structure can lead to biased or inefficient estimates, incorrect standard errors, and misleading inference.

By including random effects, mixed models allow for the estimation of both within-group and between-group variability. They provide a flexible framework for modeling the individual or group-specific effects and can capture the heterogeneity within and between groups. Additionally, mixed models can handle unbalanced or incomplete data, where some groups may have different numbers of observations.

### Fixed effects

In broad terms, fixed effects are variables that we expect will affect the dependent/response variable: they’re what you call explanatory variables in a standard linear regression. 


Fixed effects are more common than random effects, at least in their use. Fixed effects estimate different levels with no relationship assumed between the levels. For example, in a model with a dependent variable of body length and a fixed effect for fish sex, you would get an estimate of mean body length for males and then an estimate for females separately. 

#### Examples: 

1. Medical Research: In a clinical trial studying the effectiveness of different medications for treating a specific condition, the fixed effects could include categorical variables such as treatment group (e.g., medication A, medication B, placebo) or dosage level (e.g., low, medium, high). These fixed effects would capture the systematic differences in the response variable (e.g., symptom improvement) due to the specific treatment received.

2. Education Research: Suppose a study examines the impact of teaching methods on student performance in different schools. The fixed effects in this case might include variables such as school type (e.g., public, private), curriculum approach (e.g., traditional, progressive), or classroom size. These fixed effects would help explain the differences in student achievement across schools, accounting for the systematic effects of these factors.

3. Environmental Science: Imagine a study investigating the factors influencing bird species richness across different habitats. The fixed effects in this context could include variables such as habitat type (e.g., forest, grassland, wetland), habitat disturbance level (e.g., low, medium, high), or geographical region. These fixed effects would capture the systematic variations in bird species richness associated with the specific habitat characteristics.

Fixed effects are the default effects that we all learn as we begin to understand statistical concepts, and fixed effects are the default effects in functions like `lm()` and `aov()`.

### Random effects

Random effects are less commonly used but perhaps more widely encountered in nature. Each level can be considered a random variable from an underlying process or distribution in a random effect. 

On the other hand, random effects are usually grouping factors for which we are trying to control. They are always categorical, as you can’t force R to treat a continuous variable as a random effect. A lot of the time we are not specifically interested in their impact on the response variable, but we know that they might be influencing the patterns we see.

#### Examples: 

1. Longitudinal Health Study: Consider a study tracking the blood pressure of individuals over multiple time points. In this case, a random effect can be included to account for the individual-specific variation in blood pressure. Each individual's blood pressure measurements over time would be treated as repeated measures within that individual, and the random effect would capture the variability between individuals that is not explained by the fixed effects. This random effect allows for modeling the inherent individual differences in blood pressure levels.

2. Social Network Analysis: Suppose a study examines the influence of peer groups on adolescent behavior. The study may collect data on individual behaviors within schools, where students are nested within classrooms. In this scenario, a random effect can be incorporated at the classroom level to account for the shared social environment within each classroom. The random effect captures the variability in behavior among classrooms that is not accounted for by the fixed effects, enabling the study to analyze the effects of individual-level and classroom-level factors simultaneously.

3. Ecological Study: Imagine a research project investigating the effect of environmental factors on species abundance in different study sites. The study sites may be geographically dispersed, and a random effect can be included to account for the variation between study sites. The random effect captures the unexplained heterogeneity in species abundance across different sites, allowing for the examination of the effects of environmental variables while accounting for site-specific differences.


<div class="info">
<p>In the book “Data analysis using regression and
multilevel/hierarchical models” (<span
class="citation">@gelman_hill_2006</span>). The authors examined five
definitions of fixed and random effects and found no definition that
completely fit all circumstances. Thus it turns out fixed and random
effects are not born but made. We make the decision to treat a variable
as fixed or random in a particular analysis.</p>
</div>

> When determining wht should be a fixed or random effect in your study, consider what are you trying to do? What are you trying to make predictions about? What is just variation (a.k.a “noise”) that you need to control for?

<div class="warning">
<p>More about random effects:</p>
<p>Note that the golden rule is that you generally want your random
effect to have at least five levels. So, for instance, if we wanted to
control for the effects of fish sex on body length, we would fit sex (a
two level factor: male or female) as a fixed, not random, effect.</p>
<p>This is, put simply, because estimating variance on few data points
is very imprecise. Mathematically you could, but you wouldn’t have a lot
of confidence in it. If you only have two or three levels, the model
will struggle to partition the variance - it will give you an output,
but not necessarily one you can trust.</p>
<p>Finally, keep in mind that the name random doesn’t have much to do
with mathematical randomness. Yes, it’s confusing. Just think about them
as the grouping variables for now. Strictly speaking it’s all about
making our models representative of our questions and getting better
estimates. Hopefully, our next few examples will help you make sense of
how and why they’re used.</p>
<p>There’s no firm rule as to what the minimum number of factor levels
should be for random effect and really you can use any factor that has
two or more levels. However it is commonly reported that you may want
five or more factor levels for a random effect in order to really
benefit from what the random effect can do (though some argue for even
more, 10 levels). Another case in which you may not want to random
effect is when you don’t want your factor levels to inform each other or
you don’t assume that your factor levels come from a common
distribution. As noted above, male and female is not only a factor with
only two levels but oftentimes we want male and female information
estimated separately and we’re not necessarily assuming that males and
females come from a population of sexes in which there is an infinite
number and we’re interested in an average.</p>
</div>

## Why use mixed models?

The provided code generates a dataset that is suitable for testing mixed models. Let's break down the code and annotate each step:



This section creates a data frame called rand_eff containing random effects. It consists of five levels of a grouping variable (group), and for each level, it generates random effects (b0 and b1) using the `rnorm` function.


```r
data <- expand.grid(group = as.factor(seq(1:10)), 
                    obs = as.factor(seq(1:100))) %>%
  left_join(rand_eff,
            by = "group") %>%
  mutate(x = runif(n = nrow(.), 0, 10),
         B0 = 20,
         B1 = 2,
         E = rnorm(n = nrow(.), 0, 10)) %>%
  mutate(y = B0 + b0 + x * (B1 + b1) + E)

data <- expand.grid(group = as.factor(seq(1:4)), 
                    obs = as.factor(seq(1:100)))
```

This section creates the main dataset (data) for testing mixed models. It uses `expand.grid` to create a combination of levels for the grouping variable (group) and observation variable (obs). It then performs a `left join` with the rand_eff data frame, matching the group variable to incorporate the random effects for each group.

The code continues to `mutate` the dataset by adding additional variables:

- x is a random predictor variable generated using `runif` to have values between 0 and 10.

- B0 and B1 represent fixed effects of the intercept and slope with predetermined values of 20 and 2, respectively.

- E represents the error term, generated using `rnorm` with a mean of 0 and standard deviation of 10.

- Finally, y is created as the response variable using a linear model equation that includes the fixed effects (B0 and B1), random effects (b0 and b1), the predictor variable (x), and the error term (E).



```r
data.1 <- expand.grid(group = as.factor(5),
          obs = as.factor(seq(1:30)))

data <- bind_rows(data, data.1) %>% 
  left_join(rand_eff,
            by = "group") %>%
  mutate(x = runif(n = nrow(.), 0, 10),
         B0 = 20,
         B1 = 2,
         E = rnorm(n = nrow(.), 0, 10)) %>%
  mutate(y = B0 + b0 + x * (B1 + b1) + E)
```

This section creates an additional dataset (data.1) with a specific group (group = 5) and a smaller number of observations (obs = 30) for testing purposes. This is then appended to the original dataset, we will see the effect of having a smaller group within our random effects when we discuss partial pooling and shrinkage later on. 


Now we have three variables to consider in our models: x, y and group (with five levels).


```r
data %>% 
  select(x, y, group, obs) %>% 
  head()
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> x </th>
   <th style="text-align:right;"> y </th>
   <th style="text-align:left;"> group </th>
   <th style="text-align:left;"> obs </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 4.0584411 </td>
   <td style="text-align:right;"> -0.5487802 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7.2250893 </td>
   <td style="text-align:right;"> 17.3260398 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 0.5963383 </td>
   <td style="text-align:right;"> 41.2256737 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3.3034922 </td>
   <td style="text-align:right;"> 16.0958571 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7.7676400 </td>
   <td style="text-align:right;"> 32.0586590 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8.4045935 </td>
   <td style="text-align:right;"> 50.1274193 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2 </td>
  </tr>
</tbody>
</table>

</div>

Now that we have a suitable simulated dataset, let's start modelling!

### All in one model

We will begin by highlighting the importance of considering data structure and hierarchy when building linear models. To illustrate this, we will delve into an example that showcases the consequences of ignoring the underlying data structure. We might naively construct a single linear model that ignores the group-level variation and treats all observations as independent. This oversimplified approach fails to account for the fact that observations within groups are more similar to each other due to shared characteristics.

$$Y_i = \beta_0 + \beta_1X_i + \epsilon_i$$



```r
basic_model <- lm(y ~ x, data = data)
summary(basic_model)
```

```
## 
## Call:
## lm(formula = y ~ x, data = data)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -37.23 -12.11  -2.36  11.00  44.53 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  21.0546     1.6490  12.768   <2e-16 ***
## x             2.5782     0.2854   9.034   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 16.96 on 428 degrees of freedom
## Multiple R-squared:  0.1602,	Adjusted R-squared:  0.1582 
## F-statistic: 81.62 on 1 and 428 DF,  p-value: < 2.2e-16
```

Here we can see that the basic linear model has produced a statistically significant regression analysis (*t*~998~ = 11.24, *p* <0.001) with an R^2 of 0.11. There is a medium effect positive relationship between changes in x and y (Estimate = 2.765, S.E. = 0.25).

We can see that clearly if we produce a simple plot of x against y: 


```r
plot(data$x, data$y)
```

<div class="figure" style="text-align: center">
<img src="01-mixed-model_files/figure-html/unnamed-chunk-10-1.png" alt="Simple scatter plot x against y" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-10)Simple scatter plot x against y</p>
</div>

Here if we use the function `geom_smooth()` on the scatter plot, the plot also includes a fitted regression line obtained using the "lm" method. This allows us to examine the overall trend and potential linear association between the variables.


```r
ggplot(data, aes(x = x, 
                 y = y)) +
  geom_point() +
  labs(x = "Independent Variable", 
       y = "Dependent Variable")+
  geom_smooth(method = "lm")
```

<div class="figure" style="text-align: center">
<img src="01-mixed-model_files/figure-html/unnamed-chunk-11-1.png" alt="Scatter plot displaying the relationship between the independent variable and the dependent variable. The points represent the observed data, while the fitted regression line represents the linear relationship between the variables. The plot helps visualize the trend and potential association between the variables." width="100%" />
<p class="caption">(\#fig:unnamed-chunk-11)Scatter plot displaying the relationship between the independent variable and the dependent variable. The points represent the observed data, while the fitted regression line represents the linear relationship between the variables. The plot helps visualize the trend and potential association between the variables.</p>
</div>
The `check_model`  function from the `performance` package (@R-performance) is used to evaluate the performance and diagnostic measures of a statistical model. It provides a comprehensive assessment of the model's fit, assumptions, and predictive capabilities. By calling this function, you can obtain a summary of various evaluation metrics and diagnostic plots for the specified model. 

It enables you to identify potential issues, such as violations of assumptions, influential data points, or lack of fit, which can affect the interpretation and reliability of your model's results


```r
performance::check_model(basic_model)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-12-1.png" width="100%" style="display: block; margin: auto;" />

Looking at the fit of our model we would be tempted to conclude that we have an accurate and robust model.

However, when data is hierarchically structured, such as individuals nested within groups, there is typically correlation or similarity among observations within the same group. By not accounting for this clustering effect, estimates derived from a single model can be biased and inefficient. The assumption of independence among observations is violated, leading to incorrect standard errors and inflated significance levels. 

From the figure below we can see the difference in median and range of x values within each of our groups: 


```r
ggplot(data, aes(x = group, 
                 y = y)) +
  geom_boxplot() +
  labs(x = "Groups", 
       y = "Dependent Variable")
```

<div class="figure" style="text-align: center">
<img src="01-mixed-model_files/figure-html/unnamed-chunk-13-1.png" alt="Linear model conducted on all data" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-13)Linear model conducted on all data</p>
</div>

In this figure,  we colour tag the data points by group, this can be useful for determining if a mixed model is appropriate.

Here's why:

By colour-coding the data points based on the grouping variable, the plot allows you to visually assess the within-group and between-group variability. If there are noticeable differences in the data patterns or dispersion among the groups, it suggests that the data may have a hierarchical structure, where observations within the same group are more similar to each other than to observations in other groups.


```r
# Color tagged by group
plot_group <- ggplot(data, aes(x = x, 
                               y = y, 
                               color = group,
                               group = group)) +
  geom_point(alpha = 0.6) +
  labs(title = "Data Coloured by Group", 
       x = "Independent Variable", 
       y = "Dependent Variable")+
  theme(legend.position="none")

plot_group
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-14-1.png" width="100%" style="display: block; margin: auto;" />
From the above plots, it confirms that our observations from within each of the ranges aren’t independent. We can’t ignore that: as we’re starting to see, it could lead to a completely erroneous conclusion.


### Multiple analyses approach

Running separate linear models per group, also known as stratified analysis, can be a feasible approach in certain situations. However, there are several drawbacks including

- Increased complexity

- Inability to draw direct conclusions on overall variability 

- Reduced statistical power

- Inflated Type 1 error risk

- Inconsistent estimates

- Limited ability to handle unbalanced/missing data


```r
# Plotting the relationship between x and y with group-level smoothing
ggplot(data, aes(x = x, y = y, color = group, group = group)) +
  geom_point(alpha = 0.6) +  # Scatter plot of x and y with transparency
  labs(title = "Data Colored by Group", x = "Independent Variable", y = "Dependent Variable") +
  theme(legend.position = "none") +
  geom_smooth(method = "lm") +  # Group-level linear regression smoothing
  facet_wrap(~group)  # Faceting the plot by group
```

<div class="figure" style="text-align: center">
<img src="01-mixed-model_files/figure-html/unnamed-chunk-15-1.png" alt="Scatter plot showing the relationship between the independent variable (x) and the dependent variable (y) colored by group. Each subplot represents a different group. The line represents the group-level linear regression smoothing." width="100%" />
<p class="caption">(\#fig:unnamed-chunk-15)Scatter plot showing the relationship between the independent variable (x) and the dependent variable (y) colored by group. Each subplot represents a different group. The line represents the group-level linear regression smoothing.</p>
</div>



```r
# Creating nested data by grouping the data by 'group'
nested_data <- data %>%
  group_by(group) %>%
  nest()

# Fitting linear regression models to each nested data group
models <- map(nested_data$data, ~ lm(y ~ x, data = .)) %>% 
          map(broom::tidy)

# Combining the model results into a single data frame
combined_models <- bind_rows(models)

# Filtering the rows to include only the 'x' predictor
filtered_models <- combined_models %>%
                   filter(term == "x")

# Adding a column for the group index using rowid_to_column function
group_indexed_models <- filtered_models %>%
                        rowid_to_column("group")

# Modifying the p-values using a custom function report_p
final_models <- group_indexed_models %>%
                mutate(p.value = report_p(p.value))

final_models
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> group </th>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> 3.0643940 </td>
   <td style="text-align:right;"> 0.3620254 </td>
   <td style="text-align:right;"> 8.4645823 </td>
   <td style="text-align:left;"> p &lt; 0.001 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> 2.5162898 </td>
   <td style="text-align:right;"> 0.3354848 </td>
   <td style="text-align:right;"> 7.5004590 </td>
   <td style="text-align:left;"> p &lt; 0.001 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> 1.3904720 </td>
   <td style="text-align:right;"> 0.3192878 </td>
   <td style="text-align:right;"> 4.3549169 </td>
   <td style="text-align:left;"> p &lt; 0.001 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> 1.6856649 </td>
   <td style="text-align:right;"> 0.3550511 </td>
   <td style="text-align:right;"> 4.7476686 </td>
   <td style="text-align:left;"> p &lt; 0.001 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> -0.0755633 </td>
   <td style="text-align:right;"> 0.6576868 </td>
   <td style="text-align:right;"> -0.1148926 </td>
   <td style="text-align:left;"> p= 0.909 </td>
  </tr>
</tbody>
</table>

</div>

In the code above, the dataset data is first grouped by the variable 'group' using the `group_by` function, and then the data within each group is nested using the `nest` function. This results in a new dataset nested_data where each group's data is stored as a nested tibble.

Next, a linear regression model (`lm`) is fit to each nested data group using the `map` function. The `broom::tidy` function is applied to each model using map to extract the model summary statistics, such as coefficients, p-values, and standard errors. The resulting models are stored in the models object.

The `bind_rows` function is used to combine the model results into a single data frame called combined_models. The data frame is then filtered to include only the rows where the predictor is 'x' using the `filter` function, resulting in the filtered_models data frame.

To add a column for the group index, the `rowid_to_column` function is applied to the filtered_models data frame, creating the group_indexed_models data frame with an additional column named 'group'.

Finally, the p-values in the group_indexed_models data frame are modified using a custom function `report_p`


<div class='webex-solution'><button>report_p function</button>



```r
 report_p <- function(p, digits = 3) {
     reported <- if_else(p < 0.001,
             "p < 0.001",
             paste("p=", round(p, digits)))
     
     return(reported)
 }
```


</div>


### Complex model

Using a group level term with an interaction on x as a fixed effect means explicitly including the interaction term between x and the group as a predictor in the model equation. This approach assumes that the relationship between x and the outcome variable differs across groups and that these differences are constant and fixed. It implies that each group has a unique intercept (baseline level) and slope (effect size) for the relationship between x and the outcome variable. By treating the group level term as a fixed effect, the model estimates *specific parameter values for each group*.

If we are not explicitly interested in the outcomes or differences for each individual group (but wish to account for them) - this may not be the best option as it can lead to *overfitting* and it uses a lot more degrees of freedom - impacting estimates and widening our confidence intervals. As with running multiple models above, there is limited ability to make inferences outside of observed groups, and it does not handle missing data or unbalanced designs well. 

$$Y_i = \beta_0 + \beta_1X_i + \beta_2.group_i+\beta_3(X_i.group_i)+\epsilon_i$$


```r
additive_model <- lm(y ~ x*group, data = data)

summary(additive_model)
```

```
## 
## Call:
## lm(formula = y ~ x * group, data = data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -24.8614  -6.2579   0.2044   6.9342  28.5474 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   6.8125     1.8881   3.608 0.000346 ***
## x             3.0644     0.3379   9.070  < 2e-16 ***
## group2        6.4526     2.7289   2.365 0.018505 *  
## group3       44.8356     2.8539  15.710  < 2e-16 ***
## group4       15.8607     2.7184   5.835 1.08e-08 ***
## group5       22.9090     4.0772   5.619 3.51e-08 ***
## x:group2     -0.5481     0.4875  -1.124 0.261560    
## x:group3     -1.6739     0.4781  -3.501 0.000513 ***
## x:group4     -1.3787     0.4830  -2.855 0.004522 ** 
## x:group5     -3.1400     0.7479  -4.198 3.28e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 9.801 on 420 degrees of freedom
## Multiple R-squared:  0.7246,	Adjusted R-squared:  0.7187 
## F-statistic: 122.8 on 9 and 420 DF,  p-value: < 2.2e-16
```

## Our first mixed model

A mixed model is a good choice here: it will allow us to use all the data we have (higher sample size) and account for the correlations between data coming from the groups. We will also estimate fewer parameters and avoid problems with multiple comparisons that we would encounter while using separate regressions.

We can now join our random effect matrix to the full dataset and define our y values as 

$$Y_{ij} = \beta_0 + \beta_1X_{ij} + \gamma_{0i} + \gamma_{1i}X_{ij} + \epsilon_{ij}$$.



We have a response variable, and we are attempting to explain part of the variation in test score through fitting an independent variable as a fixed effect. But the response variable has some residual variation (i.e. unexplained variation) associated with group. By using random effects, we are modeling that unexplained variation through variance.

We now want to know if an association between `y ~ x` exists after controlling for the variation in group.

### Running mixed effects models with lmerTest

This section will detail how to run mixed models with the `lmer` function in the R package `lmerTest` (@R-lmerTest). This builds on the older `lme4` (@R-lme4) package, and in particular add p-values that were not previously included. There are other R packages that can be used to run mixed-effects models including the `nlme` package (@R-nlme) and the `glmmTMB` package (@R-glmmTMB). Outside of R there are also other packages and software capable of running mixed-effects models, though arguably none is better supported than R software.


<div class='webex-solution'><button>Plotting random intercepts</button>


```r
plot_function2 <- function(model, title = "Data Coloured by Group"){
  
data <- data %>% 
  mutate(fit.m = predict(model, re.form = NA),
         fit.c = predict(model, re.form = NULL))

data %>%
  ggplot(aes(x = x, y = y, col = group)) +
  geom_point(pch = 16, alpha = 0.6) +
  geom_line(aes(y = fit.c, col = group), linewidth = 2)  +
  coord_cartesian(ylim = c(-40, 100))+
  labs(title = title, 
       x = "Independent Variable", 
       y = "Dependent Variable") 
}

mixed_model <- lmer(y ~ x + (1|group), data = data)

plot_function2(mixed_model, "Random intercept")
```


</div>


<img src="01-mixed-model_files/figure-html/unnamed-chunk-20-1.png" width="100%" style="display: block; margin: auto;" />


```r
# random intercept model
mixed_model <- lmer(y ~ x + (1|group), data = data)

summary(mixed_model)
```

```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method [
## lmerModLmerTest]
## Formula: y ~ x + (1 | group)
##    Data: data
## 
## REML criterion at convergence: 3224.4
## 
## Scaled residuals: 
##      Min       1Q   Median       3Q      Max 
## -2.61968 -0.63654 -0.03584  0.66113  3.13597 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  group    (Intercept) 205      14.32   
##  Residual             101      10.05   
## Number of obs: 430, groups:  group, 5
## 
## Fixed effects:
##             Estimate Std. Error       df t value Pr(>|t|)    
## (Intercept)  23.2692     6.4818   4.1570    3.59   0.0215 *  
## x             2.0271     0.1703 424.0815   11.90   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##   (Intr)
## x -0.131
```


Here our groups clearly explain a lot of variance 

```

205/(205 + 101) = 0.669 / 66.9%

```

So the differences between groups explain ~67% of the variance that’s “left over” *after* the variance explained by our fixed effects.


### Partial pooling

It is worth noting that random effect estimates are a function of the group-level information and the overall (grand) mean of the random effect. Group levels with low sample size or poor information (i.e., no strong relationship) are more strongly influenced by the grand mean, which adds information to an otherwise poorly-estimated group. However, a group with a large sample size or strong information (i.e., a strong relationship) will have very little influence from the grand mean and largely reflect the information contained entirely within the group. This process is called partial pooling (as opposed to no pooling, where no effect is considered, or total pooling, where separate models are run for the different groups). Partial pooling results in the phenomenon known as shrinkage, which refers to the group-level estimates being shrunk toward the mean. What does all this mean? If you use a random effect, you should be prepared for your factor levels to have some influence from the overall mean of all levels. With a good, clear signal in each group, you won’t see much impact from the overall mean, but you will with small groups or those without much signal.

Below we can take a look at the estimates and standard errors for three of our previously constructed models:


```r
pooled <- basic_model %>% 
  broom::tidy() %>% 
  mutate(Approach = "Pooled", .before = 1) %>% 
  select(term, estimate, std.error, Approach)

no_pool <- additive_model %>% 
  broom::tidy() %>% 
  mutate(Approach = "No Pooling", .before = 1) %>% 
  select(term, estimate, std.error, Approach)

partial_pool <- mixed_model %>% 
  broom.mixed::tidy() %>% 
  mutate(Approach = "Mixed Model/Partial Pool", .before = 1) %>% 
  select(Approach, term, estimate, std.error)

bind_rows(pooled, no_pool, partial_pool) %>% 
  filter(term %in% c("x" , "(Intercept)") )
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:left;"> Approach </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 21.054614 </td>
   <td style="text-align:right;"> 1.6490185 </td>
   <td style="text-align:left;"> Pooled </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> 2.578217 </td>
   <td style="text-align:right;"> 0.2853798 </td>
   <td style="text-align:left;"> Pooled </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 6.812481 </td>
   <td style="text-align:right;"> 1.8881155 </td>
   <td style="text-align:left;"> No Pooling </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> 3.064394 </td>
   <td style="text-align:right;"> 0.3378685 </td>
   <td style="text-align:left;"> No Pooling </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:right;"> 23.269187 </td>
   <td style="text-align:right;"> 6.4818211 </td>
   <td style="text-align:left;"> Mixed Model/Partial Pool </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x </td>
   <td style="text-align:right;"> 2.027065 </td>
   <td style="text-align:right;"> 0.1703423 </td>
   <td style="text-align:left;"> Mixed Model/Partial Pool </td>
  </tr>
</tbody>
</table>

</div>

Pooling helps to improve the precision of the estimates by borrowing strength from the entire dataset. However, this can also lead to differences in the estimates and standard errors compared to models without pooling. 

- Pooled: in the pooled model the averaged estimates may not accurately reflect the true values within each group. As a result, the estimates in pooled models can be biased towards the average behavior across all groups. We can see this in the too small standard error of the intercept, underestimating the variance in our dataset. At the same time if there is substantial variability in the relationships between groups, the pooled estimates can be less precise. This increased variability across groups can contribute to larger standard errors of the difference (SED) for fixed effects in pooled models.

- No pooling: This model is extremely precise with the smallest errors, however these estimates reflect conditions only for the first group in the model

- Partial pooling/Mixed models: this model reflects the greater uncertainty of the Mean and SE of the intercept. However, the SED in a partial pooling model accounts for both the variability within groups and the uncertainty between groups. Compared to a no pooling approach, the SED in a partial pooling model tends to be smaller because it incorporates the pooled information, which reduces the overall uncertainty. This adjusted SED provides a more accurate measure of the uncertainty associated with the estimated differences between groups or fixed effects.

## Plotting model outcomes

ESTIMATES VS PREDICTIONS


```r
coef(mixed_model)

fixef(mixed_model)
```

```
## $group
##   (Intercept)        x
## 1    11.82356 2.027066
## 2    15.68146 2.027066
## 3    47.94678 2.027066
## 4    21.01028 2.027066
## 5    19.88385 2.027066
## 
## attr(,"class")
## [1] "coef.mer"
## (Intercept)           x 
##   23.269187    2.027066
```



```r
plot_model(mixed_model,type="pred",
           terms=c("x", "group"),
           pred.type="re",
           show.data = T)+
  facet_wrap( ~ group)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-24-1.png" width="100%" style="display: block; margin: auto;" />

```r
###

data1 <- data %>% 
  mutate(fit.m = predict(mixed_model, re.form = NA),
         fit.c = predict(mixed_model, re.form = NULL))

data1 %>% 
  ggplot(aes(x = x, y = y, colour = group)) +
    geom_point(pch = 16) + 
  geom_line(aes(y = fit.c))+ 
  geom_line(aes(y = fit.m), colour = "grey",
            linetype = "dashed")+
  facet_wrap( ~ group)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-24-2.png" width="100%" style="display: block; margin: auto;" />


http://optimumsportsperformance.com/blog/making-predictions-from-a-mixed-model-using-r/


```r
plot_model(mixed_model, terms = c("x", "group"), type = "re")
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-25-1.png" width="100%" style="display: block; margin: auto;" />

```r
plot_model(mixed_model, terms = c("x", "group"), type = "est")
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-25-2.png" width="100%" style="display: block; margin: auto;" />




```r
basic_pred <- emmeans(basic_model, specs = ~  x, at = list(x = c(0, 2.5, 5, 7.5, 10))) %>% as_tibble()

mixed_pred <- emmeans(mixed_model, specs = ~  x, at = list(x = c(0, 2.5, 5, 7.5, 10))) %>% as_tibble()

pooled_plot <- data %>%
  ggplot(aes(x = x, y = y)) +
  geom_point(pch = 16, alpha = 0.6, aes(col = group)) +
  geom_line(aes(x = x, y = emmean), linewidth = 1, data = basic_pred) +
  geom_line(aes(x = x, y = lower.CL), linewidth = 0.5, linetype = 2, col = "gray50", data = basic_pred) +
  geom_line(aes(x = x, y = upper.CL), linewidth = 0.5, linetype = 2, col = "gray50", data = basic_pred) +
  coord_cartesian(ylim = c(0, 70))+
  labs(title = "Pooled model",
       x = "Independent Variable", 
       y = "Dependent Variable") +
  theme(legend.position = "none")

partial_plot <- data %>%
  ggplot(aes(x = x, y = y)) +
  geom_point(pch = 16, alpha = 0.6, aes(col = group)) +
  geom_line(aes(x = x, y = emmean), linewidth = 1, data = basic_pred) +
  geom_line(aes(x = x, y = lower.CL), linewidth = 0.5, linetype = 2, col = "gray50", data = mixed_pred) +
  geom_line(aes(x = x, y = upper.CL), linewidth = 0.5, linetype = 2, col = "gray50", data = mixed_pred) +
  coord_cartesian(ylim = c(0, 70))+
  labs(title = "Mixed model",
       x = "Independent Variable", 
       y = "Dependent Variable") +
  theme(legend.position = "none")

pooled_plot /
  partial_plot
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-26-1.png" width="100%" style="display: block; margin: auto;" />


### `ggeffects`

#### `ggpredict`

The argument `type = random` in the `ggpredict` function (from the ggeffects package @R-ggeffects) is used to specify the type of predictions to be generated in the context of mixed effects models. The main difference between using `ggpredict` with and without `type = random` lies in the type of predictions produced:

Without `type = random`: `ggpredict` will generate **fixed-effects predictions**. These predictions are based solely on the fixed effects of the model, ignoring any variability associated with the random effects. The resulting predictions represent the average or expected values of the response variable for specific combinations of predictor values, considering only the fixed components of the model.

With `type = random`: ggpredict will generate predictions that **incorporate both fixed and random effects**. These predictions take into account the variability introduced by the random effects in the model. The resulting predictions reflect not only the average trend captured by the fixed effects but also the additional variability associated with the random effects at different levels of the grouping factor(s).

#### `ggemmeans`

### `sjPlot`

SHRINKAGE! 

BLUP - Hector book! 


## Checking model assumptions


```r
plot(mixed_model) 
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-27-1.png" width="100%" style="display: block; margin: auto;" />


```r
qqnorm(resid(mixed_model))
qqline(resid(mixed_model)) 
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-28-1.png" width="100%" style="display: block; margin: auto;" />


```r
rand_dist <- as.data.frame(ranef(mixed_model)) %>% 
  mutate(group = grp,
         b0_hat = condval,
         intercept_cond = b0_hat + summary(mixed_model)$coef[1,1],
         .keep = "none")

hist(rand_dist$b0_hat)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-29-1.png" width="100%" style="display: block; margin: auto;" />



```r
data1 %>%
  ggplot(aes(x = x, y = y)) +
  geom_point(pch = 16, col = "grey") +
  geom_violinhalf(data = rand_dist, 
                  aes(x = 0, y = intercept_cond), 
                  trim = FALSE, 
                  width = 4, 
                  adjust = 2, 
                  fill = NA)+
  geom_line(aes(y = fit.m), linewidth = 2)  +
  coord_cartesian(ylim = c(-40, 100))+
  labs(x = "Independent Variable", 
       y = "Dependent Variable")
```

<div class="figure" style="text-align: center">
<img src="01-mixed-model_files/figure-html/unnamed-chunk-30-1.png" alt="Marginal fit, heavy black line from the random effect model with a histogram of the of the distribution of conditional intercepts" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-30)Marginal fit, heavy black line from the random effect model with a histogram of the of the distribution of conditional intercepts</p>
</div>

`re.form = NA`: When re.form is set to NA, it indicates that the random effects should be ignored during prediction. This means that the prediction will be based solely on the fixed effects of the model, ignoring the variation introduced by the random effects. This is useful when you are interested in estimating the overall trend or relationship described by the fixed effects, without considering the specific random effects of individual groups or levels.

`re.form = NULL`: Conversely, when re.form is set to NULL, it indicates that the random effects should be included in the prediction. This means that the prediction will take into account both the fixed effects and the random effects associated with the levels of the random effect variable. The model will use the estimated random effects to generate predictions that account for the variation introduced by the random effects. This is useful when you want to visualize and analyze the variation in the response variable explained by different levels of the random effect.


```r
performance::check_model(mixed_model)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-31-1.png" width="100%" style="display: block; margin: auto;" />



```r
resid.mm <- DHARMa::simulateResiduals(mixed_model)

plot(resid.mm)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-32-1.png" width="100%" style="display: block; margin: auto;" />


<div class="warning">
<p>When you have a lot of data, even minimal deviations from the
expected distribution will become significant (this is discussed in the
help/vignette for the DHARMa package). You will need to assess the
distribution and decide if it is important for yourself.</p>
</div>



## Practice Questions


# Types of Random Effects

## Is it a fixed or random effect?

BAKER BOOK

MISSING DATA BAKER BOOK

## Crossed or Nested

https://www.muscardinus.be/2017/07/lme4-random-effects/


A common issue that causes confusion is this issue of specifying random effects as either  ‘crossed’ or ‘nested’. In reality, the way you specify your random effects will be determined  by your experimental or sampling design (  Schielzeth & Nakagawa, 2013  ). A simple  example can illustrate the difference. Imagine a researcher was interested in understanding  the factors affecting the clutch mass of a passerine bird. They have a study population  spread across five separate woodlands, each containing 30 nest boxes. Every week during  breeding they measure the foraging rate of females at feeders, and measure their  subsequent clutch mass. Some females have multiple clutches in a season and contribute multiple data points. 

Here, female ID is said to be  nested within woodland  : each woodland  contains multiple females unique to that woodland (that never move among woodlands).  The nested random effect controls for the fact that (i) clutches from the same female  are not independent, and (ii) females from the same woodland may have clutch masses  more similar to one another than to females from other woodlands  

Clutch Mass  ∼  Foraging Rate + (1|Woodland/Female ID)  

Now imagine that this is a long-term study, and the researcher returns every year for five  years to continue with measurements. Here it is appropriate fit year as a  crossed  random  effect because every woodland appears multiple times in every year of the dataset, and  females that survive from one year to the next will also appear in multiple years.  

Clutch Mass  ∼  Foraging Rate + (1|Woodland/Female ID)+ (1|Year)  

Understanding whether your experimental/sampling design calls for nested or crossed  random effects is not always straightforward, but it can help to visualise experimental  design by drawing it (see  Schielzeth & Nakagawa, 2013  ;  Fig. 1  ), or tabulating your  observations by these grouping factors (e.g. with the ‘  table’  command in R) to identify  how your data are distributed. We advocate that researchers always ensure that their levels  of random effect grouping variables are uniquely labelled. For example, females are  labelled 1  -  n  in each woodland, the model will try and pool variance for all females  with the same code. Giving all females a unique code makes the nested structure of the  data is implicit, and a model specified as  ∼  (1| Woodland) + (1|FemaleID) would be  identical to the model above. 


<div class="figure" style="text-align: center">

```{=html}
<div class="grViz html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-4742ce309c84006b4955" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-4742ce309c84006b4955">{"x":{"diagram":"\ndigraph boxes_and_circles {\n\n  # a \"graph\" statement\n  graph [overlap = true, fontsize = 10]\n\n  # several \"node\" statements\n  node [shape = box,\n        fontname = Helvetica]\n  I; II; 1; 2; 3; 4; 5; 6\n\n  # several \"edge\" statements\n  I->1 I ->2 I ->3\n  II ->4  II ->5 II ->6\n}\n","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
```

<p class="caption">(\#fig:unnamed-chunk-34)Fully Nested</p>
</div>


<div class="figure" style="text-align: center">

```{=html}
<div class="grViz html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-8015fb63f5c0dd7c2786" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-8015fb63f5c0dd7c2786">{"x":{"diagram":"\ndigraph boxes_and_circles {\n\n  # a \"graph\" statement\n  graph [overlap = true, fontsize = 10]\n\n  # several \"node\" statements\n  node [shape = box,\n        fontname = Helvetica]\n  I; II; 1; 2; 3\n\n  # several \"edge\" statements\n  I->1 I ->2 I ->3\n  II ->1  II ->2 II ->3\n}\n","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
```

<p class="caption">(\#fig:unnamed-chunk-35)Fully Crossed</p>
</div>


<div class="figure" style="text-align: center">

```{=html}
<div class="grViz html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-b1d1c6f9b59552fdce3c" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-b1d1c6f9b59552fdce3c">{"x":{"diagram":"\ndigraph boxes_and_circles {\n\n  # a \"graph\" statement\n  graph [overlap = true, fontsize = 10]\n\n  # several \"node\" statements\n  node [shape = box,\n        fontname = Helvetica]\n  I; II; 1; 2; 3; 4; 5 \n\n  # several \"edge\" statements\n  I->1 I ->2 I ->3\n  II ->1  II ->4 II ->5\n}\n","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
```

<p class="caption">(\#fig:unnamed-chunk-36)Partially Nested/Crossed</p>
</div>


## Random slopes





<img src="01-mixed-model_files/figure-html/unnamed-chunk-38-1.png" width="100%" style="display: block; margin: auto;" />



```r
summary(lmer3)
```

```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method [
## lmerModLmerTest]
## Formula: y ~ x + (x | group)
##    Data: data
## 
## REML criterion at convergence: 3211
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -2.5477 -0.6567  0.0042  0.7018  2.9428 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev. Corr 
##  group    (Intercept) 294.2242 17.1530       
##           x             0.9398  0.9694  -0.65
##  Residual              96.2248  9.8094       
## Number of obs: 430, groups:  group, 5
## 
## Fixed effects:
##             Estimate Std. Error      df t value Pr(>|t|)  
## (Intercept)  24.3285     7.7423  4.0342   3.142   0.0344 *
## x             1.8297     0.4708  3.2059   3.887   0.0268 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##   (Intr)
## x -0.641
## optimizer (nloptwrap) convergence code: 0 (OK)
## Model failed to converge with max|grad| = 0.00241 (tol = 0.002, component 1)
```


```r
data.2 <- data %>% 
  mutate(fit2.m = predict(lmer3, re.form = NA),
         fit2.c = predict(lmer3, re.form = NULL),
         resid2 = resid(lmer3))
```


## Random effect correlation

Understanding Group Structure: The correlation of random effects provides insight into the inherent structure of the groups in the data. It reveals the degree of similarity or dissimilarity between the random effects associated with different groups. This information helps to uncover patterns of clustering or similarity among the groups, which can be crucial in understanding the underlying mechanisms or processes being studied.

Modeling Assumptions: The correlation of random effects is directly linked to the assumptions made about the covariance structure of the random effects in the model. By reporting the correlation, researchers can assess the validity of their modeling assumptions. Violations or deviations from the assumed correlation structure may indicate a need for alternative modeling approaches or further investigation into the nature of the group-level variability.


```r
rand_dist2 <- as.data.frame(ranef(lmer3)) %>% 
  mutate(group = grp,
          term = case_when(term == "(Intercept)" ~ "b0_hat",
                             term == "x" ~ "b1_hat"),
            value = condval,
         .keep = "none") %>%
  pivot_wider(id_cols = "group", names_from = "term", values_from = "value") %>%
  mutate(Intercept_cond = b0_hat + summary(lmer3)$coef[1,1],
         Slope_cond = b1_hat + summary(lmer3)$coef[2,1])

pmain <- rand_dist2 %>%
  ggplot(aes(x = Intercept_cond, y = Slope_cond)) +
    geom_point(aes(col = group), size = 3) +
    geom_density2d(bins = 4, col = "grey", adjust = 3)+
  theme(legend.position = "none")

xdens <- ggplot()+
  geom_density(data = rand_dist2, aes(x = Intercept_cond), fill = "grey", col = NA, trim = FALSE, adjust = 2) +
  theme_void()

ydens <- ggplot()+
  geom_density(data = rand_dist2, aes(x = Slope_cond), fill = "grey", col = NA, trim = FALSE, adjust = 2) +
  coord_flip()+
  theme_void()

layout <- "
AAA#
BBBC
BBBC
BBBC"


inset <- xdens+pmain+ydens +plot_layout(design = layout)

inset
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-41-1.png" width="100%" style="display: block; margin: auto;" />






```r
((plot_function(lmer1, "Random intercept")+theme_classic())+coord_cartesian(
                    ylim = c(0, 120))) + inset_element(inset, 0.1, 0.6, 0.5, 1)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-43-1.png" width="100%" style="display: block; margin: auto;" />


## Model refining

SEE BELOW! 


# Complex designs





```{=html}
<a href="https://raw.githubusercontent.com/UEABIO/intro-mixed-models/main/book/files/Biodepth.txt">
<button class="btn btn-success"><i class="fa fa-save"></i> Download BIODEPTH data</button>
</a>
```



```r
biodepth <- biodepth %>% 
  mutate(Mix = factor(Mix),
         Diversity2 = log(Diversity, 2)) %>% 
  drop_na()

# set Mix as a factor
# Set Diversity to log, base 2
```



```r
bio.lmer1 <- lmer(Shoot2 ~ Diversity2 + (1|Site) + (1|Block) + (1|Mix), data = biodepth)

summary(bio.lmer1)
```

```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method [
## lmerModLmerTest]
## Formula: Shoot2 ~ Diversity2 + (1 | Site) + (1 | Block) + (1 | Mix)
##    Data: biodepth
## 
## REML criterion at convergence: 6082.6
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -2.2187 -0.5179 -0.1031  0.3941  3.1735 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  Mix      (Intercept) 33665.3  183.48  
##  Block    (Intercept)   383.2   19.57  
##  Site     (Intercept) 30163.9  173.68  
##  Residual             22039.8  148.46  
## Number of obs: 451, groups:  Mix, 192; Block, 15; Site, 8
## 
## Fixed effects:
##             Estimate Std. Error      df t value Pr(>|t|)    
## (Intercept)  349.488     66.244   8.576   5.276 0.000598 ***
## Diversity2    78.901     12.059 175.159   6.543 6.42e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##            (Intr)
## Diversity2 -0.286
```


In the 1 | Site:Mix specification, the random effect is specified as a two-way crossed random effect. It means that the random effect varies independently for each combination of levels in the Site and Mix factors. The : operator represents the interaction or crossed effect between the two factors. This specification allows for correlations between random effects within each combination of Site and Mix.

On the other hand, the 1 | Site/Mix specification represents a nested random effect structure. It suggests that the random effect of Mix is nested within the random effect of Site. This specification assumes that the levels of Mix are nested within each level of Site, meaning that each level of Site has its own set of random effects for the levels of Mix. The / operator denotes the nesting relationship.

To summarize:

1 | Site:Mix: Two-way crossed random effect, allowing for independent variation of random effects for each combination of levels in Site and Mix.
1 | Site/Mix: Nested random effect, with the random effect of Mix nested within the random effect of Site, assuming that the levels of Mix are nested within each level of Site.


```r
bio.lmer2 <- lmer(Shoot2 ~ Diversity2 + (Diversity2|Site) + (1|Block) + (1|Mix), data = biodepth)

summary(bio.lmer2)
```

```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method [
## lmerModLmerTest]
## Formula: Shoot2 ~ Diversity2 + (Diversity2 | Site) + (1 | Block) + (1 |  
##     Mix)
##    Data: biodepth
## 
## REML criterion at convergence: 6072.6
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -2.1292 -0.5208 -0.1004  0.3739  3.2865 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev. Corr
##  Mix      (Intercept) 31421.7  177.26       
##  Block    (Intercept)   391.6   19.79       
##  Site     (Intercept) 18930.9  137.59       
##           Diversity2   1149.9   33.91   1.00
##  Residual             21995.1  148.31       
## Number of obs: 451, groups:  Mix, 192; Block, 15; Site, 8
## 
## Fixed effects:
##             Estimate Std. Error      df t value Pr(>|t|)    
## (Intercept)  346.070     54.362   8.734   6.366 0.000149 ***
## Diversity2    79.181     16.855  11.289   4.698 0.000608 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##            (Intr)
## Diversity2 0.399 
## optimizer (nloptwrap) convergence code: 0 (OK)
## boundary (singular) fit: see help('isSingular')
```


## Likelihood tests


```r
bio.lmer3 <- lmer(Shoot2 ~ Diversity2 + (Diversity2|Site) + (1|Mix), data = biodepth)

anova(bio.lmer2, bio.lmer3)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> npar </th>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> logLik </th>
   <th style="text-align:right;"> deviance </th>
   <th style="text-align:right;"> Chisq </th>
   <th style="text-align:right;"> Df </th>
   <th style="text-align:right;"> Pr(&gt;Chisq) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> bio.lmer3 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 6104.437 </td>
   <td style="text-align:right;"> 6133.217 </td>
   <td style="text-align:right;"> -3045.218 </td>
   <td style="text-align:right;"> 6090.437 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bio.lmer2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 6105.697 </td>
   <td style="text-align:right;"> 6138.589 </td>
   <td style="text-align:right;"> -3044.849 </td>
   <td style="text-align:right;"> 6089.697 </td>
   <td style="text-align:right;"> 0.7395044 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.3898197 </td>
  </tr>
</tbody>
</table>

</div>


There is a literature on the idea of model selection, that is, an automated (or sometimes manual) way of testing many versions of a model with a different subset of the predictors in an attempt to find the model that fits best. These are sometimes called “stepwise” procedures.

This method has a number of flaws, including

Doing this is basically “p-value mining”, that is, running a lot of tests till you find a p-value you like.
Your likelihood of making a false positive is very high.
As we saw earlier, adding a new variable can have an effect on existing predictors.
Instead of doing model selection, you should use your knowledge of the data to select a subset of the variables which are either a) of importance to you, b) theoretically influential on the outcome (e.g. demographic variables) or c) what others (reviewers) would think are influential on the outcome. Then you can fit a single model including all of this. The “subset” can be all predictors if the sample size is sufficient.

Note that adjustments to fix assumptions (e.g. transformations) or multicollinearity would not fall into the category of model selection and are fine to use.


<div class="info">
<p>ML and REML</p>
</div>






```r
nested_data <- biodepth %>% 
    group_by(Site) %>% 
    nest()

models <- map(nested_data$data, ~ lm(Shoot2 ~ Diversity2, data = .)) %>% 
    map(predict)
```



```r
biodepth.2 <- biodepth %>% 
    mutate(fit.m = predict(bio.lmer2, re.form = NA),
           fit.c = predict(bio.lmer2, re.form = ~(1+Diversity2|Site)),
           fit.l = unlist(models))

biodepth.2 %>% 
    ggplot(aes(x = Diversity2, y = Shoot2, colour = Site)) +
    geom_point(pch = 16) + 
    geom_line(aes(y = fit.l), color = "black")+
    geom_line(aes(y = fit.c))+ 
    geom_line(aes(y = fit.m), colour = "grey",
              linetype = "dashed")+
    facet_wrap( ~ Site)+
   coord_cartesian(ylim = c(0, 1200))+
   theme(legend.position = "none")
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-52-1.png" width="100%" style="display: block; margin: auto;" />


# Reporting Mixed Model results

BAKER - `anova()` `ranova()` `MuMIn` `r.squaredGLMM`

## Tables

## Figures

## Write-ups


# Worked Example 1


https://bodowinter.com/tutorial/bw_LME_tutorial.pdf



```r
politeness <- read_csv("files/politeness_data.csv")

politeness.model.1 = lmer(frequency ~ gender + attitude + (1+attitude|subject) +
                            (1+attitude|scenario),
                        data=politeness)
```

# Worked Example 2 - Dolphins


```{=html}
<a href="https://raw.githubusercontent.com/UEABIO/intro-mixed-models/main/book/files/dolphins.csv">
<button class="btn btn-success"><i class="fa fa-save"></i> Download Dolphins data</button>
</a>
```



DOLPHIN FIXED EFFECTS


```r
dolphmod.1 <- lmer(vt ~ bodymass + direction + (direction|animal), data=dolphins)
dolphmod.2 <- lmer(vt ~ bodymass + direction + (1|animal), data=dolphins)
```


```r
dolphins.1 <- dolphins %>% 
    mutate(fit.m = predict(dolphmod.2, re.form = NA),
           fit.c = predict(dolphmod.2, re.form = NULL))
```



```r
dolphins.1 %>%
  ggplot(aes(x = bodymass, y = vt, group = direction)) +
  geom_point(pch = 16, aes(colour = animal)) +
  geom_line(aes(y = fit.m, 
                linetype = direction), 
            linewidth = 1)  +
  labs(x = "Body Mass", 
       y = "VT") 
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-58-1.png" width="100%" style="display: block; margin: auto;" />



```r
plot_model(dolphmod.2,type="pred",
           terms=c("bodymass", "direction"),
           pred.type="fe",
           show.data = T)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-59-1.png" width="100%" style="display: block; margin: auto;" />

```r
plot_model(dolphmod.2,type="pred",
           terms=c("bodymass", "direction", "animal"),
           pred.type="re",
           show.data = T)
```

<img src="01-mixed-model_files/figure-html/unnamed-chunk-59-2.png" width="100%" style="display: block; margin: auto;" />


# Summary

Here is a suggested workflow:

Start with a model containing only fixed effects: Begin by fitting a model with the fixed effects that are relevant to your research question. Include the main predictors and any potential interactions you hypothesize might exist. For example, if you have predictors A and B, you might start with a model like response ~ A + B + A:B.

Assess fixed effects and interactions: Evaluate the significance, direction, and magnitude of the fixed effects coefficients. Look for interactions that show significant effects and consider their interpretation in the context of your research question. This step allows you to identify the key variables and interactions that are important in explaining the variation in the response variable.

Model evaluation and refinement: Assess the goodness of fit of the fixed effects model using appropriate measures like AIC, BIC, or model deviance. Consider conducting model comparison to evaluate different models with alternative fixed effects structures. This process helps you refine the model and select the most appropriate combination of variables and interactions.

Incorporate random effects: Once you have identified the significant fixed effects and relevant interactions, you can then consider the inclusion of random effects. Random effects capture the variation at different levels and can account for individual differences or clustering within groups. Evaluate the need for random intercepts, random slopes, or crossed random effects based on your research design and the nature of the data.

Assess and compare models with random effects: Fit models with random effects and compare their fit to the fixed effects model. Consider appropriate measures such as likelihood ratio tests, AIC, or BIC for model comparison. Evaluate the significance and contribution of the random effects to the model.

Validate and interpret the final model: Validate the final model by assessing assumptions, checking for influential observations, and performing sensitivity analysis. Interpret the estimated coefficients, including fixed effects and random effects, in the context of your research question. Report the results, including confidence intervals and p-values.

By initially focusing on the fixed effects, you can establish the foundation of your model and identify the significant predictors and interactions. This step allows you to better understand the relationships in your data and guide the subsequent inclusion of random effects if appropriate.


https://ademos.people.uic.edu/Chapter17.html#121_crossed__nested_designs

## Mixed Model extensions

## Practical problems

HARRISON?

MODEL CONVERGENCE - BAKER

lmer3 <- lmer(y ~ x + (x | group), data = data, control = lmerControl(optimizer ="Nelder_Mead"))


CHECK THIS! 

With mixed models, the solution is arrived at iteratively, which means it can fail to converge for a number of reasons. Generally, failure to converge will be due to an issue with the data.


Linear model analyses can extend beyond testing differences of means in categorical groupings to test relationships with continuous variables. This is known as linear regression, where the relationship between the explanatory variable and response variable are modelled with the equation for a straight line. The intercept is the value of *y* when *x* = 0, often this isn't that useful, and we can use 'mean-centered' values if we wish to make the intercept more intuitive. 
As with all linear models, regression assumes that the unexplained variability around the regression line, is normally distributed and has constant variance. 

Once the regression has been fitted it is possible to predict values of *y* from values of *x*, the uncertainty around these predictions can be captured with confidence intervals. 



The first thing to try is scaling all your parameters:

egen scaled_var = std(var)
Dummy variables typically don’t need to be scaled, but can be. If scaling all your variables allows convergence, try different combinations of scaled and unscaled to figure out what variables are causing the problem. It’s typically (but not always) the variables which have the largest scale to begin with.

Another potential convergence issue is extremely high correlation between predictors (including dummy variables). You should have already addressed this when considering multicollinearity, but if not, it can make convergence challenging.

If the iteration keeps running (as opposed to ending and complaining about lack of convergence), try passing the option iterate(#) with a few “large” (“large” is relative to running time) numbers to tell the algorithm to stop after # iterations, regardless of convergence. (Recall that an iterative solution produces an answer at each iteration, it’s just not a consistent answer until you reach convergence.) You’re looking for two things:

First, if there are any estimated standard errors that are extremely close to zero or exploding towards infinity, that predictor may be causing the issue. Try removing it.
Second, if you try a few different max iterations (say 50, 100 and 200), and the estimated coefficients and standard errors are relatively constant, you may be running into a case where the model is converging to just beyond the tolerance which Stata uses, but for all intents and purposes is converged. Set iterate(#) to a high number and use that result.
You can try use the “reml” optimizer, by passing the reml option. This optimizer can be a bit easier to converge, though may be slower.

Finally, although it pains me to admit it, you should try running the model in different software such as R or SAS. Each software has slightly different algorithms it uses, and there are situations where one software will converge and another won’t

## Further Reading

Some suggested starter topics to continue your mixed-model journey! 

- [A brief introduction to mixed effects modelling and multi-model inference in ecology](https://peerj.com/articles/4794/) @xav_2018

- [Mixed Effects Models and Extensions in Ecology with R](https://link.springer.com/book/10.1007/978-0-387-87458-6) @zuur_2009

- [Perils and pitfalls of mixed-effects regression models in biology](https://peerj.com/articles/9522/)@silk_2020



