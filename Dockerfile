FROM rocker/r-ver:4.1.2
RUN apt-get update && apt-get install -y  git-core imagemagick libcurl4-openssl-dev libgit2-dev libicu-dev libmagic-dev libmagick++-dev libpng-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("rlang",upgrade="never", version = "0.4.11")'
RUN Rscript -e 'remotes::install_version("tibble",upgrade="never", version = "3.1.1")'
RUN Rscript -e 'remotes::install_version("png",upgrade="never", version = "0.1-7")'
RUN Rscript -e 'remotes::install_version("R6",upgrade="never", version = "2.5.0")'
RUN Rscript -e 'remotes::install_version("curl",upgrade="never", version = "4.3.2")'
RUN Rscript -e 'remotes::install_version("base64enc",upgrade="never", version = "0.1-3")'
RUN Rscript -e 'remotes::install_version("purrr",upgrade="never", version = "0.3.4")'
RUN Rscript -e 'remotes::install_version("stringr",upgrade="never", version = "1.4.0")'
RUN Rscript -e 'remotes::install_version("Rcpp",upgrade="never", version = "1.0.7")'
RUN Rscript -e 'remotes::install_version("knitr",upgrade="never", version = "1.33")'
RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "3.0.2")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.6.0")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("styler",upgrade="never", version = "1.6.2")'
RUN Rscript -e 'remotes::install_version("shinytest",upgrade="never", version = "1.5.0")'
RUN Rscript -e 'remotes::install_version("rmarkdown",upgrade="never", version = "2.11")'
RUN Rscript -e 'remotes::install_version("magick",upgrade="never", version = "2.7.3")'
RUN Rscript -e 'remotes::install_version("lintr",upgrade="never", version = "2.0.1")'
RUN Rscript -e 'remotes::install_version("dplyr",upgrade="never", version = "1.0.7")'
RUN Rscript -e 'remotes::install_version("covr",upgrade="never", version = "3.5.1")'
RUN Rscript -e 'remotes::install_version("spelling",upgrade="never", version = "2.2")'
RUN Rscript -e 'remotes::install_version("shinyjs",upgrade="never", version = "2.0.0")'
RUN Rscript -e 'remotes::install_version("gargoyle",upgrade="never", version = "0.0.1")'
RUN Rscript -e 'remotes::install_version("readr",upgrade="never", version = "2.1.0")'
RUN Rscript -e 'remotes::install_version("ggplot2",upgrade="never", version = "3.3.4")'
RUN Rscript -e 'remotes::install_version("BH",upgrade="never", version = "1.75.0-0")'
RUN Rscript -e 'remotes::install_version("globals",upgrade="never", version = "0.14.0")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.3.1")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
RUN rm -rf /build_zone
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');nbinomPlot::run_app()"
