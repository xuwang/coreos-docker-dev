#!/bin/bash
set -e

case ${1} in
  start|reload|restart)
    case ${1} in
      start)
      exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
      ;;
    esac
    ;;
  help)
    echo "Available options:"
    echo " start        - Starts the gitlab server (default)"
    echo " help         - Displays the help"
    echo " [command]        - Execute the specified command, eg. bash."
    ;;
  *)
    exec "$@"
    ;;
esac

exit 0
