FROM ubuntu:14.04
MAINTAINER govind.mulinti@whishworks.com
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common
# install java
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer
# MuleSoft EE installation:
# This line can reference either a web url (ADD), network share or local file (COPY)
ADD https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.7.0/mule-standalone-3.7.0.tar.gz /opt/
WORKDIR /opt
RUN echo "6814d3dffb5d8f308101ebb3f4e3224a mule-standalone-3.7.0.tar.gz" | md5sum -c
RUN tar -xzvf /opt/mule-standalone-3.7.0.tar.gz
RUN ln -s mule-standalone-3.7.0/ mule
RUN rm -f mule-standalone-3.7.0.tar.gz
# Configure external access:
# Mule remote debugger
EXPOSE 5000
# Mule JMX port (must match Mule config file)
EXPOSE 1098
# Mule MMC agent port
EXPOSE 7777
# Environment and execution:
ENV MULE_BASE /opt/mule
WORKDIR /opt/mule-standalone-3.7.0
CMD /opt/mule/bin/mule
