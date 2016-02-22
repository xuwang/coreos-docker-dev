#!/bin/bash
# This script start all necessary units for the nodeapp demo
n=${1:-1}
for i in $(seq $n)
do
	fleetctl destroy  nodeapp-backend/units/nodeapp@$i.service
	fleetctl destroy  /var/lib/apps/confd/units/confd@$i.service
	fleetctl destroy  units/haproxy@$i.service
	sleep 2
done


