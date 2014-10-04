#!/bin/bash 
source /var/lib/apps/nginx/envvars
source /var/lib/apps/auto-build/envvars

# Exit on error
set -e

# turn -x on if DEBUG is set to a non-empty string
[ -n "$DEBUG" ] && set -x

function set_stage {
    etcdctl set "${AB_STG_QUE}/$1" "$2"
}
function already_build {
    jobs=`etcdctl ls --recursive $AB_STG_QUE`
    for job in $jobs; do 
        [[ $1 = "`etcdctl get $job`" ]] && return 0
    done
    return 1
}

job_id=$1
job=$2
        
# get the app name from git repo url, e.g.  https://github.com/user/docker-someapp.git -> someapp
app_dir=`echo $job | sed 's/.*\///' | sed 's/^docker-//' | sed 's/\.git//'`
        
cd $AB_WORK_DIR
#clean up the old one
[ -d $app_dir ] && rm -rf $app_dir 
    
git clone $job $app_dir
cd ${app_dir}

tag=$(git rev-parse --short=12 HEAD)   
 # construct the image name-tag
img="$REGISTRY/${app_dir}:$tag"
img_last="$REGISTRY/${app_dir}:latest"
              
if already_build $img; then 
    echo already build: $img
else
    # try build
    docker build --force-rm --no-cache -t $img . 
    # push to registry
    docker tag $img $img_last
    /var/lib/apps/bin/dklogin 
    docker push $img
    docker push $img_last
    # set job image to stage-queue
    set_stage $job_id $img
fi
