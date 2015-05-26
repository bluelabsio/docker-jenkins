FROM ubuntu:14.04
MAINTAINER Chris Wegrzyn <chris @ bluelabs.com>

RUN apt-get update -qq && \
  apt-get install -qy \
    wget \
    git \
    curl \
    openjdk-7-jre-headless \
    apt-transport-https \
    ca-certificates \
    lxc \
    iptables \
    && \
  apt-get clean

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ubuntu/ | sh

# Install Jenkins
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list && \
  wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins && apt-get clean

# Install sbt
RUN wget https://dl.bintray.com/sbt/debian/sbt-0.13.8.deb && dpkg -i sbt-0.13.8.deb

VOLUME /jenkins
ENV JENKINS_HOME /jenkins

EXPOSE 8080

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

CMD /usr/local/bin/run
