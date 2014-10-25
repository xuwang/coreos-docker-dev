##Elasticsearch Load Balanced (round-robin) and HA

### Vagrant a cluster of 3 vms
modify the Vagrantfile, use the cluster configuration:

    NODES_CONF = File.join(MY_PATH, "nodes-conf", "cluster.json")

Start the cluster and login:

    vagrant up
    vagrant ssh n1

### Build nadeapp image
    cd share/apps/elasticsearch
    docker build -t <user>/elasticsearch docker
    docker push <user>/elasticsearch:latest

Tell units which image should be used in this app:

    echo "IMAGE=<user>/elasticsearch:latest" >> ./envvars

### Run elasticsearch on 3 machines
Make sure the machines are available:
   
    fleetctl list-machines

Submit the unit template:

    fleetctl submit units/elasticsearch@.service

Fire up 3 copies of the elasticsearch:

    fleetctl start units/elasticsearch@{1..3}.service

### Let's kill one of them
    exit # the vm
    vagrant halt n1