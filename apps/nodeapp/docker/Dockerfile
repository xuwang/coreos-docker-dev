#FROM dockerfile/nodejs:latest
FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y curl wget nodejs

ADD server.js /server.js

EXPOSE 8000
CMD    ["/usr/bin/nodejs", "/server.js"]