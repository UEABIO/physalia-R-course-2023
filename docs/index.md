--- 
title: "Mixed Models"
author: "Philip T. Leftwich"
date: "2023-06-21"
subtitle: An introduction in R
site: bookdown::bookdown_site
documentclass: book
bibliography:
- book.bib
- packages.bib
biblio-style: apa
csl: include/apa.csl
link-citations: yes
description: |
  This book ...
url: https://ueabio.github.io/intro-mixed-models
github-repo: UEABIO/intro-mixed-models
cover-image: images/logos/twitter_card.png
apple-touch-icon: images/logos/apple-touch-icon.png
apple-touch-icon-size: 180
favicon: images/logos/favicon.ico
---






# Overview {-}




<div class="small_right"><img src="images/logos/mixed-logo.png" 
     alt="Data skills Logo" /></div>


Data are often complex and messy. 

We can have different grouping factors like where we collect the data, etc. Sample sizes may also leave something to be desired, especially if we try to fit complicated models with many parameters. On top of that, our data points might not be truly independent. For instance, there might be structure to our data.

This is why mixed models were developed, to deal with such messy data and to allow us to use all our data, even when we have low sample sizes, structured data and many covariates to fit. On top of all that, mixed models allow us to save degrees of freedom compared to running standard linear models! Sounds good.

Here we will cover the basics of linear mixed models, how to use them responsibly and interepret your findings effectively.

If you are trying to “extend” your linear model, fear not: there are generalised linear mixed effects models, too.

## Terminology

Mixed-effects models are sometime referred to as hierarchical models, multi-level models, random effects models, and mixed-models. Regardless of the confusing vocabulary, it’s worth knowing that the terms all may be used to mean similar models.

Random effects are an important part of mixed-effects models. Random effects capture the variations that come from grouping or clustering of data. They are used in mixed models, which combine both fixed effects (relationships between variables) and random effects. This approach helps us account for correlations and dependencies within groups, making our models more realistic.

In nature, we often see hierarchical structures, such as streams within a watershed or species within a family. Random effects can be useful in these situations and others where observations tend to be clustered. By using random effects, we can improve our ability to model the system accurately.

The main purpose of applying random effects in mixed models is to capture more realistic patterns and uncertainties in the data. For example, we can account for correlations that arise from multiple observations within a group or when our observations lack complete independence.

To sum it up, random effects and mixed models help us deal with situations where observations are not independent. They allow us to capture the complexities and dependencies within groups, improving the accuracy of our statistical models.

### Variance

To understand mixed- and random effects models, we need to understand random effects and to understand random effects, we need to understand variance. 

> Variance is a statistical measure that quantifies the spread or dispersion of a set of data points. It provides a measure of how much the values in a dataset deviate from the mean.

To calculate the variance in a linear model (ordinary least squares), you first obtain the residuals, which are the differences between the observed response values and the predicted values. Then, you square each residual to eliminate the negative signs and calculate the sum of these squared residuals. Finally, you divide the sum by the degrees of freedom, which is the total number of observations minus the number of estimated coefficients in the model.

o estimate the variance components in a linear mixed model, likelihood-based methods such as [maximum likelihood estimation (MLE)](https://towardsdatascience.com/probability-concepts-explained-maximum-likelihood-estimation-c7b4342fdbb1) or restricted maximum likelihood estimation (REML) are commonly used. These methods optimize the likelihood function by adjusting the model parameters, including the variance components, to find the values that best fit the observed data. 

