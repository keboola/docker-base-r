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
		texlive-collection-basic \
		texlive-collection-fontsrecommended \
		texlive-collection-htmlxml \ 
		texlive-collection-latex \ 
		texlive-collection-latexrecommended \ 
		texlive-collection-xetex \
  		java-1.8.0-openjdk-devel \
	&& yum clean all

# Build R
RUN mkdir /usr/local/src/R \
	&& cd /usr/local/src/R \
 	&& curl -O http://cran.utstat.utoronto.ca/src/base/R-3/R-${R_VERSION}.tar.gz \
 	&& tar xzvf R-${R_VERSION}.tar.gz \
 	&& cd R-${R_VERSION} \ 
	&& ./configure --with-x=no \
	&& make \
	&& make check 

# Cleanup, Setup
RUN rm -rf /usr/local/src/R/R-${R_VERSION}/src \
 	&& rm -f R /usr/local/src/R/Rscript R-${R_VERSION}.tar.gz \ 
 	&& ln -s /usr/local/src/R/R-${R_VERSION}/bin/R /usr/local/src/R/R \ 
 	&& ln -s /usr/local/src/R/R-${R_VERSION}/bin/Rscript /usr/local/src/R/Rscript \ 
	&& mkdir /usr/share/doc/R-${R_VERSION} \
	&& mkdir /etc/R \
	&& PATH=/usr/local/src/R:$PATH \
	&& echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site 
