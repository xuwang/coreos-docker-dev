#!/bin/bash
# This script start all necessary units for the nodeapp demo
n=${1:-1}
for i in $(seq $n)
do
	fleetctl start nodeapp-backend/units/nodeapp@$i.service
	fleetctl start /var/lib/apps/confd/units/confd@$i.service
	fleetctl start units/haproxy@$i.service
	sleep 2
done


