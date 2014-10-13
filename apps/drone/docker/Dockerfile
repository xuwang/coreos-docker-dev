# Pulled from https://github.com/drone/drone/blob/master/Dockerfile
#
# This is a Docker image for the Drone CI system.
# Use the following command to start the container:
#    docker run -p 127.0.0.1:80:80 -t drone/drone

FROM google/golang

RUN apt-get update
RUN apt-get -y install zip libsqlite3-dev sqlite3 1> /dev/null 2> /dev/null

ADD . /gopath/src/github.com/drone/drone/
WORKDIR /gopath/src/github.com/drone/drone

RUN make deps build embed install

VOLUME /data

# Expose the Drone.io port
EXPOSE 8080

# The command we'll be running when the container starts
CMD /usr/local/bin/droned --datasource="/data/drone.sqlite"