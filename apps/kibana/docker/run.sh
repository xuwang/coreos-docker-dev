#!/bin/bash

[[ -f /config/config.js ]] && cp -f /config/config.js /web/kibana/config.js

/usr/bin/twistd -n web --path /web/kibana