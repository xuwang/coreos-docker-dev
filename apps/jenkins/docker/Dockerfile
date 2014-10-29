FROM jenkins
USER root
# Install Docker 
RUN apt-get update && apt-get install -qqy docker.io && \
	ln -sf /usr/bin/docker.io /usr/local/bin/docker 
USER jenkins
