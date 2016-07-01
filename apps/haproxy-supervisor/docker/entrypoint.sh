#!/bin/sh
mkdir -p /var/log/supervisor
case ${1} in
  start)
    exec /usr/bin/supervisord -nc /etc/supervisord.conf
    ;;
  reload|restart)
    # Save server state
    echo "show servers state" | socat - /var/lib/haproxy/states/socket > /var/lib/haproxy/states/server_state
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
