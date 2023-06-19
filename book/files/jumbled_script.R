#___________________________----
# SET UP ---
## Unscramble this jumbled R script ----
# dataset Orange comes preloaded with ggplot2

#__________________________----

# 🧹 TIDY ----


  filter(Tree == 1,
         Orange_filtered <- Orange %>%
         age < 1200)
#__________________________----

# 📦 PACKAGES ----
library(tidyverse) # tidy data packages

#__________________________----

# 🔍 CHECK DATA----

Orange # call the dataframe

str(Orange) # check structure of dataframe

#__________________________----

# 📊PLOT ----

ggplot(data = Orange_filtered,
       geom_point()+
           y = circumference))+
  geom_line()
aes(x = age,
