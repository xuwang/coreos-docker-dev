# Based on https://github.com/drone/drone/blob/master/Dockerfile
#
# This is a Docker image for the Drone CI system.
# Use the following command to start the container:
#    docker run -p 127.0.0.1:80:80 -t drone/drone

FROM google/golang:stable

RUN apt-get update
RUN apt-get -y install zip libsqlite3-dev sqlite3 1> /dev/null 2> /dev/null

RUN git clone https://github.com/drone/drone /gopath/src/github.com/drone/drone && \
	cd /gopath/src/github.com/drone/drone && \
	make deps build embed install

ADD ./drone.toml /etc/drone/drone.toml

VOLUME /data
VOLUME /etc/drone

# Expose the Drone.io port
EXPOSE 80

# The command we'll be running when the container starts
CMD /usr/local/bin/droned --config=/etc/drone/drone.toml