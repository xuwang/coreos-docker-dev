#!/bin/bash

fleetctl start gitlab-redis.service
fleetctl start gitlab-db.service
fleetctl start gitlab.service
