This container expects to be linked to an elasticsearch container that exposes port 9200.

It listens on port TCP 5000, for lines of JSON.

It exposes /var/lib/logstash/config volume
The default logstash config is /var/lib/logstash/config/default.conf
