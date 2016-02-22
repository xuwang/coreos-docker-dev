#!/bin/bash
docker ps --format="{{.Names}}" | tr '\n' ' ' | docker stats $(cat -)
