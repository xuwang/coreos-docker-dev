SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"
cd $SCRIPT_HOME/units
fleetctl load *.service *.timer
fleetctl start *.timer
journalctl -fu hello.service
