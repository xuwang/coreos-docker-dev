##[Logstash](http://logstash.net/docs/1.4.2/tutorials/getting-started-with-logstash)

* It exposes /var/lib/logstash/config volume
* The default logstash config is /var/lib/logstash/config/default.conf
* It listens on port TCP 5000, for lines of JSON.
* The default setup expects to be linked to an elasticsearch container that exposes port 9200.

Note: if skydns is running the elasticsearch could be linked by the dns name.

