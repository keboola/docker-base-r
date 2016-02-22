FROM keboola/base
MAINTAINER Ondrej Popelka <ondrej.popelka@keboola.com>

# Package version to install
ENV R_VERSION 3.2.1
# Set default R locale to UTF8
ENV LANG en_US.UTF-8

WORKDIR /tmp

# Install packages
RUN yum -y update \
    && yum -y install \
        openssl \
        openssl-devel \
        libcurl \
        libcurl-devel \
        libxml2-devel \
        glibc-common \
        git \
        ed \
        gcc \
        gcc-c++ \
        gcc-gfortran \
        make \
        readline-devel \        
        which \ 
        unzip \
        texlive-collection-basic \
        texlive-collection-fontsrecommended \
        texlive-collection-htmlxml \ 
        texlive-collection-latex \ 
        texlive-collection-latexrecommended \ 
        texlive-collection-xetex \
        java-1.8.0-openjdk-devel \
        libX11-devel \
        libXt-devel \
        cairo-devel \
        libXmu-devel \
        pango-devel \
        libjpeg-turbo-devel \
        perl-Data-Dumper \
        gsl-devel \
    && yum clean all

# Build R
RUN mkdir /usr/local/src/R \
    && cd /usr/local/src/R \
    && curl -O https://cran.r-project.org/src/base/R-3/R-${R_VERSION}.tar.gz \
    && tar xzvf R-${R_VERSION}.tar.gz \
    && cd R-${R_VERSION} \ 
    && ./configure --with-x=yes --enable-R-shlib \
    && make \
    && make check 

ENV R_HOME=/usr/local/src/R/R-${R_VERSION}
ENV PATH=/usr/local/src/R:$PATH

# Cleanup, Setup
RUN rm -rf /usr/local/src/R/R-${R_VERSION}/src \
    && rm -f R /usr/local/src/R/Rscript R-${R_VERSION}.tar.gz \ 
    && ln -s /usr/local/src/R/R-${R_VERSION}/bin/R /usr/local/src/R/R \ 
    && ln -s /usr/local/src/R/R-${R_VERSION}/bin/Rscript /usr/local/src/R/Rscript \ 
    && mkdir /usr/share/doc/R-${R_VERSION} \
    && echo 'options(repos = c(CRAN = "https://cran.r-project.org", "https://cran.rstudio.com/", "https://mirrors.nics.utk.edu/cran/", "https://cran.mtu.edu/"))' >> ${R_HOME}/etc/Rprofile.site \
    && echo 'options(download.file.method = "libcurl")' >> ${R_HOME}/etc/Rprofile.site 
