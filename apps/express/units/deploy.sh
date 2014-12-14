#!/bin/bash
#
# If a unit is changed, then need to destroy the unit first before restart.
# stop / start will re-pull a new image.

# Default to run on all machines
count=$(fleetctl list-units |grep nodeapp | wc -l)
forcereload=false
reload=$1
sitename=$2
sleep=2

function forcereload {
    fleetctl destroy $unit && sleep $sleep && fleetctl submit $unit && fleetctl start $unit
}


function reload {
    echo stop $unit
    fleetctl stop $unit
    until fleetctl list-units | grep $unit| grep -q failed; do sleep $sleep; done
    echo start $unit
    fleetctl start $unit
}


if [ -z $sitename ];
then
    echo "Service name is required."
    exit 1
else
    # units location
    sitedir=/var/lib/apps/sites/$sitename/units
    [ ! -d /var/lib/apps/sites/$sitename/units ] && sitedir=$PWD
fi

if [ -f $sitedir/$sitename\@.service ];
then
    for i in $(seq $count)
    do
        unit=$sitename\@$i.service
        cd $sitedir
        reload 
        until fleetctl list-units | grep $unit| grep -q active; do sleep $sleep; done
    done
else
    echo "$sitedir/$sitename\@.service doesn't exist."
    exit 1
fi

exit 0
