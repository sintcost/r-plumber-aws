FROM trestletech/plumber

MAINTAINER Shingo TAKAHASHI <shingo3takahashi@gmail.com>

RUN apt-get -y upgrade \
&& apt-get -y update \
&& apt-get -y autoremove \
&& apt-get -y clean

RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssh2-1-dev \
    git \
    pandoc

RUN wget http://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
RUN pip install boto3
RUN pip install awscli

RUN apt-get -y autoremove \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN R -e 'install.packages(c( "devtools" ))'
RUN R -e 'install.packages(c( "tidyverse", "lubridate"))'

RUN R -e 'install.packages(c( "foreach", "iterators", "doParallel"))'
RUN R -e 'install.packages(c( "jsonlite" ))'
RUN R -e 'install.packages(c( "aws.signature", "aws.s3"))'
RUN R -e 'devtools::install_github(c( "orenov/Rawscli"))'

RUN R -e 'install.packages(c( "ggplot2", "plotly", "htmlwidgets"))'
RUN R -e 'devtools::install_github(c( "trestletech/plumber"))'

RUN R -e 'install.packages(c( "caret", "DMwR"))'
RUN R -e 'install.packages(c( "NMF", "pvclust"))'
