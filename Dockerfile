FROM ubuntu:14.04
MAINTAINER Banjo

# Install base packages.
RUN \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y curl && \
    apt-get install -y nginx && \
    apt-get install -y software-properties-common && \
    apt-get install -y unzip && \
    rm -rf /var/lib/apt/lists/*

# Install java 8.
RUN \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/*  && \
    rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Copy web app
COPY build/distributions/unconference.zip /tmp/

# Unzip to www
RUN unzip /tmp/unconference.zip -d /var/www/

# Expose web app port
EXPOSE 3000

# Run the app
CMD ["/var/www/unconference/bin/unconference"]
