# Docker Development Env On CoreOS

A docker application/service devevlopment environment on Vagrant/CoreOS with:

* All the goodies come with CoreOS, i.e. ETCD, Fleet, Flannel, Systemd, Journal, OS auto-updates etc.
* A [SkyDNS][SkyDNS] service.
* A [FleetUI](https://github.com/purpleworks/fleet-ui.git) service.
* Https support for web applicaitons with a wildcard self-signed certificate
* Fleet units for applications/services:
    * private docker registry with https basic-auth
    * confd
    * nginx
    * haproxy
    * redis
    * timer 
    * flannel

Full lists of apps are under [apps](https://github.com/xuwang/coreos-docker-dev/tree/master/apps) directory. There is a working flannel cluster in which docker containers run on their own private network than that of the docker host. 

### Installation dependencies

* [VirtualBox][virtualbox] 4.3.10 or greater.
* [Vagrant][vagrant] 1.6 or greater.

### Cluster configuration

Under [nodes-conf](https://github.com/xuwang/coreos-docker-dev/tree/master/nodes-conf) directory, you can find different size of cluster configurations and default service port mappings.  You can modify json files to change the defaults and then in Vagrant configuration, pick the one you will use, for example, the cluster with flannel, with 3 nodes:

    #NODES_CONF = File.join(MY_PATH, "nodes-conf", "standalone.json")
    NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster-flannel.json")
    #NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster.json")
    #NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster-large.json")
    #NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster-secure-etcd.json")

### Clone this project and get system up and running

    git clone https://github.com/xuwang/coreos-docker-dev.git
    cd coreos-docker-dev
    vagrant up
    vagrant status
    vagrant ssh <node name>
  
Skydns service should be started automatically, as you can see in dns resolv.conf file:

    core@n1 ~/share/apps $ more /etc/resolv.conf
    domain docker.local
    search docker.local
    nameserver 127.0.0.1

### Start service units

Units are locaged under share/apps/<service>/units directory. In general, you can start a service like so:

    cd share/apps/<service>/units
    fleetctl start <name>.service

For example, to start private registry:

    cd share/apps/registry/units
    fleetctl start registry.service

### Start fleetui

    cd share/apps/fleet-ui/units
    fleetctl start fleet-ui.service
    
### Clean it up

	exit # the coreos vm
	vagrant destroy

[virtualbox]: https://www.virtualbox.org/
[vagrant]: https://www.vagrantup.com/downloads.html
[using-coreos]: http://coreos.com/docs/using-coreos/
[SkyDNS]: https://github.com/skynetservices/skydns
[Docker-Registry]: https://github.com/docker/docker-registry


