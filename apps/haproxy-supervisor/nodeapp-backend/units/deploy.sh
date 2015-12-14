#!/bin/bash
#
# If a unit is changed, then you need to destroy the unit first before restart.
# If an image is given, the script pull the image first before reload dockers.
# stop / start will re-pull a new image.
#
# Provison on default 'sites'
# E.g ./deploy.sh reload history
# 
# Provision on drush 
# E.g ./deploy.sh reload history-ssh drush 
#
# Command arguments

cmd=${1}
service=${2}
role=${3}
image=${4}

[[ ${role} = 'drush' ]] && role=ssh

# Waitting time between status changes
sleep=2

function dockerpull {
  docker pull $image
}

# Functions
function destroy {
  u=${old_unit:-${unit}}
  fleetctl destroy ${u}
  until fleetctl list-units | grep -c ${u} | grep -q '^0$'; do
    sleep $sleep
  done
}

function stop {
  u=${old_unit:-${unit}}
  echo stop ${u}
  # check that unit is running, otherwise test will fail
  if fleetctl list-units | grep -q ${u}; then
    fleetctl stop ${u}
    until fleetctl list-units | grep ${u} | egrep -q 'failed|dead'; do
      sleep $sleep
    done
    echo $(fleetctl list-units --fields unit,sub | grep ${u})
  fi
}

function start {
  u=${old_unit:-${unit}}
  echo start ${u}
  fleetctl start ${unit}
  until fleetctl list-units | grep ${unit} | grep -q running; do
    sleep $sleep
  done
  echo $(fleetctl list-units --fields unit,sub | grep ${u})
}

function reload {
  destroy && start
}

function restart {
  stop && start
}

# Main
case $cmd in
    reload|destroy|restart|start|stop)
        [[ -z ${service} ]] && echo "service name is required" && exit 1
        ;;
    help)
        echo "deploy.sh reload|destroy|restart|stop|start <service> [role]"
        exit 0
        ;;
       *)
        echo "Unknown command: $cmd";
        echo "deploy.sh reload|destroy|restart|stop|start <service> [role]"
        exit 1
        ;;
esac


# units location or the current directory
sitedir=/var/lib/apps/sites/${service}/units
[[ ! -d ${sitedir} ]] && sitedir=${PWD}

# If image is given, pull the image first 
[[ -n ${image} ]] && docker pull ${image}

# manage SSH units first
if [[ -f ${sitedir}/${service}-ssh.service ]] && [[ ${role:-'ssh'} = 'ssh' ]]; then
  # A single instance service, so just use fleetctl normally
  unit=${service}-ssh.service
  cd ${sitedir}
  ${cmd}
fi

if [[ ${role:-'sites'} = 'sites' ]]; then
  # Check if the service can have multiple instances
  if [[ -f ${sitedir}/${service}@.service ]]; then

    # if so, how many copies of the service should run
    sites_machines=$(fleetctl list-machines | grep -c role=sites)

    # Put the names of currently running services into $services
    fleetctl list-units |\
      awk '/'${service}'@[0-9].service/ {print $1}' |\
        sort -n |\
          tr '\012' ' ' |\
            read -a services

    for i in $(seq ${sites_machines}); do
      old_unit=${services[$i]}
      unit=${service}@${i}.service
      cd ${sitedir}
      ${cmd}
      echo ""
      unset services[$i]
      unset old_unit
      unset unit
    done
  
    # clean up any remaining old units
    for u in ${services[*]}; do
      fleetctl destroy ${u}
    done

  elif [[ -f ${sitedir}/${service}.service ]] && [[ ${role:-sites} = 'sites' ]]; then
    # A single instance service, so just use fleetctl normally
    unit=${service}.service
    cd ${sitedir}
    ${cmd}
  else
    echo Failed to find ${service}@.service or ${service}.service in ${sitedir}
    exit 1
  fi
fi

exit 0
