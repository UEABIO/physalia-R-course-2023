# (PART\*) Getting the most out of tidyverse {.unnumbered}










# Reading files with `readr`

## Cleaning column names

Reading a CSV file often requires some data cleaning. For example, let's say I want to import data and convert all column names to `snake_case`. 

Most of us would probably read the .CSV file first, then start data cleaning - for example with the `janitor::clean_names()` function. 


```r
library(tidyverse)
library(janitor)
#load data
penguins <- read_csv ("data/penguins_raw.csv")

penguins |> read_csv()
janitor::clean_names(penguins) 
```

In my previous example, I used the `clean_names()` function from the "janitor" package to convert the column names to lowercase. You can achieve the same result by using the `make_clean_names()` function within the `read_csv` function, specifying it in the `name_repair` argument.


```r
penguins <- read_csv ("data/penguins_raw.csv",
                      name_repair = janitor::make_clean_names)
```

By default the `janitor::make_clean_names` function has a default argument of `snake_case` but within the function there is also a `case` argument where other common naming conventions can be used. 

## Selecting columns


In addition to cleaning your column names, you can also directly select columns while using the "read_csv" function by utilizing the "col_select" argument. This can be extremely useful when working with large files, selecting only the columns you need can be memory-efficient. 


```r
penguins <- read_csv ("data/penguins_raw.csv",
                      name_repair = janitor::make_clean_names,
                      col_select = c(species, body_mass_g, flipper_length_mm)) |> 
  glimpse()
```

## Reading multiple files


```r
dir.create(c("data/many_files"))
peng_samples <- map(1:25, ~ slice_sample(penguins, n = 20))

iwalk(peng_samples, ~ write_csv(., paste0("data/many_files/", .y, ".csv")))
```

### Create a vector of file paths


```r
csv_files_list_files <- list.files(path = "data/many_files",
                                    pattern = "csv", full.names = TRUE)
```

```
 [1] "data/many_files/1.csv"  "data/many_files/10.csv" "data/many_files/11.csv" "data/many_files/12.csv"
 [5] "data/many_files/13.csv" "data/many_files/14.csv" "data/many_files/15.csv" "data/many_files/16.csv"
 [9] "data/many_files/17.csv" "data/many_files/18.csv" "data/many_files/19.csv" "data/many_files/2.csv" 
[13] "data/many_files/20.csv" "data/many_files/21.csv" "data/many_files/22.csv" "data/many_files/23.csv"
[17] "data/many_files/24.csv" "data/many_files/25.csv" "data/many_files/3.csv"  "data/many_files/4.csv" 
[21] "data/many_files/5.csv"  "data/many_files/6.csv"  "data/many_files/7.csv"  "data/many_files/8.csv" 
[25] "data/many_files/9.csv"
```

The function "list.files" has several arguments. Here's an explanation of some key arguments:

- "path": This argument allows you to specify the directory where your files are located. It's essential to ensure the path is set correctly. You should be working within an R-Studio project or have defined your working directory to avoid issues.

- "pattern": You provide a regular expression in this argument to filter the files you want to list. In your example, you mentioned that you are looking for files containing the string "csv." This helps narrow down the selection to specific file types or patterns.

- "full.names": Setting this argument to `TRUE` indicates that you want to store the full paths of the files, not just their names. This is important for ensuring you can correctly access and read these files later. If "full.names" is not set to `TRUE`, you may encounter difficulties when attempting to read the files because the file paths would be incomplete.

### Read multiple files

Now that we have obtained the file paths, we can proceed to load the files into R. The preferred method in the tidyverse is to use the `map_dfr` function from the `purrr` package. This function iterates through all the file paths and combines the data frames into a single, unified data frame. In the following code, `.x` represents the file name or path. To read and output the actual content of the CSV files (not just the filenames), you should include `.x` (the path) within a `readr` function. While this example deals with CSV files, this approach works similarly for other rectangular file formats.


```r
df <- map_dfr(csv_files_list_files,
              ~ read_csv(.x))

glimpse(df)
```


### Selecting files

`stringr::str_detect()`


```r
csv_files_list_files[str_detect(csv_files_list_files, pattern = "[2-4]",
negate = FALSE)]
```
```
 [1] "data/many_files/12.csv" "data/many_files/13.csv" "data/many_files/14.csv"
 [4] "data/many_files/2.csv"  "data/many_files/20.csv" "data/many_files/21.csv"
 [7] "data/many_files/22.csv" "data/many_files/23.csv" "data/many_files/24.csv"
[10] "data/many_files/25.csv" "data/many_files/3.csv"  "data/many_files/4.csv"
```





```r
csv_files_list_files[str_detect(csv_files_list_files, pattern = "[24]\\.csv$")]
```

```
[1] "data/many_files/12.csv" "data/many_files/14.csv" "data/many_files/2.csv" 
[4] "data/many_files/22.csv" "data/many_files/24.csv" "data/many_files/4.csv"

```

# Working across columns

In this section we will go through the following functions:



- `last_col()`

- `starts_with()`

- `ends_with()`

- `contains()`

- `matches()`

- `num_range()`

- `where()`

## Select the last column


```r
penguins |> 
  select(last_col()) |> 
  glimpse()
```

```
## Rows: 344
## Columns: 1
## $ flipper_range <fct> small, small, medium, NA, medium, small, small, medium, …
```

You can also select `n-to-the-last` with `last_col()`


```r
penguins |> 
  select(last_col(3)) |> 
  glimpse()
```

```
## Rows: 344
## Columns: 1
## $ delta_13_c_o_oo <dbl> NA, -24.69454, -25.33302, NA, -25.32426, -25.29805, -2…
```

<div class="info">
<p>Indexing starts at 0, so 1 indicates n-1.</p>
</div>


## Selecting columns based on string


```r
penguins |> 
  select(starts_with("s")) |> 
  glimpse()
```
```
Rows: 344
Columns: 5
$ study_name    <chr> "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708"…
$ sample_number <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,…
$ species       <chr> "Adelie Penguin (Pygoscelis adeliae)", "Adelie Penguin (Pygoscelis adeliae)", "Adelie …
$ stage         <chr> "Adult, 1 Egg Stage", "Adult, 1 Egg Stage", "Adult, 1 Egg Stage", "Adult, 1 Egg Stage"…
$ sex           <chr> "MALE", "FEMALE", "FEMALE", NA, "FEMALE", "MALE", "FEMALE", "MALE", NA, NA, NA, NA, "F…

```

`starts_with` and `ends_with` works with any character, but also with a vector of characters


```r
penguins |> 
  select(starts_with(c("s", "c"))) |> 
  glimpse()
```
```
Rows: 344
Columns: 9
$ study_name        <chr> "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0…
$ sample_number     <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,…
$ species           <chr> "Adelie Penguin (Pygoscelis adeliae)", "Adelie Penguin (Pygoscelis adeliae)", "Ade…
$ stage             <chr> "Adult, 1 Egg Stage", "Adult, 1 Egg Stage", "Adult, 1 Egg Stage", "Adult, 1 Egg St…
$ sex               <chr> "MALE", "FEMALE", "FEMALE", NA, "FEMALE", "MALE", "FEMALE", "MALE", NA, NA, NA, NA…
$ clutch_completion <chr> "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", "No", "No", "Yes", "Yes", "Yes", "Yes", …
$ culmen_length_mm  <dbl> 39.1, 39.5, 40.3, NA, 36.7, 39.3, 38.9, 39.2, 34.1, 42.0, 37.8, 37.8, 41.1, 38.6, …
$ culmen_depth_mm   <dbl> 18.7, 17.4, 18.0, NA, 19.3, 20.6, 17.8, 19.6, 18.1, 20.2, 17.1, 17.3, 17.6, 21.2, …
$ comments          <chr> "Not enough blood for isotopes.", NA, NA, "Adult not sampled.", NA, NA, "Nest neve…
```

### Contains

We can also use the `contains()` function to search for columns that contain a specific string, it searches for an exact match to your string (no regular expressions) but is case-insensitive


```r
penguins |> 
  select(contains("length")) |> 
  glimpse()
```

```
Rows: 344
Columns: 2
$ culmen_length_mm  <dbl> 39.1, 39.5, 40.3, NA, 36.7, 39.3, 38.9, 39.2, 34.1, 42.0, 37.8, 37.8, 41.1, 38.6, …
$ flipper_length_mm <dbl> 181, 186, 195, NA, 193, 190, 181, 195, 193, 190, 186, 180, 182, 191, 198, 185, 195…
```

### Regular expressions

https://help.relativity.com/RelativityOne/Content/Relativity/Regular_expressions/Searching_with_regular_expressions.htm#:~:text=For%20example%2C%20%E2%80%9C%5Cd%E2%80%9D,that%20follow%20a%20specific%20pattern.



```r
penguins |> 
  select(matches("[0-9]")) |> 
  glimpse()
```
```
Rows: 344
Columns: 2
$ delta_15_n_o_oo <dbl> NA, 8.94956, 8.36821, NA, 8.76651, 8.66496, 9.18718, 9.46060, NA, 9.13362, 8.63243, …
$ delta_13_c_o_oo <dbl> NA, -24.69454, -25.33302, NA, -25.32426, -25.29805, -25.21799, -24.89958, NA, -25.09…

```


```r
penguins |> 
  select(matches("[0-9]")) |> 
  glimpse()
```


```r
penguins |> 
    select(matches("length_[a-z][a-z]")) |> 
    glimpse()
```


## Selecting by column type

The where function is used when you want to select variables of a specific data type in a dataset. For example, you can use it to select character variables.



```r
penguins |> 
    select(where(is.character)) |> 
    glimpse()
```
```
Rows: 344
Columns: 10
$ study_name        <chr> "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0…
$ species           <chr> "Adelie Penguin (Pygoscelis adeliae)", "Adelie Penguin (Pygoscelis adeliae)", "Ade…
$ region            <chr> "Anvers", "Anvers", "Anvers", "Anvers", "Anvers", "Anvers", "Anvers", "Anvers", "A…
$ island            <chr> "Torgersen", "Torgersen", "Torgersen", "Torgersen", "Torgersen", "Torgersen", "Tor…
$ stage             <chr> "Adult, 1 Egg Stage", "Adult, 1 Egg Stage", "Adult, 1 Egg Stage", "Adult, 1 Egg St…
$ individual_id     <chr> "N1A1", "N1A2", "N2A1", "N2A2", "N3A1", "N3A2", "N4A1", "N4A2", "N5A1", "N5A2", "N…
$ clutch_completion <chr> "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", "No", "No", "Yes", "Yes", "Yes", "Yes", …
$ date_egg          <chr> "11/11/2007", "11/11/2007", "16/11/2007", "16/11/2007", "16/11/2007", "16/11/2007"…
$ sex               <chr> "MALE", "FEMALE", "FEMALE", NA, "FEMALE", "MALE", "FEMALE", "MALE", NA, NA, NA, NA…
$ comments          <chr> "Not enough blood for isotopes.", NA, NA, "Adult not sampled.", NA, NA, "Nest neve…
```

Other "predicate functions" include

- is.double

- is.numeric

- is.logical

- is.factor

- is.integer


## Combos

Using standard logical operators such as `|` and `&` we can string toether different combinations of selection criteria


```r
penguins |> 
  select(where(is.numeric) | contains("species")) |> 
  glimpse()
```
```
Rows: 344
Columns: 8
$ sample_number     <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,…
$ culmen_length_mm  <dbl> 39.1, 39.5, 40.3, NA, 36.7, 39.3, 38.9, 39.2, 34.1, 42.0, 37.8, 37.8, 41.1, 38.6, …
$ culmen_depth_mm   <dbl> 18.7, 17.4, 18.0, NA, 19.3, 20.6, 17.8, 19.6, 18.1, 20.2, 17.1, 17.3, 17.6, 21.2, …
$ flipper_length_mm <dbl> 181, 186, 195, NA, 193, 190, 181, 195, 193, 190, 186, 180, 182, 191, 198, 185, 195…
$ body_mass_g       <dbl> 3750, 3800, 3250, NA, 3450, 3650, 3625, 4675, 3475, 4250, 3300, 3700, 3200, 3800, …
$ delta_15_n_o_oo   <dbl> NA, 8.94956, 8.36821, NA, 8.76651, 8.66496, 9.18718, 9.46060, NA, 9.13362, 8.63243…
$ delta_13_c_o_oo   <dbl> NA, -24.69454, -25.33302, NA, -25.32426, -25.29805, -25.21799, -24.89958, NA, -25.…
$ species           <chr> "Adelie Penguin (Pygoscelis adeliae)", "Adelie Penguin (Pygoscelis adeliae)", "Ade…

```


# Modifying variables

## count

## extract


```r
penguins |> 
  separate(species,
          into = c("species", "full_latin_name"),
          sep = "\\("
          )
```

This approach reaches its limits quite quickly - note here it has left an ugly `)` on the end of the second column. There are also issues when we lack a clear separator to distinguish the columns we want to create. For these use cases we have extract.

Now suppose you want to separate the common names and latin names of the species variable by regex:


```r
penguins <- penguins |> 
  extract(species,
          into = c("species", "full_latin_name"),
          regex = "(\\w+) .* \\(([^)]+)\\)"
          )
penguins |> colnames()
```

```
##  [1] "study_name"        "sample_number"     "species"          
##  [4] "full_latin_name"   "region"            "island"           
##  [7] "stage"             "individual_id"     "clutch_completion"
## [10] "date_egg"          "culmen_length_mm"  "culmen_depth_mm"  
## [13] "flipper_length_mm" "body_mass_g"       "sex"              
## [16] "delta_15_n_o_oo"   "delta_13_c_o_oo"   "comments"         
## [19] "date_egg_proper"   "flipper_range"
```

- The first group captures at least 1 letter (\\w+).

- The column is then followed by a space, and all characters in between are followed by
another space: .*

- The last group contains anything found inside brackets `()`

# Factors

## Anonymising factors

Sometimes you want to make your data completely anonymous so that other people can’t see sensitive information. Or because you wish to blind you own analyses.

`forcats::fct_anon` 


```r
penguins |> 
  mutate(species = fct_anon(species,
         prefix = "species_"))
```

## lump factors


```r
penguins |> 
  mutate(body_size = fct_lump_min(as_factor(species), 50)) |> 
  ggplot(aes(x = body_size,
         y = flipper_length_mm))+
  geom_boxplot()
```

## ordering factors


```r
penguins |> 
  mutate(species = fct_relevel(species, "Adelie", "Chinstrap", "Gentoo")) |> 
  ggplot(aes(x = species))+
  geom_bar()+
  coord_flip()
```

<img src="04-tidyverse_files/figure-html/unnamed-chunk-26-1.png" width="100%" style="display: block; margin: auto;" />

With the function `fct_infreq` we can change the order according to how frequently each level occurs


```r
penguins |> 
  mutate(species = fct_infreq(species)) |> 
  ggplot(aes(x = species))+
  geom_bar()+
  coord_flip()
```

<img src="04-tidyverse_files/figure-html/unnamed-chunk-27-1.png" width="100%" style="display: block; margin: auto;" />



```r
penguins |> 
  mutate(species = fct_rev(as_factor(species))) |> 
  ggplot(aes(x = species))+
  geom_bar()+
  coord_flip()
```

<img src="04-tidyverse_files/figure-html/unnamed-chunk-28-1.png" width="100%" style="display: block; margin: auto;" />

`fct_reorder` allows us to order the levels based on another continuous variable


```r
penguins |> 
  mutate(species = as_factor(species) |> 
           fct_reorder(body_mass_g,
                       .fun = median)) |> 
  # by default the levels are ordered by the median values of the continuous variable
  # mean, min and max can all be included here
  ggplot(aes(x = species,
             y = body_mass_g,
             colour = species))+
  geom_boxplot(width = .2,
               outlier.shape = NA)+
  geom_jitter(width = .2,
              alpha = .4)
```

<img src="04-tidyverse_files/figure-html/unnamed-chunk-29-1.png" width="100%" style="display: block; margin: auto;" />


# Applying functions across columns

## calculate summary statistics across columns


```r
penguins |> 
  group_by(species) |> 
  summarise(
    mean_body_mass = mean(body_mass_g, na.rm = T),
    mean_flipper_length = mean(flipper_length_mm, na.rm = T)
  )
```


```r
penguins |> 
  group_by(species) |> 
  summarise(
    across(
      .cols = where(is.numeric),
      .fns = ~mean(.x, na.rm = T),
      .names = "mean_{.col}")
    )
```

<div class="kable-table">

|species                                   | mean_sample_number| mean_culmen_length_mm| mean_culmen_depth_mm| mean_flipper_length_mm| mean_body_mass_g| mean_delta_15_n_o_oo| mean_delta_13_c_o_oo|
|:-----------------------------------------|------------------:|---------------------:|--------------------:|----------------------:|----------------:|--------------------:|--------------------:|
|Adelie Penguin (Pygoscelis adeliae)       |               76.5|              38.79139|             18.34636|               189.9536|         3700.662|             8.859733|            -25.80419|
|Chinstrap penguin (Pygoscelis antarctica) |               34.5|              48.83382|             18.42059|               195.8235|         3733.088|             9.356155|            -24.54654|
|Gentoo penguin (Pygoscelis papua)         |               62.5|              47.50488|             14.98211|               217.1870|         5076.016|             8.245338|            -26.18530|

</div>

## Change variable types across columns


```r
penguins |> 
  mutate(
    across(.cols = c("species", "island", "region"),
           .fns = as_factor)
  ) |> 
  select(where(is.factor)) |> 
  glimpse()
```

```
## Rows: 344
## Columns: 4
## $ species       <fct> Adelie Penguin (Pygoscelis adeliae), Adelie Penguin (Pyg…
## $ region        <fct> Anvers, Anvers, Anvers, Anvers, Anvers, Anvers, Anvers, …
## $ island        <fct> Torgersen, Torgersen, Torgersen, Torgersen, Torgersen, T…
## $ flipper_range <fct> small, small, medium, NA, medium, small, small, medium, …
```

```
Rows: 344
Columns: 3
$ species <fct> Adelie, Adelie, Adelie, Adelie, Adelie, Adelie, Adelie, Adelie, Adelie, Adel…
$ region  <fct> Anvers, Anvers, Anvers, Anvers, Anvers, Anvers, Anvers, Anvers, Anvers, Anve…
$ island  <fct> Torgersen, Torgersen, Torgersen, Torgersen, Torgersen, Torgersen, Torgersen,…
```


## Correct typos


```r
x <- c("Adelie", "adelie", "pinstrap", "Chinstrap")
y <- c("adelie", "Adelie", "Chinstrap","Chinstrap")

typo_df <- tibble(x,y)
```



```r
typo_df |> 
  mutate(across(
    .cols = everything(),
    .fns = ~ case_when(
      str_detect(., "adelie") ~ str_replace(., "adelie", "Adelie"),
      str_detect(., "pinstrap") ~ str_replace(., "pinstrap", "Chinstrap"),
      TRUE ~ .
    )
  ))
```

<div class="kable-table">

|x         |y         |
|:---------|:---------|
|Adelie    |Adelie    |
|Adelie    |Adelie    |
|Chinstrap |Chinstrap |
|Chinstrap |Chinstrap |

</div>


# Working with rows

## Filtering rows based on conditions across multiple columns



```r
penguins |> 
  filter(
    if_any(.cols = contains("culmen"),
           .fns = ~. < 40)
  ) |> 
  glimpse()
```



```r
penguins |> 
  filter(
    if_all(.cols = contains("culmen"),
           .fns = ~. < 40)
  ) |> 
  glimpse()
```

## filter rows based on missing values


```r
penguins |> 
  filter(
    if_all(.cols = where(is.numeric),
           .fns = ~!is.na(.))
  ) 
```

<div class="try">
<p>At first the outcome above can seem counter-intuitive, but can be
explained by the <code>!</code> operator. The if_all is evaluating
whether all columns meet the condition of NOT containing NA.</p>
<p>You can try different combinations of if_all, if_any and the NOT
operator</p>
</div>

## slicing


```r
penguins |> 
  arrange(desc(body_mass_g)) |> 
  slice(1:10)
```

<div class="kable-table">

|study_name | sample_number|species                           |region |island |stage              |individual_id |clutch_completion |date_egg   | culmen_length_mm| culmen_depth_mm| flipper_length_mm| body_mass_g|sex  | delta_15_n_o_oo| delta_13_c_o_oo|comments |date_egg_proper |flipper_range |
|:----------|-------------:|:---------------------------------|:------|:------|:------------------|:-------------|:-----------------|:----------|----------------:|---------------:|-----------------:|-----------:|:----|---------------:|---------------:|:--------|:---------------|:-------------|
|PAL0708    |            18|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N39A2         |Yes               |27/11/2007 |             49.2|            15.2|               221|        6300|MALE |         8.27376|       -25.00169|NA       |2007-11-27      |large         |
|PAL0708    |            34|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N56A2         |Yes               |03/12/2007 |             59.6|            17.0|               230|        6050|MALE |         7.76843|       -25.68210|NA       |2007-12-03      |large         |
|PAL0809    |            78|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N58A2         |Yes               |06/11/2008 |             51.1|            16.3|               220|        6000|MALE |         8.40327|       -26.76821|NA       |2008-11-06      |large         |
|PAL0910    |           118|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N36A2         |Yes               |01/12/2009 |             48.8|            16.2|               222|        6000|MALE |         8.33825|       -25.88547|NA       |2009-12-01      |large         |
|PAL0809    |            80|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N60A2         |Yes               |09/11/2008 |             45.2|            16.4|               223|        5950|MALE |         8.19749|       -26.65931|NA       |2008-11-09      |large         |
|PAL0910    |           112|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N32A2         |Yes               |20/11/2009 |             49.8|            15.9|               229|        5950|MALE |         8.29226|       -26.21019|NA       |2009-11-20      |large         |
|PAL0708    |            14|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N37A2         |Yes               |29/11/2007 |             48.4|            14.6|               213|        5850|MALE |         7.82080|       -25.48025|NA       |2007-11-29      |large         |
|PAL0708    |            16|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N38A2         |Yes               |03/12/2007 |             49.3|            15.7|               217|        5850|MALE |         8.07137|       -25.52473|NA       |2007-12-03      |large         |
|PAL0910    |           116|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N35A2         |Yes               |25/11/2009 |             55.1|            16.0|               230|        5850|MALE |         8.08354|       -26.18161|NA       |2009-11-25      |large         |
|PAL0809    |            68|Gentoo penguin (Pygoscelis papua) |Anvers |Biscoe |Adult, 1 Egg Stage |N51A2         |Yes               |09/11/2008 |             49.5|            16.2|               229|        5800|MALE |         8.49854|       -26.74809|NA       |2008-11-09      |large         |

</div>


```r
penguins |> 
  arrange(desc(body_mass_g)) |> 
  rownames_to_column(var = "row_number") |> 
  slice(c(1,123,307))
```

<div class="kable-table">

|row_number |study_name | sample_number|species                                   |region |island |stage              |individual_id |clutch_completion |date_egg   | culmen_length_mm| culmen_depth_mm| flipper_length_mm| body_mass_g|sex    | delta_15_n_o_oo| delta_13_c_o_oo|comments                              |date_egg_proper |flipper_range |
|:----------|:----------|-------------:|:-----------------------------------------|:------|:------|:------------------|:-------------|:-----------------|:----------|----------------:|---------------:|-----------------:|-----------:|:------|---------------:|---------------:|:-------------------------------------|:---------------|:-------------|
|1          |PAL0708    |            18|Gentoo penguin (Pygoscelis papua)         |Anvers |Biscoe |Adult, 1 Egg Stage |N39A2         |Yes               |27/11/2007 |             49.2|            15.2|               221|        6300|MALE   |         8.27376|       -25.00169|NA                                    |2007-11-27      |large         |
|123        |PAL0809    |            59|Gentoo penguin (Pygoscelis papua)         |Anvers |Biscoe |Adult, 1 Egg Stage |N17A1         |Yes               |06/11/2008 |             43.2|            14.5|               208|        4450|FEMALE |         8.48367|       -26.86485|NA                                    |2008-11-06      |medium        |
|307        |PAL0708    |            17|Chinstrap penguin (Pygoscelis antarctica) |Anvers |Dream  |Adult, 1 Egg Stage |N71A1         |No                |30/11/2007 |             50.3|            20.0|               197|        3300|MALE   |        10.02019|       -24.54704|Nest never observed with full clutch. |2007-11-30      |medium        |

</div>


```r
penguins |> 
  arrange(desc(body_mass_g)) |> 
  rownames_to_column(var = "row_number") |> 
  slice(c(-1:-340))
```

<div class="kable-table">

|row_number |study_name | sample_number|species                                   |region |island    |stage              |individual_id |clutch_completion |date_egg   | culmen_length_mm| culmen_depth_mm| flipper_length_mm| body_mass_g|sex    | delta_15_n_o_oo| delta_13_c_o_oo|comments                                                 |date_egg_proper |flipper_range |
|:----------|:----------|-------------:|:-----------------------------------------|:------|:---------|:------------------|:-------------|:-----------------|:----------|----------------:|---------------:|-----------------:|-----------:|:------|---------------:|---------------:|:--------------------------------------------------------|:---------------|:-------------|
|341        |PAL0809    |            65|Adelie Penguin (Pygoscelis adeliae)       |Anvers |Biscoe    |Adult, 1 Egg Stage |N29A1         |Yes               |13/11/2008 |             36.4|            17.1|               184|        2850|FEMALE |         8.62623|       -26.11650|NA                                                       |2008-11-13      |small         |
|342        |PAL0809    |            39|Chinstrap penguin (Pygoscelis antarctica) |Anvers |Dream     |Adult, 1 Egg Stage |N72A1         |No                |24/11/2008 |             46.9|            16.6|               192|        2700|FEMALE |         9.80589|       -24.73735|Nest never observed with full clutch.                    |2008-11-24      |medium        |
|343        |PAL0708    |             4|Adelie Penguin (Pygoscelis adeliae)       |Anvers |Torgersen |Adult, 1 Egg Stage |N2A2          |Yes               |16/11/2007 |               NA|              NA|                NA|          NA|NA     |              NA|              NA|Adult not sampled.                                       |2007-11-16      |NA            |
|344        |PAL0910    |           120|Gentoo penguin (Pygoscelis papua)         |Anvers |Biscoe    |Adult, 1 Egg Stage |N38A2         |No                |01/12/2009 |               NA|              NA|                NA|          NA|NA     |              NA|              NA|Adult not sampled. Nest never observed with full clutch. |2009-12-01      |NA            |

</div>

Helper functions include `slice_head()`, `slice_tail()`, `slice_max()`, `slice_min()` and `slice_sample()`
We can use these functions to more quickly and easily filter our data under some situations


```r
penguins |> 
  slice_max(order_by = body_mass_g,
            n = 20) |> # we can also use prop e.g. prop =.1 to slice the top 10%
  select(species, body_mass_g)
```

<div class="kable-table">

|species                           | body_mass_g|
|:---------------------------------|-----------:|
|Gentoo penguin (Pygoscelis papua) |        6300|
|Gentoo penguin (Pygoscelis papua) |        6050|
|Gentoo penguin (Pygoscelis papua) |        6000|
|Gentoo penguin (Pygoscelis papua) |        6000|
|Gentoo penguin (Pygoscelis papua) |        5950|
|Gentoo penguin (Pygoscelis papua) |        5950|
|Gentoo penguin (Pygoscelis papua) |        5850|
|Gentoo penguin (Pygoscelis papua) |        5850|
|Gentoo penguin (Pygoscelis papua) |        5850|
|Gentoo penguin (Pygoscelis papua) |        5800|
|Gentoo penguin (Pygoscelis papua) |        5800|
|Gentoo penguin (Pygoscelis papua) |        5750|
|Gentoo penguin (Pygoscelis papua) |        5700|
|Gentoo penguin (Pygoscelis papua) |        5700|
|Gentoo penguin (Pygoscelis papua) |        5700|
|Gentoo penguin (Pygoscelis papua) |        5700|
|Gentoo penguin (Pygoscelis papua) |        5700|
|Gentoo penguin (Pygoscelis papua) |        5650|
|Gentoo penguin (Pygoscelis papua) |        5650|
|Gentoo penguin (Pygoscelis papua) |        5650|

</div>

## groupwise slicing


```r
penguins |> 
  group_by(species) |> 
  slice_max(order_by = body_mass_g,
            n = 3) |> 
  select(species, body_mass_g) |> 
  ungroup()
```

<div class="kable-table">

|species                                   | body_mass_g|
|:-----------------------------------------|-----------:|
|Adelie Penguin (Pygoscelis adeliae)       |        4775|
|Adelie Penguin (Pygoscelis adeliae)       |        4725|
|Adelie Penguin (Pygoscelis adeliae)       |        4700|
|Chinstrap penguin (Pygoscelis antarctica) |        4800|
|Chinstrap penguin (Pygoscelis antarctica) |        4550|
|Chinstrap penguin (Pygoscelis antarctica) |        4500|
|Gentoo penguin (Pygoscelis papua)         |        6300|
|Gentoo penguin (Pygoscelis papua)         |        6050|
|Gentoo penguin (Pygoscelis papua)         |        6000|
|Gentoo penguin (Pygoscelis papua)         |        6000|

</div>

## bootstrapping with slice


```r
set.seed(342)
bootstraps <- map(1:100, ~slice_sample(penguins, prop = .1, replace = TRUE))

bootstraps %>%
    map_dbl(~ mean(.$body_mass_g, na.rm = TRUE)) |> 
  tibble(x = _ ) |> 
ggplot(aes(x = x)) +
geom_histogram(fill = "grey80", color = "black")+
  geom_vline(data = penguins,
             aes(xintercept = mean(body_mass_g, na.rm = T)),
             linewidth = 2, colour = "red", linetype  ="dashed")
```

<img src="04-tidyverse_files/figure-html/unnamed-chunk-44-1.png" width="100%" style="display: block; margin: auto;" />



# Group work

The R4DS book demonstrates how functions can be used to run multiple models simultaneously. This technique is valuable for extracting meaningful insights from your data. A well-known example of this approach involves the Gapminder dataset. We will cover a brief version here: 

To find out how well culmen length can predict culmen depth we build a linear regression model.

Once we have created the model, we can retrieve the results parameters and test statistics
with the summary function:
`summary(model)`


```r
model <- lm(culmen_depth_mm ~ culmen_length_mm, data = penguins)

summary(model)
```

```
## 
## Call:
## lm(formula = culmen_depth_mm ~ culmen_length_mm, data = penguins)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -4.1381 -1.4263  0.0164  1.3841  4.5255 
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      20.88547    0.84388  24.749  < 2e-16 ***
## culmen_length_mm -0.08502    0.01907  -4.459 1.12e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.922 on 340 degrees of freedom
##   (2 observations deleted due to missingness)
## Multiple R-squared:  0.05525,	Adjusted R-squared:  0.05247 
## F-statistic: 19.88 on 1 and 340 DF,  p-value: 1.12e-05
```

Now we know that there are important covariates to consider - and the most appropriate method from an analysis perspective would be to include these as covariates within a single model


```r
model <- lm(culmen_depth_mm ~ culmen_length_mm * species, data = penguins)

summary(model)
```

```
Call:
lm(formula = culmen_depth_mm ~ culmen_length_mm * species, data = penguins)

Residuals:
    Min      1Q  Median      3Q     Max 
-2.6574 -0.6675 -0.0524  0.5383  3.5032 

Coefficients:
                                  Estimate Std. Error t value Pr(>|t|)    
(Intercept)                       11.40912    1.13812  10.025  < 2e-16 ***
culmen_length_mm                   0.17883    0.02927   6.110 2.76e-09 ***
speciesChinstrap                  -3.83998    2.05398  -1.870 0.062419 .  
speciesGentoo                     -6.15812    1.75451  -3.510 0.000509 ***
culmen_length_mm:speciesChinstrap  0.04338    0.04558   0.952 0.341895    
culmen_length_mm:speciesGentoo     0.02601    0.04054   0.642 0.521590    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.9548 on 336 degrees of freedom
  (2 observations deleted due to missingness)
Multiple R-squared:  0.7697,	Adjusted R-squared:  0.7662 
F-statistic: 224.5 on 5 and 336 DF,  p-value: < 2.2e-16

```

However, there may be occasions where we wish to apply simple models to each subpopulation in turn:


```r
penguins |> 
  group_by(species) |> 
  nest() |> 
  mutate(model = map(data, ~ lm(culmen_depth_mm ~ culmen_length_mm, data = .))) |> 
  mutate(tidy = map(model, broom::tidy)) |> 
  unnest(tidy)
```
```
A tibble:6 × 8
Groups:species [3]

Adelie	<tibble>	<S3: lm>	(Intercept)	11.4091245	1.33893250	
Adelie	<tibble>	<S3: lm>	culmen_length_mm	0.1788343	0.03443569	
Gentoo	<tibble>	<S3: lm>	(Intercept)	5.2510084	1.05480901	
Gentoo	<tibble>	<S3: lm>	culmen_length_mm	0.2048443	0.02215802	
Chinstrap	<tibble>	<S3: lm>	(Intercept)	7.5691401	1.55052928	
Chinstrap	<tibble>	<S3: lm>	culmen_length_mm	0.2222117	0.03167825	
6 rows | 1-6 of 8 columns

```

# Pivot

## pivot wider

<div class="info">
<p>Un-tidy data violates one of these three principles in one way or
another:</p>
<p>• Each variable forms a column • Each observation forms a row • Each
type of observation unit is a table</p>
</div>



```r
wk1 <- c(1,2,4,5)
wk2 <- c(3,4,1,0)
wk3 <- c(0,0,2,0)
penguin_id <- c("N15A1" , "N15A2" , "N18A1", "N71A2")

peng_obs <- tibble(penguin_id, wk1,wk2,wk3)
```

This data is untidy because a value that measures the same underlying attribute (number of observations) is split across three columns. Here wk1,wk2 and wk3 represent the underlying variable of observations split across three weeks.

We can use pivot to create a tidy representation of the data


```r
peng_obs |> 
  pivot_longer(
    cols = "wk1":"wk3",
    names_to = "week",
    values_to = "observations"
  )
```

<div class="kable-table">

|penguin_id |week | observations|
|:----------|:----|------------:|
|N15A1      |wk1  |            1|
|N15A1      |wk2  |            3|
|N15A1      |wk3  |            0|
|N15A2      |wk1  |            2|
|N15A2      |wk2  |            4|
|N15A2      |wk3  |            0|
|N18A1      |wk1  |            4|
|N18A1      |wk2  |            1|
|N18A1      |wk3  |            2|
|N71A2      |wk1  |            5|
|N71A2      |wk2  |            0|
|N71A2      |wk3  |            0|

</div>

We can tidy this dataframe further by removing the "wk" prefix:


```r
peng_obs |> 
  pivot_longer(
    cols = "wk1":"wk3",
    names_to = "week",
    names_prefix = "wk",
    values_to = "observations"
  )
```

<div class="kable-table">

|penguin_id |week | observations|
|:----------|:----|------------:|
|N15A1      |1    |            1|
|N15A1      |2    |            3|
|N15A1      |3    |            0|
|N15A2      |1    |            2|
|N15A2      |2    |            4|
|N15A2      |3    |            0|
|N18A1      |1    |            4|
|N18A1      |2    |            1|
|N18A1      |3    |            2|
|N71A2      |1    |            5|
|N71A2      |2    |            0|
|N71A2      |3    |            0|

</div>
<div class="warning">
<p>Note that the week column is still being treated as a character
string. using <code>names_transform</code> we can fix this</p>
</div>


```r
peng_obs |> 
  pivot_longer(
    cols = "wk1":"wk3",
    names_to = "week",
    names_prefix = "wk",
    names_transform = as.integer,
    values_to = "observations"
  )
```

<div class="kable-table">

|penguin_id | week| observations|
|:----------|----:|------------:|
|N15A1      |    1|            1|
|N15A1      |    2|            3|
|N15A1      |    3|            0|
|N15A2      |    1|            2|
|N15A2      |    2|            4|
|N15A2      |    3|            0|
|N18A1      |    1|            4|
|N18A1      |    2|            1|
|N18A1      |    3|            2|
|N71A2      |    1|            5|
|N71A2      |    2|            0|
|N71A2      |    3|            0|

</div>

## pivot longer

Suppose you would like to make a data frame wider because you would like to present the results in a human-readable table. To do this, you can use pivot_wider and provide arguments for its main parameters:

- id_cols: These columns are the identifiers for the observations. These column names
remain unchanged in the data frame. Their values form the rows of the transformed data
frame. By default, all columns except those specified in names_from and values_from
become id_cols.

-  names_from: These columns will be transformed into a wider format. Their values will
be converted to columns. If you specify more than one column for names_from, the
newly created column names will be a combination of the column values.

- values_from: The values of these columns will be used for the columns created with
names_from.


## pivot wider for summary tables


```r
penguins |> 
  group_by(species, island) |> 
  summarise(mean = mean(body_mass_g, na.rm = T))
```

<div class="kable-table">

|species                                   |island    |     mean|
|:-----------------------------------------|:---------|--------:|
|Adelie Penguin (Pygoscelis adeliae)       |Biscoe    | 3709.659|
|Adelie Penguin (Pygoscelis adeliae)       |Dream     | 3688.393|
|Adelie Penguin (Pygoscelis adeliae)       |Torgersen | 3706.373|
|Chinstrap penguin (Pygoscelis antarctica) |Dream     | 3733.088|
|Gentoo penguin (Pygoscelis papua)         |Biscoe    | 5076.016|

</div>




```r
penguins |> 
  group_by(species, island) |> 
  summarise(mean = mean(body_mass_g, na.rm = T)) |> 
  pivot_wider(names_from = c(species, island),
              values_from = mean,
              names_prefix = "mean_")
```

<div class="kable-table">

| mean_Adelie Penguin (Pygoscelis adeliae)_Biscoe| mean_Adelie Penguin (Pygoscelis adeliae)_Dream| mean_Adelie Penguin (Pygoscelis adeliae)_Torgersen| mean_Chinstrap penguin (Pygoscelis antarctica)_Dream| mean_Gentoo penguin (Pygoscelis papua)_Biscoe|
|-----------------------------------------------:|----------------------------------------------:|--------------------------------------------------:|----------------------------------------------------:|---------------------------------------------:|
|                                        3709.659|                                       3688.393|                                           3706.373|                                             3733.088|                                      5076.016|

</div>

# Writing Functions in Tidyverse

The goal here is to understand how to use tidy evaluation to write functions that incorporate `{tidyverse}` functions e.g. (mutate, select, filter) etc. 

Below is an example of some code to select a variable:


```r
penguins |> 
  select(species)
```

Put that exact working code into a function


```r
test_function <- function(select_var){
  penguins |> 
  select(select_var)
}

test_function(select_var = species)
```
```
Error: object 'species' not found

```

This error occurs becaus of *tidy evaluation*

<div class="info">
<p>Tidy evaluation: A framework for controlling how expressions and
variables in your code are evaluated by tidyverse functions.</p>
<ul>
<li><p>Allows programmers to select variables based on their position,
name, or type</p></li>
<li><p>Useful for passing variable names as inputs to functions that use
tidyverse packages like dplyr and ggplot2</p></li>
<li><p>{dplyr} verbs rely on tidy evaluation to resolve programming
commands</p></li>
</ul>
</div>

## Data masking

Data masking is a handy feature of tidyverse that makes it easier to program with dataframes. It allows you to reference columns wihout using `$`, whereas almost all base R functions use unmasked programming.

However, this makes it harder to create functions

Data masking is used by `arrange()`, `count()`, `filter()`, `group_by()`, `mutate()`, and `summarise()`. To check which type of tidy evaluation a function uses, check the help file. 


```r
test_filter_species <- function(filter_var) {
  penguins %>%
    filter(species == filter_var)
}

test_filter_species("Adelie") %>%
  glimpse()
```

```
## Rows: 0
## Columns: 19
## $ study_name        <chr> 
## $ sample_number     <dbl> 
## $ species           <chr> 
## $ region            <chr> 
## $ island            <chr> 
## $ stage             <chr> 
## $ individual_id     <chr> 
## $ clutch_completion <chr> 
## $ date_egg          <chr> 
## $ culmen_length_mm  <dbl> 
## $ culmen_depth_mm   <dbl> 
## $ flipper_length_mm <dbl> 
## $ body_mass_g       <dbl> 
## $ sex               <chr> 
## $ delta_15_n_o_oo   <dbl> 
## $ delta_13_c_o_oo   <dbl> 
## $ comments          <chr> 
## $ date_egg_proper   <date> 
## $ flipper_range     <fct>
```

By passing quoted arguments to the function, you can use it directly in the expression, and the function will evaluate it as if it were part of the data frame. 


```r
test_filter_general <- function(filter_condition) {
  penguins %>%
    filter(filter_condition)
}

test_filter_general("flipper_length_mm > 180") %>%
  glimpse()
```

```
Error in `filter()`:
ℹ In argument: `filter_condition`.
Caused by error:
! `..1` must be a logical vector, not the string "fliper_length_mm > 180".
Backtrace:
  1. test_filter_general("flipper_length_mm > 180") %>% glimpse()
 12. dplyr:::dplyr_internal_error(...)

```

However, we can avoid this by embracing the curly operators `{{.}}` this allows the data-masked argument to have its evaluation delayed until after the data frame columns are defined. With the `{{` operator you can tunnel data-variables (i.e. columns from the data frames) through arg-variables (function arguments). 


```r
test_filter_general <- function(filter_condition) {
  penguins %>%
    filter({{filter_condition}})
}

test_filter_general(flipper_length_mm > 180) %>%
  glimpse()
```

```
## Rows: 329
## Columns: 19
## $ study_name        <chr> "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708…
## $ sample_number     <dbl> 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, …
## $ species           <chr> "Adelie Penguin (Pygoscelis adeliae)", "Adelie Pengu…
## $ region            <chr> "Anvers", "Anvers", "Anvers", "Anvers", "Anvers", "A…
## $ island            <chr> "Torgersen", "Torgersen", "Torgersen", "Torgersen", …
## $ stage             <chr> "Adult, 1 Egg Stage", "Adult, 1 Egg Stage", "Adult, …
## $ individual_id     <chr> "N1A1", "N1A2", "N2A1", "N3A1", "N3A2", "N4A1", "N4A…
## $ clutch_completion <chr> "Yes", "Yes", "Yes", "Yes", "Yes", "No", "No", "Yes"…
## $ date_egg          <chr> "11/11/2007", "11/11/2007", "16/11/2007", "16/11/200…
## $ culmen_length_mm  <dbl> 39.1, 39.5, 40.3, 36.7, 39.3, 38.9, 39.2, 34.1, 42.0…
## $ culmen_depth_mm   <dbl> 18.7, 17.4, 18.0, 19.3, 20.6, 17.8, 19.6, 18.1, 20.2…
## $ flipper_length_mm <dbl> 181, 186, 195, 193, 190, 181, 195, 193, 190, 186, 18…
## $ body_mass_g       <dbl> 3750, 3800, 3250, 3450, 3650, 3625, 4675, 3475, 4250…
## $ sex               <chr> "MALE", "FEMALE", "FEMALE", "FEMALE", "MALE", "FEMAL…
## $ delta_15_n_o_oo   <dbl> NA, 8.94956, 8.36821, 8.76651, 8.66496, 9.18718, 9.4…
## $ delta_13_c_o_oo   <dbl> NA, -24.69454, -25.33302, -25.32426, -25.29805, -25.…
## $ comments          <chr> "Not enough blood for isotopes.", NA, NA, NA, NA, "N…
## $ date_egg_proper   <date> 2007-11-11, 2007-11-11, 2007-11-16, 2007-11-16, 200…
## $ flipper_range     <fct> small, small, medium, medium, small, small, medium, …
```

Let's try another data-masked function


```r
summary_table <- function(df, var){
  df |> 
    summarise(mean = mean({{var}}, na.rm = T),
              sd = sd({{var}}, na.rm = T))
}

summary_table(penguins, body_mass_g)
```

<div class="kable-table">

|     mean|       sd|
|--------:|--------:|
| 4201.754| 801.9545|

</div>

### Alternative to `{{}}`

The `{{.}}` is a shortcut for `!!enquo(.)` Where `rlang::enquo()` captures and quote an argument or an expression. The result of `enquo()` is a **quosure**, which is a combination of the quoted expression and its associated environment. 

`!!` This is the unquote operator. It's used to unquote or unsplice the contents of a quosure. In other words, it takes the quoted expression out of the quosure and evaluates it. We can see how this would work for one of our previous examples: 


```r
test_filter_general <- function(filter_condition) {
  
  filter_quo <- enquo(filter_condition)
  
  penguins %>%
    filter(!!filter_quo)
}

test_filter_general(flipper_length_mm > 180) %>%
  glimpse()
```

```
## Rows: 329
## Columns: 19
## $ study_name        <chr> "PAL0708", "PAL0708", "PAL0708", "PAL0708", "PAL0708…
## $ sample_number     <dbl> 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, …
## $ species           <chr> "Adelie Penguin (Pygoscelis adeliae)", "Adelie Pengu…
## $ region            <chr> "Anvers", "Anvers", "Anvers", "Anvers", "Anvers", "A…
## $ island            <chr> "Torgersen", "Torgersen", "Torgersen", "Torgersen", …
## $ stage             <chr> "Adult, 1 Egg Stage", "Adult, 1 Egg Stage", "Adult, …
## $ individual_id     <chr> "N1A1", "N1A2", "N2A1", "N3A1", "N3A2", "N4A1", "N4A…
## $ clutch_completion <chr> "Yes", "Yes", "Yes", "Yes", "Yes", "No", "No", "Yes"…
## $ date_egg          <chr> "11/11/2007", "11/11/2007", "16/11/2007", "16/11/200…
## $ culmen_length_mm  <dbl> 39.1, 39.5, 40.3, 36.7, 39.3, 38.9, 39.2, 34.1, 42.0…
## $ culmen_depth_mm   <dbl> 18.7, 17.4, 18.0, 19.3, 20.6, 17.8, 19.6, 18.1, 20.2…
## $ flipper_length_mm <dbl> 181, 186, 195, 193, 190, 181, 195, 193, 190, 186, 18…
## $ body_mass_g       <dbl> 3750, 3800, 3250, 3450, 3650, 3625, 4675, 3475, 4250…
## $ sex               <chr> "MALE", "FEMALE", "FEMALE", "FEMALE", "MALE", "FEMAL…
## $ delta_15_n_o_oo   <dbl> NA, 8.94956, 8.36821, 8.76651, 8.66496, 9.18718, 9.4…
## $ delta_13_c_o_oo   <dbl> NA, -24.69454, -25.33302, -25.32426, -25.29805, -25.…
## $ comments          <chr> "Not enough blood for isotopes.", NA, NA, NA, NA, "N…
## $ date_egg_proper   <date> 2007-11-11, 2007-11-11, 2007-11-16, 2007-11-16, 200…
## $ flipper_range     <fct> small, small, medium, medium, small, small, medium, …
```

## tidy-select

When using functions that use tidy-select, we put variable names in quotes and use th `all_of` and `any_of` functions.


```r
my_select_function <- function(select_variable){
  penguins |> 
    dplyr::select(select_variable)
  }

my_select_function(species) |> 
  glimpse()
```

```
Error: object 'species' not found

```


```r
my_select_function <- function(select_variable){
  penguins |> 
    dplyr::select(select_variable)
  }

my_select_function("species") |> 
  glimpse()
```

```
Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
Please use `all_of()` or `any_of()` instead.
# Was:
data %>% select(select_variable)

# Now:
data %>% select(all_of(select_variable))

```

- `any_of()`: selecting any of the listed variables

- `all_of()`: for strict selection. If any of the variables in the character vector is missing, an error is thrown

- Can also use `!all_of()` to select all variables not found in the character vector supplied to all_of()



```r
my_select_function <- function(select_variable){
  penguins |> 
    dplyr::select(dplyr::all_of(select_variable))
  }

my_select_function(select_variable = c("species", "sex")) |> 
  glimpse()
```

```
## Rows: 344
## Columns: 2
## $ species <chr> "Adelie Penguin (Pygoscelis adeliae)", "Adelie Penguin (Pygosc…
## $ sex     <chr> "MALE", "FEMALE", "FEMALE", NA, "FEMALE", "MALE", "FEMALE", "M…
```




## Practice

<div class="panel panel-default"><div class="panel-heading"> Task </div><div class="panel-body"> 

Write a `function` that uses filter to take any two of the penguin species then selects one numeric variable e.g. body_mass_g and compares them with a violin plot (`geom_violin()`)

 </div></div>


<button id="displayTextunnamed-chunk-68" onclick="javascript:toggle('unnamed-chunk-68');">Show Solution</button>

<div id="toggleTextunnamed-chunk-68" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
compare_species_plot <- function(data, species_1, species_2, feature) {
    
  filtered_data <- data |> 
        filter(species %in% c(species_1, species_2))
    
    # Create a conditional ggplot
    ggplot(filtered_data, aes(x = species, y = {{feature}}))+ 
      geom_violin()
        

}

compare_species_plot(penguins, "Adelie", "Chinstrap", culmen_length_mm)
```

<img src="04-tidyverse_files/figure-html/unnamed-chunk-71-1.png" width="100%" style="display: block; margin: auto;" />
</div></div></div>

In the example below I have used `enquo` to enable conversion to character strings, this means all of the function arguments can be provided without "quotes". 

<button id="displayTextunnamed-chunk-69" onclick="javascript:toggle('unnamed-chunk-69');">Show Solution</button>

<div id="toggleTextunnamed-chunk-69" style="display: none"><div class="panel panel-default"><div class="panel-heading panel-heading1"> Solution </div><div class="panel-body">

```r
compare_species_plot <- function(data, species_1, species_2, feature) {
    
   
    
    # Quote species_1 and species_2 using quosures
    species_1_quo <- quo_name(enquo(species_1))
    species_2_quo <- quo_name(enquo(species_2))
    

    filtered_data <- data |> 
        filter(species %in% c(species_1_quo, species_2_quo))
    
    # Create a conditional ggplot
    ggplot(filtered_data, aes(x = species, y = {{feature}})) +
        geom_violin()
}

# Example usage without quotes for species names

compare_species_plot(penguins, Adelie, Chinstrap, culmen_length_mm)
```
</div></div></div>


## Practice

Can you write your own custom function in tidyverse? 



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
##  [1] janitor_2.2.0      knitr_1.43         webexercises_1.1.0 glossary_1.0.0    
##  [5] lubridate_1.9.2    forcats_1.0.0      stringr_1.5.0      dplyr_1.1.2       
##  [9] purrr_1.0.1        readr_2.1.4        tidyr_1.3.0        tibble_3.2.1      
## [13] ggplot2_3.4.2      tidyverse_2.0.0   
## 
## loaded via a namespace (and not attached):
##  [1] sass_0.4.6        utf8_1.2.3        generics_0.1.3    xml2_1.3.5       
##  [5] stringi_1.7.12    hms_1.1.3         digest_0.6.33     magrittr_2.0.3   
##  [9] evaluate_0.21     grid_4.3.1        timechange_0.2.0  bookdown_0.34    
## [13] fastmap_1.1.1     jsonlite_1.8.7    fansi_1.0.4       scales_1.2.1     
## [17] jquerylib_0.1.4   cli_3.6.1         rlang_1.1.1       munsell_0.5.0    
## [21] withr_2.5.0       cachem_1.0.8      yaml_2.3.7        tools_4.3.1      
## [25] tzdb_0.4.0        memoise_2.0.1     colorspace_2.1-0  vctrs_0.6.3      
## [29] R6_2.5.1          lifecycle_1.0.3   snakecase_0.11.0  fs_1.6.2         
## [33] pkgconfig_2.0.3   pillar_1.9.0      bslib_0.5.0       gtable_0.3.3     
## [37] glue_1.6.2        xfun_0.39         tidyselect_1.2.0  rstudioapi_0.15.0
## [41] htmltools_0.5.5   rmarkdown_2.23    compiler_4.3.1    downlit_0.4.3
```
