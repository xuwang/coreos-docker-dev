GitLab in a Box
=================================

* [Docker-GitLab](https://github.com/sameersbn/docker-gitlab)
* [GitLab Documentation](https://about.gitlab.com/documentation/)

Start GitLab Services
======================
	cd units
	
	fleetctl start gitlab-redis.service
	fleetctl start gitlab-db.service
	fleetctl start gitlab.service	

or simply:

	fleetctl start -no-block *
	
check service status:

	fleetctl list-units
	
if all gitlab services are up and running, open http://localhost:8080 and login with:
	
	username: root
	password: 5iveL!fe