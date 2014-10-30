FROM jenkins
USER root
# Install Docker 
RUN apt-get update && apt-get install -qqy docker.io && \
	ln -sf /usr/bin/docker.io /usr/local/bin/docker
RUN  apt-get install -qqy python python-dev python-distribute python-pip
RUN pip install awscli s3cmd

USER jenkins
