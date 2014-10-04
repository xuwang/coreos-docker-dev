# Docker Development Env On CoreOS

A docker application/service devevlopment environment on Vagrant/CoreOS with:

* All the goodies come with CoreOS, i.e. ETCD, Fleet, Systemd, Journal, OS auto-updates etc.
* A [SkyDNS][SkyDNS] service.
* Support of a wildcard self-signed certificates, it's convient for https web/api.
* Fleet units for applications/services:
    * private docker registry with https basic-auth
    * confd
    * nginx
    * haproxy
    * redis
    * timer example
etc.

It may started as:

* Standalong one node system
* A cluster of one etcd/skydns node and two fleet nodes  
etc.

Just link nodes.json to different configrations under nodes-conf dir.

### Install dependencies

* [VirtualBox][virtualbox] 4.3.10 or greater.
* [Vagrant][vagrant] 1.6 or greater.

### Clone this project and get system up and login

	git clone https://github.com/xuwang/coreos-docker-dev.git
	cd coreos-docker-dev
	vagrant up
    vagrant ssh
### Clean it up

	exit # the coreos vm
	vagrant destroy

[virtualbox]: https://www.virtualbox.org/
[vagrant]: https://www.vagrantup.com/downloads.html
[using-coreos]: http://coreos.com/docs/using-coreos/
[SkyDNS]: https://github.com/skynetservices/skydns
[Docker-Registry]: https://github.com/docker/docker-registry


