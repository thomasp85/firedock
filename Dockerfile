FROM rocker/tidyverse

RUN R -e "devtools::install_github('thomasp85/fiery'); devtools::install_github('thomasp85/routr')"
