#########################################################
# If etcd is not reachable at localhost (127.0.0.0:4001),
# these env vars are necessary for tools that talk to etcd
# 
# make sure this file has the right values and drop it
# under the /etc/profile.d

# for skydns
export ETCD_MACHINES="http://172.17.8.101:4001"
#export ETCD_MACHINES="http://172.17.8.101:4001,http://172.17.8.102:4001,http://172.17.8.103:4001"
#export ETCD_TLSKEY= - path of TLS client certificate - private key.
#export ETCD_TLSPEM= - path of TLS client certificate - public key.
#export ETCD_CACERT= - path of TLS certificate authority public key

# for etcdctl
export ETCDCTL_PEERS="http://172.17.8.101:4001"
#export ETCDCTL_PEERS="http://172.17.8.101:4001,http://172.17.8.102:4001,http://172.17.8.103:4001"
#export ETCD_CAFILE= - etcd CA file authentication
#export ETCD_CERTFILE=	- etcd cert file authentication
#export ETCD_KEYFILE=	- etcd key file authentication

# for fleetctl, IMHO: fleetctl should only be used on etcd cluster.
export FLEETCTL_ENDPOINT="http://172.17.8.101:4001"