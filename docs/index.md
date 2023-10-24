--- 
title: "Introduction to Statistics"
author: "Philip T. Leftwich"
date: "2023-10-24"
subtitle: A guide for Biologists and Ecologists
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
url: https://ueabio.github.io/physalia-intro-stats-2023/
github-repo: UEABIO/physalia-intro-stats-2023
cover-image: images/logos/twitter_card.png
apple-touch-icon: images/logos/apple-touch-icon.png
apple-touch-icon-size: 180
favicon: images/logos/favicon.ico
---






# Overview {-}




<div class="small_right"><img src="images/logos/logo.png" 
     alt="Data skills Logo" /></div>


This course will introduce scientists and practitioners interested in applying statistical approaches in their daily routine using R as a working environment. Participants will be introduced into R and R Studio while learning how to perform common statistical analyses. After a short introduction on R and its principles, the focus will be on questions that could be addressed using common statistical analyses, both for descriptive statistics and for statistical inference.

## Learning outcomes

1. Understand how to read, interpret and write scripts in R.

2. Learn statistical tools to address common questions in research activities.

3. An introduction to efficient, readable and reproducible analyses

4. Being comfortable with using R when performing both descriptive and inferential statistics.


## Packages


```r
library(tidyverse)
library(janitor)
library(rstatix)
library(performance)
library(see)
library(lmerTest)
library(patchwork)
library(broom.mixed)
library(ggeffects)
library(DHARMa)
library(sjPlot)
library(emmeans)
library(report)
library(MuMIn)
library(GGally)
library(colorBlindness)
```
