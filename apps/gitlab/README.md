# GitLab in a Box

* [GitLab Documentation](https://about.gitlab.com/documentation/)
* [Docker-GitLab](https://github.com/sameersbn/docker-gitlab)
* [GitLab CI](http://doc.gitlab.com/ce/ci/)

## Before you start##

Copy *envvars.smtp.tmpl* to *envvars.smtp* and modify *envvars.smtp* to 
configure SMTP host, user, password for sending sign-up confirmation email.

Postgres and Redis data are persist in *apps-data/gitlab* directory.

*NOTE* running gitlab with ci runner needs a large vbox with large memory, e.g. 4096M

## Start GitLab Services

```shell
cd units
fleetctl start gitlab-redis.service
fleetctl start gitlab-db.service
fleetctl start gitlab.service	
```

check service status and get the gitlab service ip:

```shell
fleetctl list-units
or
ping gitlab.docker.local
```

If all gitlab services are up and running, open *https://172.17.8.101:8443* and login with:

```
    username: root
    password: 5iveL!fe
```
Add a gitlab user on *https://gitlab.docker.local:8443/admin/users*

## Setup Git

Add following lines to $HOME/.ssh/config on you host machine:
```
    Host gitlab.docker.local
    IdentityFile ~/.ssh/id_rsa
    Port 10022
```
Add id_rsa.pub to your gitlib user account on *https://gitlab.docker.local:8443/profile/keys*


## Setup Gitlab CI Runner: Use CoreOS vbox as the runner machine
See [gitlab-ci-multi-runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/linux-manually.md)

### Install
```shell
  sudo wget -O /opt/bin/gitlab-ci-multi-runner \
    https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64
  sudo chmod 755 /opt/bin/gitlab-ci-multi-runner
  sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash -G docker
  sudo /opt/bin/gitlab-ci-multi-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
```

### Register the Shell Runner
Get *registration token* on page:
  https://gitlab.docker.local:8443/admin/runners

for example:
    Registration token is 9TqrzAmKzHSvggmLYDKo

```shell
  sudo /opt/bin/gitlab-ci-multi-runner register  -n \
    --url https://gitlab.docker.local:8443/ci \
    --registration-token 9TqrzAmKzHSvggmLYDKo \
    --executor shell \
    --description "Shell Runner" \
    --tag-list "shell,ssh"

Registering runner... succeeded                     runner=9TqrzAmK
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```

### Start Shell Runner
  sudo /opt/bin/gitlab-ci-multi-runner start

## Setup Gitlab CI Runner: Use Runner-Docker
See [Docker-GitLab-Runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/docker.md)
 
### Start the runner unit:

```shell
cd units
fleetctl start gitlab-docker-runner.service
fleetctl start gitlab-cleaner.service
```
### Register  runner:
Get *registration token* on page:
  https://gitlab.docker.local:8443/admin/runners

for example:
    Registration token is 9TqrzAmKzHSvggmLYDKo

```shell
docker exec gitlab-runner.service gitlab-runner register -n \
  --url https://gitlab.docker.local:8443/ci \
  --registration-token 9TqrzAmKzHSvggmLYDKo \
  --executor docker \
  --description "Dind Runner" \
  --docker-image "gitlab/dind:latest" \
  --tag-list "docker,dind" \
  --docker-wait-for-services-timeout 300 \
  --docker-privileged

Registering runner... succeeded                     runner=9TqrzAmK
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```

## Example .gitlab-ci.yml 
See *apps/nodeapp/docker/.gitlab-ci.yml*

# Setup Slack Integration

## Create and get a slack incoming webhook at:
    *https://dockerage.slack.com/apps/manage/custom-integrations*

    *https://gitlab.docker.local:8443/<user>/<project>/services/slack/edit*

## Example .gitlab-ci.yml 
See *apps/nodeapp/docker/.gitlab-ci.yml*