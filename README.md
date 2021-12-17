
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
Sys.setlocale("LC_MESSAGES", 'en_US.UTF-8')
Sys.setenv(LANG = 'en_US.UTF-8')
devtools::test()
```

## Run on Shiny Server

Build and run a Docker container with **Dockerfile_shiny**

``` bash
docker build -f Dockerfile_shiny -t nbinom .
docker run -t nbinom
```

and launch **shiny-server** in the container, and you can access the
nbinomPlot app at <http://example.com:3838/nbinomPlot>. Note that you
have to replace the URL with an actual server.
