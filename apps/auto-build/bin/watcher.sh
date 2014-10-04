#!/bin/sh
source /var/lib/apps/auto-build/envvars

# turn -x on if DEBUG is set to a non-empty string
[ -n "$DEBUG" ] && set -x

default_id=$$
my_id=${1:-$default_id}

function setup_queues {
    ( etcdctl ls ${AB_ERR_QUE} ) || etcdctl mkdir ${AB_ERR_QUE}
    ( etcdctl ls ${AB_REQ_QUE} ) || etcdctl mkdir ${AB_REQ_QUE}
    ( etcdctl ls ${AB_JOB_QUE} ) || etcdctl mkdir ${AB_JOB_QUE}
    ( etcdctl ls ${AB_STG_QUE} ) || etcdctl mkdir ${AB_STG_QUE}
}
function set_job {
    etcdctl mk --ttl 300 "${AB_JOB_QUE}/$1" $2 > /dev/null
}
function set_error {
    etcdctl set "${AB_ERR_QUE}/$1" $2
}
function clear_job {
    etcdctl rm "${AB_JOB_QUE}/$1" --with-value $my_id
}
function clear_all_my_job {
    jobs=`etcdctl ls --recursive $AB_JOB_QUE`
    for job in $jobs; do 
        [[ $my_id = "`etcdctl get $job`" ]] && etcdctl rm $job
    done
}
function clear_request {
    etcdctl rm "${AB_REQ_QUE}/$1"
}

function cleanup {
    err=$?
    if [[ -n $job_id ]] && [[ -n $my_id ]]; then
        clear_all_my_job  > /dev/null 2>&1
        if [[ $err -gt 0 ]]; then
            set_error $job_id $job
        fi
     fi
     exit
}
trap cleanup INT TERM EXIT

setup_queues

while true; do
    reqs=`etcdctl ls --recursive $AB_REQ_QUE`
    if [[ -n $reqs ]]; then
        reqs=`basename -a $reqs | sort -n`
        for job_id in $reqs; do 
            if set_job $job_id $my_id ; then
                job=`etcdctl get "${AB_REQ_QUE}/$job_id"`
                if echo $job | grep '.git$' > /dev/null ; then
                    # build, set error if failed
                    ( /bin/sh -c "$AB_BUILD_CMD $job_id $job" ) || set_error $job_id $job
                fi
                clear_request $job_id
                clear_job $job_id
            fi
        done
    fi
    # the etcd history expire may cause problem with --after-index
    if [[ -n $job_id ]]; then
        etcdctl watch ${AB_REQ_QUE} --recursive --after-index $job_id
        job_id=''
    else
        etcdctl watch ${AB_REQ_QUE} --recursive 
    fi
    # wait 5 sec for all request coming in
    sleep 5
done


# exec-watch is not reliable :-()
#etcdctl exec-watch --recursive $AB_REQ_QUE -- sh -c "$AB_BUILD_CMD $1 ; exit 0"