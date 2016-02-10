# GitLab in a Box

* [GitLab Documentation](https://about.gitlab.com/documentation/)
* [Docker-GitLab](https://github.com/sameersbn/docker-gitlab)
* [GitLab CI](http://doc.gitlab.com/ce/ci/)
* [Docker-GitLab-Runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/docker.md)

## Before you start##

Copy *envvars.smtp.tmpl* to *envvars.smtp* and modify *envvars.smtp* to 
configure SMTP host, user, password for sending sign-up confirmation email.

Postgres and Redis data are persist in *apps-data/gitlab* directory.

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

## Setup Gitlab CI Runner

### Start the runner unit:

```shell
cd units
fleetctl start gitlab-runner
```
### Register the runner:
    Get *registration token* on page:
        https://gitlab.docker.local:8443/admin/runners


```shell
docker exec -it gitlab-runner.service gitlab-runner register
        Running in system-mode.

        Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/ci):
        https://gitlab.docker.local:8443/ci
        Please enter the gitlab-ci token for this runner:
        *registration token*
        Please enter the gitlab-ci description for this runner:
        [xxxxxxxxx]: runner-shared
        Please enter the gitlab-ci tags for this runner (comma separated):
        shell,ssh,docker,ruby
        Registering runner... succeeded                     runner=XXXX
        Please enter the executor: docker, docker-ssh, virtualbox, ssh, shell, parallels:
        docker
        Please enter the default Docker image (eg. ruby:2.1):
        ruby:2.1
        Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```