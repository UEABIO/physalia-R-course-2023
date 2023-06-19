# (PART\*) Mixed Models {.unnumbered}

# Introduction








# Foundations of Mixed Modelling

## Why use mixed models?

## Fixed vs Random effects




We can now join our random effect matrix to the full dataset and define our y values as 

$$yi = B0i + b0j + B1xi + b1xj + ε$$.


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
```




```r
plot(data$x, data$y)
```

<img src="15-Regression_files/figure-html/unnamed-chunk-5-1.png" width="100%" style="display: block; margin: auto;" />


```r
theme_set(theme_classic())
```




```r
# Color tagged by group
plot_group <- ggplot(data, aes(x = x, 
                               y = y, 
                               color = group,
                               group = group)) +
  geom_point() +
  labs(title = "Data Coloured by Group", 
       x = "Independent Variable", 
       y = "Dependent Variable")+
  theme(legend.position="none")

plot_group
```

<img src="15-Regression_files/figure-html/unnamed-chunk-7-1.png" width="100%" style="display: block; margin: auto;" />


```r
plot_group+
  facet_wrap(~group)
```

<img src="15-Regression_files/figure-html/unnamed-chunk-8-1.png" width="100%" style="display: block; margin: auto;" />








```r
grViz("
digraph boxes_and_circles {

  # a 'graph' statement
  graph [overlap = true, fontsize = 10]

  # several 'node' statements
  node [shape = box,
        fontname = Helvetica]
  A; B; C; D; E; F

  node [shape = circle,
        fixedsize = true,
        width = 0.9] // sets as circles
  1; 2; 3; 4; 5; 6; 7; 8

  # several 'edge' statements
  A->1 B->2 B->3 B->4 C->A
  1->D E->A 2->4 1->5 1->F
  E->6 4->6 5->7 6->7 3->8
}
")
```

```{=html}
<div class="grViz html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-60e47007fa32436b2ab7" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-60e47007fa32436b2ab7">{"x":{"diagram":"\ndigraph boxes_and_circles {\n\n  # a \"graph\" statement\n  graph [overlap = true, fontsize = 10]\n\n  # several \"node\" statements\n  node [shape = box,\n        fontname = Helvetica]\n  A; B; C; D; E; F\n\n  node [shape = circle,\n        fixedsize = true,\n        width = 0.9] // sets as circles\n  1; 2; 3; 4; 5; 6; 7; 8\n\n  # several \"edge\" statements\n  A->1 B->2 B->3 B->4 C->A\n  1->D E->A 2->4 1->5 1->F\n  E->6 4->6 5->7 6->7 3->8\n}\n","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
```

# Random slopes

random_slopes_intercept_model <- lmer(dependent_var ~ independent_var + (independent_var | group), data = data)
random_slopes_values <- predict(random_slopes_model)

# Random intercept

# Random intercept model
model_intercept <- lmer(dependent_var ~ independent_var + (1 | group), data = data)
random_intercept_values <- predict(model_intercept)

ggplot(data, aes(x = independent_var, y = dependent_var, color = group, group = group)) +
    geom_point(position = position_jitter(width = 0.2), alpha = 0.6) +
    geom_line(aes(x = independent_var, y= random_intercept_values)) +
    labs(title = "Random Slopes", x = "Independent Variable", y = "Dependent Variable") +
    theme_minimal()





```

## Nested and crossed random effects

## Random slopes

## Mixed model equations

## Assumptions of a mixed model

# Mixed Models in R

## Demonstration

## Model fitting

## Model simplification

## Interpretation

# Mixed Model extensions


# Summary

## Further Reading



Linear model analyses can extend beyond testing differences of means in categorical groupings to test relationships with continuous variables. This is known as linear regression, where the relationship between the explanatory variable and response variable are modelled with the equation for a straight line. The intercept is the value of *y* when *x* = 0, often this isn't that useful, and we can use 'mean-centered' values if we wish to make the intercept more intuitive. 
As with all linear models, regression assumes that the unexplained variability around the regression line, is normally distributed and has constant variance. 

Once the regression has been fitted it is possible to predict values of *y* from values of *x*, the uncertainty around these predictions can be captured with confidence intervals. 
