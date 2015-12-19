#!/bin/bash
case ${1} in
  start)
    exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
    ;;
  reload|restart)
    # Delay SYN at the TCP level while we restart haproxy.
    iptables -I INPUT -p tcp --match multiport --dports 80,443 --syn -j DROP
    pgrep -x haproxy && pkill -x haproxy
    sleep 0.5
    iptables -D INPUT -p tcp --match multiport --dports 80,443 --syn -j DROP
    ;;
  status)
    /usr/bin/supervisorctl status haproxy
    ;;
  help)
    echo "Available options:"
    echo " start|reload|restart - Starts the haproxy server (default)"
    echo " status       - Show status"
    echo " help         - Displays the help"
    echo " [command]        - Execute the specified command, eg. bash."
    ;;
  *)
    exec "$@"
    ;;
esac

exit 0
