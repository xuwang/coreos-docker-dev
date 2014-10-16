## Cloud-init user-data files

### Start units by cloud-init or by fleet, that is the question.

### Cloud-init configuration are breaked into pieces

Cloud-init configuration are breaked into segements and put into it's own file. The final "user-data" file for cloud-init will be assembled at the target machine in vagrant provisioning process.

So each node of a cluster can pick the cloud-init segements only needs or fits to that specific node.

Usage examples are in ndoes-conf/
