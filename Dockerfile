FROM rocker/r-ver

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  file \
  git \
  libapparmor1 \
  libcurl4-openssl-dev \
  libedit2 \
  libssl-dev \
  lsb-release \
  psmisc \
  python-setuptools \
  sudo \
  wget \
  libxml2-dev \
  libcairo2-dev \
  libsqlite-dev \
  libmariadbd-dev \
  libmariadb-client-lgpl-dev \
  libpq-dev \
  libssh2-1-dev \
  && R -e "source('https://bioconductor.org/biocLite.R')" \
  && install2.r --error devtools \
  && R -e "devtools::install_github('thomasp85/fiery'); install.packages('routr')"

## Switch from root
RUN useradd --create-home --shell /bin/bash ruser
USER ruser
WORKDIR /home/ruser

ADD fiery.R /home/ruser/

EXPOSE 8080

CMD ["Rscript", "fiery.R"]
