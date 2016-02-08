GitLab in a Box
=================================

* [Docker-GitLab](https://github.com/sameersbn/docker-gitlab)
* [GitLab Documentation](https://about.gitlab.com/documentation/)

Before you start
=================================

Copy *envvars.smtp.tmpl* to *envvars.smtp* and modify *envvars.smtp* to 
configure SMTP host, user, password for sending sign-up confirmation email.

Postgres and Redis data are persist in *apps-data/gitlab* directory.

Start GitLab Services
======================
	cd units
	fleetctl start gitlab-redis.service
	fleetctl start gitlab-db.service
	fleetctl start gitlab.service	

or simply:

	fleetctl start -no-block *
	
check service status and get the gitlab service ip:

	fleetctl list-units
        ping gitlab.docker.local

if all gitlab services are up and running, open https://172.17.8.101:8443 and login with:
	
	username: root
	password: 5iveL!fe

add a gitlab user.


Setup Git
======================
Add following lines to $HOME/.ssh/config:
		Host gitlab.docker.local
    	IdentityFile ~/.ssh/id_rsa
    	Port 10022

Add id_rsa.pub to your gitlib user account
