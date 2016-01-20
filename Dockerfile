# VERSION 1.0.1
FROM keboola/base
MAINTAINER Ondrej Popelka <ondrej.popelka@keboola.com>

WORKDIR /tmp

# Install packages
RUN yum -y update && \
	yum -y install \
		openssl \
		openssl-devel \
		libcurl \
		libcurl-devel \
		libxml2-devel \
		glibc-common \
		git \
		ed \
		tar \
		R-3.2.3 && \
	yum clean all

# Create html folder under the R directory (name of directory depends on version) - required for some R packages
RUN find /usr/share/doc/ -name 'R*' -exec mkdir '{}/html' \;

# Set default R locale to UTF8
ENV LANG en_US.UTF-8
