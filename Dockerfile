FROM keboola/base
MAINTAINER Ondrej Popelka <ondrej.popelka@keboola.com>

WORKDIR /tmp

# Install packages
RUN yum -y install \
	openssl \
	openssl-devel \
	libcurl \
	libcurl-devel \
	libxml2-devel \
	git \
	R

# Create html folder under the R directory (name of directory depends on version) - required for some R packages
RUN find /usr/share/doc/ -name R* -exec mkdir '{}/html' \;
