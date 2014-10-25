#!/bin/bash

#fleetctl destroy *.service && sleep 3
#fleetctl submit *.service

fleetctl start --no-block elasticsearch@{1..1}.service
fleetctl start --no-block logstash@{1..1}.service
fleetctl start kibana.service
fleetctl start logging.service