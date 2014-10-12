# Pull from base Ubuntu image
FROM ubuntu:14.04

# Do system updates and install dependencies
RUN apt-get update
RUN apt-get -y upgrade
RUN sudo apt-get -y install git wget
RUN apt-get clean

# Download Drone.io
RUN wget http://downloads.drone.io/latest/drone.deb
RUN dpkg -i drone.deb

VOLUME /data

# Expose the Drone.io port
EXPOSE 8080

# The command we'll be running when the container starts
CMD /usr/local/bin/droned --datasource="/data/drone.sqlite"