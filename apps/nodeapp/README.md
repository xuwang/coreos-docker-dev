##NodeJS App Load Balanced (round-robin) and HA

### Vagrant a cluster of 3 vms
modify the Vagrantfile, use the cluster configuration:

    NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster.json")

Start the cluster and login:

    vagrant up
    vagrant ssh n1

### Build nadeapp image
    cd share/apps/nodeapp
    docker build -t <user>/nodeapp docker
    docker push <user>/nodeapp:latest

Tell units which image should be used in this app:

    echo "IMAGE=<user>/nodeapp:latest" >> ./envvars

### Run nodeapp on 3 machines
Make sure the machines are available:
   
    fleetctl list-machines

Submit the unit template:

    fleetctl submit units/nodeapp@.service

Fire up 3 copies of the nodeapp:

    fleetctl start units/nodeapp@{1..3}.service

Call nodeapp:

    curl http://nodeapp
    curl http://nodeapp
    curl http://nodeapp

### Let's kill one of them
    exit # the vm
    vagrant halt n1