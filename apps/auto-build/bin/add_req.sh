#!/bin/bash
source /var/lib/apps/auto-build/envvars

echo $1 | grep '.git$' > /dev/null

if [ $? -ne 0 ]; then 
	echo "Add a auto-build job:" 
	echo "Usage $0 <git-repo>" 
	exit 1 
fi

echo etcdctl mkdir $AB_REQ_QUE > /dev/null 2>&1
echo curl -s -L http://127.0.0.1:4001/v2/keys${AB_REQ_QUE} -XPOST -d value="$1"
result=`curl -s -L http://127.0.0.1:4001/v2/keys${AB_REQ_QUE} -XPOST -d value="$1"` 
echo $result
# for only return the job index:
#echo $result | sed "s|.*\(${AB_REQ_QUE}/[0-9]*\).*|\1|"
