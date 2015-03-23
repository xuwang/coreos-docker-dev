Run FleetUI on CoreOS
=====================

* Generate a pair of ssh key for fleetui

        ssh-keygen -f /home/core/.ssh/id_rsa_fleetui -t rsa -C "fleetui@example.com"
        
* Add the public key to /home/core/.ssh/authorized_keys.d
 
        cp /home/core/.ssh/id_rsa_fleetui.pub /home/core/.ssh/authorized_keys.d
        sudo /usr/bin/update-ssh-keys
        
* Start the unit

  Find the ETCD_PEER:
   
        systemctl cat etcd | grep ETCD_PEER_ADDR

  Replace the ETCD_PEER setting in envvars file, the fire up the fleet ui container:

       cd unit && fleetctl start unit/fleet-ui.service

* Go to browser, for example: localhost:3000

![fleet-ui machine list](images/fleetui-example.png "fleet-ui machine list")
