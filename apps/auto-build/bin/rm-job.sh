#!/bin/bash
source /var/lib/apps/auto-build/envvars

etcdctl rm $AB_REQ_QUE/1 --with-value 'https://github.com/dockerfile/ubuntu.git'
etcdctl rm $AB_REQ_QUE/2 --with-value 'https://github.com/dockerfile/python.git'
etcdctl rm $AB_REQ_QUE/3 --with-value 'https://github.com/dockerfile/redis.git'
