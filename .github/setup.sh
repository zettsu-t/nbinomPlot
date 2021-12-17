#!/bin/bash
sudo apt-get install -y git-core imagemagick libboost-dev libcairo2-dev libcurl4-openssl-dev libgit2-dev libicu-dev libmagic-dev libmagick++-dev libpng-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc qpdf zlib1g-dev
Rscript -e 'install.packages(c("remotes"))'
Rscript -e 'remotes::install_deps(dependencies = TRUE)'
