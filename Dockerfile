FROM ubuntu:14.04
MAINTAINER Chris Wegrzyn <chris @ bluelabs.com>

RUN apt-get update && apt-get clean
RUN apt-get -y install wget git curl
RUN apt-get install -q -y openjdk-7-jre-headless && apt-get clean

RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins && apt-get clean

# Install docker, but don't run
RUN curl -sSL -O https://get.docker.io/builds/Linux/x86_64/docker-1.1.2 && \
  chmod +x docker-1.1.2 && \
  mv docker-1.1.2 /usr/local/bin/docker

# Install sbt
RUN wget http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb && dpkg -i sbt-0.13.5.deb

VOLUME /jenkins
ENV JENKINS_HOME /jenkins

EXPOSE 8080

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

CMD /usr/local/bin/run
