
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kmodesFlow

<!-- badges: start -->
<!-- badges: end -->

The `kmodesFlow` package provides convenience functions to improve workflow with kmodes modeling.
It allows users to easily fit multiple models, assess model
fit, and examine results with automated visualizations.

## Installation

You can install the development version of kmodesFlow from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Sdbock/kmodesFlow")
```

## Tutorial

The workhorse of the `kmodesFlow` package is the `fit_models()`
function. To fit 8 models, with 1 through 8-k solutions, simply specify
“1:8” as the number for k:

``` r
library(kmodesFlow)

fit_models(
  data = data,
  k = 1:8,
  seed = 1234
)
```

The `fit_models()` returns a tibble with the number of rows equal to the
number of models specified. The columns contain information about
cluster assignment for respondents, model fit, and visualization of
cluster profiles. To examine the modal category for each variable within
clusters, print the `table_cluster_modes` column for the relevant model.
I suggest using the `pluck()` function to identify and print the desired
row and column. To look at the modes across clusters for the
![k = 3](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;k%20%3D%203 "k = 3")
model:

``` r
pluck(model_output, "table_cluster_modes", 3)
```

There is also a heat map of the distributions of variable levels within
each cluster, which can be accessed in the
“table_attribute_distribution” column:

``` r
pluck(model_output, "table_attribute_distribution", 3)
```

Finally, the `plot_elbow()` function takes a `fit_models()` output and
returns a plot of the sum of within-cluster differences across each
level of
![k](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;k "k").
This “elbow” plot is a common tool in determining the optimal number of
clusters.

``` r
plot_elbow(model_output)
```

For a fuller overview, see the `kmodesFlow` [demo](https://sdbock.github.io/kmodesFlow/).
