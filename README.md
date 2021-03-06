
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nbinomPlot

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/zettsu-t/nbinomPlot/workflows/R-CMD-check/badge.svg)](https://github.com/zettsu-t/nbinomPlot/actions)
<!-- badges: end -->

The goal of nbinomPlot is to show an example of how to build, test, and
deploy a production-grade Shiny app.

![Sample Page](man/images/initital_screen.png)

## Installation

``` r
devtools::install_github("zettsu-t/nbinomPlot")
```

## Example

This is a basic example that shows you how to launch the nbinomPlot app:

``` r
library(nbinomPlot)
run_app()
```

## Testing

This is an example to test this app.

``` r
library(devtools)
# This may skip some tests due to non utf8 locale
devtools::test()
Sys.setlocale("LC_MESSAGES", 'en_US.UTF-8')
Sys.setenv(LANG = 'en_US.UTF-8')
# Run again
devtools::test()
```

## Run on Shiny Server

Build and run a Docker container with **Dockerfile_shiny**

``` bash
docker build -f Dockerfile_shiny -t nbinom .
docker run -e PASSWORD=yourpassword -p 3838:3838 -p 8787:8787 -v /path/to/nbinomPlot:/home/rstudio/work -d nbinom
```

and launch **shiny-server** on Terminal of an RStudio Server in the
container, and you can access the nbinomPlot app at
<http://example.com:3838/nbinomPlot>. Note that you have to replace the
URL with an actual server.

``` bash
sudo shiny-server &
```

## Format, analyze, and count code

You can run a code formatter, a static code analyzer, and count lines of
code.

``` r
library(styler)
library(lintr)
styler::style_dir()
lintr::lint_dir("R")
lintr::lint_dir("tests")
source("dev/cloc_package.R", echo = TRUE)
```
